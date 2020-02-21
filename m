Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFEB3C35646
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 13:56:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9A7F20578
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 13:56:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WTW4ifG5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9A7F20578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58386 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j58mx-0005pU-VB
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 08:56:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38304)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1j58mH-0004on-I4
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:55:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1j58mG-0002ZP-Bd
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:55:37 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:50732)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>)
 id 1j58mG-0002YU-4b; Fri, 21 Feb 2020 08:55:36 -0500
Received: by mail-wm1-x342.google.com with SMTP id a5so1890388wmb.0;
 Fri, 21 Feb 2020 05:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=9e7n7M18RHMSF6frDK17dm7+ja+ezL4VMhtqybc+YYM=;
 b=WTW4ifG5td5/ncAFZUhqCTdtsB+qROkOl+P/G/6SC705aRT4GGSfEHmGMemOo4mbtc
 0hOec5Y7dOdRQGC0Jrd3jPFKPfiWmh4mwIQbAHNDWnK68vVMrSLk/kLrL3hr8OJ7L10G
 po5UQXO7EpYElslR7mN8viZHx0jx7kn8ytO78wOTTKVcYv03jzqeQLDlbpSluSrAvil/
 mxwiuuFqw2CLuHnBSqUkVGeHIexCkmIr9JcHZU17h9/XYTPOGltgI+zHDJdv9ekRUDy7
 3trrpp9CjDgtg4mKDvJtvMBmPcvWa5Mybgao4orOgIzTh+IPWuUpmyDWHgjMcJKXSEuZ
 oMTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=9e7n7M18RHMSF6frDK17dm7+ja+ezL4VMhtqybc+YYM=;
 b=Lu2rHQF7ck2USK5J0eKeRQv0+zwLc5RMucr6Ree9ugZ4HfoG2+bEt7ARyApxyGIYwa
 InUrg9JIWTwJ509lxw6Yu2rvUX+AtGRv9gNKayV4f8IA+37aCT5um+iilhk2/FjXdsA6
 5jSpMcLumfKCf3ftmuDpOr7e7hXxeIzC5ZBuXBNbHQypQtg0ymU6/oQ+NBgbzU2SPUGx
 TBZdPI9cHw9+js+OL3BQxqI69OZ3tHeA6WYxin0fj2qWtxypmEvRjassAPTwQK9hfuj7
 6CBRvxiSvtJUZaeHY5QD6OqwYrqxWPO4Ju9Yzi9QFACwCX9ziNDgI8MyMDJ73uUmwGXf
 n04Q==
X-Gm-Message-State: APjAAAV8IUu8ECR76DtQetyeHGS+Mh3PrAL0xclHZvS+YkSkKtkL/L5A
 U6Eaz/G8/gLpxsdP0dzktFo=
X-Google-Smtp-Source: APXvYqxuwxn4hz4d73mU1NSdZoHPQOD/XLWoLCX27LcVlyGWePU8fesQTsow93PglxFmU/J39kDYPA==
X-Received: by 2002:a1c:e3c2:: with SMTP id a185mr4049027wmh.27.1582293335057; 
 Fri, 21 Feb 2020 05:55:35 -0800 (PST)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id k8sm4135083wrq.67.2020.02.21.05.55.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2020 05:55:34 -0800 (PST)
Date: Fri, 21 Feb 2020 13:55:32 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v3] util/async: make bh_aio_poll() O(1)
Message-ID: <20200221135532.GO1484511@stefanha-x1.localdomain>
References: <20200221093951.1414693-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="KM+e2hnYAO+MCJ5e"
Content-Disposition: inline
In-Reply-To: <20200221093951.1414693-1-stefanha@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--KM+e2hnYAO+MCJ5e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2020 at 09:39:51AM +0000, Stefan Hajnoczi wrote:
> The ctx->first_bh list contains all created BHs, including those that
> are not scheduled.  The list is iterated by the event loop and therefore
> has O(n) time complexity with respected to the number of created BHs.
>=20
> Rewrite BHs so that only scheduled or deleted BHs are enqueued.
> Only BHs that actually require action will be iterated.
>=20
> One semantic change is required: qemu_bh_delete() enqueues the BH and
> therefore invokes aio_notify().  The
> tests/test-aio.c:test_source_bh_delete_from_cb() test case assumed that
> g_main_context_iteration(NULL, false) returns false after
> qemu_bh_delete() but it now returns true for one iteration.  Fix up the
> test case.
>=20
> This patch makes aio_compute_timeout() and aio_bh_poll() drop from a CPU
> profile reported by perf-top(1).  Previously they combined to 9% CPU
> utilization when AioContext polling is commented out and the guest has 2
> virtio-blk,num-queues=3D1 and 99 virtio-blk,num-queues=3D32 devices.
>=20
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
> v3:
>  * Use QSLIST_FOREACH_RCU() and QSLIST_FIRST_RCU() [Paolo]
> v2:
>  * Use QSLIST for BHs and QSIMPLEQ for BHListSlices [Paolo]
>    (Note that I replaced bh =3D atomic_rcu_read(&first_bh) with
>     QSLIST_FOREACH(&bh_list) so there is no memory ordering but I think
>     this is safe.)
>  * Comment clarifications [Paolo]
>=20
> Based-on: 20200220103828.24525-1-pbonzini@redhat.com
>           ("[PATCH] rcu_queue: add QSLIST functions")
> ---
>  include/block/aio.h |  20 +++-
>  tests/test-aio.c    |   3 +-
>  util/async.c        | 237 ++++++++++++++++++++++++++------------------
>  3 files changed, 158 insertions(+), 102 deletions(-)

Thanks, applied to my block tree:
https://github.com/stefanha/qemu/commits/block

Stefan

--KM+e2hnYAO+MCJ5e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl5P4VQACgkQnKSrs4Gr
c8j2wggAnLK1n+ArSzOmtiL+0mQuYpuAnLhRWobP52xzDROgMK8q+650RRhwiWdr
9EahXJ9dabO5lKgiAMMFrWytL6Z44oZBuLh4R+3ubO3mUh70CM8QQWo1HHw86VCH
++JQThOLUOrBTdjyZ7TsATK+mClisqohtvHTQCna/IOse6ZGKFcSGyuuuxrESrH7
jXOg6/3N5mwmgg761Vmt8K+aX2mhObxDYASYFHdW0SLm1EPzo45jaWb7Z0TYhfqS
k7xvxdRJ0ksEsVPMqLiSLtj86RY0/6pwRyRRnpRMMDU+G2OEta/xN30AW8V2VchD
kz+yTGzdOvB8p4Ywd81wAC8Shk3EZA==
=Bt9d
-----END PGP SIGNATURE-----

--KM+e2hnYAO+MCJ5e--

