Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48D6DC43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 15:18:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F41AC20786
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 15:18:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="AdCabol+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F41AC20786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40064 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJIf5-0006nA-6M
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 11:18:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60075)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1jJIdN-0005L2-3v
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 11:16:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1jJIdL-0004vc-J8
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 11:16:57 -0400
Received: from mail-am6eur05on2134.outbound.protection.outlook.com
 ([40.107.22.134]:27520 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1jJIdG-0004sN-I4; Tue, 31 Mar 2020 11:16:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aEN58rfDJVB0Y+eRuLAF0wBWn/21+Uc/JjQM8zvsBEdK5//sF2CXvsblQS7GMUSJBwrjNeeSNwUnwCi/D3Uy0OpfhfvQHlmZnhTO7qAynjpmpwo8okunk6E9cuHVqAjxpV12jn8bwYB2dPZNVeUdODluCAS5Jx5fLeEbWH2ybaS6g0kM/eRU3PxTOeQ0LvoTErBdX0nsFY9lKj2Ol9orgOhetXOp/luhCMsYpW/mgaBjJtqzPckjC5O74aTwGhlbC2hM6fjqhmTGjc968rvmqQKHL5IbMVcKFasgbmDV+HTOq8CYj566Eon2eFqNk4tanU0aJfrKURyzoUg5likSCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2MtBXpYXWYY4ubCN2EyrK5wi1PtIL9ZgUxw8nFiEZwk=;
 b=hruQs9moTYc/1Jnz+dB5uTXh9bWjRQpAQ1n0vcFUW7OItsdqw/sPEANkp0b4MYxptpLfd7s1prRZgLFnzCgoVGoOKA4u1lFBskxdOKA7EGr1JkVJ5AE/PkpFGC45Bsji4II1I/iU5Z7VmEiTgx+iFCevKOvfGbeX314r/kdZ+j1TcxZygNyM/1saptX/n+91kzkum4XAiPQC/keh7edpuULi7n8bQEoSTIqH5v9Vlj8E19HPIw5EYsREl49uRGTYm14sTm5HOVBUoFBb3qBzeVVnGxWMDvp02+X1M69tB+dEl6T+uFdX+/x6dNEAB5MoihMH3UL5OhalVdp1myAKhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2MtBXpYXWYY4ubCN2EyrK5wi1PtIL9ZgUxw8nFiEZwk=;
 b=AdCabol+Ol+CClYbrZ+RIIIWclOcNntM/hsy6VZwntV78bS7GeZz3uelBPuZRIiHkYoKgmMcEkmwuIvV+1NzKr1b8YMaQ4Jt95FwqvdfSIEKOgqQcljCT1sw1MlEb8+hfCduEBTkCfGkb3FDBJxY10NVl7KZ7Szjt9Ba3SKa+d4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=dplotnikov@virtuozzo.com; 
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com (20.178.22.27) by
 AM0PR08MB4226.eurprd08.prod.outlook.com (20.179.36.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.20; Tue, 31 Mar 2020 15:16:48 +0000
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::95e6:1da8:1244:d16f]) by AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::95e6:1da8:1244:d16f%4]) with mapi id 15.20.2856.019; Tue, 31 Mar 2020
 15:16:48 +0000
Subject: Re: [PATCH v13 3/4] qcow2: add zstd cluster compression
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
References: <20200331131743.17448-1-dplotnikov@virtuozzo.com>
 <20200331131743.17448-4-dplotnikov@virtuozzo.com>
 <c2bab0c3-a39e-7c4c-49cc-065f366906fc@virtuozzo.com>
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
Message-ID: <882f0f50-bf2a-4c1a-1013-258e9ed29857@virtuozzo.com>
Date: Tue, 31 Mar 2020 18:16:43 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <c2bab0c3-a39e-7c4c-49cc-065f366906fc@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-ClientProxiedBy: AM0PR02CA0103.eurprd02.prod.outlook.com
 (2603:10a6:208:154::44) To AM0PR08MB3745.eurprd08.prod.outlook.com
 (2603:10a6:208:ff::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.64] (178.34.150.115) by
 AM0PR02CA0103.eurprd02.prod.outlook.com (2603:10a6:208:154::44) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20 via Frontend
 Transport; Tue, 31 Mar 2020 15:16:46 +0000
