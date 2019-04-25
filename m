Return-Path: <SRS0=VSQP=S3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99F1AC10F03
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 08:27:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 631D7208E4
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 08:27:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O9o1BGIu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 631D7208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53778 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJZiq-0004gi-Id
	for qemu-devel@archiver.kernel.org; Thu, 25 Apr 2019 04:27:12 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53131)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hJZhu-0003wy-Fp
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 04:26:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hJZht-000193-4g
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 04:26:14 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:40958)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1hJZhs-00018H-U2
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 04:26:13 -0400
Received: by mail-wm1-x342.google.com with SMTP id h11so2422367wmb.5
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 01:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=NBTmVR1/O+kIGjUae+OFP7wkZ0DUswD/OM6EUZru1RQ=;
	b=O9o1BGIuWK9bf1E1WJDGXrJNp61DL25HkbFO8lK/2wiDCjG4kKSkzrN34VHZF9HZqV
	ZyjaECr3oJeXBcc11FvOEOqhiG1MmYoABK58dpDzbRmH+1VA1231neMNk/OA4h17LpnH
	LtQPDYkc5Vtm5m1V0jX6BOsJoyUPzA9iODnccvm5RbN4w+LL8ujHaB896jrdiIPal1fZ
	jOMbDga6YSUqgAX5Ov0ZVameFYQZXqV753h9uET47NAOC++ZZVOntJgfx133etC/HVHO
	iAk9KYalViYtHW70WY0Bdbm0OdX4rqdd4rRVGe6AS9ZeGbJ45U4HOSt+q+/JQ0NYKFcT
	GZTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=NBTmVR1/O+kIGjUae+OFP7wkZ0DUswD/OM6EUZru1RQ=;
	b=QAcMZj2V7I9WY+6jnFlMINCJlDw+EYi8ootyfx6zHWXjiQdsLbOeMsUQdCgCZ5h8J7
	bcsNLavjqqn4TT/6sy/yv0EpbYUZ27ybO9M1lpWp9Td4jbgm/E9rU1JfJevrI6CHQ+fG
	gxiNvSG2qQxOcpcKESicHEMeiVL0yP39X0h5D6mBZ1sLM371hdYwdnDblAMFTwc7S0uB
	tFQJwuIMZtbxyAlkRuu90k1sB9fQ0lGMU4dpH571KV29kSxrx22V/HJwHsVymqV7enRF
	1y2S4Xu1y9t3D/tkTddlSHz+LKw+JZVJAg4Xsb2n2uWlqi4Dskntiqg6Om9W7oN5Lo9m
	RTYA==
X-Gm-Message-State: APjAAAWwhLL2RyOfm1U+FKWKrqbnbPYMIXvEA0LHe51UNdEdulEr8vHt
	5srzwmEEYHDIoGg3a5XEuqE=
X-Google-Smtp-Source: APXvYqyuzeJ9BfQMkfFUQdUty/BHuZqnvfhfjsXAtE89rFSk40ErUPu8eDjGEcCruCiTKdkufcJCmA==
X-Received: by 2002:a1c:4e19:: with SMTP id g25mr2636429wmh.9.1556180771353;
	Thu, 25 Apr 2019 01:26:11 -0700 (PDT)
Received: from localhost ([51.15.41.238])
	by smtp.gmail.com with ESMTPSA id y4sm1355714wrt.34.2019.04.25.01.26.10
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 25 Apr 2019 01:26:10 -0700 (PDT)
Date: Thu, 25 Apr 2019 09:26:09 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Wei Yang <richardw.yang@linux.intel.com>
Message-ID: <20190425082609.GB30231@stefanha-x1.localdomain>
References: <20190422004849.26463-1-richardw.yang@linux.intel.com>
	<20190422004849.26463-2-richardw.yang@linux.intel.com>
	<20190423092518.GD32465@stefanha-x1.localdomain>
	<20190424010105.GA12824@richard>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9zSXsLTf0vkW971A"
