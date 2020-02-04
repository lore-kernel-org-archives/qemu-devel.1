Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4847DC2D0B1
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 14:02:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 120492082E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 14:02:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="PCjdJLG5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 120492082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59116 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyymK-00068X-8R
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 09:02:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57228)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iyyjV-0002X9-4J
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 08:59:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iyyjT-0008R6-P9
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 08:59:17 -0500
Received: from mail-db8eur05on2134.outbound.protection.outlook.com
 ([40.107.20.134]:58848 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iyyjP-00081h-Ox; Tue, 04 Feb 2020 08:59:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cv8ZOhFkO0n4jOPwk11Ru7kGdO/y4f+992Xyk/sP524fhnUmPPU3ph8skHWudNuOqbnotJBCjOQivjuz8IQs1iWpzT+fTWXegskwjD0ThM0Q1Q4kEQSz6WGP5GDxmbupjkQyI3g+3Sip1SRzR6FZIeL+Wtj19A1qLBbgASBErSQYyAD3pbX9USPJxadoI0JwG+ei/QdwQ4aTcmG9DQqQXdmW/uG2b6C/KpZ/gkvVx+xX3zIzXpz1jaZ0s/UsGlHDGjzhLcWROTq/3G1MYPh2o78tVbshJAYAbrxIic3ii2ZWmoft4bXaPARqC6oxoWJCdRpvrpUYk7Y0na8bEky8Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DwOw79WZUhkbE5kR9Vm3hWdYKBfpJmcYn1dfj7K+eD8=;
 b=c+f3p/hfnlwAz9UME8wETjigtznSf5aqFYTzjWckR3FBhDOhJqZPKPMDDgBoZDn4lRkx4aKwWcCYgF1o/UpHpBeSheTDuY3q/JTM5yW5BU4s86R8OW3nx3+qHhYnZ/5SUbaTz+aqfDt1TIn/ECcK2Kl88PoRKBqGeUh2S9cgewGE5RsOMLwIzqPeMHDG9T3voB7hxBPaip4pYkb57eO2R7WPTULfBhmvluQW0NuZviUsavqAwxt658DjP6c2bnTp5w1rPC+iq6LF+II/XMLEZerVzCSgWKaNs4c6Ej4B4BUwZ1blLbzjhDnZFZG8LNsQJM1sWWShg30+ZDBbXOQkJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DwOw79WZUhkbE5kR9Vm3hWdYKBfpJmcYn1dfj7K+eD8=;
 b=PCjdJLG5f4iTdaxdz0A/b1Yf3VlMXusAkDiUQVfcOgdKNjz62O5rL3b2XFFPqqi+N2X0okyk3ZbJBSy/VILd42p0uWLS/o9kwrY2K5nHptk/ATOjGyWjCwtmCEHdg54u+FKAr/fCaWVN4ESUCkP9HWI/2x/9IL8cG1vXPqxTxW4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB3943.eurprd08.prod.outlook.com (20.178.87.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.30; Tue, 4 Feb 2020 13:59:08 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030%7]) with mapi id 15.20.2686.034; Tue, 4 Feb 2020
 13:59:08 +0000
Subject: Re: [PATCH v3 1/1] qemu-img: Add --target-is-zero to convert
To: Eric Blake <eblake@redhat.com>,
 David Edmondson <david.edmondson@oracle.com>, qemu-devel@nongnu.org
References: <20200204095246.1974117-1-david.edmondson@oracle.com>
 <20200204095246.1974117-2-david.edmondson@oracle.com>
 <90f3f74b-6154-d7ce-4e0e-ba4422f7da11@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200204165905452
Message-ID: <91c3d45b-4c27-d366-6dd9-5c27164cce35@virtuozzo.com>
Date: Tue, 4 Feb 2020 16:59:05 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <90f3f74b-6154-d7ce-4e0e-ba4422f7da11@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: HE1PR05CA0322.eurprd05.prod.outlook.com
 (2603:10a6:7:92::17) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
