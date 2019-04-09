Return-Path: <SRS0=I56D=SL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF31DC10F0E
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 13:18:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96A542084C
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 13:18:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SRtbVaUS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96A542084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41697 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDqeO-0007I6-Pr
	for qemu-devel@archiver.kernel.org; Tue, 09 Apr 2019 09:18:56 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59194)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hDqdA-0006kR-S0
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 09:17:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hDqd9-0007ZN-NR
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 09:17:40 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:39021)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1hDqd9-0007Xy-AE
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 09:17:39 -0400
Received: by mail-wr1-x441.google.com with SMTP id j9so20879085wrn.6
	for <qemu-devel@nongnu.org>; Tue, 09 Apr 2019 06:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=2siJSdlobkrY6bd6VFqIwsNeEFpLEPobuPm6LNwAhv8=;
	b=SRtbVaUSvARBLMeiTqUPsiCsy2u9rkYJ2yMjvIGulq0jpcZez3W+68X5+f4cgj7DGy
	dM7frh4ou3ZYdUmZr2T/xrs5dpFw/6xEy4Zvq8RiMEv6XgAW5ZNGuGIi3msxel1OcPjw
	vmi3s36Nu/8nh96nEzN/LecdY14jl2qAbMW369UYPRqp1541nO22g0BfYm3N3coHXkWU
	b30wHFXzgKDzQ7QiJhFD77lz+dNigRyZ3eV715afPtqml8U2u3ouXTiKTc8lnNjBrGW9
	MokcacoFdbfcr4AHn660U0HMKcjhJT04mguTU4YJRWIGyR3k9w+wrFpwJ4DX17Mppkp5
	JXRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=2siJSdlobkrY6bd6VFqIwsNeEFpLEPobuPm6LNwAhv8=;
	b=BUbr1LzaHvpJyfJq+a3xdoQ6R27bYaVxG8vkLeYNoZ5EUYvMdiQmbVpWmf7wLXVXvD
	B+e7uAh7FigUqA/7hXAb3NGQ2EMfwqv7oecd5h4doP9SGXTXptunIzRz1YSMuNz2N1HF
	A8O417CED7YZ0wAlPzgzyDpsNPOW71/ycC656eDINbzmmQZqOxwY/j5wyM4+UxdyUAcg
	GTj2PyfP14xjyfdOAMn9tKjUPWThUQ1XIK8HB09S0aP57nWkhQmSQ9dXMdPBEnvsYtpw
	1QQcPWXTh6sszcondsNvs6BstzMamGEd2xFYXKy9PIpChh5f/12neJjZGBqPFblq1fbA
	mReQ==
X-Gm-Message-State: APjAAAVd3drhC8+w3Msr1LNYz0QEQSTfzYfNfVIMlZwt4EkGv1ocCUKV
	mLQQYoVxerqIr8lLmuzJqqk=
X-Google-Smtp-Source: APXvYqx1mQ8G/tb2n1EIVAvNPpDM63LtQ30OEXjw5ju0plMl6ngTdm6tXygNOSbMhzogUccS65VJ/w==
X-Received: by 2002:adf:e602:: with SMTP id p2mr3434895wrm.105.1554815856324; 
	Tue, 09 Apr 2019 06:17:36 -0700 (PDT)
Received: from localhost ([51.15.41.238]) by smtp.gmail.com with ESMTPSA id
	o12sm35378320wrx.92.2019.04.09.06.17.35
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 09 Apr 2019 06:17:35 -0700 (PDT)
Date: Tue, 9 Apr 2019 14:17:34 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Yoni Bettan <ybettan@redhat.com>
Message-ID: <20190409131734.GE16944@stefanha-x1.localdomain>
References: <20190401111843.54528-1-ybettan@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wTWi5aaYRw9ix9vO"
Content-Disposition: inline
In-Reply-To: <20190401111843.54528-1-ybettan@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: Re: [Qemu-devel] [RFC-PATCH] Introducing virtio-example device.
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, ailan@redhat.com,
	qemu-devel@nongnu.org, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190409131734.hlISMAxWHUOSUsdoFr7xlFSRN21Xa4n79OJ556ln1n8@z>


--wTWi5aaYRw9ix9vO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 01, 2019 at 02:18:43PM +0300, Yoni Bettan wrote:
> The main goal is to add an example device to Qemu to be used as template =
or
> guideline for contributors when they wish to create a new virtio device.
>=20
> Another reason for this device is to document "the right way" to write
> a new virtio device in Qemu.
>=20
> This device is a simple device and its functionality is to increase its i=
nput
> by 1.
>=20
> The device driver is located at:
> https://github.com/ybettan/QemuDeviceDrivers.git
>=20
> In addition I am writing a blog to give a logical overview of the virtio
> protocol and a step-by-step guide to write a new virtio device.
> This blog can be found at https://howtovms.wordpress.com.
>=20
> scripts/checkpatch.pl have some errors do to "//" (old style one line com=
ment),
> those lines contains FIXMEs for the next version and will be removed.
>=20
> Signed-off-by: Yoni Bettan <ybettan@redhat.com>

Where is the specification for this device?  The lack of specification
is already not "the right way".

There are multiple problems with the code, but the larger issue is that
this example device is just helping people shoot themselves in the foot
more easily.

The difficulty with VIRTIO is not how to implement devices/drivers, it's
that people don't read the specification and therefore do not understand
the device model properly.  The spec is dry and missing information in
some places.  I think more accessible documentation, like your blog, can
help here.

If you would like to educate people about VIRTIO, then explaining the
device model, lifecycle, how to change a device in a
backwards-compatible way, virtqueue semantics, etc are the topics that
deserve attention.

For someone who has learnt these topics, implementing the device/driver
is not hard.  For someone who doesn't understand these topics, no
example device will help.  At best they will copy-paste together
something that sort of works but has issues.

Stefan

--wTWi5aaYRw9ix9vO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcrJttAAoJEJykq7OBq3PIPPwIAIKF152sgXyO5boc8OrpO4yd
YBOevTT5xhGAWGD8SVLW0aNZ9jcwyFcvFhbpomBSueFTj43U9zedqXPLUjOlsQDE
xsYmo0pGZy7voMJPYHOxQEV6efeBNfsMIqOTIyw5VNRuBu+U6hbyT7oCEsov07SV
A+6DYDVYXaYiajSDgZs3iwihyaZHaRc/GW2zc2W+210WSrwVAijkmxZPg4mIJWzJ
HMhLmAJ/jnKRVSXyZG383TvMe6bZFGwzOk/8+dNQGFqk6BJVcMOvI7WyhE93Ic2G
vCAZ4GfkaQss5Rm+1MBY99A97yIte+iYmn4s9kydR6p+qNLmXVZ0Lq3pxUTUNbU=
=35DD
-----END PGP SIGNATURE-----

--wTWi5aaYRw9ix9vO--

