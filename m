Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDC61C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 13:09:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A676020702
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 13:09:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A676020702
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59308 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joRci-00068j-0B
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 09:09:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53896)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lma@suse.com>) id 1joRb9-0004Sd-U5
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 09:07:23 -0400
Received: from de-smtp-delivery-102.mimecast.com ([62.140.7.102]:44424)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lma@suse.com>) id 1joRb7-00070w-Co
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 09:07:23 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2057.outbound.protection.outlook.com [104.47.13.57]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-14-svfj8kodOMq4i8vKLPCsdg-1; Thu, 25 Jun 2020 15:07:16 +0200
X-MC-Unique: svfj8kodOMq4i8vKLPCsdg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z7QE1pH2McRv1OUYqOXymye7zULBNjaJot2jw4GTfQcbmO3YHWcXsCt7mNSdvudDdNjFmrJryfZY6NcoYCfphwIpoAIPbaIYMvNkZXAu5Uan5CWJ0zsy+fPqtpq534G8jLz02T9x9z4fhF928RhP5VCDX1HCOgmUirBgvXr2cqivC70mFj+AME8d901MY34RrOUeVhPdYsBHt0yLY+BKLahMPdcjPwxNpzaeTy9uvKvj2kuR3QQXink8KEYnWGf+iTw+uG7ech69Twfk0vpN0NaPC7n+mSYB15T5PBQpqLuvVlKflAqXJxURW78FYebBT4sM0OvErtVKtmh0VfTtHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pTS1kBmEYJJSOg3s6N/41IPrYzj9IggnLFUwUjIKH0Q=;
 b=njOB77iF8fh0upUz4avvjrdyOLJRfzp4GoATpykiVBK2zYVhW3SgZZCGYhG8pRNq2m2P02wgUt40EtOI3Ii4Jt2QbLpkCkSbcM0YcBh6aN6pB0d7mdqSW497q8MG1/TE68KhN2Kfsw8/cwteFlBCKQjr4jUAHvhAzSikWFBOd4UY8odpQN3iHUnriuEIr4OnHL+JbZulJEOgGrcKZQ6Cw6EtqPqUs/UsUoBe2Kbw0EY1ROFmyU36V1mOWvXOMhTd9HqOmkOv96cRepjgiTwNy/6S+AkTBVsg9CPw/4+bxDsZvA9PsNCA2NgiZCpbefvBx7br34R/3ZR2KizLP/HqJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Received: from AM6PR04MB5782.eurprd04.prod.outlook.com (2603:10a6:20b:aa::17)
 by AM6PR04MB5736.eurprd04.prod.outlook.com (2603:10a6:20b:a8::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.21; Thu, 25 Jun
 2020 13:07:14 +0000
Received: from AM6PR04MB5782.eurprd04.prod.outlook.com
 ([fe80::d848:9dea:7742:a55]) by AM6PR04MB5782.eurprd04.prod.outlook.com
 ([fe80::d848:9dea:7742:a55%4]) with mapi id 15.20.3109.027; Thu, 25 Jun 2020
 13:07:14 +0000
From: Lin Ma <LMa@suse.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v2 1/3] block: Add bdrv_co_get_lba_status
Thread-Topic: [PATCH v2 1/3] block: Add bdrv_co_get_lba_status
Thread-Index: AQHWSvGLsxCF3bdHXUiG3AAhm4Y64A==
Date: Thu, 25 Jun 2020 13:07:14 +0000
Message-ID: <AM6PR04MB57820B6AA7FCB70AB82D4EA9C5920@AM6PR04MB5782.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=suse.com;
x-originating-ip: [124.192.225.43]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5910f931-dabc-4023-504f-08d81908ae3f
x-ms-traffictypediagnostic: AM6PR04MB5736:
x-microsoft-antispam-prvs: <AM6PR04MB5736E0C8E5DA4C9ECC6AF654C5920@AM6PR04MB5736.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0445A82F82
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xxUjfOBkjSeynmbYxPj/FlU7/pf86pe776ipXFuYJvIU8STmyrU2J0zy3xy8gNzKsoSzJmepQP1gvdM/M3RcqYuBwmtOomzbe4TYpCKGy93p+vJzeMfax98n/81qCUGpWTjT3wapEXAuDdCEY8pVjAItSGZF5uWNOAyATsBtUEqPZiKkrTkt+8c1gw8e7I6Ldos7RQQo/h20cLOC8npICx8urpkjZ2wh+NiIcVRY9sPRPDdi77ol2+LGQEL1NzH+QuLY5H9XR9eRLrztSv2evIfZEDg858cLw8TH5ujUjk00mTJmWoj5lF2ox9KaOz4RX//T39NZw4f8ABvuNTNb/g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR04MB5782.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(136003)(39860400002)(396003)(366004)(346002)(376002)(2906002)(478600001)(26005)(316002)(4326008)(186003)(33656002)(19627405001)(55236004)(55016002)(66446008)(64756008)(83380400001)(66556008)(5660300002)(8676002)(8936002)(66476007)(71200400001)(86362001)(53546011)(91956017)(52536014)(76116006)(7696005)(6916009)(6506007)(9686003)(66946007)(54906003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: 0XmH8yXrPRvYyZH8ecc6bL/xRdntTTUI6FJvekibVQ0YhYA9cVE4UjJbbzt/5cx+iY/CNZoOny9nMOrNmZaiyY+EbSknfls3La2t1aLA+dffZPw5vqUPBzPajpl4b8lA8sAscXJW/Tw4S3TEnqy+TWPTzJlBQBZ8X3jgOUyPCLSesJlodIDjOcAFIcby3eXhQdgqP4S1QfiU4nVb29yZiJo9WRNCu1OEsmxPqHArkQ20l8K+tcGW3YW4fKLguM1WtcVKiSWxH+UElVZtDN/6xZN3M3VTLonxy0VMMez46po4KdjblOJz16HMSLgluJyTcHTiIzBnbTOS+Ybminym6JqM5E/pmYKOdeMlJ02kZn1oIK71QjYDOWY9Hl/5tG5L11r1MffAbbCcSnE4xEw0HnEfo35OEZM7NvesRacIH4glfsl2wq9ND56DFQQ2GflsmXnGWG+tBpBCBWW3i0+oZ5HiqbRNDMOzWQ3aG25gGIumOoAoqus00tZqxjlVgDcX
x-ms-exchange-transport-forked: True
Content-Type: multipart/alternative;
 boundary="_000_AM6PR04MB57820B6AA7FCB70AB82D4EA9C5920AM6PR04MB5782eurp_"
