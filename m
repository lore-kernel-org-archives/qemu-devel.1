Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06B2BC35247
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 16:10:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C757920730
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 16:10:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="W9fC++vx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C757920730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iz0mk-0000Xs-SV
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 11:10:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37704)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iz0jq-0004Av-56
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 11:07:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iz0jo-0006VT-My
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 11:07:46 -0500
Received: from mail-am6eur05on2129.outbound.protection.outlook.com
 ([40.107.22.129]:34016 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iz0jk-0006Id-2n; Tue, 04 Feb 2020 11:07:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IQmBSrjt+cc0vRaFnYzQS4iFc+YcoDlVywqiGVEcz+sYxYvFEiax6YbHpDT4WS6JmObr70gpd7MzY7V6Eqk5donJ94a/fsqVQSgO7ZApRHKeyUI3FX/kMHuaPfwOBUgDDYXkhgK1jh/u+ZrwYW9WoWBS9yoTt/t0vNf7hH2ve0NfQp2AMYUSjmzq5Pja4SfTOK/SmG1i1V3Cw9PRMsOTrWsbEysGPZUGZSF1T+hmhcc7EIPXSF3JZQ6liJ6zgBG1JLgo958PGsOyhr4hd9uq2+LfuuML2O7qA9Vbr1+4QaRVYRLfosRxS4Z3Hj/rLmUpQgypkKGvmIqUiSzcWTfXoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k5MbLq/1IIAnZSusS4gG/Z2Nm64wO1mskvP12pkA1us=;
 b=TbdlWXimrGyUahQ+9b9nmwDfg0emUxJaX+28pPdnn/mXeFwpgfmd5MgI0a7cTBJ9S9GrNiPvBZlA3+Bth1qh/Cmb6wsV6pv2W8RkFxi5FCK2Fk2y57ibB3xyPPbRAy0haiS72uvo04TQw3bgYhB3sp+uCqS4N2pRGn6PdBj17mAnwCV16uk+jkBOJFp3MyfpSPMJIMch30W48rzhTJkHfT/RWmqZnV9LWZoYjbnENLnJlJKXUZDD6+Xko+Kslj3FfSVs4+mjsG/sVCLQ3VhlMD44YmjEGt2XOKtAal0UIi9w+9aJrldbnc8zRsk9qJgCJeUE944cNEeF56eiOQ0Pjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k5MbLq/1IIAnZSusS4gG/Z2Nm64wO1mskvP12pkA1us=;
 b=W9fC++vxDfQCmD78CYhJBKtC2nt5QuEiKd4BGUazj3ODFfr4rG/rUua3iJeIqbZvCWcLddZFfeYWAePI/7tUa9UofQgG4T6xHsNNGHCKTiA+LXjrUN76qU/ailBK2bwelquhuSYcR0mDTTiEhyULWu09CzpqfwObJSIbbp/VGJo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB3526.eurprd08.prod.outlook.com (20.177.115.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.33; Tue, 4 Feb 2020 16:07:37 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030%7]) with mapi id 15.20.2686.034; Tue, 4 Feb 2020
 16:07:37 +0000
Subject: Re: [PATCH 09/17] block: Refactor bdrv_has_zero_init{,_truncate}
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20200131174436.2961874-1-eblake@redhat.com>
 <20200131174436.2961874-10-eblake@redhat.com>
 <339f0a60-1e4f-286c-6594-1153bf284082@virtuozzo.com>
 <6247aca7-4a2e-ffa9-6336-4c1e71f63d96@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200204190734382
