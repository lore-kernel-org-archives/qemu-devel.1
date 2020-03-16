Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A873AC0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 09:20:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71BF920674
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 09:20:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OlloZLNN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71BF920674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDlv1-0005l6-4c
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 05:20:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36228)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jDlPF-0002Nj-LO
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 04:47:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jDlPE-0004ip-58
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 04:47:29 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50692
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jDlPE-0004fn-04
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 04:47:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584348447;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/eXifeUCAMQQHeVJ6rVrMffetIkCey2N7CnWUIiz7nY=;
 b=OlloZLNN1/GuCxIKozUDKlHeNSij6KARqa77iGTuNFLzrCH+xhODFardl2QYA7QE1moO0a
 mHuCDMzO5cX6jWp4HLRTLFJKoocBrgX9C1oN0LJYZHIgu47vtvby+gwVdymag3JU9ofbmv
 DiSJmMUbD2T3IQkGUWPlSoKGgAJYbcw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-25-cyUcFD9TORSiG0gTJ6KAag-1; Mon, 16 Mar 2020 04:47:26 -0400
X-MC-Unique: cyUcFD9TORSiG0gTJ6KAag-1
Received: by mail-wr1-f69.google.com with SMTP id t10so2385210wrp.15
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 01:47:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=tCKD1kAVUQeiUdQJbaLHjInVTHbaPoxfG9u3/DEMEVQ=;
 b=J2jd/ZAP0rTEr0PFk+GqBWKf/e8gec8L85t8Vn+hlxKqhkq8P4UbdV2A/mmS5AVuV2
 w0nNbJcfqyJfa2fSTepvJmc8V9VFnbAGL0SwI76BmmIQ36rdVcp1hzZvsLgnF/Uv+Ktb
 9vVOGk3hD/wiouFt0EUKVi3fUlOxB/BFbYrxHXrdYu/L+SQCs4RXD4BGKCL5CJlNANMW
 0MJS3aPPamD2iEhiRXL0Y8TxL73tO+r1jtdwdu7RrYvu72ZIJh0ODyohhGsV9uFoaOdD
 zkth1fgj2KJDPAE700o7PQ8l4y9F86R0/D8+hESSVNPzF4bAjfa6hUhNfPn/o49q6qUr
 bbuA==
X-Gm-Message-State: ANhLgQ24sZZ3l9jWkVARqQFascF+BfiYWp8YznAkw496NpFdQqzL8fQ6
 jadeLwj9ZNyY1KZbk/lFcoeqjrZHbsVyoCJBI2bWCfNeJ2SkTB8+celqIfruGGecstQUr6JzXwr
 y4wLikrdI27fiik4=
X-Received: by 2002:adf:f80d:: with SMTP id s13mr8571896wrp.426.1584348444970; 
 Mon, 16 Mar 2020 01:47:24 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vu6rES9G4E1oG2QgntGJmTPoLYOEjIR5LYze+I4l/zQkSr485GbRNTLU5hEZgINpR4aejJOvg==
X-Received: by 2002:adf:f80d:: with SMTP id s13mr8571862wrp.426.1584348444671; 
 Mon, 16 Mar 2020 01:47:24 -0700 (PDT)
Received: from [192.168.1.40] (191.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.191])
 by smtp.gmail.com with ESMTPSA id y69sm30117365wmd.46.2020.03.16.01.47.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Mar 2020 01:47:24 -0700 (PDT)
Subject: Re: [PATCH 1/2] block: bdrv_set_backing_bs: fix use-after-free
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200316060631.30052-1-vsementsov@virtuozzo.com>
 <20200316060631.30052-2-vsementsov@virtuozzo.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <db91173b-f485-b70f-01c1-4087298d4ec9@redhat.com>
