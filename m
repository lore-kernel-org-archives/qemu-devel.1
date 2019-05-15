Return-Path: <SRS0=zTTU=TP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B388C04E53
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 14:18:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC2202084E
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 14:18:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RK0bIYqf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC2202084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37819 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQujX-0002Hx-87
	for qemu-devel@archiver.kernel.org; Wed, 15 May 2019 10:18:15 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58806)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hQuia-0001hh-IQ
	for qemu-devel@nongnu.org; Wed, 15 May 2019 10:17:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hQuiZ-0005IX-N5
	for qemu-devel@nongnu.org; Wed, 15 May 2019 10:17:16 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:53129)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1hQuiZ-0005He-Gq
	for qemu-devel@nongnu.org; Wed, 15 May 2019 10:17:15 -0400
Received: by mail-wm1-x342.google.com with SMTP id y3so222829wmm.2
	for <qemu-devel@nongnu.org>; Wed, 15 May 2019 07:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=7KWhJ6NCKLwBYX48ZZP4U/FZUJisIHcSSoPNPIisGm8=;
	b=RK0bIYqf+1lZA4h1osmllfKDuJkaGXxpphgiiVbAcsJs02k37zsKS+37Gqxx+he3Wo
	oFI3ml/ZMmt70Q3928GUOkKJSzXwjvC+HfNZ9t0RaS9aAecWERaXrw11uutI4/9PmXQE
	q5AjP4Q5Oh4dl5FFmYrkcp76wAzyDzN1SfZtf0RLT9F68YJXt8P9xTfEeWEBcWaq5gvv
	+m0f/24uPO63ruwiQKeoX6pDRRVzo7ztS4Cj+eCxw/br7/nWy1qHzP+tUeo9RXsu8QFU
	LrilZErLQ6KI+yVUrDBS49+I6m5EFpF/7FDrmvYqKM4KMU0QHzQu/RzuyO5mV+M97rX1
	CJgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=7KWhJ6NCKLwBYX48ZZP4U/FZUJisIHcSSoPNPIisGm8=;
	b=rkMexAnmZZ3SG4Tr8LbjsfStfq8Jv4S0zWiBT8JYzLkGrXt7QljVdD1YiINQr5FKf0
	MJ7F6drsveLYwAoFwo+ZW5+WSKvqOzXO5T6R19ov7FOqwIxOQ4IudGyzlccYViUA0spM
	R6hdk0PdjYLr6H2/wJNn9Aze6U8I8/13XJA7I7D8AICn2lsR/Um6F0+TdZhy6MJwvFAF
	4a5oi5sQ5E54O3ZCn7LLvT5KwytqU5rCVkZ3QFosiamszWQ+9YEzgcAeYz5bFieQqeSS
	mknENBfp0+OnnvotZZCEB+1eqBtYAjC0VUvnjc4WfqdIGXDRFaeh4cnkDeGDuwzMhoLD
	a2Vg==
X-Gm-Message-State: APjAAAW5u9F+R/bt9LaTufXydhNyuLq6tynY+vtfgbu82QTshqoAcayf
	Z5BTQt5kHFNQxBhE1VBjeK4=
X-Google-Smtp-Source: APXvYqxx7QZ8EvCOCjmZ9pqSuuHaroqCTwoMe0+9P7iymUyUouBS1gTvbPNRmZjbeIbTFHgsHJXxlw==
X-Received: by 2002:a05:600c:254e:: with SMTP id
	e14mr12625571wma.70.1557929834314; 
	Wed, 15 May 2019 07:17:14 -0700 (PDT)
Received: from localhost ([51.15.41.238]) by smtp.gmail.com with ESMTPSA id
	h188sm3728636wmf.48.2019.05.15.07.17.13
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 15 May 2019 07:17:13 -0700 (PDT)
Date: Wed, 15 May 2019 15:17:12 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Ernest Esene <eroken1@gmail.com>
Message-ID: <20190515141712.GG29507@stefanha-x1.localdomain>
References: <20190510180410.GA10349@erokenlabserver>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="0qt3EE9wi45a2ZFX"
Content-Disposition: inline
In-Reply-To: <20190510180410.GA10349@erokenlabserver>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: Re: [Qemu-devel] [PATCH v3] chardev/char-i2c: Implement Linux I2C
 character device
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--0qt3EE9wi45a2ZFX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 10, 2019 at 07:04:10PM +0100, Ernest Esene wrote:
> Add support for Linux I2C character device for I2C device passthrough
> For example:
> -chardev i2c,address=3D0x46,path=3D/dev/i2c-N,id=3Di2c-chardev
>=20
> QEMU supports emulation of I2C devices in software but currently can't
> passthrough to real I2C devices. This feature is needed by developers
> using QEMU for writing and testing software for I2C devices.
>=20
> Signed-off-by: Ernest Esene <eroken1@gmail.com>

How is -chardev i2c meant to be used?  Do you have code to connect this
new chardev type to an emulated I2C bus?

Stefan

--0qt3EE9wi45a2ZFX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAlzcH2gACgkQnKSrs4Gr
c8g0vwf7BgFmGbxeXEmZxzFigr9bTRp0HI1G2vG80rgCF6UI/OefwzW9fQbdDKc6
SwPRHYxQPGxA3x4ABHa/hF06RbWXFHMkrAUbqKeKsy51ewfrx4ghXQXM0eAw8sLN
3nkfmPJ+wAzTRrKunnlEG1QZNnq8sb4z29DOJP1ODim445bhrJkQdZlZzCQeDqe1
8OCwvzVPHjHWgRzT4W2sFWJK1lJLk1NPQ1PUZwBcweoIlbct9USLy8zgOVl4nVux
lxe2Fm9HOZYy1ONefsGFmD6JF3/Uidia12QxFn1ptptRHeouYk4ZfX+RDwXIoYw7
3DgXt3k0uCafTZwQtOg3IFod3xd6hg==
=xFfi
-----END PGP SIGNATURE-----

--0qt3EE9wi45a2ZFX--

