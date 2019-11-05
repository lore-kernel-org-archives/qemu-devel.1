Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC0E0C5DF60
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 15:54:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95081217F5
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 15:54:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tgHv11s8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95081217F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45504 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iS1A8-0007Ab-Kd
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 10:54:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45428)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1iS18b-0005jc-Fs
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 10:52:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1iS18a-0007tj-Cg
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 10:52:57 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:35843)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>)
 id 1iS18Y-0007sB-1S; Tue, 05 Nov 2019 10:52:54 -0500
Received: by mail-wm1-x344.google.com with SMTP id c22so20718233wmd.1;
 Tue, 05 Nov 2019 07:52:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=0fSfe/VKBKgwyIC+LveqryTN02qwOVl38OfU5ASdO8U=;
 b=tgHv11s88M1HlijE/HRFqQGXNJyf3FpXuvNKgZ5F4OE/9qZBxRK1HFQVbCzDozKMXz
 Gx7jB9zq9HDZmTXZlZ9CrrO7xu5W1SynQzBpwqdVpt9A7WejZHNvguZmWSy6oL+yx95X
 E+tJd3qjlHU+3HhKpIddjg5Du7l/Uje5aiN3aXf1RH4XLqkWtjBePbvdVFi10I7vCDow
 bDuFJenef7iBr6tdMsOijgymUkwsvcJtbcMQEwBddWyoIpWA0lO1Ah0ECsYQUnZz9h6J
 T4QnIY4fSNY/GgglPa9gj4djaYejxNdA2C4tAt06zyb+R8Ib5PX6/J4VUdF4pxl40+8r
 qPEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=0fSfe/VKBKgwyIC+LveqryTN02qwOVl38OfU5ASdO8U=;
 b=Gmaq6neCEbrbAXaO6/2rACTcgv3d3kmHBo+g1+Gb7W4o/vjbApQxNeyKPbaDPaUUoh
 E9j3GPK9UV6P3uFVtaIlsw4U4l9hfOJ3c1PtkIlEwXYqjrr8vDdp+V5KdrcAt6cc8Omf
 85jP+Y3DUJF2OIW2j/orLEiFRcfDkIjbzg+bAOBV3/MX2vZnO9nc6tNa6KdW8IZ5WuL2
 0KlfZceFg1PoT/8OZNQwEYRg4tIKva21qTLt2XtHBk77eJ9S5muU/VjNBTbh2zPvSHrX
 IiGMvTXi5B/qs/jVJEmoIPsCNWxg76cppSmbe9m9OSZ/ah7pNfaRdnU8gvu5maQzeIJ8
 uzew==
X-Gm-Message-State: APjAAAXXkAZUpSZUl7WInwDaIULo7bMYozi7Uctom4pU5d03XRdg6QAr
 8VUIGyCN0Bx56sD1mhREUwI=
X-Google-Smtp-Source: APXvYqzaA2y3bX4TcifMg2NUH6nvoXz0ui9Dx2sZDEjAaaaXB636n3NCzPQLvnjfrgfQdFVxFIT+7A==
X-Received: by 2002:a1c:9d07:: with SMTP id g7mr4870658wme.53.1572969172601;
 Tue, 05 Nov 2019 07:52:52 -0800 (PST)
Received: from localhost (91.141.1.3.wireless.dyn.drei.com. [91.141.1.3])
 by smtp.gmail.com with ESMTPSA id x205sm27591252wmb.5.2019.11.05.07.52.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Nov 2019 07:52:51 -0800 (PST)
Date: Tue, 5 Nov 2019 16:52:50 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [RFC PATCH 00/18] Add qemu-storage-daemon
Message-ID: <20191105155250.GE166646@stefanha-x1.localdomain>
References: <20191017130204.16131-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="+JUInw4efm7IfTNU"
Content-Disposition: inline
In-Reply-To: <20191017130204.16131-1-kwolf@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Cc: mreitz@redhat.com, pkrempa@redhat.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--+JUInw4efm7IfTNU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2019 at 03:01:46PM +0200, Kevin Wolf wrote:
> This series adds a new tool 'qemu-storage-daemon', which can be used to
> export and perform operations on block devices. There is some overlap
> between qemu-img/qemu-nbd and the new qemu-storage-daemon, but there are
> a few important differences:
>=20
> * The qemu-storage-daemon has QMP support. The command set is obviously
>   restricted compared to the system emulator because there is no guest,
>   but all of the block operations are present.
>=20
>   This means that it can access advanced options or operations that the
>   qemu-img command line doesn't expose. For example, blockdev-create is
>   a lot more powerful than 'qemu-img create', and qemu-storage-daemon
>   allows to execute it without starting a guest.
>=20
>   Compared to qemu-nbd it means that, for example, block jobs can now be
>   executed on the server side, and backing chains shared by multiple VMs
>   can be modified this way.
>=20
> * The existing tools all have a separately invented one-off syntax for
>   the job at hand, which usually comes with restrictions compared to the
>   system emulator. qemu-storage-daemon shares the same syntax with the
>   system emulator for most options and prefers QAPI based interfaces
>   where possible (such as --blockdev), so it should be easy to make use
>   of in libvirt.
>=20
> * While this series implements only NBD exports, the storage daemon is
>   intended to serve multiple protocols and its syntax reflects this. In
>   the past, we had proposals to add new one-off tools for exporting over
>   new protocols like FUSE or TCMU.
>=20
>   With a generic storage daemon, additional export methods have a home
>   without adding a new tool for each of them.

No comments on the command-line, QAPI, or monitor aspects, but the
general idea of having a qemu-storage-daemon is likely to be useful.

Acked-by: Stefan Hajnoczi <stefanha@redhat.com>

--+JUInw4efm7IfTNU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl3BmtIACgkQnKSrs4Gr
c8jLEgf/Rhm43KqEJY3V6Up5RYKGY2Y5cWaLa/msBrt2sf8aVXWV1LcbLBqtk/us
BNmnMlVXARKq2A4XRsvOm14/UzudSG60BewCR201WyPy164B5dGSkqpDyj4jOi1K
s1zp3vAm1PCFLiBidmpTOxd/iBirmSBoz7Ilbsz5OFHDSxbri5mtwsO01yFwAUOC
ShYUK1YfJF7aMX0Hirt40qtCDU6UCfSe+Sht9MRRZdlkOzH7kcZOqh78ndngHHMy
Y5ITCWRK+Mwj5mgIqpPwWxPmTlBFgFdhy8qxJWLUGwYDZ4UpqIk8t/5+8y0pyKzO
fXjzVQD+6e/miLo9IpVTtVLYVpv3hQ==
=NDiH
-----END PGP SIGNATURE-----

--+JUInw4efm7IfTNU--