MIME-Version: 1.0
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5910f931-dabc-4023-504f-08d81908ae3f
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2020 13:07:14.5923 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kS4EEtwWB+b/nAEy0hV9RNUv6UfnSEnYCr8FPt2rP2B6MLKmClEulp8pGc2P87+a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5736
Received-SPF: pass client-ip=62.140.7.102; envelope-from=lma@suse.com;
 helo=de-smtp-delivery-102.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 09:07:17
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: "fam@euphon.net" <fam@euphon.net>, "kwolf@redhat.com" <kwolf@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--_000_AM6PR04MB57820B6AA7FCB70AB82D4EA9C5920AM6PR04MB5782eurp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On 2020-06-25 20:59, Lin Ma wrote:
> From: Stefan Hajnoczi
> Sent: Monday, June 22, 2020 6:25 PM
> ...
>> diff --git a/block/io.c b/block/io.c
>> index df8f2a98d4..2064016b19 100644
>> --- a/block/io.c
>> +++ b/block/io.c
>> @@ -2208,6 +2208,49 @@ int coroutine_fn bdrv_co_pwrite_zeroes(BdrvChild =
*child, int64_t offset,
>>                             BDRV_REQ_ZERO_WRITE | flags);
>>  }
>>
>> +int coroutine_fn
>> +bdrv_co_get_lba_status(BdrvChild *child, int64_t offset, int64_t bytes,
>> +                       uint32_t *num_blocks, uint32_t *is_deallocated)
>
> Missing doc comments.

I'll add the comments.

