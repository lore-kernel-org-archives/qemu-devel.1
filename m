Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13B6AC35254
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 14:26:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D20B520702
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 14:26:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="jMdmVEoQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D20B520702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48160 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izLdg-0006Xq-3W
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 09:26:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51522)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1izLcj-0005co-4y
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 09:25:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1izLch-0007LO-TA
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 09:25:49 -0500
Received: from mail-eopbgr80114.outbound.protection.outlook.com
 ([40.107.8.114]:51330 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1izLcd-0006kr-Ri; Wed, 05 Feb 2020 09:25:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jSfto2FxCq0p8ik21OUNRzX18XE0U3YgF8MDe+I+SVfDz+cGenj5BEUv2HKCcYWRSzR3YEANECpfmTucosJiXlqoT3q/4t48+ovmMP9JwMBTjQSI3irNoKyK+Bc0GbGczPPzdEcPc5GnxKW6PXq5SB4XATjT+3CnrHsRaQ90D+Yaq0hK8LREk++l0qNXkmTumhQvRI7mczgBq8f0bw7GA0ERb7eDlEChXBqAiA60uBcfnjXb+4nTVHV4PDyMYFkJUc1YHe88E5OIUIO84KNCrsjjVHagrAfT4f7/fRUcJVYj6hkLavhorB3hyPvvGnSnpwPQ5imx6FbBCfcDCo2GMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mm1zdWrgVxUZeFNB0VMCVKhrhYLQ2tWRBCjYn+vXWvE=;
 b=ELy81zUY0dhniweu5kgIMfm+PF7Wmd403gL+K654k1b8gFEwYWzbHgNHFshqlWOMYZEf8I+xFKNUJKLVgsTFNaEi9F0Y+xjUQ1bL76QCSCBuHJQm/VWmNkyKbt2PzxOgLqnCztDnnurrNl+4Y0tLo5pr5gFXYRRAwlp2ymiVCzntKJ3MD7lVztTaYvKAOX1zpN7Z7R1bK0MI0M5D6B82rP2KnE/8GI8w7pRZNj8OJ07AdiLM5uINP1wCtggxgeA54HCJ+OuFBbY2Fs35aeg2brs9Kc05E6EPbHHDkpBrS7yCGQrb/1FSvsXChSWCp9fGnCLcHOIicUtbBeB0TZqj6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mm1zdWrgVxUZeFNB0VMCVKhrhYLQ2tWRBCjYn+vXWvE=;
 b=jMdmVEoQUm1NVgHxvK6xvBzzlLhdANj5x8ZBlMf2YGVvu8w1ErBq9hoKv3pGVzwYp3HRs8Z1JAAbsiVK43idbC2GbPvixIQ48SoEXJikyBOfxN1e+/Vs/VRnn0mYfEpG0vBoAXQIW+2Kze/F8kbFsFS1DYVXMcg+MG4gvqwELec=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from VI1PR08MB4432.eurprd08.prod.outlook.com (20.179.28.138) by
 VI1PR08MB3087.eurprd08.prod.outlook.com (52.134.123.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21; Wed, 5 Feb 2020 14:25:40 +0000
Received: from VI1PR08MB4432.eurprd08.prod.outlook.com
 ([fe80::9c56:6d95:76d1:d0]) by VI1PR08MB4432.eurprd08.prod.outlook.com
 ([fe80::9c56:6d95:76d1:d0%2]) with mapi id 15.20.2686.034; Wed, 5 Feb 2020
 14:25:40 +0000
Subject: Re: [PATCH 09/17] block: Refactor bdrv_has_zero_init{,_truncate}
To: Eric Blake <eblake@redhat.com>, Max Reitz <mreitz@redhat.com>,
 qemu-devel@nongnu.org
References: <20200131174436.2961874-1-eblake@redhat.com>
 <20200131174436.2961874-10-eblake@redhat.com>
 <339f0a60-1e4f-286c-6594-1153bf284082@virtuozzo.com>
 <62078ab7-b46f-cb70-ffb1-5e84c7e1bee5@redhat.com>
 <8debd8e0-52bd-a962-0877-53dd0e610f1d@virtuozzo.com>
 <945a62b8-6b50-70bf-bb7e-daacc00d5e43@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200205172537432
Message-ID: <c63179c1-671c-20fe-0dbc-4cc570e026a7@virtuozzo.com>
Date: Wed, 5 Feb 2020 17:25:37 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <945a62b8-6b50-70bf-bb7e-daacc00d5e43@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: HE1PR05CA0352.eurprd05.prod.outlook.com
 (2603:10a6:7:92::47) To VI1PR08MB4432.eurprd08.prod.outlook.com
 (2603:10a6:803:102::10)
MIME-Version: 1.0
Received: from [172.16.24.200] (185.231.240.5) by
 HE1PR05CA0352.eurprd05.prod.outlook.com (2603:10a6:7:92::47) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.29 via Frontend Transport; Wed, 5 Feb 2020 14:25:39 +0000
X-Tagtoolbar-Keys: D20200205172537432
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 465c46f1-214a-4ea6-3313-08d7aa4746f8
X-MS-TrafficTypeDiagnostic: VI1PR08MB3087:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR08MB3087CB411924075373FFE0F6C1020@VI1PR08MB3087.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0304E36CA3
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(376002)(39850400004)(396003)(366004)(136003)(346002)(189003)(199004)(956004)(2616005)(31686004)(53546011)(26005)(16526019)(186003)(7416002)(36756003)(81166006)(8676002)(81156014)(8936002)(2906002)(4326008)(110136005)(6486002)(31696002)(66946007)(66476007)(66556008)(478600001)(5660300002)(316002)(52116002)(86362001)(16576012)(54906003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:VI1PR08MB3087;
 H:VI1PR08MB4432.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Dw1vOFbkXuX8WsoUorh2Yfd3EWUa/kazS1cIG8wOewI2NpSccscykQ8gQqJpoeQ73fKN1GhwGUp5piRBKbSUFEk+LARFVsf+DqiyBXlnwsDcr9BSsg6e5zu1A0Hz2ek7SH8/w3bOuTpdBFyKYxYKoqRQAC0jaWeYQZdKlMf3fqhIOQnwpsrsUINiIKtF62uG80euVAtGWglE5THem+HveixOqD0dNNdhX28HZWePbs9mTsgdyZYtdlgdKfZJSO8c4zixiv1O+DJzL7wyaRcoN9XKX/BAp9hdl0cNcOgc/ToFwX3sqfm76vC2n0Wdyt38HozPG5X5oZK3xrY5MD0VTTuhaeVa6dN/bltxv0S6dGHfEpwbacD8MmhwmHb/YISw8/PpgK2KgUDQq4fnLdabMl+F2IV/tJHIP84QgKEAbvzGP33oxrHFnKASkmqkHwsT
X-MS-Exchange-AntiSpam-MessageData: jP0zmOcNRXm4lMxo12KzssjSGRXGQez1oHo2tJm8xhWbWgqVm6Ir9WoEYE8U2fOGoxMJHLZq6gICWGIwa/TAMNZbXzCBnFyXTmig7vmE5AbdXYfvz1GUaJ6YgjqIuuNBk4D6qwgtwFVvoGegyhszIQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 465c46f1-214a-4ea6-3313-08d7aa4746f8
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2020 14:25:40.7404 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VWxXuIZAt0+8Sd88IZ+t8pxmZG+jS5NZouAJLW7f/aJqDbIKDlT17MMB0uCU+KA8a745HNSfCe2lU0UIj7bmNIM+s+oN0xWff01vviCeyHA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3087
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.8.114
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
 Markus Armbruster <armbru@redhat.com>, david.edmondson@oracle.com,
 Stefan Hajnoczi <stefanha@redhat.com>, "Denis V. Lunev" <den@openvz.org>,
 Liu Yuan <namei.unix@gmail.com>, Jason Dillaman <dillaman@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

05.02.2020 17:07, Eric Blake wrote:
> On 2/5/20 1:51 AM, Vladimir Sementsov-Ogievskiy wrote:
>=20
>>>>> +typedef enum {
>>>>> +=C2=A0=C2=A0=C2=A0 /*
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * bdrv_known_zeroes() should include this b=
it if the contents of
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * a freshly-created image with no backing f=
ile reads as all
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * zeroes without any additional effort.=C2=
=A0 If .bdrv_co_truncate is
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * set, then this must be clear if BDRV_ZERO=
_TRUNCATE is clear.
>>>>
>>>> I understand that this is preexisting logic, but could I ask: why?
>>>> What's wrong
>>>> if driver can guarantee that created file is all-zero, but is not sure
>>>> about
>>>> file resizing? I agree that it's normal for these flags to have the sa=
me
>>>> value,
>>>> but what is the reason for this restriction?..
>>>
>>> If areas added by truncation (or growth, rather) are always zero, then
>>> the file can always be created with size 0 and grown from there.=C2=A0 =
Thus,
>>> images where truncation adds zeroed areas will generally always be zero
>>> after creation.
>>
>> This means, that if truncation bit is set, than create bit should be set=
.. But
>> here we say that if truncation is clear, than create bit must be clear.
>=20
> Max, did we get the logic backwards?
>=20
>>
>>>
>>>> So, the only possible combination of flags, when they differs, is
>>>> create=3D0 and
>>>> truncate=3D1.. How is it possible?
>>>
>>> For preallocated qcow2 images, it depends on the storage whether they
>>> are actually 0 after creation.=C2=A0 Hence qcow2_has_zero_init() then d=
efers
>>> to bdrv_has_zero_init() of s->data_file->bs.
>>>
>>> But when you truncate them (with PREALLOC_MODE_OFF, as
>>> BlockDriver.bdrv_has_zero_init_truncate()=E2=80=99s comment explains), =
the new
>>> area is always going to be 0, regardless of initial preallocation.
>>
>> ah yes, due to qcow2 zero clusters.
>=20
> Hmm. Do we actually set the zero flag on unallocated clusters when resizi=
ng a qcow2 image?=C2=A0 That would be an O(n) operation (we have to visit t=
he L2 entry for each added cluster, even if only to set the zero cluster bi=
t).=C2=A0 Or do we instead just rely on the fact that qcow2 is inherently s=
parse, and that when you resize the guest-visible size without writing any =
new clusters, then it is only subsequent guest access to those addresses th=
at finally allocate clusters, making resize O(1) (update the qcow2 metadata=
 cluster, but not any L2 tables) while still reading 0 from the new data.=
=C2=A0 To some extent, that's what the allocation mode is supposed to contr=
ol.

We must mark as ZERO new cluster at least if there is a _larger_ backing fi=
le, to prevent data from backing file become available for the guest. But w=
e don't do it. It's a bug and there is fixing series from Kevin, I've just =
pinged it:
"[PATCH for-4.2? v3 0/8] block: Fix resize (extending) of short overlays"

>=20
> What about with external data images, where a resize in guest-visible len=
gth requires a resize of the underlying data image?=C2=A0 There, we DO have=
 to worry about whether the data image resizes with zeroes (as in the files=
ystem) or with random data (as in a block device).
>=20


--=20
Best regards,
Vladimir

