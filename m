Return-Path: <SRS0=6DzB=ZD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F7A0C43331
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 10:07:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09EAC214E0
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 10:07:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JxQbeVrI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09EAC214E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50430 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iU6bZ-0002Uz-4s
	for qemu-devel@archiver.kernel.org; Mon, 11 Nov 2019 05:07:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45907)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sgarzare@redhat.com>) id 1iU6au-00022q-DI
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 05:06:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sgarzare@redhat.com>) id 1iU6at-00069B-87
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 05:06:48 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43581
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1iU6at-000694-49
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 05:06:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573466806;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kXHKdeXQQV0L0y5nl168v0HCbvS9Pk5W52JaTMiSJbU=;
 b=JxQbeVrIccDRr6811dVFZuKhd0ljue+46ZGMb9vAp17PuU38tbPbghpm531jLFrqac7jnX
 7XhA7SgGH7g4pTgTjR2+IG2NOAjv9Y4LH8eWo9FQVVMQYVrWX0PPTlpvmy9YxRoU/DOWfg
 EGaWIE+l/BRE+TwMrqecty2bkD5miYg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-388-PiXzSHGyMKmOSYWEypA-Uw-1; Mon, 11 Nov 2019 05:06:45 -0500
Received: by mail-wr1-f69.google.com with SMTP id e3so9561317wrs.17
 for <qemu-devel@nongnu.org>; Mon, 11 Nov 2019 02:06:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=NWtC/+rTzRpdv6M8je3X7t8oHi07Rfa8UGGXXQzkY28=;
 b=Np4fgwewxuTcX+H90c2oA3KpIBQAybw87XEMHWKo5FvZ+M1b5ryqXN/ocVQd4aQmRO
 dkQxUCds9S+ujrlvx9Y/nBmtoqtxNAP1aXJL1xaY8cI/AjYfk5HNxUwkn+Ma9msVAq7e
 4Tx/sl0gof4H0wZJy9u3tqKXZHek5x/YhdValrQmc69yp1NiQ1h26JgcRMowsVlf5gQq
 ZKqzpziBU6uEPO9246wCwfQq9g71V8+HLH3G/tJGU10ECFM61BRlRj3abTfC0zA//Eds
 ROw30yXzp++Q1QvWOzPGYqbvn4iHbkVXh1kdRJ3SNVQDyq+yiXXFpe3DoYEZ1fFzRhT8
 gzAg==
X-Gm-Message-State: APjAAAVrvEjLJwLJn8khmA2UoFRVtRg9+6DPWodRZbuezfdZK7vT7b12
 bD7w9r1UPiFaUu17qWKbkeyw6iyEzaujExXRwnREYl9p9vxYFqPUNWgUMNIePxgYiNFGiYqRVsY
 5CmQ4aiBl/InyPkA=
X-Received: by 2002:a1c:b1c3:: with SMTP id a186mr20270559wmf.10.1573466804266; 
 Mon, 11 Nov 2019 02:06:44 -0800 (PST)
X-Google-Smtp-Source: APXvYqxWqBMWczXo84etWcUMG9N3t+NKrjt+i8C5o1RZDY0C3ElPSU1dHWWWbnUDay3DkIIOqJ/peg==
X-Received: by 2002:a1c:b1c3:: with SMTP id a186mr20270542wmf.10.1573466804037; 
 Mon, 11 Nov 2019 02:06:44 -0800 (PST)
Received: from steredhat (a-nu5-32.tin.it. [212.216.181.31])
 by smtp.gmail.com with ESMTPSA id 4sm16959881wmd.33.2019.11.11.02.06.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Nov 2019 02:06:43 -0800 (PST)
Date: Mon, 11 Nov 2019 11:06:41 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Wei Yang <richardw.yang@linux.intel.com>
Subject: Re: [PATCH 2/2] core: replace sysconf(_SC_PAGESIZE) with
 qemu_real_host_page_size
Message-ID: <20191111100641.uvi47rjjb3ink5jl@steredhat>
References: <20191015031350.4345-1-richardw.yang@linux.intel.com>
 <20191015031350.4345-3-richardw.yang@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <20191015031350.4345-3-richardw.yang@linux.intel.com>
X-MC-Unique: PiXzSHGyMKmOSYWEypA-Uw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 jasowang@redhat.com, richard.henderson@linaro.org, dgilbert@redhat.com,
 mreitz@redhat.com, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Why "core:" in the commit title?

Perhaps to indicate that the patch concerns different subsystems,
I'd use "qemu: ", but I'm not sure :-)

On Tue, Oct 15, 2019 at 11:13:50AM +0800, Wei Yang wrote:
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> Suggested-by: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> CC: Richard Henderson <richard.henderson@linaro.org>
> ---
>  block/file-posix.c              | 2 +-
>  net/l2tpv3.c                    | 2 +-
>  tests/tcg/multiarch/test-mmap.c | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/block/file-posix.c b/block/file-posix.c
> index 5d1995a07c..853ed42134 100644
> --- a/block/file-posix.c
> +++ b/block/file-posix.c
> @@ -2562,7 +2562,7 @@ static void check_cache_dropped(BlockDriverState *b=
s, Error **errp)
>      off_t end;
> =20
>      /* mincore(2) page status information requires 1 byte per page */
> -    page_size =3D sysconf(_SC_PAGESIZE);
> +    page_size =3D qemu_real_host_page_size;
>      vec =3D g_malloc(DIV_ROUND_UP(window_size, page_size));
> =20
>      end =3D raw_getlength(bs);
> diff --git a/net/l2tpv3.c b/net/l2tpv3.c
> index 55fea17c0f..5f843240de 100644
> --- a/net/l2tpv3.c
> +++ b/net/l2tpv3.c
> @@ -41,7 +41,7 @@
>   * chosen to be sufficient to accommodate one packet with some headers
>   */
> =20
> -#define BUFFER_ALIGN sysconf(_SC_PAGESIZE)
> +#define BUFFER_ALIGN qemu_real_host_page_size
>  #define BUFFER_SIZE 2048
>  #define IOVSIZE 2
>  #define MAX_L2TPV3_MSGCNT 64
> diff --git a/tests/tcg/multiarch/test-mmap.c b/tests/tcg/multiarch/test-m=
map.c
> index 9ea49e2307..370842e5c2 100644
> --- a/tests/tcg/multiarch/test-mmap.c
> +++ b/tests/tcg/multiarch/test-mmap.c
> @@ -466,7 +466,7 @@ int main(int argc, char **argv)
>      if (argc > 1) {
>          qemu_strtoul(argv[1], NULL, 0, &pagesize);
>      } else {
> -        pagesize =3D sysconf(_SC_PAGESIZE);
> +        pagesize =3D qemu_real_host_page_size;
>      }
> =20
>      /* Assume pagesize is a power of two.  */

The patch LGTM:
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks,
Stefano


