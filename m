Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15755C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 09:50:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7B6C20671
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 09:50:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vaPoWDQj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7B6C20671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33248 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbhqE-0005Ip-VQ
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 05:50:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59656)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jbhpX-0004Sp-UO
 for qemu-devel@nongnu.org; Thu, 21 May 2020 05:49:35 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:53345)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jbhpX-0003ys-2H
 for qemu-devel@nongnu.org; Thu, 21 May 2020 05:49:35 -0400
Received: by mail-wm1-x342.google.com with SMTP id u1so5032038wmn.3
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 02:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=dab727b92pWIn4BAU5fQNy37+/dwpAGvdumHvUN3T68=;
 b=vaPoWDQj3Qzb+PCro61q715FTpOKdNYpYNSpZDW1cN3rqThhwdA9NbYpTjGfZzmiIq
 RHChNnbiS7pG43KGoUgd0C73Hi3+3K/xbK/5nIdXZZcrlWMpdcAXUyp1nD6TROHswSCp
 puZtgyOUuJ0xOhxp7SR2oVIpK2vRO1BjnmM+xThq9S8gjZd+XgB+/08xT7RkKVsSotsE
 80ycxxn+TtMasnp4hTa+RNOqp/bFIpWF4X4Rcg/sWTmcqWRUMZNmvyYvrOJYhpDktQ2s
 q2DCz30e/zZSs3Jhe1BglJLF+14EpJ+QcjBlsUH2SestcclmajijQpIp/689qNhWVfM7
 Fcyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=dab727b92pWIn4BAU5fQNy37+/dwpAGvdumHvUN3T68=;
 b=lRrGtdpcmuvMVk5huswSnDQkzsZXFBdM7VAsXMkTAwXGwH3J+5H7oAo91rMxm1b9Z8
 2Ceg7yNs8PLKrgUrvVVksU6Vd89aMHXrtElwlsD4Nz21JQdg0n0QAD0zkWT4Ayb1WDHZ
 HMMZook4AhgrPV19X+850kqx1ctkcRwXEB0hl2FIOTzhi69+VLSVbLL7CEMxPuY6LRO+
 mn6t17BOVoHq9kFuCbi7Wjt/FFo23cl9ysNnrrednPLiuMp+j8W3k6XkVOwMFpN1sk1A
 YpU3IwxYoWk6A7JT5hD48vDE3nchFGfUl0rTQ3IIe5J2jwygF3MpQEGRlkcuQMh2SBUN
 h0vQ==
X-Gm-Message-State: AOAM530NDsx9r/kAwAq/a3QCQpvQdHQxSeSPZwdfWsbIyjrWw8gz8HCU
 CxwTg7g8saFqHft7cYAB2ek=
X-Google-Smtp-Source: ABdhPJxC9hRYc6GSBkWDn9jpqQqsFVmrI5+U6cEkeS+dCNZImLgPsUOyY7cAyc1VUixOyUIYNbBS6g==
X-Received: by 2002:a7b:c8c1:: with SMTP id f1mr8813553wml.66.1590054573572;
 Thu, 21 May 2020 02:49:33 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id e5sm5799655wro.3.2020.05.21.02.49.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2020 02:49:32 -0700 (PDT)
Date: Thu, 21 May 2020 10:49:30 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Daniele Buono <dbuono@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/4] coroutine: Add check for SafeStack in sigalstack
Message-ID: <20200521094930.GB251811@stefanha-x1.localdomain>
References: <20200429194420.21147-1-dbuono@linux.vnet.ibm.com>
 <20200429194420.21147-3-dbuono@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="v9Ux+11Zm5mwPlX6"
Content-Disposition: inline
In-Reply-To: <20200429194420.21147-3-dbuono@linux.vnet.ibm.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=stefanha@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Tobin Feldman-Fitzthum <tobin@ibm.com>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--v9Ux+11Zm5mwPlX6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 29, 2020 at 03:44:18PM -0400, Daniele Buono wrote:

s/sigalstack/sigaltstack/ in the commit message.

> LLVM's SafeStack instrumentation cannot be used inside signal handlers
> that make use of sigaltstack().
> Since coroutine-sigaltstack relies on sigaltstack(), it is not
> compatible with SafeStack. The resulting binary is incorrect, with
> different coroutines sharing the same unsafe stack and producing
> undefined behavior at runtime.
> To avoid this, we add a check in coroutine-sigaltstack that throws a
> preprocessor #error and interrupt the compilation if SafeStack is
> enabled.
>=20
> Signed-off-by: Daniele Buono <dbuono@linux.vnet.ibm.com>
> ---
>  util/coroutine-sigaltstack.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/util/coroutine-sigaltstack.c b/util/coroutine-sigaltstack.c
> index f6fc49a0e5..b7cdc959f8 100644
> --- a/util/coroutine-sigaltstack.c
> +++ b/util/coroutine-sigaltstack.c
> @@ -30,6 +30,10 @@
>  #include "qemu-common.h"
>  #include "qemu/coroutine_int.h"
> =20
> +#ifdef CONFIG_SAFESTACK
> +#error "SafeStack does not work with sigaltstack's implementation"
> +#endif

Neither the commit description nor the #error message explain why it
doesn't work. Could it work in the future or is there a fundamental
reason why it will never work?

Stefan

--v9Ux+11Zm5mwPlX6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl7GTqoACgkQnKSrs4Gr
c8jcrwf/UwFu+fdyNgn+DtiSRnBpLULgT8YRZNwClG/2WRhGhXjO98KERAG55kWd
rCpIgDPnxQ6va7kpkBCcwBz9c7nIis7t03aTGHfIVV2CV6GoHWX5Z4A1d5Xe1aeW
f2ErAlOrOf2xz1CEG63dHbZqNP5iicmmh+nVQUNYWIeYtSaBmMUsyK8gHLNe5TwP
hYlaZ07qC8oJ6kLnJauFJZq9RocHVCmtIpNHimnQrACXUOR+ExHd/qLKbgT3vVwq
pYPpLASQYkh0Ei5tCK1GS2yAocvOoe4gAMLiz1fF3MtVCzzhoTnxl2fas9n8LMn6
fjkO2kPHBSRbot3S6ec1j7v98sw5dg==
=jAyN
-----END PGP SIGNATURE-----

--v9Ux+11Zm5mwPlX6--

