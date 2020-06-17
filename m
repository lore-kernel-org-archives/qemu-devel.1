Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EB50C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 15:32:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8200208B8
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 15:32:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NzI9jdtd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8200208B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44000 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jla39-0003b0-5j
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 11:32:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54832)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jlZxV-00073M-Pu
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 11:26:37 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:45963)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jlZxT-000143-J8
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 11:26:37 -0400
Received: by mail-wr1-x441.google.com with SMTP id c3so2754536wru.12
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 08:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=QAvwiCQZDSGhT7lG+6eVbucTJXrTZAZVAj1OPYLXkLs=;
 b=NzI9jdtd9b2KBaD3lu3ITkFa9q9QEkBannlhNjApuhj60c+y44eFYVINL7z091aXFO
 EkOSV2RT98Nn7RYPNGLjUord6dWUE5q8qpK9pYrVUSU1g49FqCLidLvqRylgh0REhk6K
 03rGiBLcuxDjj6Pp4RgMDJ3vAbgb14Wyd1vwM5YriL9z/mCY1X65s4EPEqF0yrXvTW6y
 t9MoYLmKuwbo/x2NTP+ZznxCgYhzIZkCG6UmDoqU0OrA7Q8uX6Km6KXWINamwoeu77st
 zPi/CtGwcVOvBHTQpMGPQyYtPiRpB4iaC8KhDZsPMZyldM7CkUTj+xMsP6EmXTkhfjXd
 BczQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=QAvwiCQZDSGhT7lG+6eVbucTJXrTZAZVAj1OPYLXkLs=;
 b=RdFuIzDSAKyeY21H3HI0VMvVhHfurT914XwuvSr2mveKIRsILHkmXOuW+6QDuZ3HIV
 2mgBbTQPoYzqATGsPK5+T86A34UekAeqfM6e8BsgqFmf8IzMqmju7Q09dt16aMqXuoY2
 dPofngx8eOIUtKQ+dGT3U+1n4ZxyrT1utRhc/2wPF5Sqx5djOfxb+CqANbDkZrEp7uJG
 sTa7//FwEJQTjD9nFE4NuJvYE5YS9oGN13wW/XZaT7rGfhlJjP3wR8JNY7IUbEv+DAux
 psCvTZh1CNUNX6WmB2XlvV6HcZtS1PxNiJCHvgb6AeeLQwCMhwtoCxMd2pY/btKPapyx
 4+kA==
X-Gm-Message-State: AOAM530JLqVGBVu/T9eZZHbHIMiBWOWKfWGX6O7Z+qdi636qhjC08gE8
 9uxoYNswaR1nwqvSUSkByp4=
X-Google-Smtp-Source: ABdhPJx7UVG0UFE1WtQhU8IsBEv5t2ejM5Ve0XMDht0aMEBIRoUbsdZ29ZEpkA0nmTF2Hfs+cIgQBA==
X-Received: by 2002:a5d:4c45:: with SMTP id n5mr9098412wrt.341.1592407593636; 
 Wed, 17 Jun 2020 08:26:33 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id v27sm37417244wrv.81.2020.06.17.08.26.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 08:26:32 -0700 (PDT)
Date: Wed, 17 Jun 2020 16:26:30 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v2] trace/simple: Fix unauthorized enable
Message-ID: <20200617152630.GN1728005@stefanha-x1.localdomain>
References: <20200527065613.25322-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="dZihrQ6eCIduWT38"
Content-Disposition: inline
In-Reply-To: <20200527065613.25322-1-armbru@redhat.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=stefanha@gmail.com; helo=mail-wr1-x441.google.com
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
Cc: qemu-devel@nongnu.org, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--dZihrQ6eCIduWT38
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 27, 2020 at 08:56:13AM +0200, Markus Armbruster wrote:
> st_set_trace_file() accidentally enables tracing.  It's called
> unconditionally during startup, which is why QEMU built with the
> simple trace backend always writes a trace file "trace-$PID".
>=20
> This has been broken for quite a while.  I didn't track down the exact
> commit.
>=20
> Fix st_set_trace_file() to restore the state.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
> v2: Make st_set_trace_file() less confusing [Stefan]
>=20
>  trace/simple.h |  2 +-
>  trace/simple.c | 20 ++++++++++++++------
>  2 files changed, 15 insertions(+), 7 deletions(-)

Thanks, applied to my tracing tree:
https://github.com/stefanha/qemu/commits/tracing

Stefan

--dZihrQ6eCIduWT38
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl7qNiYACgkQnKSrs4Gr
c8jRxwgAl/+tOtZMXBFUxWxRmEYhWwCyaWcpcq35m/fgzdSF31F66MzWipzYFQqV
ei3720oVg4hIwfs49Lak1cT6zT0hHyE5OoxTMXoXRFiTFd4QB81iSG03C9H8oPuJ
3igUflLE7Ugb/BhjMqfqpLYF+7m6D/y8AToiEWkijrYjUzhEjAmdibWCWZdQRBNc
IyUx1qd8S3bnLdgaf5b6NdCQfXy8hsjj3XOViBa+CQjpzbV8Fy22CEUmOnhRmMjt
WGXX9tjZ9ej0CLbmgUjOJJ8gpMXg8vjlBzL6o4MB6vj57Xc75pLEi4vOR+YFCPr3
pcZMWoJFia7rsICrqt08rIK37o1xEA==
=KVNj
-----END PGP SIGNATURE-----

--dZihrQ6eCIduWT38--

