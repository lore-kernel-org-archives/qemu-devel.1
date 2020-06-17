Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7B7AC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 12:51:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 937C0214DB
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 12:51:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AJiYKnuj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 937C0214DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57388 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlXWx-0006KJ-O4
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 08:51:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38438)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jlXWG-0005pz-ML
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 08:50:20 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:35104)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jlXWE-0005vC-Lj
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 08:50:20 -0400
Received: by mail-wr1-x442.google.com with SMTP id x14so2232642wrp.2
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 05:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=KUONf8Odr0RsZu6R1Xu+9PMsmgiV3guHsy+iMzaih50=;
 b=AJiYKnujknCqu8UX3v15gTBUsq4bU1ro3H5zOdSdY6Ukk49TE4+Ovdq8tWnf0znqhh
 xJ8eLF/8QjAIYutMe/+87OfQPo/fuKKDEY540yy8Me/lykzJPADsvOPJ3YWjbYy0RPyO
 YGhaZH4zTX3xs0kbCAfkaGoGE6EQZjrGF4EdZE8XltlaesIYcmY+yo4Pt9dutOEBvf3n
 wTWvSq9ag6eDy+H3WFKMtIH0UYtF/oKmma5cREZ5Nfd2aik7kpCjWEX/yyc19HLo5IQy
 sEJ6LPbtFm+1p6BdlYjCCyCBafhamJh1+xBPRRVHXutLyuikfuRBipvvbRSml6CT+g0M
 MhPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=KUONf8Odr0RsZu6R1Xu+9PMsmgiV3guHsy+iMzaih50=;
 b=cVgLRzhmQvmDm7XZpWsEmYUzlzg3LgpYxrB2XnliVS5/Ux7Q1l7Pm1l4tMERtX7wAP
 4AS2kgLSeCw1HHFK7qzI7clil1FX1X0VsJeQG6HJQV5DZKqzU283J9gVYTddu9zSlmJQ
 CHNxwOE/1O+RMwdNosx04RD7yLGGdvRJyWVVrXtwAXPJNUkS7Ao5fyBKEdml9pEVfi7N
 lg0RcjQUh6vZ+BQVNSh8ME1k8uvjkDuZyt2p08m3xN2djtpBrid588x7CLWCZ10U/5Be
 ZTLVyXs/S4tpCfoz9vyC/5HFB+9ImNG2bZ91aaB57a4VglKTnaFGnqBxn1rK1B7pRcqw
 b8ig==
X-Gm-Message-State: AOAM532nA9LaB6sqluJigCrt319sGJdWwXsdGCe7QNYa2rlycBcRn2sy
 3QFWGxJsDehbrazJiZUh4m8Uu9MyZFI=
X-Google-Smtp-Source: ABdhPJy0cr4b1o0yJTY4QutNJKlDQZdeWqq1W/2S4RzamCj8LDPIuJzBMHZwWDYBNGtbZmkSl7s7XA==
X-Received: by 2002:adf:b348:: with SMTP id k8mr9250885wrd.157.1592398217133; 
 Wed, 17 Jun 2020 05:50:17 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id a7sm319033wmh.14.2020.06.17.05.50.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 05:50:16 -0700 (PDT)
Date: Wed, 17 Jun 2020 13:50:14 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Colin Walters <walters@verbum.org>
Subject: Re: [PATCH] virtiofsd: Use clone() and not unshare(),  support
 non-root
Message-ID: <20200617125014.GC1728005@stefanha-x1.localdomain>
References: <348d4774-bd5f-4832-bd7e-a21491fdac8d@www.fastmail.com>
 <20200602095547.GD9852@stefanha-x1.localdomain>
 <7b355ffb-2b96-4984-a198-ac40a07c422e@www.fastmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="B4IIlcmfBL/1gGOG"
Content-Disposition: inline
In-Reply-To: <7b355ffb-2b96-4984-a198-ac40a07c422e@www.fastmail.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=stefanha@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--B4IIlcmfBL/1gGOG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 02, 2020 at 09:53:18PM -0400, Colin Walters wrote:
> On Tue, Jun 2, 2020, at 5:55 AM, Stefan Hajnoczi wrote:
> > Ping Colin. It would be great if you have time to share your thoughts on
> > this discussion and explain how you are using this patch.
>=20
> Yeah sorry about not replying in this thread earlier, this was just a qui=
ck Friday side project for me and the thread obviously exploded =3D)
>=20
> Thinking about this more, probably what would be good enough for now is a=
n option to just disable internal containerization/sandboxing.  In fact per=
 the discussion our production pipeline runs inside OpenShift 4 and because=
 Kubernetes doesn't support user namespaces yet it also doesn't support rec=
ursive containerization, so we need an option to turn off the internal cont=
ainerization.
>=20
> Our use case is somewhat specialized - for what we're doing we generally =
trust the guest.  We use VMs for operating system testing and development o=
f content we trust, as opposed to e.g. something like kata.
>=20
> It's fine for us to run virtiofs as the same user/security context as qem=
u.
>=20
> So...something like this?  (Only compile tested)
=2E..
> @@ -2775,6 +2775,8 @@ static void setup_capabilities(void)
>  static void setup_sandbox(struct lo_data *lo, struct fuse_session *se,
>                            bool enable_syslog)
>  {
> +    if (se->no_namespaces)
> +        return;
>      setup_namespaces(lo, se);
>      setup_mounts(lo->source);
>      setup_seccomp(enable_syslog);

Something along these lines should work. Hopefully seccomp can be
retained. It would also be necessary to check how not having the shared
directory as / in the mount namespace affects functionality. For one,
I'm pretty sure symlink escapes and similar path traversals outside the
shared directory will be possible since virtiofsd normally relies on /
as protection.

Stefan

--B4IIlcmfBL/1gGOG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl7qEYYACgkQnKSrs4Gr
c8hklAf/WrTt+0+Uqm3gAEWKBUpc+MQKndtGCSr0BKAMGvTzmPJxXW9IjjNI8A5Z
Fch70G4l2mFN6H+kXvdpbJqLA6+qLGJPz+kwt8A/KtNwy9mCoC1bLppdy+jAFz2m
o1vCFGI6TP2zOmLE7/6U2lJUOMb0/0ukVSc1bsoTi2jXSKRMC5MihZyzV2hxPpCF
R8qwJh5G/HKlXAAPD3s9W09LTt/adcUw2BcGr0Af9axAJ3ugUPm+IGFT8O0yuMkU
Hhmpp/vzwfZoQU87TNNrNrvUOXTIb5lTnwfYvty57LxefEhxK4c1wf19kPINNk2i
jPYO2QLlL8P+AvWcuQkgm4aguiUK/Q==
=RKLu
-----END PGP SIGNATURE-----

--B4IIlcmfBL/1gGOG--

