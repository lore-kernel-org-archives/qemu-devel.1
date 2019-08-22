Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53F37C3A5A1
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 14:35:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CA6423401
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 14:35:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lYfxvRSn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CA6423401
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0oBo-00005F-8X
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 10:35:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59165)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1i0oA2-00073m-Gj
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 10:34:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1i0oA0-00060H-BH
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 10:33:58 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:34337)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1i0oA0-0005zH-4n
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 10:33:56 -0400
Received: by mail-wm1-x344.google.com with SMTP id e8so7239013wme.1
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2019 07:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=kme/UPewk/B2sEUH3MjLqZyPeLcnm5cZjPBrspN1uj0=;
 b=lYfxvRSnSxASta2zuRA7mOpRdTL4WIpFYPVwsAvPtzoOcW9yptKaX5z46CcsaWXIm7
 dTAbV/SbkY/OnWdI/IBxlyaCElUj0SCEeUhfUKDjBW60uQQ6ysh4wZsNgR2AmQ3Gf3GR
 LtuHDOOGBCPiuhNBx6+zUYC7g6dyVW74pC18C83rQGHjBCeXV4a0hfiNB4KimWlODVvx
 Hcl/echUqJKwRghVcchZoM0tzO9turEWpqz43r3/NVxKVGBAuTdm/e1qc83FZabIpvNL
 zao6/gqUrTj1Q5K6ai6ciZVfNcVUczY9zYry54ND+6OkZE4BHYs8lUc30SF+3uhjuO40
 q/RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=kme/UPewk/B2sEUH3MjLqZyPeLcnm5cZjPBrspN1uj0=;
 b=Oc2nSZG2vQhiWCjxiibI2PSBHr4GyaLTH8c5iNjts3ktjHQPlwUIyYVspm2tHYj3gS
 mQtyCi9JSBRRQ5zxnfSYhwSoD2Zoqp6wzUnqvkWkBIhSxMtAXl5qIXnpJvEQba1X2dfJ
 PdCSyrRffu6/yywFTpZhkJqb8HtidZHDAGYUy0IpggVwjRwt08Zc4+3SCAWz8VYBLqV7
 qprxFAnyzTTcFsW8ftCozlBvtf9HXshIxsz2R0NIu2/v6XpiodvLXg21emXQyQyLTq3i
 7LMvAJbPYB3ClpILJ2oqCcSAqQiXdZ6Z1B2zgeS/voBsR8myl3YNyJRPXr1Ffy6ESVM+
 cp2g==
X-Gm-Message-State: APjAAAV5z+8wEpQ+2O++xP7GhihkkcCKhlsmby9qGri1jLaX8omyipuX
 cAIwu99n+1wptKqHqo1sezY=
X-Google-Smtp-Source: APXvYqxd13dA57x71atkUS2fDct04vah3JYBkvWGjo9EehlyMVU/c1j1cFJSuOZ+HfOfmNVaWY9ltg==
X-Received: by 2002:a1c:be19:: with SMTP id o25mr6603348wmf.54.1566484434705; 
 Thu, 22 Aug 2019 07:33:54 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id r5sm6005936wmh.35.2019.08.22.07.33.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Aug 2019 07:33:53 -0700 (PDT)
Date: Thu, 22 Aug 2019 15:33:52 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Message-ID: <20190822143352.GL20491@stefanha-x1.localdomain>
References: <20190819105753.30913-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Y+Z5jE7Arku/2GrR"
Content-Disposition: inline
In-Reply-To: <20190819105753.30913-1-alex.bennee@linaro.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: Re: [Qemu-devel] [Webpage PATCH] add support page
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


--Y+Z5jE7Arku/2GrR
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 19, 2019 at 11:57:53AM +0100, Alex Benn=E9e wrote:

Good idea!

> +If you have a support question that is not answered by our
> +[documentation](/documentation) you have a number of options available
> +to you.
> +
> +If the question is specifically about the integration of QEMU with the
> +rest of your distribution you may be better served by asking through

s/distribution/Linux distribution/

> +your distribution's support channels. This includes questions about a
> +specifically packaged versions of QEMU. The developers are generally

s/versions/version/

s/developers/QEMU developers/

> +concerned with the latest release and the current state of the [master
> +branch](https://git.qemu.org/?p=3Dqemu.git).

"and do not provide support for QEMU binaries shipped by Linux
distributions".

> +
> +Questions about complex configurations of networking and storage are
> +usually met with a recommendation to use management tool like

s/tool/tools/

> +[virt-manager](https://virt-manager.org/) from the [libvirt
> +project](https://libvirt.org/) to configure and run QEMU.

"Management tools handle the low-level details of setting up devices
that most users should not need to learn."

--Y+Z5jE7Arku/2GrR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl1ep9AACgkQnKSrs4Gr
c8hIvwf+PyLqaNOLUW87Zq1x2wr0StUuWGSam49JEQcebbgejd60eCQ3GcPqWy8b
zlUo4wi7Am0TzOOqsB/EIJF+2Ld9TqZHZ05EOpjsufafnyLXVlKuDf7AB/q/mFKC
Zn3pN5Di4KXkSIiZPjuakLtqVgSFtI59zwvR1HP5mly74yuszbUDvoKJmK11BOH2
sdAVNu+LwnqvuuC1L696qauSHavSIoFiJjrrqrlewcv4WOHl9q36S7L75OTy9zCV
zz9II57HLxRCkVdkm7NKAlQS8EIh6zexhhAprSq9n1cnXQyjaZ5A/S/9W6DGXQb/
GBZMq3H7OtMNl2itX2yjxgSVQxUHYQ==
=ugNG
-----END PGP SIGNATURE-----

--Y+Z5jE7Arku/2GrR--