X-Originating-IP: [178.34.150.115]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3f14d3fa-0924-46cb-22b0-08d7d5868812
X-MS-TrafficTypeDiagnostic: AM0PR08MB4226:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR08MB4226CF15BA854816EE68DC19CFC80@AM0PR08MB4226.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0359162B6D
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR08MB3745.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(376002)(346002)(136003)(366004)(39840400004)(396003)(8936002)(81166006)(86362001)(2906002)(36756003)(8676002)(66476007)(52116002)(6666004)(26005)(66946007)(31696002)(5660300002)(16526019)(66556008)(186003)(478600001)(81156014)(53546011)(16576012)(4326008)(6486002)(316002)(31686004)(2616005)(956004);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9X175L5lZIc/pFnHT3pKofpw3dmVrAdAymDJj/HIpYspu4FtXHc4zTVv+8SUcmA3AXVNYL0OH+h0W/M9zGEYKNB2wtObYLKUJZqeY9tUjKaqBgGcq34TUWeGKkwYapxoLLMylklRm5FzAKX3xxWQHioMg6M4B40b7+yR7AVvTLGR5puK11YrjZMbzJ9rslKNBZnlaWvISWbXCNzeonL3+N+bfFWsl+wkIlzhs2TOmsGHQ1bjcbvIpAXYa6Cw62M+f8W2EhfrDmrL2GorBKtVS8Hz0+SwpFF/C1N5IcPUR8uamy/0573RWoyehQ4v4fO7clV7+WF10XCoKttrvcaUtp4HQCpuxckjCzZbFy5MTngw08aQ8MRN2sd5eb1j9OwJZRobMLXaj9A0KcUCIKl+PEbEp0t5dDNGT+xVkwhQ4JBip+5QV/SkZ4i0vMEc2kX/
X-MS-Exchange-AntiSpam-MessageData: S7i5RuXNKsB/yZkHBE+Oah9XWtTqeT5FY838gGf+5zJ1c/ZQeM95V8VWE3D0wyhpSu22IywyiK6YDYADIQC6k+qOYXEq/sP9vAT1xeMzvQA4hS4343m20ngTPkuOLaXv0qZyF0omSjOV1HTzOIv8VQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f14d3fa-0924-46cb-22b0-08d7d5868812
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2020 15:16:48.2617 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cNA4ZdXSLlZy5ayF69zSlMCeF1z3BfPlVEdcXHKayplCeMBZvsAvB4QhNHEuWNd2bBzFKmTb/rvUWuQZHo540V4OyXOF3Vl4OXeeMrjmUzU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4226
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.22.134
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
Cc: kwolf@redhat.com, berto@igalia.com, qemu-block@nongnu.org,
 armbru@redhat.com, mreitz@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 31.03.2020 17:49, Vladimir Sementsov-Ogievskiy wrote:
