Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8403C4332B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 12:23:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 817112078B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 12:23:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="qHlvxVYE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 817112078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33074 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGM7a-0005z5-KI
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 08:23:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49303)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1jGM6f-0004vQ-ML
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 08:23:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1jGM6b-0005kj-8P
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 08:23:01 -0400
Received: from mail-db8eur05on2135.outbound.protection.outlook.com
 ([40.107.20.135]:46176 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1jGM6V-0005hy-R3; Mon, 23 Mar 2020 08:22:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UuJipiwwd7UQwDwtLr6VIaEv198i+VI+uI9ZJujAmBwGTjWvqoqxzwcK7iY4ybYa4/jYdaXiZczG8wdBw71eBaO9eyQ8AkRDMNXm8iPuaJuU25oQlnkAkO5uZX9PmFlo2zbXJb7DYxxP233EcRmfois2GSpsnjB8+Sz8aSedSjCiVBtjyKaeR0t+rI4m8IgdzW6Gj2lBJ0QhR4pSL0pnAWS+UxPXBcfega0t5pAfAKjSLdsOXnGJzqqU62L0z5F7hGPn+G/pVKS/6MaQNXhyArTkAXMQe/hpEPQK0WGWzS+O2v/r4lsxvAPAE551OdlYiX5af0Qd8ldeRStsGwEtPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aLZBu8689t0MLYLTJhJIGpJO+T9x3C0YuDan9wSc1Q4=;
 b=PnCDAF19LBJM+20tYrirjs8UeJd7BQlCfcS3z/Y+d+CNnoSzWI5btdTo9ZgNUZ78TJXaHCt8EoUt3zBvWFRTc/0xIsaTvmRs5CPGgn3+3Upv+UAeI1ezbEYTAWXT/GUsemEtf+ifZTKIicEPIOiBLNGmY8UPUnnRv07vStdn6Q2I1rDl5bGZULHIUosSvrGhOpbYlTEshDFoNLcjw8vE9AsaOpCEHNpW35j8hezzR/GQEiXdywgyBHSFgNJpou+0FVZZKhwpIi9QVgXHExqHBVMz5ug/jsiePOkoRrlpUHtC7IMqZcxjnqeLxd8ZMwPoAkHpeNqPDGl1Y43wLzkKPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aLZBu8689t0MLYLTJhJIGpJO+T9x3C0YuDan9wSc1Q4=;
 b=qHlvxVYECSTMmiYyT2gVADEdtKDzz9f+h9qbRa5X7OKI0XI6aWF5Rt/UeLFbewjToK0+VpzyyrHw7vfIv1bZbPIMc88IibBGLtbuVniyWm9fzA1oxodelFy336kPyVK+n4ez7Q5V6Tl5gCp8+HomQbi/8+vBtj1SnXkZq26q1Bo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=dplotnikov@virtuozzo.com; 
Received: from VI1PR08MB3760.eurprd08.prod.outlook.com (20.178.80.91) by
 VI1PR08MB5534.eurprd08.prod.outlook.com (52.133.246.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.20; Mon, 23 Mar 2020 12:22:49 +0000
Received: from VI1PR08MB3760.eurprd08.prod.outlook.com
 ([fe80::acf5:3103:8e4d:af20]) by VI1PR08MB3760.eurprd08.prod.outlook.com
 ([fe80::acf5:3103:8e4d:af20%7]) with mapi id 15.20.2835.021; Mon, 23 Mar 2020
 12:22:49 +0000
Subject: Re: [PATCH v8 1/4] qcow2: introduce compression type feature
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
References: <20200321143431.19629-1-dplotnikov@virtuozzo.com>
 <20200321143431.19629-2-dplotnikov@virtuozzo.com>
 <401c0627-a7ad-3434-a861-69f4a5d58d21@virtuozzo.com>
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
Message-ID: <ea557760-b2a5-db20-cb48-fa94a4a2d1e9@virtuozzo.com>
Date: Mon, 23 Mar 2020 15:22:45 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <401c0627-a7ad-3434-a861-69f4a5d58d21@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-ClientProxiedBy: HE1PR0802CA0022.eurprd08.prod.outlook.com
 (2603:10a6:3:bd::32) To VI1PR08MB3760.eurprd08.prod.outlook.com
 (2603:10a6:803:c1::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.64] (94.255.82.30) by
 HE1PR0802CA0022.eurprd08.prod.outlook.com (2603:10a6:3:bd::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.20 via Frontend Transport; Mon, 23 Mar 2020 12:22:48 +0000
X-Originating-IP: [94.255.82.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7190745d-d385-454b-1ba9-08d7cf24e697
X-MS-TrafficTypeDiagnostic: VI1PR08MB5534:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR08MB5534BDC39F78FB46E6F9022FCFF00@VI1PR08MB5534.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-Forefront-PRVS: 0351D213B3
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(4636009)(39840400004)(366004)(346002)(376002)(136003)(396003)(199004)(36756003)(186003)(4326008)(16526019)(5660300002)(316002)(2906002)(16576012)(31686004)(6666004)(66556008)(66476007)(53546011)(86362001)(6486002)(2616005)(478600001)(52116002)(26005)(956004)(31696002)(8676002)(81166006)(81156014)(66946007)(8936002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:VI1PR08MB5534;
 H:VI1PR08MB3760.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UcIweEOpYCQkwgq4gdeIaMEzikcL5HVQ4dr5XMEkSkZY8Kq3Q/klgX+STHc0bFHPM2zbtJZxQLDmWP+RhDUZJTTR5034qstHjlPyE905B+bBRIHdhbxj+HfyhZlIbbLbm7I90KSc/PTtkhLlT6FeidXBnY5BPVfr6YeIWp6pwurWYulJAsbazF79uChj3HIlJ8vKA6MUOv/e880mO51Wjebr/w3B6RWc2uWcagYiCs4uLf1SA0P4jB8KIBIZzyBPYNCSsK7bRleskDjN5w1dmnYTQPPYWcVIX+Xj0jg+zc3Tjer+x2ZpgYe/YlMAvJ/1yP8mgGgzaH0TwiQFqVaQEUjlds8RzVKyn2U7szqEAfiyeXzYzMpv960f2zCcim65UXO5Iv1Ss4lRw/CvhScH8QRoetUESeESu5nhQpsc3cLJl9Z8Y8XPjRK9JLuGtLIw
X-MS-Exchange-AntiSpam-MessageData: ecGWWjKZwKo7QQ6RXDYiF2he8ZP/+pNjlZz4JotSAWQxe6hc9B3xoC1jeyAsauQuHXmwze/Kt7y4dwsqmE7AWXngJlCMedYkUybQ+gh2S4gySK0F80vnTtoplJTpsRlb0G4jOb18LKjuZnJHF9zusQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7190745d-d385-454b-1ba9-08d7cf24e697
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2020 12:22:49.4267 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dFCgj+Ll3Xgt39XQ9o8Nfd2KmZgfTaIHL89W3mT7MNtti1DGmh8x/s3ZBIr7wyL8Y7U9cRYA4fZaW59Tvm7meGtcMyAJM96KmpDGmA5xaYw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB5534
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.20.135
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



On 23.03.2020 11:00, Vladimir Sementsov-Ogievskiy wrote:
> 21.03.2020 17:34, Denis Plotnikov wrote:
>> The patch adds some preparation parts for incompatible compression type
>> feature to qcow2 allowing the use different compression methods for
>> image clusters (de)compressing.
>>
>> It is implied that the compression type is set on the image creation and
>> can be changed only later by image conversion, thus compression type
>> defines the only compression algorithm used for the image, and thus,
>> for all image clusters.
>>
>> The goal of the feature is to add support of other compression methods
>> to qcow2. For example, ZSTD which is more effective on compression=20
>> than ZLIB.
>>
>> The default compression is ZLIB. Images created with ZLIB compression=20
>> type
>> are backward compatible with older qemu versions.
>>
>> Adding of the compression type breaks a number of tests because now the
>> compression type is reported on image creation and there are some=20
>> changes
>> in the qcow2 header in size and offsets.
>>
>> The tests are fixed in the following ways:
>> =C2=A0=C2=A0=C2=A0=C2=A0 * filter out compression_type for many tests
>> =C2=A0=C2=A0=C2=A0=C2=A0 * fix header size, feature table size and backi=
ng file offset
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 affected tests: 031, 036, 061, 080
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 header_size +=3D8: 1 byte compressi=
on type
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 7 bytes =
padding
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 feature_table +=3D 48: incompatible=
 feature compression type
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 backing_file_offset +=3D 56 (8 + 48=
 -> header_change +=20
>> feature_table_change)
>> =C2=A0=C2=A0=C2=A0=C2=A0 * add "compression type" for test output matchi=
ng when it isn't=20
>> filtered
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 affected tests: 049, 060, 061, 065,=
 144, 182, 242, 255
>>
>> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
>> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>
> [...]
>
>> @@ -4859,6 +4949,7 @@ static ImageInfoSpecific=20
>> *qcow2_get_specific_info(BlockDriverState *bs,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 .data_file=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D=
 g_strdup(s->image_data_file),
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 .has_data_file_raw=C2=A0 =3D has_data_file(bs),
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 .data_file_raw=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D data_file_is_raw(bs=
),
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .com=
pression_type=C2=A0=C2=A0 =3D s->compression_type,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* if this assert=
ion fails, this probably means a new=20
>> version was
>> @@ -5248,6 +5339,22 @@ static int=20
>> qcow2_amend_options(BlockDriverState *bs, QemuOpts *opts,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "images");
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else if (!strcmp(desc->nam=
e, BLOCK_OPT_COMPRESSION_TYPE)) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int =
compression_type =3D
>> + qapi_enum_parse(&Qcow2CompressionType_lookup,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_opt_get(opts,=20
>> BLOCK_OPT_COMPRESSION_TYPE),
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -1, errp);
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (=
compression_type =3D=3D -EINVAL) {
>
> You should compare to -1, as qapi_enum_parse returns given default on=20
> error.
ok
>
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 error_setg(errp, "Unknown compression type");
>
> and errp is already set (ofcourse, if qemu_opt_get returned non NULL,=20
> but I hope it is guaranteed by if (!strcmp(desc->name,=20
> BLOCK_OPT_COMPRESSION_TYPE)) condition
I wouldn't propagate the error from qapi_enum_parse because it looks=20
like "invalid parameter value: foo". I think it's better to print=20
"Unknown compression type: foo"
>
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 return -ENOTSUP;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (=
compression_type !=3D s->compression_type) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 error_setg(errp, "Changing the compression type "
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "is not supported");
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 return -ENOTSUP;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 /* if this point is reached, this probably means a new=20
>> option was
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 * added without having it covered here */
>> @@ -5516,6 +5623,12 @@ static QemuOptsList qcow2_create_opts =3D {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 .help =3D "Width of a reference count entry in bits",
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 .def_value_str =3D "16"
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 },
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .nam=
e =3D BLOCK_OPT_COMPRESSION_TYPE,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .typ=
e =3D QEMU_OPT_STRING,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .hel=
p =3D "Compression method used for image cluster=20
>> compression",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .def=
_value_str =3D "zlib"
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 },
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { /* end of list =
*/ }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0 };
>
>
> [...]
>
>


