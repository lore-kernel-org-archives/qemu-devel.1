Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1A9EC1975A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 20:05:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DEB72073E
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 20:05:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="u0REbvj0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DEB72073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40632 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEITD-0007n5-MI
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 16:05:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48870)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jEISJ-0007Ej-Ay
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 16:04:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jEISI-00058y-1j
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 16:04:51 -0400
Received: from mail-ve1eur01on0726.outbound.protection.outlook.com
 ([2a01:111:f400:fe1f::726]:59265
 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jEISA-0004ks-Dv; Tue, 17 Mar 2020 16:04:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gLvi7gy0GZcZeidrLa+vcyDby1rGiXfwR25c9Eq2/HHryqXbf1xO3nfqRxw0obnWgMEK+ScOdPhrcI7Iu1W00qhQ690jmrtaFpeTlz369068C4xw5S0dWytEGP9wTr6puUebijtiugo+iBwj5mvWmZLiaqoU+LCKDLMeU/tuWUU4aC81qfW/hrQLy2HNZqkhrv8nk/lLH8zeFA5eMminu9DHAWq5tg6Z8jA+IC6P8llOvUzKEygInjtlBNSpvpwy5tAzUDOB3gb9/Rgoejs6B+Wxg/aWHu9QSQk517K85irmSBU7tiPJTyaeYsx4hEXskCITSEH/GRLXOG7GDNcSRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SSoU1/36/gfA5lcH5SClNeR8uaH2K3OdT0XUg1hHGds=;
 b=HY2YL4cIFMiMba11Eld6WR1ml3oPru3Rwo7YKPz+dTRH8hQ0XAQWZ5YPwCwGkuK3kLvP9gN0dXObc1I39of8gTt6kxq7WwuHH40VEgQ97C0KqWx5NtYj3695L/28Ha86SqV2H806DhCX+fTaZXs+zQs1DeRsMkL+XfePEvq+g75UK7y/uFj7jX+GqocN2GLNenax39nbxS/h7uXSHnIQR3990IJSeOttW1kariSsJ/BAOjM/BTZ4Z5+dom3gyeQXl/0axPDK8q1J9RPUr/jt2NMVxZu+ZkXJteMeHJX7sX1mYj471UVs3wEQP+sfwLxP5rF8YtrICQfSQVARzjuHzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SSoU1/36/gfA5lcH5SClNeR8uaH2K3OdT0XUg1hHGds=;
 b=u0REbvj09E0szcqmRBbdwKaZ7VSGaNZE6W3Ru4y7H+tF5MhcuarEcZlQxEvxdSwDdOytCizOenB2ziTklERHUgjK/A9nw6jiLp1lpMKOyiYbk+SBRUzt7528yIexRU6IKhZqPGJy86GaGR2PFo5QxFtdDf+2aGFJr3rc+55MX5w=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from HE1PR0802MB2507.eurprd08.prod.outlook.com (10.175.35.136) by
 HE1PR0802MB2507.eurprd08.prod.outlook.com (10.175.35.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.22; Tue, 17 Mar 2020 20:04:38 +0000
Received: from HE1PR0802MB2507.eurprd08.prod.outlook.com
 ([fe80::4d32:e4e1:5b9f:240f]) by HE1PR0802MB2507.eurprd08.prod.outlook.com
 ([fe80::4d32:e4e1:5b9f:240f%12]) with mapi id 15.20.2814.021; Tue, 17 Mar
 2020 20:04:38 +0000
Subject: Re: [PATCH 3/3] xen-block: Use one Error * variable instead of two
To: Markus Armbruster <armbru@redhat.com>
References: <20200313170517.22480-1-armbru@redhat.com>
 <20200313170517.22480-4-armbru@redhat.com>
 <d6497746-2ed5-02e0-1934-065db818c1c6@virtuozzo.com>
 <87y2ryls6t.fsf@dusky.pond.sub.org>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200317230435947
Message-ID: <acbccde4-b882-8bdc-bc05-32b70ae04544@virtuozzo.com>
Date: Tue, 17 Mar 2020 23:04:36 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <87y2ryls6t.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: HE1PR05CA0306.eurprd05.prod.outlook.com
 (2603:10a6:7:93::37) To HE1PR0802MB2507.eurprd08.prod.outlook.com
 (2603:10a6:3:e1::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.248) by
 HE1PR05CA0306.eurprd05.prod.outlook.com (2603:10a6:7:93::37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.19 via Frontend Transport; Tue, 17 Mar 2020 20:04:37 +0000
X-Tagtoolbar-Keys: D20200317230435947
X-Originating-IP: [185.215.60.248]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0de70cf3-f107-4337-6e36-08d7caae6bdb
X-MS-TrafficTypeDiagnostic: HE1PR0802MB2507:
X-Microsoft-Antispam-PRVS: <HE1PR0802MB250770ADE7779923FD3317F5C1F60@HE1PR0802MB2507.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0345CFD558
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(4636009)(39850400004)(136003)(396003)(366004)(346002)(376002)(199004)(66476007)(52116002)(6916009)(2616005)(66556008)(36756003)(5660300002)(86362001)(31686004)(956004)(186003)(16526019)(26005)(4326008)(8936002)(81156014)(8676002)(31696002)(81166006)(478600001)(2906002)(6486002)(66946007)(316002)(16576012);
 DIR:OUT; SFP:1102; SCL:1; SRVR:HE1PR0802MB2507;
 H:HE1PR0802MB2507.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vhZw81phutPDr5Ogy0mF0gaCzMjLnTeMtggVDksQJLKeokL1jNV4D6Lmm/HHpe0MGVKuuKQEXy2dohRee1lpeo/kOhV31x2JqdiLB3omkFroprfoSBGPuU4Rt6rtmYdjRAlXzZBJOOYd44BP02A3SO9QjeT1OfHK1xJOVAR2+heMRPg1cJ7Fc3CtbBJswBHjMM8dj0qhAOIJ9VnzkuIh72cOzi7dfA/rRq+N9MiB7flQKGGO8wshTbtM1JRPm5AigY3fy5E+faJrVAYGl6uPIkW501HGAb96TUst31aDcbxhY6OzQnvgJVpl4E/ErUSkFL0pS6O38vv7XpC5Q9n5EgqbVwwdmBPUMbkDYRMd9ktOTqFKOSJltDuAPo0MHbPQXeXG6cjg3YeTKkF5+LSnOiJ8pToSAoctHyv5FuRXlI4y6Dcw1rkv5d7Vp/odlIsz
X-MS-Exchange-AntiSpam-MessageData: XhUtUR4TRQwfrxEgCxQ6MePHuxDl224hyWGdVdI/0bwaNYYqnExCR2r026sQdUMWP0nkfmJyf4zJCxPVKcBrgnTfxpMn9wbP4f00vDEz/D4jP1nKmz9a+PDfwrGJA35tjIpF6JpTYD0HRsWtCoRcBg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0de70cf3-f107-4337-6e36-08d7caae6bdb
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2020 20:04:38.1056 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VgGjwEk/EuV7QnyUF6+q2EQhOJbiHIzURS7GHDGRzP7l4GzyQFve6SDSjpjVvn1yK+1ByNlR9H+s6z1xjBXsp9MjYN+nEwviKRjNf3yh+Rg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0802MB2507
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a01:111:f400:fe1f::726
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: alxndr@bu.edu, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 ashijeetacharya@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

17.03.2020 22:03, Markus Armbruster wrote:
> Uh, I failed to actually send this.  It's in my pull request now.
>=20
> Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:
>=20
>> 13.03.2020 20:05, Markus Armbruster wrote:
>>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>>> ---
>>>    hw/block/xen-block.c | 5 +----
>>>    1 file changed, 1 insertion(+), 4 deletions(-)
>>>
>>> diff --git a/hw/block/xen-block.c b/hw/block/xen-block.c
>>> index 3885464513..7b3b6dee97 100644
>>> --- a/hw/block/xen-block.c
>>> +++ b/hw/block/xen-block.c
>>> @@ -998,14 +998,13 @@ static void xen_block_device_destroy(XenBackendIn=
stance *backend,
>>>        XenBlockVdev *vdev =3D &blockdev->props.vdev;
>>>        XenBlockDrive *drive =3D blockdev->drive;
>>>        XenBlockIOThread *iothread =3D blockdev->iothread;
>>> +    Error *local_err =3D NULL;
>>>          trace_xen_block_device_destroy(vdev->number);
>>>          object_unparent(OBJECT(xendev));
>>>          if (iothread) {
>>> -        Error *local_err =3D NULL;
>>> -
>>>            xen_block_iothread_destroy(iothread, &local_err);
>>>            if (local_err) {
>>>                error_propagate_prepend(errp, local_err,
>>> @@ -1015,8 +1014,6 @@ static void xen_block_device_destroy(XenBackendIn=
stance *backend,
>>>        }
>>>          if (drive) {
>>> -        Error *local_err =3D NULL;
>>> -
>>>            xen_block_drive_destroy(drive, &local_err);
>>>            if (local_err) {
>>>                error_propagate_prepend(errp, local_err,
>>
>> Hmm, no "return;" statement after this propagation. It's OK, as there no=
 more code in the function after this "if", but I'd add it to be consistent=
 and to avoid forgetting to add a return here when add more code to the fun=
ction.
>>
>> (and if you do this, you may also fix indentation of string paramter of =
error_propagate_prepend...)
>>
>>
>>
>> Anyway,
>> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>=20
> Like this, I guess:
>=20
> xen-block: Use one Error * variable instead of two
>=20
> While there, tidy up indentation, and add return just for consistency
> and robustness.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Message-Id: <20200313170517.22480-4-armbru@redhat.com>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>=20
> diff --git a/hw/block/xen-block.c b/hw/block/xen-block.c
> index 3885464513..07bb32e22b 100644
> --- a/hw/block/xen-block.c
> +++ b/hw/block/xen-block.c
> @@ -998,29 +998,27 @@ static void xen_block_device_destroy(XenBackendInst=
ance *backend,
>       XenBlockVdev *vdev =3D &blockdev->props.vdev;
>       XenBlockDrive *drive =3D blockdev->drive;
>       XenBlockIOThread *iothread =3D blockdev->iothread;
> +    Error *local_err =3D NULL;
>  =20
>       trace_xen_block_device_destroy(vdev->number);
>  =20
>       object_unparent(OBJECT(xendev));
>  =20
>       if (iothread) {
> -        Error *local_err =3D NULL;
> -
>           xen_block_iothread_destroy(iothread, &local_err);
>           if (local_err) {
>               error_propagate_prepend(errp, local_err,
> -                                "failed to destroy iothread: ");
> +                                    "failed to destroy iothread: ");
>               return;
>           }
>       }
>  =20
>       if (drive) {
> -        Error *local_err =3D NULL;
> -
>           xen_block_drive_destroy(drive, &local_err);
>           if (local_err) {
>               error_propagate_prepend(errp, local_err,
> -                                "failed to destroy drive: ");
> +                                    "failed to destroy drive: ");
> +            return;
>           }
>       }
>   }
>=20
Yes, that's what I meant, thanks!

--=20
Best regards,
Vladimir