Message-ID: <9ca73263-17bd-e72c-0c0e-ac7a54ba4578@virtuozzo.com>
Date: Tue, 4 Feb 2020 19:07:34 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <6247aca7-4a2e-ffa9-6336-4c1e71f63d96@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: HE1P18901CA0006.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:3:8b::16) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
MIME-Version: 1.0
Received: from [172.16.24.200] (185.231.240.5) by
 HE1P18901CA0006.EURP189.PROD.OUTLOOK.COM (2603:10a6:3:8b::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.27 via Frontend Transport; Tue, 4 Feb 2020 16:07:36 +0000
X-Tagtoolbar-Keys: D20200204190734382
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fec1dd19-5300-46aa-0d6a-08d7a98c5a96
X-MS-TrafficTypeDiagnostic: AM6PR08MB3526:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB3526D0C420C8382A9C39DE26C1030@AM6PR08MB3526.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 03030B9493
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(39850400004)(396003)(346002)(376002)(366004)(136003)(199004)(189003)(54906003)(956004)(2616005)(16576012)(316002)(2906002)(66556008)(5660300002)(66476007)(66946007)(478600001)(86362001)(8936002)(31686004)(8676002)(81166006)(81156014)(52116002)(7416002)(4326008)(16526019)(186003)(26005)(53546011)(36756003)(6486002)(31696002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3526;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Sp9frJSBsB3aZ77q0zMmqxtsZKJbZ9HZg/VuyLnsoVKeh5ps3a+x2i9sUZmvt9ybbAvN5F3/Y4ZxkeF2PHQlXVjOpEFjIQxGIGpP/KCA+rPo5u4r+m7rxfi38E5SxeZxq1vKfBvllyheOJKx9SeKWlKO4EyqUT3LDkjecqoUj8zJemQwn8bkY0KrVjRwbg2KytltDfNnxu6BKVRp/OLce7hQM0K4ccYBK46M/qhotOT12zbUCVcSr0htQ3a0/9BYhGWg84sJ+imlJooJfgpPXAxpPKe/wxNNdjLU4OC5ovSYPvtmiA/qDc4TfuGtFl5FoZG02sBttWyWtrbfyZ92PDni4cOtZZxW098xXIJCZ3967GDBVHlnnKhGeV288oud3m+kcm5+YXDVhq9e0TP7N+BUDA/ojdYNN44SYcs51mwJ59VGxp+O3/7x39WWZDHX
X-MS-Exchange-AntiSpam-MessageData: R1bH51gFyF6HPn+L54Q+rsBuffa0srIpdDnHV9T/iJCqe6mvG2LqOfpYdyulcPZ/CbugLDPvcdxXgwy+lp+hLS8abocvTsLP5cHRFXKF4p9AhUzL8VporC1Fp/8XThynA06HQ/XWrT0C3gF+I9hqVg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fec1dd19-5300-46aa-0d6a-08d7a98c5a96
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2020 16:07:37.8362 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /2+PM/8uoTrXjZDantnmtSAed4kO7OZEb/pTsoU9mivL4B8/WcC023sJ6oVQ8HFa+/oizFxiivOXNnGaKGOK5c1ZKi4Zj4llC6tvOeU/VLo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3526
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.22.129
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 "open list:Sheepdog" <sheepdog@lists.wpkg.org>, qemu-block@nongnu.org,
 Jeff Cody <codyprime@gmail.com>, Stefan Weil <sw@weilnetz.de>,
 Peter Lieven <pl@kamp.de>, "Richard W.M. Jones" <rjones@redhat.com>,
 mreitz@redhat.com, david.edmondson@oracle.com,
 Stefan Hajnoczi <stefanha@redhat.com>, "Denis V. Lunev" <den@openvz.org>,
 Liu Yuan <namei.unix@gmail.com>, Jason Dillaman <dillaman@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

04.02.2020 18:49, Eric Blake wrote:
> On 2/4/20 9:35 AM, Vladimir Sementsov-Ogievskiy wrote:
>> 31.01.2020 20:44, Eric Blake wrote:
>>> Having two slightly-different function names for related purposes is
>>> unwieldy, especially since I envision adding yet another notion of
>>> zero support in an upcoming patch.=C2=A0 It doesn't help that
>>> bdrv_has_zero_init() is a misleading name (I originally thought that a
>>> driver could only return 1 when opening an already-existing image
>>> known to be all zeroes; but in reality many drivers always return 1
>>> because it only applies to a just-created image).=C2=A0 Refactor all us=
es
>>> to instead have a single function that returns multiple bits of
>>> information, with better naming and documentation.
>>
>> Sounds good
>>
>>>
>>> No semantic change, although some of the changes (such as to qcow2.c)
>>> require a careful reading to see how it remains the same.
>>>
>>
>> ...
>>
>>> diff --git a/include/block/block.h b/include/block/block.h
>>> index 6cd566324d95..a6a227f50678 100644
>>> --- a/include/block/block.h
>>> +++ b/include/block/block.h
>>
>> Hmm, header file in the middle of the patch, possibly you don't use
>> [diff]
>> =C2=A0=C2=A0=C2=A0=C2=A0 orderFile =3D scripts/git.orderfile
>>
>> in git config.. Or it is broken.
>=20
> I do have it set up, so I'm not sure why it didn't work as planned. I'll =
make sure v2 follows the order I intended.
>=20
>>
>>> @@ -85,6 +85,28 @@ typedef enum {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BDRV_REQ_MASK=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D 0x3ff,
>>> =C2=A0 } BdrvRequestFlags;
>>>
>>> +typedef enum {
>>> +=C2=A0=C2=A0=C2=A0 /*
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * bdrv_known_zeroes() should include this bit=
 if the contents of
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * a freshly-created image with no backing fil=
e reads as all
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * zeroes without any additional effort.=C2=A0=
 If .bdrv_co_truncate is
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * set, then this must be clear if BDRV_ZERO_T=
RUNCATE is clear.
>>
>> I understand that this is preexisting logic, but could I ask: why? What'=
s wrong
>> if driver can guarantee that created file is all-zero, but is not sure a=
bout
>> file resizing? I agree that it's normal for these flags to have the same=
 value,
>> but what is the reason for this restriction?..
>=20
> For _this_ patch, my goal is to preserve pre-existing practice. Where we =
think pre-existing practice is wrong, we can then improve it in other patch=
es (see patch 6, for example).

This is OK, of course, I'm just trying to understand existing logic.

>=20
> I _think_ the reason for this original limitation is as follows: If an im=
age can be resized, we could choose to perform 'create(size=3D0), truncate(=
size=3Dfinal)' instead of 'create(size=3Dfinal)', and we want to guarantee =
the same behavior. If truncation can't guarantee a zero read, then why is c=
reation doing so?

If we want to guarantee the same behavior, we should restrict any differenc=
e between these flags :)

>=20
> But as I did not write the original patch, I would welcome Max's input wi=
th regards to the thought behind commit ceaca56f.
>=20
>>
>> So, the only possible combination of flags, when they differs, is create=
=3D0 and
>> truncate=3D1.. How is it possible?
>=20
> qcow2 had that mode, at least before patch 5.

yes, it reported even for encrypted images truncate=3D1...

>=20
>>
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * Since this bit is only reliable at image cr=
eation, a driver may
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * return this bit even for existing images th=
at do not currently
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * read as zero.
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>>> +=C2=A0=C2=A0=C2=A0 BDRV_ZERO_CREATE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 =3D 0x1,
>>> +
>>> +=C2=A0=C2=A0=C2=A0 /*
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * bdrv_known_zeroes() should include this bit=
 if growing an image
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * with PREALLOC_MODE_OFF (either with no back=
ing file, or beyond
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * the size of the backing file) will read the=
 new data as all
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * zeroes without any additional effort.=C2=A0=
 This bit only matters
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * for drivers that set .bdrv_co_truncate.
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>>> +=C2=A0=C2=A0=C2=A0 BDRV_ZERO_TRUNCATE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
=3D 0x2,
>>> +} BdrvZeroFlags;
>>> +
>>
>> ...
>>
>>
>=20


--=20
Best regards,
Vladimir