> 31.03.2020 16:17, Denis Plotnikov wrote:
>> zstd significantly reduces cluster compression time.
>> It provides better compression performance maintaining
>> the same level of the compression ratio in comparison with
>> zlib, which, at the moment, is the only compression
>> method available.
>>
>> The performance test results:
>> Test compresses and decompresses qemu qcow2 image with just
>> installed rhel-7.6 guest.
>> Image cluster size: 64K. Image on disk size: 2.2G
>>
>> The test was conducted with brd disk to reduce the influence
>> of disk subsystem to the test results.
>> The results is given in seconds.
>>
>> compress cmd:
>> =C2=A0=C2=A0 time ./qemu-img convert -O qcow2 -c -o compression_type=3D[=
zlib|zstd]
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 src.img [zlib|zstd]_compressed.img
>> decompress cmd
>> =C2=A0=C2=A0 time ./qemu-img convert -O qcow2
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [zlib|zstd]_compressed.img uncompresse=
d.img
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 compr=
ession=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 decompression
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 zlib=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 zstd=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 zlib=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 zstd
>> ------------------------------------------------------------
>> real=C2=A0=C2=A0=C2=A0=C2=A0 65.5=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 16=
.3 (-75 %)=C2=A0=C2=A0=C2=A0 1.9=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 1.6 (-16 %)
>> user=C2=A0=C2=A0=C2=A0=C2=A0 65.0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 15=
.8=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 5.3=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2.5
>> sys=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 3.3=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 0.2=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 2.0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2.0
>>
>> Both ZLIB and ZSTD gave the same compression ratio: 1.57
>> compressed image size in both cases: 1.4G
>>
>> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
>> QAPI part:
>> Acked-by: Markus Armbruster <armbru@redhat.com>
>> ---
>
> Hi!
>
> I have three suggestions:
>
> 1. return type of qcow2 compression functions is ssize_t, and return=20
> type of zstd is size_t. I think better is not to mix them.
> 2. safe check for ENOMEM in compression part - avoid overflow (=20
> maximum of paranoia :)
> 3. slightly more tolerate sanity check in decompression part: allow=20
> zstd to make progress only on one of the buffers
>
> Here is it, and if you like it, take it together with my
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>
> diff --git a/block/qcow2-threads.c b/block/qcow2-threads.c
> index 0b04f30bd8..208218c8f3 100644
> --- a/block/qcow2-threads.c
> +++ b/block/qcow2-threads.c
> @@ -188,7 +188,7 @@ static ssize_t qcow2_zlib_decompress(void *dest,=20
> size_t dest_size,
> =C2=A0static ssize_t qcow2_zstd_compress(void *dest, size_t dest_size,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const void =
*src, size_t src_size)
> =C2=A0{
> -=C2=A0=C2=A0=C2=A0 size_t ret;
> +=C2=A0=C2=A0=C2=A0 ssize_t ret;
> =C2=A0=C2=A0=C2=A0=C2=A0 ZSTD_outBuffer output =3D { dest, dest_size, 0 }=
;
> =C2=A0=C2=A0=C2=A0=C2=A0 ZSTD_inBuffer input =3D { src, src_size, 0 };
> =C2=A0=C2=A0=C2=A0=C2=A0 ZSTD_CCtx *cctx;
> @@ -214,13 +214,14 @@ static ssize_t qcow2_zstd_compress(void *dest,=20
> size_t dest_size,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * We want to use z=
std streamed interface on decompression,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * as we won't know=
 the exact size of the compressed data.
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D ZSTD_compressStream2(=
cctx, &output, &input, ZSTD_e_end);
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ZSTD_isError(ret)) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 size_t zstd_ret =3D ZSTD_comp=
ressStream2(cctx, &output, &input,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ZSTD_e_end);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ZSTD_isError(zstd_ret)) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
ret =3D -EIO;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
goto out;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Dest buffer isn't big=
 enough to store compressed content */
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (output.pos + ret > output=
.size) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (zstd_ret > output.size - =
output.pos) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
ret =3D -ENOMEM;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
goto out;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
I'll apply this part as you suggested
> @@ -248,7 +249,8 @@ out:
> =C2=A0static ssize_t qcow2_zstd_decompress(void *dest, size_t dest_size,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 const void *src, size_t src_size)
> =C2=A0{
> -=C2=A0=C2=A0=C2=A0 size_t ret =3D 0;
> +=C2=A0=C2=A0=C2=A0 ssize_t ret =3D 0;
> +=C2=A0=C2=A0=C2=A0 size_t zstd_ret =3D 0;
> =C2=A0=C2=A0=C2=A0=C2=A0 ZSTD_outBuffer output =3D { dest, dest_size, 0 }=
;
> =C2=A0=C2=A0=C2=A0=C2=A0 ZSTD_inBuffer input =3D { src, src_size, 0 };
> =C2=A0=C2=A0=C2=A0=C2=A0 ZSTD_DCtx *dctx =3D ZSTD_createDCtx();
> @@ -269,8 +271,9 @@ static ssize_t qcow2_zstd_decompress(void *dest,=20
> size_t dest_size,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * ZSTD_decompressStream reads another ONE =
full frame.
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> =C2=A0=C2=A0=C2=A0=C2=A0 while (output.pos < output.size) {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 size_t last_input_pos =3D inp=
ut.pos;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D ZSTD_decompressStream=
(dctx, &output, &input);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 size_t last_progress =3D inpu=
t.pos + output.pos;

These two may overflow last_progress. In that case we have to check them=20
in separate
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 zstd_ret =3D ZSTD_decompressS=
tream(dctx, &output, &input);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * zstd manual does=
n't explicitly states what happens,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * if the read the =
frame partially. But, based on the
> @@ -278,7 +281,7 @@ static ssize_t qcow2_zstd_decompress(void *dest,=20
> size_t dest_size,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * and have read al=
l the frames from the input,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * we end up with e=
rror here.
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ZSTD_isError(ret)) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ZSTD_isError(zstd_ret)) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
ret =3D -EIO;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
break;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> @@ -286,7 +289,7 @@ static ssize_t qcow2_zstd_decompress(void *dest,=20
> size_t dest_size,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Sanity check tha=
t each time we do some progress
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (last_input_pos >=3D input=
.pos) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (last_progress >=3D input.=
pos + output.pos) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
ret =3D -EIO;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
break;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> @@ -297,7 +300,7 @@ static ssize_t qcow2_zstd_decompress(void *dest,=20
> size_t dest_size,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * if not, we somehow managed to get uncomp=
ressed cluster
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * greater then the cluster size.
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> -=C2=A0=C2=A0=C2=A0 if (ret > 0) {
> +=C2=A0=C2=A0=C2=A0 if (zstd_ret > 0) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D -EIO;
> =C2=A0=C2=A0=C2=A0=C2=A0 }
I'll apply the changes and resend the series.
Thanks!
>
>
>
>


