Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39F69C352A2
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 12:09:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2EB220838
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 12:09:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Fs35TzA8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2EB220838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55162 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j02RR-00041M-2f
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 07:09:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42310)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j02QC-0003Ej-0G
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 07:07:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j02QA-0005o5-OB
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 07:07:43 -0500
Received: from mail-eopbgr00117.outbound.protection.outlook.com
 ([40.107.0.117]:48036 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1j02Q5-0005kM-Vh; Fri, 07 Feb 2020 07:07:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HrZlqycqsuR67m09+Fad3IHWXsPUzKezhVcmtVLtKYGYh75b7PbXT9koc1MQc5twTxhHZjJvRZeRXjz4rdEpRyMb5QnY8R6NIhYfcZummlQB30n/IXSQ0Lcb60G0YTATHw1MIq098E06PW09wbF7wo9uVzNJ8UN6SftvYvdaU/bPmnXjrswMJgP+dIkHPNQa+Fvm+4xdtjn0ZCOGZHXeHN/2HJbgpdKXXYDdaF0uHCYLXRdQx5FKKKEg7v34BZukGj3k40ygp2xR04uCB9GIDRx5y2/5Ml8qbfRrSJ8tabhds4s16/NHG0he5TtFSMQituqqQFXd+vR1rymDrIo6qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wQYGHtqgUKAHiwPTvexAk6D+zO2YMX5kjaummTanSZ8=;
 b=SRvKSITv84YyD0w9qgcjCd13vRMO6gBv4R/9fwktyXMNNFTCse1ux+NgW/xk43i9Y6gkOoqnqmi7YdBgjbKLgcoBoXPWmrKV3VVXLkfvQwOzL2wtaYCcdCS6xe46SOS0CGxvWARDeM36iKWPFBEKNOmIECebKdkEltnf5sxs9GaqZbX5dPBEAKCWcmBGyrw0Irj65FBmU2JRWN4FcJ+grGYuC+dEIwMKcpcCS22kdYKv25LCB2AUt58yRW/SeDl3zOA5EOq4XB9Jau6chKvWUqJA3fYAzvd7Qojbq/IOI5+i9jRzD14mHa9Xco8+tztZvO56h1xOFOUdMlajADw3hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wQYGHtqgUKAHiwPTvexAk6D+zO2YMX5kjaummTanSZ8=;
 b=Fs35TzA8cyLZbiAkcpcJtW8WL/EPCHL61+6BnYcnR1UiwAIFJaEtcq4e3X1XYn19GXrq04j3txuQ3+ITbUM31qt0EfTtCDcMfGmb3yBEB6yoDG7he/OKLYqEMWeNrUWFVXtqhyYzr4nwEe0ca++QRFz66gJlUzHdQlnvDqHbrJI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB5217.eurprd08.prod.outlook.com (10.255.98.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21; Fri, 7 Feb 2020 12:07:35 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664%4]) with mapi id 15.20.2707.023; Fri, 7 Feb 2020
 12:07:35 +0000
Subject: Re: [PATCH v3 1/1] qemu-img: Add --target-is-zero to convert
To: Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>,
 David Edmondson <david.edmondson@oracle.com>, qemu-devel@nongnu.org
References: <20200204095246.1974117-1-david.edmondson@oracle.com>
 <20200204095246.1974117-2-david.edmondson@oracle.com>
 <90f3f74b-6154-d7ce-4e0e-ba4422f7da11@redhat.com>
 <91c3d45b-4c27-d366-6dd9-5c27164cce35@virtuozzo.com>
 <92ca6082-a3a6-c116-d1cc-e9810280c0c6@redhat.com>
 <38ac63ec-af49-d9d5-c1d4-e45614b71d4c@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200207150733133
Message-ID: <f110458f-b3e7-6301-64bf-2b4957f3601e@virtuozzo.com>
Date: Fri, 7 Feb 2020 15:07:33 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <38ac63ec-af49-d9d5-c1d4-e45614b71d4c@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: HE1PR07CA0043.eurprd07.prod.outlook.com
 (2603:10a6:7:66::29) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
