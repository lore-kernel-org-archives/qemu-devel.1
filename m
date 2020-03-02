Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30C87C3F2D2
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 11:32:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0A5F2166E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 11:32:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HlExh/1L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0A5F2166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59136 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8jJK-0002Cx-3f
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 06:32:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35360)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j8jHu-00015c-Jx
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 06:31:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j8jHt-00083H-FO
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 06:31:06 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:39845)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j8jHt-000839-8K
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 06:31:05 -0500
Received: by mail-wm1-x342.google.com with SMTP id c24so2775269wml.4
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2020 03:31:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=9wZi5kAlgNUgWe7acdVeV3iKlGdG9HI+9ZrLHDdBWDc=;
 b=HlExh/1LjLdcR8ApzdRKSp3GHuCpUQHQnVpFi7Tjbr1ZlSkpWz/fZ4qgVs+Aq013kj
 5iM4dfAoF+NqEtr0F0RXp0aXDMt1PHwQvFA5UIdpPDhtbyMjLkrRfIDXfZqJvmxVW+tk
 YQ3NQ+CMNJQIQ7Vs+hbMb2AsXtWDtfAJBPKayAMc3+jYrNw80ano1PqkP6AvfL+KRxtc
 G06oYxDgrUlmpuRQ7w6ZMNyVJ/NtaJqnl5UdbS76lKlyinySGGsipffFgN55MxNEw0zh
 CDYAHMZDF917bw/JEl0QR7/d4JCcGsUb2c5m4R8lTN+MUaVwwdKsfn45ooCb7WFfANdV
 u8HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=9wZi5kAlgNUgWe7acdVeV3iKlGdG9HI+9ZrLHDdBWDc=;
 b=X0aGitFZ3u9WveC5MR4xfwgamAdXOk4f5sgpthkHGOzUUk8Q1Flr3my1C/w9x3l9ud
 7tUsOa3BXf524fQkSZJUpZmJuK5ahMTnzX/1GIqyfDCDHAdI15XDsh2TBd1RRtjgBFzc
 K31mI1E/RiWjkwKSDmXKcAb/05KZFsfuJrdAe12pH2P5YQvuwCSGiOvPK/3P1nOP7s42
 xCxRYFdOR0BB6wmDwDZqHyWW5km2EjvF/mlVmwNFQud8v5Q2KqUlr8twJHahHck1QOUx
 XhLvMDZsG+QgLLNoOECU5eDRTNwDOhK8rMQsBIZ9gpU60U/x7P0vayPu+7GahmUCABXq
 PTdQ==
X-Gm-Message-State: APjAAAWP36wxLvTxsW+Dt7LL37kh6P70Xbcm+odnTMC00Mhl7PUr6bTl
 6rAWwCrRJdi/oSZKsrznZYwRIw==
X-Google-Smtp-Source: APXvYqyBKg3pIz73CwgL7wkY7b2aTKBYrpBPvIEvGc9z+MwQOk8o/al5U6oYu8mUj82q/jX8r2xi9Q==
X-Received: by 2002:a1c:1fca:: with SMTP id
 f193mr13754699wmf.160.1583148664077; 
 Mon, 02 Mar 2020 03:31:04 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id d17sm14885452wmb.36.2020.03.02.03.31.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2020 03:31:02 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 134A81FF87;
 Mon,  2 Mar 2020 11:31:02 +0000 (GMT)
References: <20200228153619.9906-1-peter.maydell@linaro.org>
 <20200228153619.9906-11-peter.maydell@linaro.org>
User-agent: mu4e 1.3.9; emacs 27.0.90
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v3 10/33] qemu-doc: move qemu-tech.texi into main section
In-reply-to: <20200228153619.9906-11-peter.maydell@linaro.org>
Date: Mon, 02 Mar 2020 11:31:02 +0000
Message-ID: <87lfojat8p.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Kashyap Chamarthy <kchamart@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> From: Paolo Bonzini <pbonzini@redhat.com>
>
> The only remaining content in qemu-tech.texi is a few paragraphs
> about managed start up options.  Move them in the main section
> about full system emulation.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Message-id: 20200226113034.6741-11-pbonzini@redhat.com
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  Makefile                                           | 2 +-
>  qemu-tech.texi =3D> docs/system/managed-startup.texi | 9 +--------
>  qemu-doc.texi                                      | 5 ++---
>  3 files changed, 4 insertions(+), 12 deletions(-)
>  rename qemu-tech.texi =3D> docs/system/managed-startup.texi (92%)
>
> diff --git a/Makefile b/Makefile
> index 9790a0fd15b..56382a45936 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1120,7 +1120,7 @@ txt: qemu-doc.txt docs/interop/qemu-qmp-ref.txt doc=
s/interop/qemu-ga-ref.txt
>=20=20
>  qemu-doc.html qemu-doc.info qemu-doc.pdf qemu-doc.txt: \
>  	qemu-options.texi \
> -	qemu-tech.texi qemu-option-trace.texi \
> +	qemu-option-trace.texi \
>  	qemu-deprecated.texi qemu-monitor.texi \
>  	qemu-monitor-info.texi \
>          docs/system/quickstart.texi \
> diff --git a/qemu-tech.texi b/docs/system/managed-startup.texi
> similarity index 92%
> rename from qemu-tech.texi
> rename to docs/system/managed-startup.texi
> index 35da6a40af1..ec168095cc4 100644
> --- a/qemu-tech.texi
> +++ b/docs/system/managed-startup.texi
> @@ -1,11 +1,4 @@
> -@node Implementation notes
> -@appendix Implementation notes
> -
> -@menu
> -* Managed start up options::
> -@end menu
> -
> -@node Managed start up options
> +@node managed_startup
>  @section Managed start up options
>=20=20
>  In system mode emulation, it's possible to create a VM in a paused state=
 using
> diff --git a/qemu-doc.texi b/qemu-doc.texi
> index f702dce4557..e4bff7edbee 100644
> --- a/qemu-doc.texi
> +++ b/qemu-doc.texi
> @@ -39,7 +39,6 @@
>  * QEMU System emulator::
>  * QEMU System emulator targets::
>  * Security::
> -* Implementation notes::
>  * Deprecated features::
>  * Recently removed features::
>  * Supported build platforms::
> @@ -144,6 +143,7 @@ accelerator is required to use more than one host CPU=
 for emulation.
>  * vnc_security::       VNC security
>  * network_tls::        TLS setup for network services
>  * gdb_usage::          GDB usage
> +* managed_startup::    Managed startup options
>  @end menu
>=20=20
>  @include docs/system/quickstart.texi
> @@ -159,6 +159,7 @@ accelerator is required to use more than one host CPU=
 for emulation.
>  @include docs/system/vnc-security.texi
>  @include docs/system/tls.texi
>  @include docs/system/gdb.texi
> +@include docs/system/managed-startup.texi
>=20=20
>  @node QEMU System emulator targets
>  @chapter QEMU System emulator targets
> @@ -190,8 +191,6 @@ various targets are mentioned in the following sectio=
ns.
>=20=20
>  @include docs/security.texi
>=20=20
> -@include qemu-tech.texi
> -
>  @include qemu-deprecated.texi
>=20=20
>  @include docs/system/build-platforms.texi


--=20
Alex Benn=C3=A9e