>> +{
>> +    BlockDriverState *bs =3D child->bs;
>
> Why does this function take a BdrvChild argument instead of
> BlockDriverState? Most I/O functions take BlockDriverState.

OK, I'll use BlockDriverState instead.

>> +    int ret =3D 0;
>> +    int64_t target_size, count =3D 0;
>> +    bool first =3D true;
>> +    uint8_t wanted_bit1 =3D 0;
>> +
>> +    target_size =3D bdrv_getlength(bs);
>> +    if (target_size < 0) {
>> +        return -EIO;
>> +    }
>> +
>> +    if (offset < 0 || bytes < 0) {
>> +        return -EIO;
>> +    }
>> +
>> +    for ( ; offset <=3D target_size - bytes; offset +=3D count) {
>> +        ret =3D bdrv_block_status(bs, offset, bytes, &count, NULL, NULL=
);
>> +        if (ret < 0) {
>> +            goto out;
>> +        }
>> +        if (first) {
>> +            if (ret & BDRV_BLOCK_ZERO) {
>> +                wanted_bit1 =3D BDRV_BLOCK_ZERO >> 1;
>> +                *is_deallocated =3D 1;
>
> This is a boolean. Please use bool instead of uint32_t.

As you mentioned in comment of patch 3/3, is_deallocated boolean is not eno=
ugh
to represent 3 states. I'll keep the uint32_t *, but rename 'is_deallocated=
' to
'provisioning_status'

> Please initialize is_deallocated to false at the beginning of the
> function to avoid accidental uninitialized variable accesses in the
> caller.

It has already been initialized to 0 by 'data =3D g_new0(GetLbaStatusCBData=
, 1);'
in function scsi_disk_emulate_get_lba_status of patch 3/3, Do I still need =
to
initialize it at the beginning of this function?

>> +            } else {
>> +                wanted_bit1 =3D 0;
>> +            }
>> +            first =3D false;
>> +        }
>> +        if ((ret & BDRV_BLOCK_ZERO) >> 1 =3D=3D wanted_bit1) {
>> +            (*num_blocks)++;
>
> If there is a long span of allocated/deallocated blocks then this
> function only increments num_blocks once without counting the number of
> blocks. I expected something like num_blocks +=3D pnum / block_size.  Wha=
t
> is the relationship between bytes, count, and blocks in this function?

OK, I'll change it to '*num_blocks +=3D pnum / bytes;'
The 'bytes' is the logical block size(default value is 512).
In fact, 'count' has the same meaning as 'pnum', It is the number of bytes
(including and immediately following the specified offset) that are known t=
o
be in the same allocated/unallocated state. I'll rename the 'count' to 'pnu=
m'.

Once this function returns, The number of contiguous logical blocks sharing
the same provisioning status as the specified logical block will be saved i=
nto
'num_blocks'.

>> +        } else {
>> +            break;
>> +        }
>> +    }
>> +out:
>> +    return ret;
>> +}
>> +
>>  /*
>>   * Flush ALL BDSes regardless of if they are reachable via a BlkBackend=
 or not.
>>   */
>> diff --git a/include/block/block_int.h b/include/block/block_int.h
>> index 791de6a59c..43f90591b9 100644
>> --- a/include/block/block_int.h
>> +++ b/include/block/block_int.h
>> @@ -1296,6 +1296,11 @@ int coroutine_fn bdrv_co_block_status_from_backin=
g(BlockDriverState *bs,
>>                                                     int64_t *pnum,
>>                                                     int64_t *map,
>>                                                     BlockDriverState **f=
ile);
>> +int coroutine_fn bdrv_co_get_lba_status(BdrvChild *child,
>> +                                        int64_t offset,
>> +                                        int64_t bytes,
>> +                                        uint32_t *num_blocks,
>> +                                        uint32_t *is_deallocated);
>
> Should this function be in include/block/block.h (the public API) so
> that any part of QEMU can call it? It's not an internal API.

I'll move it to include/block/block.h.

--_000_AM6PR04MB57820B6AA7FCB70AB82D4EA9C5920AM6PR04MB5782eurp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<span>On 2020-06-25 20:59, Lin Ma wrote:<br>
</span>
<div>&gt; From: Stefan Hajnoczi<br>
</div>
<div>&gt; Sent: Monday, June 22, 2020 6:25 PM<br>
</div>
<div>&gt; ...<br>
</div>
<div>&gt;&gt; diff --git a/block/io.c b/block/io.c<br>
</div>
<div>&gt;&gt; index df8f2a98d4..2064016b19 100644<br>
</div>
<div>&gt;&gt; --- a/block/io.c<br>
</div>
<div>&gt;&gt; &#43;&#43;&#43; b/block/io.c<br>
</div>
<div>&gt;&gt; @@ -2208,6 &#43;2208,49 @@ int coroutine_fn bdrv_co_pwrite_ze=
roes(BdrvChild *child, int64_t offset,<br>
</div>
<div>&gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; BDRV_REQ_ZERO_WRITE | flags);<br>
</div>
<div>&gt;&gt; &nbsp;}<br>
</div>
<div>&gt;&gt;<br>
</div>
<div>&gt;&gt; &#43;int coroutine_fn<br>
</div>
<div>&gt;&gt; &#43;bdrv_co_get_lba_status(BdrvChild *child, int64_t offset,=
 int64_t bytes,<br>