Content-Disposition: inline
In-Reply-To: <20190424010105.GA12824@richard>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: Re: [Qemu-devel] [PATCH v14 1/2] util/mmap-alloc: support MAP_SYNC
 in qemu_ram_mmap()
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
Cc: pagupta@redhat.com, xiaoguangrong.eric@gmail.com, mst@redhat.com,
	Haozhong Zhang <haozhong.zhang@intel.com>, qemu-devel@nongnu.org,
	yi.z.zhang@linux.intel.com, yu.c.zhang@linux.intel.com,
	Stefan Hajnoczi <stefanha@redhat.com>, pbonzini@redhat.com,
	imammedo@redhat.com, dan.j.williams@intel.com, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190425082609.rptZX21xCL_5BqOhil6Q4tGuna6hUTv7KiyOwNtMydI@z>


--9zSXsLTf0vkW971A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2019 at 09:01:05AM +0800, Wei Yang wrote:
> On Tue, Apr 23, 2019 at 10:25:18AM +0100, Stefan Hajnoczi wrote:
> [...]
> >> +#ifdef CONFIG_LINUX
> >> +#include <linux/mman.h>
> >> +#else  /* !CONFIG_LINUX */
> >> +#define MAP_SYNC              0x0
> >> +#define MAP_SHARED_VALIDATE   0x0
> >> +#endif /* CONFIG_LINUX */
> >
> >MAP_SHARED_VALIDATE is is from 2017:
> >
> >  commit 1c9725974074a047f6080eecc62c50a8e840d050
> >  Author: Dan Williams <dan.j.williams@intel.com>
> >  Date:   Wed Nov 1 16:36:30 2017 +0100
> >
> >    mm: introduce MAP_SHARED_VALIDATE, a mechanism to safely define new =
mmap flags
> >
> >This code fails to compile on Linux hosts with pre-4.15 headers.
> >
>=20
> Ok, qemu build will fail on pre-4.15 linux.
>=20
> >Instead you could use the following (even on Linux!):
> >
> >  #ifndef MAP_SYNC
> >  #define MAP_SYNC 0
> >  #endif
> >  #ifndef MAP_SHARED_VALIDATE
> >  #define MAP_SHARED_VALIDATE 0
> >  #endif
> >
> >Either way:
>=20
> You mean replace the above code to:
>=20
> #ifdef CONFIG_LINUX
> #include <linux/mman.h>
> #endif /* CONFIG_LINUX */
>=20
> #ifndef MAP_SYNC
> #define MAP_SYNC 0
> #endif
> #ifndef MAP_SHARED_VALIDATE
> #define MAP_SHARED_VALIDATE 0
> #endif

Yes, please.

This is not critical but I bet someone will hit this issue when
compiling a new QEMU on an old host.  This small tweak will save them
time.

Stefan

--9zSXsLTf0vkW971A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcwW8hAAoJEJykq7OBq3PI9/0IAKCQ520Vn7UaLDGx2fhGHq48
omsvcpTNdimVOCIrB6rb1ZJ81gQ8R7VQX4lqoMADYAcSt+EBI7hSIKMWlgbZBr0r
cz5Gco4wSXgl+74GnuuNYxjsPK8Zp8a7gyWllas8ls71P9rxjQfkS46bEJFaX2BB
Hg8a2M5cUsIk0/uT/62puyD9xHSJWS7tT28qoi+R0WKKPKzw2HwaocK44Gddt6ae
czbQQY4QmzP0+TtgPnObipxJBFF/+jwdSb3meYtujGHotyduYfNyvduQsaxOggiX
O7riI1xhJVWk4oOglFtjmMD6YwFWA2YvZ0/lXkq5t3/9TDkjCZMnQmNVk7Gp71A=
=Mev/
-----END PGP SIGNATURE-----

--9zSXsLTf0vkW971A--

