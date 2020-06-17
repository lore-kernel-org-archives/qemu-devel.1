Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E51EC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 13:50:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDF6820707
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 13:50:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="liPv6prN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDF6820707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60512 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlYSF-0002qS-6f
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 09:50:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55120)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jlYQa-0001AP-Lp
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 09:48:32 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:39364)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jlYQY-0007Zj-Uv
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 09:48:32 -0400
Received: by mail-wr1-x444.google.com with SMTP id t18so2415471wru.6
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 06:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=0mwH6E/0+FcYvmz1WQDgzHW9s38uTme6ggphoPnuCjc=;
 b=liPv6prN7IWv1xf6WHzLwnF1i7Ob2heZ4kHdn80WiQlyJVGctQrJnqkvZUNXPy+eq4
 oPYbkmWZWrkPP8M4J1tQiGQ3GBHerkk/UgHs1hPzkyz+6u/fVe8HrZNiyf57vg08+XGr
 H99urzRgFH03tlL6zapuz0nCrmSx9o/az7fBr3UAp0PzOtamtOynaQmgzyk0xrmBR8YH
 M44kjt9qFPYv74PbZrelRslfBuMtq1FA0bydXoIKtpGmZ2MJerU0kiBqHmbCGqQJ0fMb
 yDo/J9EPxMMChoaFNf09+aC96q3JjaLbTLbIBqCyVFvFZwJdwa+tU/8xzRlGSy5gL2Eq
 9OJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=0mwH6E/0+FcYvmz1WQDgzHW9s38uTme6ggphoPnuCjc=;
 b=Vc4MZAX7uiaJCpW94DMPYlMmtwrGghEhyge6jzdejZA5TIW55leFX+oG7HchSreq/Q
 YhAMe+Jy6MF8KY3lHvJ4ZxkylNQ9v7PLzxzTui3UEkoHLsAUCK6oLkt2hBBxw+n58mVi
 iWotDjWm0euFYs/Kv5ShpW1DtJwWggcDJzPFcONN7okXcB5Lb4b5FL1AQaYNJIuHI3u+
 SG0bVcf2YeewVBClLLUBKu/SU/ptxdR9D0zFzwAcQu/92DSx2sjEMf8B4YFNtUSot35c
 zBsBs+uosaeyIDXv4czwpKEVB87N9mu3r93goejT3+vuezRVcLj5ygqXcwiEo9O2FwLS
 yUwA==
X-Gm-Message-State: AOAM533OgzxbMpjmg60jQEamtr7CdpSw30X3kLOZ1EFFOMSzDTt0K1rq
 HTFEFkvKAAph3adwEnk/qZQ=
X-Google-Smtp-Source: ABdhPJzlm6QXZxaFPfmpdSh61uPMUIFItSkQv9xMsFsAGJWfjDMCAz9/PhII7rhp73pKcDp92sUYRg==
X-Received: by 2002:adf:9163:: with SMTP id j90mr8453967wrj.65.1592401708843; 
 Wed, 17 Jun 2020 06:48:28 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id a3sm497822wmb.7.2020.06.17.06.48.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 06:48:27 -0700 (PDT)
Date: Wed, 17 Jun 2020 14:48:25 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH] minikconf: explicitly set encoding to UTF-8
Message-ID: <20200617134825.GF1728005@stefanha-x1.localdomain>
References: <20200521153616.307100-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="z+pzSjdB7cqptWpS"
Content-Disposition: inline
In-Reply-To: <20200521153616.307100-1-stefanha@redhat.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=stefanha@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Cleber Rosa <crosa@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--z+pzSjdB7cqptWpS
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 21, 2020 at 04:36:16PM +0100, Stefan Hajnoczi wrote:
> QEMU currently only has ASCII Kconfig files but Linux actually uses
> UTF-8. Explicitly specify the encoding and that we're doing text file
> I/O.
>=20
> It's unclear whether or not QEMU will ever need Unicode in its Kconfig
> files. If we start using the help text then it will become an issue
> sooner or later. Make this change now for consistency with Linux
> Kconfig.
>=20
> Reported-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  scripts/minikconf.py | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Thanks, applied to my block tree:
https://github.com/stefanha/qemu/commits/block

Stefan

--z+pzSjdB7cqptWpS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl7qHykACgkQnKSrs4Gr
c8isMQf+J7zph0Z4nxXUbI5fmiRb0p4HosR1qcblM+nOKQ7K8kUgeoDvBx/eXaJf
GFwam17KcoZzzv7GiOYEZ+nGe3A7b0tJJXveH4PT4KY2yNaMIzkgIpbieDbMtgsz
KmDwqpk/yCszzrPt66EZTBd0we19CmbGrhtgklXQzWBgrQzWp2DjneyIHJjM4RrD
Ua86+1SbLljCa5ggS0d+0SG+2Y8nB6II03RfFIrbcRuANdh6Uwutj+ibO2i4DzRc
go6XC1jUySCJ12MDddxsuEIjLuN2BsNa1puVZ7BkpXMu805QQEbdp9JruPW831py
0vaf/kudsU82HPsjVsCgGcOdjqzDdg==
=YzYs
-----END PGP SIGNATURE-----

--z+pzSjdB7cqptWpS--