</div>
<div>&gt;&gt; &#43; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; uint32_t *num_blocks, uint32_t *is_deallocated)<br>
</div>
<div>&gt; <br>
</div>
<div>&gt; Missing doc comments.<br>
</div>
<div><br>
</div>
<div>I'll add the comments.<br>
</div>
<div><br>
</div>
<div>&gt;&gt; &#43;{<br>
</div>
<div>&gt;&gt; &#43; &nbsp; &nbsp;BlockDriverState *bs =3D child-&gt;bs;<br>
</div>
<div>&gt; <br>
</div>
<div>&gt; Why does this function take a BdrvChild argument instead of<br>
</div>
<div>&gt; BlockDriverState? Most I/O functions take BlockDriverState.<br>
</div>
<div><br>
</div>
<div>OK, I'll use BlockDriverState instead.<br>
</div>
<div><br>
</div>
<div>&gt;&gt; &#43; &nbsp; &nbsp;int ret =3D 0;<br>
</div>
<div>&gt;&gt; &#43; &nbsp; &nbsp;int64_t target_size, count =3D 0;<br>
</div>
<div>&gt;&gt; &#43; &nbsp; &nbsp;bool first =3D true;<br>
</div>
<div>&gt;&gt; &#43; &nbsp; &nbsp;uint8_t wanted_bit1 =3D 0;<br>
</div>
<div>&gt;&gt; &#43;<br>
</div>
<div>&gt;&gt; &#43; &nbsp; &nbsp;target_size =3D bdrv_getlength(bs);<br>
</div>
<div>&gt;&gt; &#43; &nbsp; &nbsp;if (target_size &lt; 0) {<br>
</div>
<div>&gt;&gt; &#43; &nbsp; &nbsp; &nbsp; &nbsp;return -EIO;<br>
</div>
<div>&gt;&gt; &#43; &nbsp; &nbsp;}<br>
</div>
<div>&gt;&gt; &#43;<br>
</div>
<div>&gt;&gt; &#43; &nbsp; &nbsp;if (offset &lt; 0 || bytes &lt; 0) {<br>
</div>
<div>&gt;&gt; &#43; &nbsp; &nbsp; &nbsp; &nbsp;return -EIO;<br>
</div>
<div>&gt;&gt; &#43; &nbsp; &nbsp;}<br>
</div>
<div>&gt;&gt; &#43;<br>
</div>
<div>&gt;&gt; &#43; &nbsp; &nbsp;for ( ; offset &lt;=3D target_size - bytes=
; offset &#43;=3D count) {<br>
</div>
<div>&gt;&gt; &#43; &nbsp; &nbsp; &nbsp; &nbsp;ret =3D bdrv_block_status(bs=
, offset, bytes, &amp;count, NULL, NULL);<br>
</div>
<div>&gt;&gt; &#43; &nbsp; &nbsp; &nbsp; &nbsp;if (ret &lt; 0) {<br>
</div>
<div>&gt;&gt; &#43; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;goto out;<br>
</div>
<div>&gt;&gt; &#43; &nbsp; &nbsp; &nbsp; &nbsp;}<br>
</div>
<div>&gt;&gt; &#43; &nbsp; &nbsp; &nbsp; &nbsp;if (first) {<br>
</div>
<div>&gt;&gt; &#43; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if (ret &amp; =
BDRV_BLOCK_ZERO) {<br>
</div>
<div>&gt;&gt; &#43; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
wanted_bit1 =3D BDRV_BLOCK_ZERO &gt;&gt; 1;<br>
</div>
<div>&gt;&gt; &#43; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
*is_deallocated =3D 1;<br>
</div>
<div>&gt; <br>
</div>
<div>&gt; This is a boolean. Please use bool instead of uint32_t.<br>
</div>
<div><br>
</div>
<div>As you mentioned in comment of patch 3/3, is_deallocated boolean is no=
t enough<br>
</div>
<div>to represent 3 states. I'll keep the uint32_t *, but rename 'is_deallo=
cated' to<br>
</div>
<div>'provisioning_status'<br>
</div>
<div><br>
</div>
<div>&gt; Please initialize is_deallocated to false at the beginning of the=
<br>
</div>
<div>&gt; function to avoid accidental uninitialized variable accesses in t=
he<br>
</div>
<div>&gt; caller.<br>
</div>
<div><br>
</div>
<div>It has already been initialized to 0 by 'data =3D g_new0(GetLbaStatusC=
BData, 1);'<br>
</div>
<div>in function scsi_disk_emulate_get_lba_status of patch 3/3, Do I still =
need to<br>
</div>
<div>initialize it at the beginning of this function?<br>
</div>
<div><br>
</div>
<div>&gt;&gt; &#43; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;} else {<br>
</div>
<div>&gt;&gt; &#43; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
wanted_bit1 =3D 0;<br>
</div>
<div>&gt;&gt; &#43; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;}<br>
</div>
<div>&gt;&gt; &#43; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;first =3D fals=
e;<br>
</div>
<div>&gt;&gt; &#43; &nbsp; &nbsp; &nbsp; &nbsp;}<br>
</div>
<div>&gt;&gt; &#43; &nbsp; &nbsp; &nbsp; &nbsp;if ((ret &amp; BDRV_BLOCK_ZE=
RO) &gt;&gt; 1 =3D=3D wanted_bit1) {<br>
</div>
<div>&gt;&gt; &#43; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(*num_blocks)&=
#43;&#43;;<br>
</div>
<div>&gt; <br>
</div>
<div>&gt; If there is a long span of allocated/deallocated blocks then this=
<br>
</div>
<div>&gt; function only increments num_blocks once without counting the num=
ber of<br>
</div>
<div>&gt; blocks. I expected something like num_blocks &#43;=3D pnum / bloc=
k_size. &nbsp;What<br>
</div>
<div>&gt; is the relationship between bytes, count, and blocks in this func=
tion?<br>
</div>
<div><br>
</div>
<div>OK, I'll change it to '*num_blocks &#43;=3D pnum / bytes;'<br>
</div>
<div>The 'bytes' is the logical block size(default value is 512).<br>
</div>
<div>In fact, 'count' has the same meaning as 'pnum', It is the number of b=
ytes<br>
</div>
<div>(including and immediately following the specified offset) that are kn=
own to<br>
</div>
<div>be in the same allocated/unallocated state. I'll rename the 'count' to=
 'pnum'.<br>
</div>
<div><br>
</div>
<div>Once this function returns, The number of contiguous logical blocks sh=
aring<br>
</div>
<div>the same provisioning status as the specified logical block will be sa=
ved into<br>
</div>
<div>'num_blocks'.<br>
</div>
<div><br>
</div>
<div>&gt;&gt; &#43; &nbsp; &nbsp; &nbsp; &nbsp;} else {<br>
</div>
<div>&gt;&gt; &#43; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;break;<br>
</div>
<div>&gt;&gt; &#43; &nbsp; &nbsp; &nbsp; &nbsp;}<br>
</div>
<div>&gt;&gt; &#43; &nbsp; &nbsp;}<br>
</div>
<div>&gt;&gt; &#43;out:<br>
</div>
<div>&gt;&gt; &#43; &nbsp; &nbsp;return ret;<br>
</div>
<div>&gt;&gt; &#43;}<br>
</div>
<div>&gt;&gt; &#43;<br>
</div>
<div>&gt;&gt; &nbsp;/*<br>
</div>
<div>&gt;&gt; &nbsp; * Flush ALL BDSes regardless of if they are reachable =
via a BlkBackend or not.<br>
</div>
<div>&gt;&gt; &nbsp; */<br>
</div>
<div>&gt;&gt; diff --git a/include/block/block_int.h b/include/block/block_=
int.h<br>
</div>
<div>&gt;&gt; index 791de6a59c..43f90591b9 100644<br>
</div>
<div>&gt;&gt; --- a/include/block/block_int.h<br>
</div>
<div>&gt;&gt; &#43;&#43;&#43; b/include/block/block_int.h<br>
</div>
<div>&gt;&gt; @@ -1296,6 &#43;1296,11 @@ int coroutine_fn bdrv_co_block_sta=
tus_from_backing(BlockDriverState *bs,<br>
</div>
<div>&gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; int64_t *pnum,<br>
</div>
<div>&gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; int64_t *map,<br>
</div>
<div>&gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; BlockDriverState **file);<br>
</div>
<div>&gt;&gt; &#43;int coroutine_fn bdrv_co_get_lba_status(BdrvChild *child=
,<br>
</div>
<div>&gt;&gt; &#43; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp;int64_t offset,<br>
</div>
<div>&gt;&gt; &#43; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp;int64_t bytes,<br>
</div>
<div>&gt;&gt; &#43; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp;uint32_t *num_blocks,<br>
</div>
<div>&gt;&gt; &#43; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp;uint32_t *is_deallocated);<br>
</div>
<div>&gt; <br>
</div>
<div>&gt; Should this function be in include/block/block.h (the public API)=
 so<br>
</div>
<div>&gt; that any part of QEMU can call it? It's not an internal API.<br>
</div>
<div><br>
</div>
<span>I'll move it to include/block/block.h.</span><br>
</body>
</html>

--_000_AM6PR04MB57820B6AA7FCB70AB82D4EA9C5920AM6PR04MB5782eurp_--


