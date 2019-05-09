Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03620C04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 13:54:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C266720675
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 13:54:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C0P+aEwQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C266720675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54917 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOjVJ-0001zs-1t
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 09:54:33 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54293)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hOjUV-0001is-Le
	for qemu-devel@nongnu.org; Thu, 09 May 2019 09:53:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hOjUP-0005SQ-Ko
	for qemu-devel@nongnu.org; Thu, 09 May 2019 09:53:43 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:53984)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1hOjUJ-00056h-GB
	for qemu-devel@nongnu.org; Thu, 09 May 2019 09:53:32 -0400
Received: by mail-wm1-x341.google.com with SMTP id 198so3373420wme.3
	for <qemu-devel@nongnu.org>; Thu, 09 May 2019 06:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=m5bv1+lGLOEyQrAwYfQqLnYlP4D6TKEP1An7v5r9cxY=;
	b=C0P+aEwQgtPY7iEN1zvZ+NFgRQ8PqY8WtxlltfzMNNuYyxEmLrLTtZTDD06wdOpReV
	IWU9nZJZI6ez6zbWWT5Nrlpr1eI+q2SUuKPnz/1lL2iT36MTuFOf3Z0c+rCbMf7i/VIZ
	5lFaLcRHjqzzrmqqoXRROdTbPhQjBlgp5obx/buFZfNJKtSdisD5vI60fvY6C9eQ+D6n
	GcbIMmy7JbwQ+7GIxi4POccmpPB1Fx0LUxJFw1aXAKa3IZPHTdCsXLYBWfWzMkdeydNN
	s6wj3pXJyqE2Dk5bqhASaW0iH7eqnTrlEPMlg0vt6QFQWismM8FOYvKJ15H15M6tza8E
	cv4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=m5bv1+lGLOEyQrAwYfQqLnYlP4D6TKEP1An7v5r9cxY=;
	b=JI7g7989z4NTDJLk3X9n9Gi/33MywqYd0Zjys4TjgmjtPyf6u96/P6Ak80jKCfuOYQ
	kQ+toYO9G1t/Uu+e4YuJf6LnNVeCM+2bz+qcMXMCuk8lPzBIEQQh5/3/elX/ZFPd8NsG
	4bx2WU3ACYBMPqmQDQR6XlNcoGT1wmLKkN65wjTSYju3ybrgr193aj4cp0qJe1ugeaJj
	U/nBG6QKUIcDmleDPYnApEN9xeEwYniZn28ajkOL3tpo+X4vdkmrju+JEM7of6wcj8Z+
	T0g2E+PiBQVemkQ5IhwtXsV1Tix4aaqY6ZEyOqslkaAEB74OUajgWefRqpEuEEGzq+JZ
	XJ5g==
X-Gm-Message-State: APjAAAX2+4IPRrxK6b4aW2X1a2zBu7IXQVcCPwet3djn66vNDhCm3xPY
	FALvppPM1hAFVV74cebR8j0=
X-Google-Smtp-Source: APXvYqxF9t3n+Qd4+wN6AQ4lHjPNSv3dA7GQ9eiP78FgCMtX2SzEnAM87DFsahi2AIhqhzzD9JOcZQ==
X-Received: by 2002:a1c:9689:: with SMTP id y131mr3247916wmd.74.1557410001929; 
	Thu, 09 May 2019 06:53:21 -0700 (PDT)
Received: from localhost ([51.15.41.238]) by smtp.gmail.com with ESMTPSA id
	d17sm1347529wrw.73.2019.05.09.06.53.20
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 09 May 2019 06:53:20 -0700 (PDT)
Date: Thu, 9 May 2019 14:53:20 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Kashyap Chamarthy <kchamart@redhat.com>
Message-ID: <20190509135320.GE17133@stefanha-x1.localdomain>
References: <20190503154613.4192-1-kchamart@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2qXFWqzzG3v1+95a"
Content-Disposition: inline
In-Reply-To: <20190503154613.4192-1-kchamart@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: Re: [Qemu-devel] [PATCH] VirtIO-RNG: Update default entropy source
 to `/dev/urandom`
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
Cc: armbru@redhat.com, amit@kernel.org, qemu-devel@nongnu.org,
	rjones@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--2qXFWqzzG3v1+95a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 03, 2019 at 05:46:12PM +0200, Kashyap Chamarthy wrote:
> When QEMU exposes a VirtIO-RNG device to the guest, that device needs a
> source of entropy, and that source needs to be "non-blocking", like
> `/dev/urandom`.  However, currently QEMU defaults to the problematic
> `/dev/random`, which is "blocking" (as in, it waits until sufficient
> entropy is available).
>=20
> So change the entropy source to the recommended `/dev/urandom`.

Why is /dev/urandom "recommended"?

I understand the requirement for instant random numbers, but what about
the concerns about quality?  Have you decided that the consumers of
these random numbers are safe with /dev/urandom?

>=20
> Related discussion in these[1][2] past threads.
>=20
> [1] https://lists.nongnu.org/archive/html/qemu-devel/2018-06/msg08335.html
>     -- "RNG: Any reason QEMU doesn't default to `/dev/urandom`?"
> [2] https://lists.nongnu.org/archive/html/qemu-devel/2018-09/msg02724.html
>     -- "[RFC] Virtio RNG: Consider changing the default entropy source to
>        /dev/urandom"

Please include actual justification in the commit description instead of
linking to email threads that need to be read and interpreted.

Stefan

--2qXFWqzzG3v1+95a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAlzUMM8ACgkQnKSrs4Gr
c8iQwwf+KjLlClpI+ycFWYiXsFUqKKE8sKek82Uq+NinqAPTipE61q+Hir3kzZUl
ZQjE3kt+9q2MZoLNYYnPTHEtQgGLUFokxRqW592gDaCXph41IyIg4Qa+sN3Q0A7K
FBQex1NpTgfpAWm1C3i7T7Ox3XOPSWblBKIg8OwKf/7jC3eMZ2JRydhU4AmZukCe
B8AZG7SIgMQq3QaaUJwZjBQ9QtLBgMFS8ejCmChhFjEWPFKZM7cJATII6CV+7xty
+htBkmF0jK7TiHq37+u6Gko8HGGFPgESJDo1Lz4vSlUZS8iqWeffloZCKEysBYRN
lKIpCXwJxG8vEWGnbs2aRBjp5E1ZYQ==
=e4Br
-----END PGP SIGNATURE-----

--2qXFWqzzG3v1+95a--