Date: Mon, 16 Mar 2020 09:47:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200316060631.30052-2-vsementsov@virtuozzo.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: kwolf@redhat.com, den@openvz.org, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/16/20 7:06 AM, Vladimir Sementsov-Ogievskiy wrote:
> There is a use-after-free possible: bdrv_unref_child() leaves
> bs->backing freed but not NULL. bdrv_attach_child may produce nested
> polling loop due to drain, than access of freed pointer is possible.
>=20
> I've produced the following crash on 30 iotest with modified code. It
> does not reproduce on master, but still seems possible:
>=20
>      #0  __strcmp_avx2 () at /lib64/libc.so.6
>      #1  bdrv_backing_overridden (bs=3D0x55c9d3cc2060) at block.c:6350
>      #2  bdrv_refresh_filename (bs=3D0x55c9d3cc2060) at block.c:6404
>      #3  bdrv_backing_attach (c=3D0x55c9d48e5520) at block.c:1063
>      #4  bdrv_replace_child_noperm
>          (child=3Dchild@entry=3D0x55c9d48e5520,
>          new_bs=3Dnew_bs@entry=3D0x55c9d3cc2060) at block.c:2290
>      #5  bdrv_replace_child
>          (child=3Dchild@entry=3D0x55c9d48e5520,
>          new_bs=3Dnew_bs@entry=3D0x55c9d3cc2060) at block.c:2320
>      #6  bdrv_root_attach_child
>          (child_bs=3Dchild_bs@entry=3D0x55c9d3cc2060,
>          child_name=3Dchild_name@entry=3D0x55c9d241d478 "backing",
>          child_role=3Dchild_role@entry=3D0x55c9d26ecee0 <child_backing>,
>          ctx=3D<optimized out>, perm=3D<optimized out>, shared_perm=3D21,
>          opaque=3D0x55c9d3c5a3d0, errp=3D0x7ffd117108e0) at block.c:2424
>      #7  bdrv_attach_child
>          (parent_bs=3Dparent_bs@entry=3D0x55c9d3c5a3d0,
>          child_bs=3Dchild_bs@entry=3D0x55c9d3cc2060,
>          child_name=3Dchild_name@entry=3D0x55c9d241d478 "backing",
>          child_role=3Dchild_role@entry=3D0x55c9d26ecee0 <child_backing>,
>          errp=3Derrp@entry=3D0x7ffd117108e0) at block.c:5876
>      #8  in bdrv_set_backing_hd
>          (bs=3Dbs@entry=3D0x55c9d3c5a3d0,
>          backing_hd=3Dbacking_hd@entry=3D0x55c9d3cc2060,
>          errp=3Derrp@entry=3D0x7ffd117108e0)
>          at block.c:2576
>      #9  stream_prepare (job=3D0x55c9d49d84a0) at block/stream.c:150
>      #10 job_prepare (job=3D0x55c9d49d84a0) at job.c:761
>      #11 job_txn_apply (txn=3D<optimized out>, fn=3D<optimized out>) at
>          job.c:145
>      #12 job_do_finalize (job=3D0x55c9d49d84a0) at job.c:778
>      #13 job_completed_txn_success (job=3D0x55c9d49d84a0) at job.c:832
>      #14 job_completed (job=3D0x55c9d49d84a0) at job.c:845
>      #15 job_completed (job=3D0x55c9d49d84a0) at job.c:836
>      #16 job_exit (opaque=3D0x55c9d49d84a0) at job.c:864
>      #17 aio_bh_call (bh=3D0x55c9d471a160) at util/async.c:117
>      #18 aio_bh_poll (ctx=3Dctx@entry=3D0x55c9d3c46720) at util/async.c:1=
17
>      #19 aio_poll (ctx=3Dctx@entry=3D0x55c9d3c46720,
>          blocking=3Dblocking@entry=3Dtrue)
>          at util/aio-posix.c:728
>      #20 bdrv_parent_drained_begin_single (poll=3Dtrue, c=3D0x55c9d3d558f=
0)
>          at block/io.c:121
>      #21 bdrv_parent_drained_begin_single (c=3Dc@entry=3D0x55c9d3d558f0,
>          poll=3Dpoll@entry=3Dtrue)
>          at block/io.c:114
>      #22 bdrv_replace_child_noperm
>          (child=3Dchild@entry=3D0x55c9d3d558f0,
>          new_bs=3Dnew_bs@entry=3D0x55c9d3d27300) at block.c:2258
>      #23 bdrv_replace_child
>          (child=3Dchild@entry=3D0x55c9d3d558f0,
>          new_bs=3Dnew_bs@entry=3D0x55c9d3d27300) at block.c:2320
>      #24 bdrv_root_attach_child
>          (child_bs=3Dchild_bs@entry=3D0x55c9d3d27300,
>          child_name=3Dchild_name@entry=3D0x55c9d241d478 "backing",
>          child_role=3Dchild_role@entry=3D0x55c9d26ecee0 <child_backing>,
>          ctx=3D<optimized out>, perm=3D<optimized out>, shared_perm=3D21,
>          opaque=3D0x55c9d3cc2060, errp=3D0x7ffd11710c60) at block.c:2424
>      #25 bdrv_attach_child
>          (parent_bs=3Dparent_bs@entry=3D0x55c9d3cc2060,
>          child_bs=3Dchild_bs@entry=3D0x55c9d3d27300,
>          child_name=3Dchild_name@entry=3D0x55c9d241d478 "backing",
>          child_role=3Dchild_role@entry=3D0x55c9d26ecee0 <child_backing>,
>          errp=3Derrp@entry=3D0x7ffd11710c60) at block.c:5876
>      #26 bdrv_set_backing_hd
>          (bs=3Dbs@entry=3D0x55c9d3cc2060,
>          backing_hd=3Dbacking_hd@entry=3D0x55c9d3d27300,
>          errp=3Derrp@entry=3D0x7ffd11710c60)
>          at block.c:2576
>      #27 stream_prepare (job=3D0x55c9d495ead0) at block/stream.c:150
>      ...
>=20

Apparently:
Fixes: 12fa4af61f (block: Add Error parameter to bdrv_set_backing_hd)
Right?

> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

> ---
>   block.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/block.c b/block.c
> index 957630b1c5..a862ce4df9 100644
> --- a/block.c
> +++ b/block.c
> @@ -2735,10 +2735,10 @@ void bdrv_set_backing_hd(BlockDriverState *bs, Bl=
ockDriverState *backing_hd,
>  =20
>       if (bs->backing) {
>           bdrv_unref_child(bs, bs->backing);
> +        bs->backing =3D NULL;
>       }
>  =20
>       if (!backing_hd) {
> -        bs->backing =3D NULL;
>           goto out;
>       }
>  =20
>=20


