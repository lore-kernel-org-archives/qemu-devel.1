Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 012F2C2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 11:34:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFCF724685
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 11:34:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kZ2lgJzc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFCF724685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuEHI-00016X-HF
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 06:34:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38961)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1iuEG2-0008Pm-7C
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 06:33:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1iuEG1-00073a-7O
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 06:33:14 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:52489)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1iuEG0-000718-US
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 06:33:13 -0500
Received: by mail-wm1-x341.google.com with SMTP id p9so6444409wmc.2
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2020 03:33:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=HrnBG3s59mGnDKtHgk/uHCxnSAkuu7gFD6rieyacomk=;
 b=kZ2lgJzcqMEFPFkSMDcHlw/LcD6CRLqpjkeOmDhCaNKwi3QF9AKPeCnKVo+a0nM/kj
 mSmU5FXiCOHdAwbrKummdOlG0XDyeS39k0TMI+fKTkOzR8yyLov+IW8+hRAVzYYuGgGV
 oOOOn2e9UjZgzTreq6QEBOLLc1Ur0Tx70f9vg1WczV5bCaTIiXPTte96p1kOoGlJnROa
 OhJIreeLWUAuHbzZdSdB4E6kF/YGzhnSUym5od8N4Ph7gSHJACcknZfuGu74hYNzg4DA
 8MPvzv0uH6gFbnh4zblBKPpbzkvcQmIeK9JwLuw1tWJQqjb0+pynBhTlQqWYt7vnicfc
 540g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=HrnBG3s59mGnDKtHgk/uHCxnSAkuu7gFD6rieyacomk=;
 b=uRKnucMFT1bpE9LfhxRbEeKkMp7e+HDzgQLa5hIc9FxeXXkoS8/GbDwq89wvJpjRu5
 AdeaBx740yCp2/47KKP+224nH7Oc+SDMMp9lAN7mwbOlhjfBZOmTWSsrrRrvzFCvmZSp
 N7TyNg/e+UCdhGczboXhO3hIiw5yJRcKsgZ8hhSNdoRKkueORwPXlj5zHinHVOvO+PEE
 btG73iKJauhwDOf/VDNJwpuIJtFjdw6RRO0AlhHErn/Lt03BIDnBevl9ZDJazEpmMNrx
 RH11XjH17SQ0MlhdlJjqIzDgb6Ed2uRRk+GY9NXTNF4Hd+ZZ1UVqwLq/JIkdlxcuFOIP
 pwuw==
X-Gm-Message-State: APjAAAXZXMrCZiRNnZ7n5GtTJZ4KBmjNUdwsqVAkM+67A8Jc9JMPD4+M
 Hx6dMvv/wE3n8XZc0auL1ZI=
X-Google-Smtp-Source: APXvYqwKaV/9ayZHomYuhjMPjGiGEoH4kDOzhctnDlds9fYmWSF+bze3oFe2gO+a9VL1RUnQK8fHYw==
X-Received: by 2002:a7b:c956:: with SMTP id i22mr2598081wml.67.1579692791638; 
 Wed, 22 Jan 2020 03:33:11 -0800 (PST)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id g21sm3562477wmh.17.2020.01.22.03.33.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jan 2020 03:33:10 -0800 (PST)
Date: Wed, 22 Jan 2020 11:33:09 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] vhost: coding style fix
Message-ID: <20200122113309.GB663955@stefanha-x1.localdomain>
References: <20200122080840.592054-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="gj572EiMnwbLXET9"
Content-Disposition: inline
In-Reply-To: <20200122080840.592054-1-mst@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--gj572EiMnwbLXET9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 22, 2020 at 03:08:49AM -0500, Michael S. Tsirkin wrote:
> Drop a trailing whitespace. Make line shorter.
>=20
> Fixes: 76525114736e8 ("vhost: Only align sections for vhost-user")
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  hw/virtio/vhost.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--gj572EiMnwbLXET9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl4oMvUACgkQnKSrs4Gr
c8iGXAf+MjqNvXc8S7yRcZuQ+Z7HaoqN8NNIHsMQFRVuKgFQ211N4BW/C6xHO7p7
F06U3Z146O24mBVsHR/f+NOvElN5syC+LtpAyTt9LVIFCyGV9TM3FZVNKy9QRhYA
Ij/3hwr/fdFM4ez5pXtBifAOB+uoTltl9R+UnTivOdm1f7Ohi2BHegz768xfYOig
Q+yjRgsoNKisPHt0OaImnfWiDS8hzqvf3FKwXAjNWYHZOwiSJ71v9sbKlCDCXXvF
E9OAnxSJZUcHbyKbS+ZFoRKIwp7GacAP7SLySYdGnc3liGUwayeWV81iqCzgzBwH
oGh6a1vKzNLTJbVdllWHgxviykl9Tw==
=I6Lg
-----END PGP SIGNATURE-----

--gj572EiMnwbLXET9--

