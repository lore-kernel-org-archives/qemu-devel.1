Return-Path: <SRS0=08iY=SU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ACF6C10F0E
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 09:42:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7C51206B6
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 09:42:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I7qDZo9v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7C51206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38579 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hH3Yy-0006x6-4S
	for qemu-devel@archiver.kernel.org; Thu, 18 Apr 2019 05:42:36 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57133)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hH3Xc-00069R-PS
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 05:41:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hH3Xa-0005cb-OF
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 05:41:12 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:51348)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1hH3XW-0005Z9-Ut
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 05:41:08 -0400
Received: by mail-wm1-x342.google.com with SMTP id 4so2012385wmf.1
	for <qemu-devel@nongnu.org>; Thu, 18 Apr 2019 02:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=r8eoLVxI9eYB71LA7KSPdof1ihMqouhtTRhuqukfoF0=;
	b=I7qDZo9vv5k46mrNjCh1HzFT8v0MaFiHErOMXmmvCXlY6ge5K/ysIHMgQ8/WNH3b6P
	P0J70wuaBJtXhBNeOlbJmcZ8ITk89ZZTlaCFda8sSaTGosZG7Qzr3A/ob+WBWCQ5kdEb
	gSxiA7vq0QyG24gI5mJ/NZ75gGVdDYHQF6FQvrLbLSUEOo4S5qRr8gjnw1Di9BQ7oDuH
	0FKIaab9V1Lc+FgBYd9xk/tJWK4RM9VFoCSXFiqIpP/I9HF7uS3NjgdEe310cP4iRIV7
	VZImJy9kOKwMelo/TiSztk11R8RxITaIWP1xFdjYYn1vPJdVh6bxt+jdCFdHtHUc7Vem
	tvyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=r8eoLVxI9eYB71LA7KSPdof1ihMqouhtTRhuqukfoF0=;
	b=i+QMRVpqHPq/LI23b9TpCW7/6SutofR7v+voKkjOdlWe3IgITXjKevgIYqVz+JHROU
	ix+XaFbzBWLUuA2m7W6+EQ5Q1pwI9DLjwwS+28OzzYWZZZLpFCLhzJtDMxAXrA5RgYeN
	Fp9bXj/VW8wYIRqIlUnVIcCxGPhzvT1YjWGzl5laKkJn0jZP/nAjwPx3zoMt0WJDivY8
	U6QYPtiVYOhoP2xqCMBb/uXGMWvNhcqcNKlJbXYvwNYfd3vlE96lxVYZuDnxTrxGd1Dm
	Qboi3HabPW5g4Sv1YsihrsGWifMwMDGR4iiUP438vtkIImnsBuzl4MxUwwaFhspj8/4/
	C5hA==
X-Gm-Message-State: APjAAAWX3k1ddigDZeRGXoCUrvQHKiolfsETMLmqtu47MXeQTdbQSINs
	CTaAtPXbrp3AGH9YawrHem8=
X-Google-Smtp-Source: APXvYqzJ7PGvlBUnhNE4o+AhMkF3QWRLFn8eHuPOv68WM6LUrcCX6D1Kr51IbK94Ogxy2OuhGGW/1A==
X-Received: by 2002:a1c:43c2:: with SMTP id q185mr2382283wma.53.1555580464003; 
	Thu, 18 Apr 2019 02:41:04 -0700 (PDT)
Received: from localhost ([51.15.41.238])
	by smtp.gmail.com with ESMTPSA id z14sm792701wro.81.2019.04.18.02.41.02
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 18 Apr 2019 02:41:02 -0700 (PDT)
Date: Thu, 18 Apr 2019 10:41:01 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Liran Alon <liran.alon@oracle.com>
Message-ID: <20190418094101.GA23876@stefanha-x1.localdomain>
References: <20190416125912.44001-1-liran.alon@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="u3/rZRmxL6MmkK24"
Content-Disposition: inline
In-Reply-To: <20190416125912.44001-1-liran.alon@oracle.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: Re: [Qemu-devel] [PATCH v2 0/3] vhost-scsi: Support migration
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
Cc: ehabkost@redhat.com, mtosatti@redhat.com, qemu-devel@nongnu.org,
	bijan.mottahedeh@oracle.com, pbonzini@redhat.com,
	nir.weiner@oracle.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190418094101.CymI8Q__187rO0FHmFaUV7lkWJanvtrSN5ulUwbg3GU@z>


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2019 at 03:59:09PM +0300, Liran Alon wrote:
> Hi,
>=20
> This patch series aims to add supprot to migrate a VM with a vhost-scsi d=
evice.
>=20
> The 1st patch fixes a bug of mistakenly not stopping vhost-scsi backend w=
hen a
> VM is stopped (As happens on migratino pre-copy completion).
>=20
> The 2nd patch adds ability to save/load vhost-scsi device state in VMStat=
e.
>=20
> The 3rd and final paqtch adds a flag to vhost-scsi which allows admin to =
specify
> it's setup supports vhost-scsi migratino. For more detailed information o=
n why
> this is valid, see commit message of specific patch.
>=20
> Regards,
> -Liran

Looks fine for vhost_scsi.ko.  I have not checked how this interacts
with vhost-user-scsi.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--u3/rZRmxL6MmkK24
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcuEYtAAoJEJykq7OBq3PIEcsH/1vNqde/oYQpzqgvf2wJ4rJz
b6w+NN8o/o25fA3j6+2K6rRhuYwvH5FVb2cZyKEc1bD267NMsx9KmgBwNBk6+Mqc
Q7d0DFxJZILudDOvgp0AQUcSXZxlwPhsFY2lQkKAPccqHNoVGASPrhOGzXLnkZGx
Hjh7MhhiWD6OS6TTkTmzVLM+5DVjSjFystwZuB3u/dVnXIjbIkKwXSCDBr0zDWlF
ON2ieQVwqcKzgrOfDPdgDytAKeIJcnASgn1xv7X7U+YDzjq7jMJceww9SdGSRsgT
QU5DK5wJL344qnP2lmM4tGzSu9IhMiqeLy0wPle4kak5YcpDdqDKMi+pGeW2MHE=
=ZRen
-----END PGP SIGNATURE-----

--u3/rZRmxL6MmkK24--

