Return-Path: <SRS0=qKtL=YC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB0D3ECE58C
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 18:45:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5EA921848
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 18:45:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DwqCniKp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5EA921848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIGxy-00080Z-7b
	for qemu-devel@archiver.kernel.org; Wed, 09 Oct 2019 14:45:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55072)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1iIC9n-0004pk-KG
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 09:37:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1iIC9l-0000BU-Jq
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 09:37:35 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:35835)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1iIC9j-00007c-H8
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 09:37:33 -0400
Received: by mail-wm1-x341.google.com with SMTP id y21so2671752wmi.0
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2019 06:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=NL7rjsWuhfTgIp/hXoS0/fgYkTCfTOtpObXG4BI9cOg=;
 b=DwqCniKpu4oLSTaieE9SKRadbwiL5hzCA/MxQ0Y3ASGGmfGOh8xz6XO/xTQwqB/S0m
 gvfnxMPqG0L4QCl8y2Bx9NbpspOQQfZUSffUhFU/Jo/7PWgt4TwPrYF27WDXy5LNuW30
 edz6cbHSFze33wsnLhB3lIm903MTkNrUqnCRL8WKk+n/bQku8syc1DXP60BbBuQNCeqc
 uU+P8Xohht+fVcoyIAALtJzhjklGRxBv9jI6RWYmnf3SoU69YxZqTLQhUgkFR1eTI2WH
 72SPKkJ536uPCz8a9POjZRmUcTo+enf3D0AfYqyVZ/bfdpRMewOfpH7TYKuu31u4WDcm
 ql/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=NL7rjsWuhfTgIp/hXoS0/fgYkTCfTOtpObXG4BI9cOg=;
 b=TDedf6A6IDSs21c2F0TqRIGWrMh0EQsx+bqZwfOpbvXFDk/i9+jQeXEU/2kkMOy5uE
 cY0TvkPA6colv0cdKGtFLYU17kmyoc5mbIp+c5Obs2Fj8vwBv+uMvm8d6R9F3bgvQJ6F
 sJI9pqlZHUnp4D8FzuQUVkcjqdqCbaTaNiZsGX/U1UDmFlVinqlQS+fDeJlxVKRCsF6F
 MpjBx+Qgpw3Ij5SPFaXWFJuOyJP8HtF/dV6fUI4BuM/0RNQO4+k4o6Wtk6oWc5hpelol
 0cXQ3JeOp/LZ6VQjkAdfsNwfteCeu/PZQlU4mF4LSkmbwPARJTnqDeRVQRhjNbqZ71gV
 ji2A==
X-Gm-Message-State: APjAAAXsLvceyx5ZMnKlOQm1ud0cdQfCpFT3ushmUHMLqvecLHgAsiWr
 yLWYufA9JbAYs0WkTbsn5Fs=
X-Google-Smtp-Source: APXvYqx+3XDkw4sqrcKj1zup6/IjoMmYNzG/9oiMqpYg88K7wX3E0SVIdrytYKpaQ+1YyArw0woyZw==
X-Received: by 2002:a1c:7c0a:: with SMTP id x10mr2754897wmc.48.1570628246740; 
 Wed, 09 Oct 2019 06:37:26 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id u83sm7737200wme.0.2019.10.09.06.37.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Oct 2019 06:37:25 -0700 (PDT)
Date: Wed, 9 Oct 2019 14:37:24 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [Qemu-devel] [RFC v3 PATCH 07/45] multi-process: define
 proxy-link object
Message-ID: <20191009133724.GP5747@stefanha-x1.localdomain>
References: <cover.1567534653.git.jag.raman@oracle.com>
 <51220007b0f8a34cc72ff2847f5deb1f85c9c0e4.1567534653.git.jag.raman@oracle.com>
 <20190912153435.GM23174@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="iq/fWD14IMVFWBCD"
Content-Disposition: inline
In-Reply-To: <20190912153435.GM23174@stefanha-x1.localdomain>
User-Agent: Mutt/1.12.1 (2019-06-15)
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
Cc: elena.ufimtseva@oracle.com, fam@euphon.net, john.g.johnson@oracle.com,
 qemu-devel@nongnu.org, kraxel@redhat.com,
 Jagannathan Raman <jag.raman@oracle.com>, quintela@redhat.com, mst@redhat.com,
 armbru@redhat.com, kanth.ghatraju@oracle.com, thuth@redhat.com,
 ehabkost@redhat.com, konrad.wilk@oracle.com, dgilbert@redhat.com,
 liran.alon@oracle.com, rth@twiddle.net, kwolf@redhat.com, berrange@redhat.com,
 mreitz@redhat.com, ross.lagerwall@citrix.com, marcandre.lureau@gmail.com,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--iq/fWD14IMVFWBCD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 12, 2019 at 05:34:35PM +0200, Stefan Hajnoczi wrote:
> On Tue, Sep 03, 2019 at 04:37:33PM -0400, Jagannathan Raman wrote:
> > +    msg->num_fds =3D 0;
> > +    for (chdr =3D CMSG_FIRSTHDR(&hdr); chdr !=3D NULL;
> > +         chdr =3D CMSG_NXTHDR(&hdr, chdr)) {
> > +        if ((chdr->cmsg_level =3D=3D SOL_SOCKET) &&
> > +            (chdr->cmsg_type =3D=3D SCM_RIGHTS)) {
> > +            fdsize =3D chdr->cmsg_len - CMSG_LEN(0);
> > +            msg->num_fds =3D fdsize / sizeof(int);
> > +            memcpy(msg->fds, CMSG_DATA(chdr), fdsize);
>=20
> Please validate num_fds before memcpy to prevent the buffer overflow.
>=20
> > +            break;
> > +        }
> > +    }
> > +
> > +    if (msg->size && msg->bytestream) {
> > +        msg->data2 =3D calloc(1, msg->size);
> > +        data =3D msg->data2;
> > +    } else {
> > +        data =3D (uint8_t *)&msg->data1;
> > +    }
> > +
> > +    if (msg->size) {
> > +        do {
> > +            rc =3D read(sock, data, msg->size);
> > +        } while (rc < 0 && (errno =3D=3D EINTR || errno =3D=3D EAGAIN)=
);
> > +    }
>=20
> Please validate size to prevent the buffer overflow.

I didn't see a reply so I want to highlight that the effort to introduce
isolation between devices is pointless if the communications link is not
coded securely.

Multi-process QEMU adds no security if one process can corrupt the
memory of another process by sending invalid inputs.  Please audit the
code.

Stefan

--iq/fWD14IMVFWBCD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl2d4pQACgkQnKSrs4Gr
c8huPwgAgtbR6wtbp0vHh7TcisSHoIbPPMdxKTId4+x4wvNn0/W5IKqXXmdzhsQh
b51gACJCsH2ozxQquCHsvuSBtOc0guPmZEH3RL0DbjNqEwPWH+2SIHD6DJvj3knR
+PQ5MHJRQrMEdms6RIhZtAq0tCqpRkLysGz87OklA9K2chf6HOAAMLW7ALNeYcQ6
EHwu2PI7ax4pJ7Tz/mh67D3WLbwdb+TpohbLzIl2qsPq+1/W787f055R85I313tP
4YAo6q0nAzg0d909JQrhIqZjS9j/Hye0Kja0+Avd/vOTg5Fs/eWzTsOzRftLYC8P
Sh8ESqHcAEmmmQgYUTo9XVfxa6MN/Q==
=ni8F
-----END PGP SIGNATURE-----

--iq/fWD14IMVFWBCD--