MIME-Version: 1.0
Received: from [172.16.24.200] (185.231.240.5) by
 HE1PR05CA0322.eurprd05.prod.outlook.com (2603:10a6:7:92::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21 via Frontend Transport; Tue, 4 Feb 2020 13:59:07 +0000
X-Tagtoolbar-Keys: D20200204165905452
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1e4ae704-7b87-4ace-c6cd-08d7a97a6746
X-MS-TrafficTypeDiagnostic: AM6PR08MB3943:
X-Microsoft-Antispam-PRVS: <AM6PR08MB39437BD4D001D274B0D1D006C1030@AM6PR08MB3943.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-Forefront-PRVS: 03030B9493
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(366004)(136003)(39850400004)(376002)(396003)(346002)(189003)(199004)(52116002)(5660300002)(86362001)(956004)(2906002)(2616005)(16526019)(53546011)(26005)(31686004)(4326008)(186003)(81156014)(66556008)(66476007)(8676002)(81166006)(66946007)(8936002)(31696002)(16576012)(316002)(36756003)(6486002)(110136005)(478600001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3943;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hlFpQZbCI40Wz9BWmPrgZjKHfWymHCIrpb1YCrQOmYzTkgoGnEAZutBBKl/DrIednF0d25FBo+SDuGLH6Gvmb6Q955RPiX36lUPi4sChZRXBd2QfHY9YgnXRxluD5npsss68Y9pyqs2vLKTVKx4gMeuSl24QqEQPkb6G7lVv/I/9vXH9YB2dEPQlqUbJmMVBawflqmMfqGm+sygByDJtXWpkzO2PDj3GP6bdM8sjxkRi057orNw1rsz19iHHJ9MSIyLMf3SBb+fVe7wvUl5csim/dAh0JnU/wYnMq8l8vMIHhL060p5K894J8ll2+B1atzWIYWf01Ng+gZIplQHNF6g/B/si6D3V0HO0O51bur1lbREBPs/JsoYLDXI9o0XCPLy8gxvnvUe6+0FrwAJl6XcVDHFnAdX4rvRC/F3NaroiuI5AIMAmb738LcD3mg4j
X-MS-Exchange-AntiSpam-MessageData: REvW2fckQhVnd19rxHCPSXNxdXqGUsQ0dEgWec5guA5kx3SFJweig+jBKgmxUs5eKQw+Up4E5MM8n0vr/EQaEI2EZsupVTvlBIk3xlC2sK+1IrmIXxHpF+T9pz/wJznM+JZwBGd8fsMInclbu3MwvA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e4ae704-7b87-4ace-c6cd-08d7a97a6746
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2020 13:59:08.1309 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qvErosleL6Qjc3eY0BQMi1LO3uvppvqu9jNg8B8bH1OEVjMAXnAnqyMFDVh+M4otuzcwa92V5IU1DCumqgApVC0U9QQr1uI7HFi2VLM1nac=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3943
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.20.134
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

04.02.2020 16:31, Eric Blake wrote:
> On 2/4/20 3:52 AM, David Edmondson wrote:
>> In many cases the target of a convert operation is a newly provisioned
>> target that the user knows is blank (filled with zeroes). In this
>=20
> 'filled with zeroes' is accurate for a preallocated image, but reads awkw=
ardly for a sparse image; it might be better to state 'reads as zero'.
>=20
>> situation there is no requirement for qemu-img to wastefully zero out
>> the entire device.
>>
>> Add a new option, --target-is-zero, allowing the user to indicate that
>> an existing target device is already zero filled.
>>
>> Signed-off-by: David Edmondson <david.edmondson@oracle.com>
>> ---
>> =C2=A0 docs/interop/qemu-img.rst |=C2=A0 8 +++++++-
>> =C2=A0 qemu-img-cmds.hx=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0 4 ++--
>> =C2=A0 qemu-img.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 25 ++++++++++++++++++++++---
>> =C2=A0 3 files changed, 31 insertions(+), 6 deletions(-)
>>
>> diff --git a/docs/interop/qemu-img.rst b/docs/interop/qemu-img.rst
>> index fa27e5c7b453..99bdbe4740ee 100644
>> --- a/docs/interop/qemu-img.rst
>> +++ b/docs/interop/qemu-img.rst
>> @@ -214,6 +214,12 @@ Parameters to convert subcommand:
>> =C2=A0=C2=A0=C2=A0 will still be printed.=C2=A0 Areas that cannot be rea=
d from the source will be
>> =C2=A0=C2=A0=C2=A0 treated as containing only zeroes.
>> +.. option:: --target-is-zero
>> +
>> +=C2=A0 Assume that the destination is filled with zeros. This parameter=
 is
>=20
> Spelled 'zeroes' just three lines earlier.
>=20
>> +=C2=A0 mutually exclusive with the use of a backing file. It is require=
d to
>> +=C2=A0 also use the ``-n`` parameter to skip image creation.
>=20
> I understand that it is safer to have restrictions now and lift them late=
r, than to allow use of the option at any time and leave room for the user =
to shoot themselves in the foot with no way to add safety later.=C2=A0 The =
argument against no backing file is somewhat understandable (technically, a=
s long as the backing file also reads as all zeroes, then the overall image=
 reads as all zeroes - but why have a backing file that has no content?); t=
he argument requiring -n is a bit weaker (if I'm creating an image, I _know=
_ it reads as all zeroes, so the --target-is-zero argument is redundant, bu=
t it shouldn't hurt to allow it).

I know that it reads as all zeroes, only if this format provides zero initi=
alization..

>=20
>> +++ b/qemu-img.c
>=20
>> @@ -2247,6 +2256,11 @@ static int img_convert(int argc, char **argv)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 warn_report("This=
 will become an error in future QEMU versions.");
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 if (s.has_zero_init && !skip_create) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_report("--target-is-ze=
ro requires use of -n flag");
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto fail_getopt;
>> +=C2=A0=C2=A0=C2=A0 }
>=20
> So I think we could drop this hunk with no change in behavior.

I think, no we can't. If we allow target-is-zero, with -n, we'd better to c=
heck that what we are creating is zero-initialized (format has zero-init), =
and if not we should report error.

>=20
>> +
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s.src_num =3D argc - optind - 1;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 out_filename =3D s.src_num >=3D 1 ? argv[=
argc - 1] : NULL;
>> @@ -2380,6 +2394,11 @@ static int img_convert(int argc, char **argv)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s.target_has_backing =3D (bool) out_basei=
mg;
>> +=C2=A0=C2=A0=C2=A0 if (s.has_zero_init && s.target_has_backing) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_report("Cannot use --t=
arget-is-zero with a backing file");
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out;
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>=20
> while keeping this one makes sense.=C2=A0 At any rate, typo fixes are min=
or, and whether or not we drop the hunk I claim is a needless restriction a=
gainst redundancy,
>=20
> Reviewed-by: Eric Blake <eblake@redhat.com>
>=20


--=20
Best regards,
Vladimir

