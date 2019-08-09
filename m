Return-Path: <SRS0=8dir=WF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32C58C31E40
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 09:02:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F416920B7C
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 09:02:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="od4hORKx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F416920B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hw0n4-00050W-AM
	for qemu-devel@archiver.kernel.org; Fri, 09 Aug 2019 05:02:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43880)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stefanha@gmail.com>) id 1hw0md-0004SF-Lb
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 05:02:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1hw0mc-0003xb-Jg
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 05:01:59 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:50299)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1hw0mc-0003vX-B7
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 05:01:58 -0400
Received: by mail-wm1-x342.google.com with SMTP id v15so4937417wml.0
 for <qemu-devel@nongnu.org>; Fri, 09 Aug 2019 02:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=H/AQQy2mRe10U3SxrY7l/IW4FcM8weL94R7QsDdAQeM=;
 b=od4hORKxN4N13Mav6EqMZfWmGLvCMtCQQuX6xyEvZtDmrht5kaCJxxKeczFWcq+Rib
 qjbrUnxPLTj1AqCdf8dH7mu7Pn6X3lm2qR02PFrcGh4e2RWS90zZTmycVZFphWMhPn+S
 TMUAwpkDrvITu3NvC6/eL2+AnXvJALY+cqhrv+0fq9VrE16HlgWvulAIlRB8EL6v3vvx
 KHrETSsGol7rkeVdEkCqIgh3Now0g+wtKLr5fMj97wBcS9ne85ZY0ZIQcoCkqvmEdKuO
 4jQ860YjBDAdAJu8VoDrGwbLThoQU9/Q7jm20AdAgpdoJe62L6QAkqT8qCo+00tAiDLj
 L8KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=H/AQQy2mRe10U3SxrY7l/IW4FcM8weL94R7QsDdAQeM=;
 b=pXePdJfIe2i8olhVV3lyRmjrWdUIP8Vd7Laku0s7rZpgJG6LrLIuGctt9QbLC2wo7u
 2nWtgh9T88fxCWXrpdERWD6sYCPWP5z/6bW/M2llZo5SOJjjDqzXMj+6EzZZgy+EHICG
 fxYmQWB5oEVyLnrtfBgV3KxDWB7jtnMb14RcjfPoq07IhL27TYsYZrEUy9e+WIZBH23/
 /BP56USVo0u+j0NB20CJZY5Ed/yl1D84w5/w6A/GBmDXP5IOCuVEG84myLVUmdr4JOic
 0LDCJgjYA/bVc74xMDb7jd38Bwz/SFC8UkkCF2X3ibiYjTTF0x7xN1RAV5lVQQN6ummb
 y4Lw==
X-Gm-Message-State: APjAAAUMoOZyJWQXNRJPouBbIjiGJ8c7atWt40KiQbXlbyQrFgFCoraF
 +Yh3u249oTX41UfvHn2HQA4=
X-Google-Smtp-Source: APXvYqzXa8FhK2eOU5VcVW4WhiQhLav6Ih01KtUhWlRwp8BT6AbSJXW2xGZfHbHkVHpwa9oVhSzX7w==
X-Received: by 2002:a1c:a1c1:: with SMTP id k184mr9839480wme.81.1565341315778; 
 Fri, 09 Aug 2019 02:01:55 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id o6sm209888800wra.27.2019.08.09.02.01.54
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 09 Aug 2019 02:01:54 -0700 (PDT)
Date: Fri, 9 Aug 2019 10:01:53 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: "Oleinik, Alexander" <alxndr@bu.edu>
Message-ID: <20190809090153.GF25286@stefanha-x1.localdomain>
References: <20190805071038.32146-1-alxndr@bu.edu>
 <20190805071038.32146-4-alxndr@bu.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="GLp9dJVi+aaipsRk"
Content-Disposition: inline
In-Reply-To: <20190805071038.32146-4-alxndr@bu.edu>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: Re: [Qemu-devel] [RFC PATCH v2 03/17] fuzz: Keep memory mapped for
 fork-based fuzzer
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
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "bsd@redhat.com" <bsd@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--GLp9dJVi+aaipsRk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 05, 2019 at 07:11:04AM +0000, Oleinik, Alexander wrote:
> Otherwise, the RAM is unmapped from the child-processes, which breaks
> any fuzz tests relying on DMA.
>=20
> Signed-off-by: Alexander Oleinik <alxndr@bu.edu>
> ---
>  exec.c | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--GLp9dJVi+aaipsRk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl1NNoEACgkQnKSrs4Gr
c8jlMAf6A5UR77x3yax/5uC/YGOOQYXIzRbMF9aTTY+dD3+GGgv0WV6pjY6Y633h
oSNXpDN++uHqJPa4XxCj+rt/l4oE5awd+BzQYxLrj/gGxsvYtydqTRvsk41qFHUh
p756SMm1+X+MYskLM07hVzw7/sihlCkFBAGwBUK5sdE3OU5AHxnct87NygfYp0IX
9yLlaz5SnezeOXcZCfm5Szd6wTHnxcHWIZkgYTR28fkSSGkJiZoxBIE2e/EU8gwh
KlbMJoUNXSMOY5L8L7kokAv4N7pjSTZk+DBMHYSw/FxY2rOBjw1/TxtqYX+ux+O5
nXtr//kaoHVCmB4B4L4mCO2kacCbOQ==
=Sm9q
-----END PGP SIGNATURE-----

--GLp9dJVi+aaipsRk--