MIME-Version: 1.0
Received: from [172.16.24.200] (185.231.240.5) by
 HE1PR07CA0043.eurprd07.prod.outlook.com (2603:10a6:7:66::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.13 via Frontend Transport; Fri, 7 Feb 2020 12:07:34 +0000
X-Tagtoolbar-Keys: D20200207150733133
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: af3ebebc-64f6-4f58-a9bc-08d7abc65151
X-MS-TrafficTypeDiagnostic: AM6PR08MB5217:
X-Microsoft-Antispam-PRVS: <AM6PR08MB521732552511B34AFD4E89B9C11C0@AM6PR08MB5217.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0306EE2ED4
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(136003)(376002)(396003)(39850400004)(366004)(346002)(199004)(189003)(26005)(2906002)(52116002)(6486002)(36756003)(66556008)(31696002)(81156014)(81166006)(4326008)(66476007)(186003)(16526019)(316002)(16576012)(66946007)(8936002)(8676002)(110136005)(86362001)(478600001)(956004)(2616005)(31686004)(53546011)(5660300002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB5217;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1i+pjLU2WOqus45WAQjX2ZxauAOmdVA6zZ22T1qkqY+TjzSDoSxK1EyuZ1Ct0IoO9K/BbCAuWRjg00pJ9N+9+an4bBfnqI3BrpqnbZYJxrFF/4GlVaL35qwTpDK0kfE4kC/JRG7cM/AelbGdTA5H1V0gIOZNKPdfAr79H7ozTOdmd8egs73AAgFXeABvZAJGC48i6Nl2wYPDf0QoAsdARCSvtUXMHT6FTR7iiy9z2iCU7Biokzpl/g4zFoyMvoZi0uA/U6xiXmkogZWHcgexo3URL6bZRa+iJXpiCyqG+VJDPTu0va1BJ4SR8MhNSN3FdwhvHqPdg2jQrUtIJNN/NIQdIlBhN2lLLqMggLPx6xkTLZ/zLSp/MJ3TJkYRSaIlzrzaGQEaCdawRWasfwpvVQnDhJCgYQHyFfemUz9B3bx0jnGRYJFqyAOXQWHco5qB
X-MS-Exchange-AntiSpam-MessageData: Yi2drmH9XaSWtwmEDwteOlJ68Dm/fMhFqDrgDqETeYGSjzApRUaarVMIWDgGSyJEhRFaEDU1hDbZMbR9epVZoITBc+WzS2yegiThVu/tiGLkD4SpveOos7yEsXEIOD5i49X1wy5CNf3XJTZqKOOprg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af3ebebc-64f6-4f58-a9bc-08d7abc65151
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2020 12:07:35.3524 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ozD9wGC415M62u65Q7USbAN0hueb6PnsYdSGWj2EY/3om/vwTIe+wkw31l9UmyC0Q69mJ+w3N0I/pOFiuVwk8eLHX72/J2t2Hg36wt9PMzQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5217
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.0.117
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
Cc: qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

07.02.2020 13:33, Max Reitz wrote:
> On 04.02.20 15:23, Eric Blake wrote:
>> On 2/4/20 7:59 AM, Vladimir Sementsov-Ogievskiy wrote:
>>
>>>> I understand that it is safer to have restrictions now and lift them
>>>> later, than to allow use of the option at any time and leave room for
>>>> the user to shoot themselves in the foot with no way to add safety
>>>> later.=C2=A0 The argument against no backing file is somewhat
>>>> understandable (technically, as long as the backing file also reads
>>>> as all zeroes, then the overall image reads as all zeroes - but why
>>>> have a backing file that has no content?); the argument requiring -n
>>>> is a bit weaker (if I'm creating an image, I _know_ it reads as all
>>>> zeroes, so the --target-is-zero argument is redundant, but it
>>>> shouldn't hurt to allow it).
>>>
>>> I know that it reads as all zeroes, only if this format provides zero
>>> initialization..
>>>
>>>>
>>>>> +++ b/qemu-img.c
>>>>
>>>>> @@ -2247,6 +2256,11 @@ static int img_convert(int argc, char **argv)
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 warn_report("=
This will become an error in future QEMU
>>>>> versions.");
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>> +=C2=A0=C2=A0=C2=A0 if (s.has_zero_init && !skip_create) {
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_report("--target-is=
-zero requires use of -n flag");
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto fail_getopt;
>>>>> +=C2=A0=C2=A0=C2=A0 }
>>>>
>>>> So I think we could drop this hunk with no change in behavior.
>>>
>>> I think, no we can't. If we allow target-is-zero, with -n, we'd better
>>> to check that what we are creating is zero-initialized (format has
>>> zero-init), and if not we should report error.
>>>
>>
>> Good call.=C2=A0 Yes, if we allow --target-is-zero without -n, we MUST i=
nsist
>> that bdrv_has_zero_init() returns 1 (or, after my followup series,
>> bdrv_known_zeroes() includes BDRV_ZERO_CREATE).
>=20
> Why?
>=20
> I could imagine a user creating a qcow2 image on some block device with
> preallocation where we cannot verify that the result will be zero.  But
> they want qemu not to zero the device, so they would specify
> --target-is-zero.

If user create image, setting --target-is-zero is always valid. But if we i=
n
same operation create the image automatically, having --target-is-zero, whe=
n
we know that what we are creating is not zero is misleading and should
fail..

If we want to add a behavior to skip zeros unconditionally, we should call =
new
option --skip-zeroes, to clearly specify what we want.

>=20
> OTOH, we can always choose to allow that behavior at a later point.
>=20
> Max
>=20


--=20
Best regards,
Vladimir

