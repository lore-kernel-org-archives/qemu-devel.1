Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7229C54FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 16:26:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF76A2076E
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 16:26:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RS9DaT5G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF76A2076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54036 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRICw-0000TG-Td
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 12:26:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36428)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1jRIC9-0008Im-9u
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 12:25:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1jRIC8-0001k9-G3
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 12:25:52 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:54175)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jRIC7-0001Ka-NP
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 12:25:52 -0400
Received: by mail-wm1-x32e.google.com with SMTP id t63so3075869wmt.3
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2020 09:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=BSBKJkoipTLZJAaAPh8G/dSFLtBiBGFjBleCFIJ3zow=;
 b=RS9DaT5G2NMOREPA/24Z77EcbxjK6d3KtamRrTdPRgd6O1nbKv91rYBdITLMtdkAjm
 uvfa4lkbb/rqd+mNe/WgGbUw4LxXzfKcHFDkR6+s/F42Ua6oURN5l+lnOcfFN4Fa8hZk
 SSyc3G0bQNqU0KNUQAMdajqJamoSDjeMTK6BstummyBnTeVXVGtr5gYfaC5KIDb/5q/4
 tTiz/p9eSW3rLx4Z4voJX4Iz0be2ZzrEHWlSOekoK3qQ8+l18maqsFk9uJE9/8LFFOao
 o3XcUSU43cLD4Fr7xD+dRIXC+KuEuj1ldTVGM7tZU7Y6hG1GI31fe8y7cUuBIhOP1dd9
 96lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=BSBKJkoipTLZJAaAPh8G/dSFLtBiBGFjBleCFIJ3zow=;
 b=qHs66f1lsrdIRf+JIJ/pKimTEIrogSCgbxNNnXm1FCaP2p3EFVtkw8Z91/rzoAvAvX
 kdhUEcnuOk37TilrZhhv3aixdTtddKp8ZXx5blBGiB9WUUdqVd0/wY68qUaJhNfRJb3H
 3NplcprX8gOWoQM462ZRooR8VzeB693KEYiAQPznAEnqLAkqy7sKV3gOzxlltIheqTmD
 W097jChRE6tpyeLSaImXbq8xSfZX5PtmUiL3EpTSXM8wlJHrXcG+DE1y23MMrjRRRIf1
 JfVMXIarFX1YBEr3Hj6HBvlxmhbkuxSG0BMHanMjpbd6bU4FN4FIq8qcLX5CxKV9GhwQ
 wB/A==
X-Gm-Message-State: AGi0PuYlXBmJ1bvqWh7MsMAe+fLPc+ekTNoJWLrPgTeCFS8+IKOSLI8p
 lwjdaTrjFlw9lJETOkfgVw4=
X-Google-Smtp-Source: APiQypKN4tzYuU1Nh3MVYPOfqWtEUHC25uV8rAG7PXvjk8l8nFARwwNsezD8ec1XPIBFWutCehjOXQ==
X-Received: by 2002:a1c:5a41:: with SMTP id o62mr11230185wmb.43.1587572749280; 
 Wed, 22 Apr 2020 09:25:49 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id i25sm8397976wml.43.2020.04.22.09.25.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2020 09:25:48 -0700 (PDT)
Date: Wed, 22 Apr 2020 17:25:46 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Joshua Abraham <j.abraham1776@gmail.com>
Subject: Re: AF_UNIX Monitor Device
Message-ID: <20200422162546.GJ47385@stefanha-x1.localdomain>
References: <CAMmOe3R6_Q7929+GOrk+G3_2+uj2BSs4jKP6h9VYD6FXcEOCwA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="JsihDCElWRmQcbOr"
Content-Disposition: inline
In-Reply-To: <CAMmOe3R6_Q7929+GOrk+G3_2+uj2BSs4jKP6h9VYD6FXcEOCwA@mail.gmail.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=stefanha@gmail.com; helo=mail-wm1-x32e.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::32e
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
Cc: netdev@vger.kernel.org, qemu-devel@nongnu.org,
 "David S. Miller" <davem@davemloft.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--JsihDCElWRmQcbOr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 14, 2020 at 09:46:00PM -0400, Joshua Abraham wrote:
> Hello Stefan,
>=20
> This blog post [0] talks about the AF_VSOCK monitoring device
> (vsockmon) Stefan upstreamed into Linux a few years ago. It seems to
> me the same rationale for enabling packet captures for AF_VSOCK
> traffic applies to UNIX domain sockets as well. What do you think? I
> have a proof of concept patch for Linux for a unixmon capture device
> if you think this is a good idea.
>=20
> [0] https://blog.vmsplice.net/2017/07/packet-capture-coming-to-afvsock.ht=
ml

Sorry, I didn't see your email until now.

Unlike AF_VSOCK, AF_UNIX has no control packets so the capture would
only consist of the data which you can already see using strace(1).
So while you really need this feature in order to inspect AF_VSOCK
traffic you don't strictly need it for AF_UNIX.  Maybe that is why this
feature has never been implemented.

I suggest asking the Linux AF_UNIX and networking maintainers if this
feature could be merged.  I've CCed them.

Stefan

--JsihDCElWRmQcbOr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl6gcAoACgkQnKSrs4Gr
c8hH0Af/WUZO0rMijl5cr1eGF1hRlV5r5W9GmcqF6cBiEcPfoXwVy3W4YD1xBaoC
r+QXUpgk4sBq8vyDpN9Rgbh8KxKpRuurBtVTPGpp3/0KHrm2cvuCISt7uUqS1FL4
kvs8+mBnaYft48CCyOm7qvAmP/Hrar+MUZhE1gMvk2vom3I0whXDC5PxIOHKG1+q
ibDsoU6uAr0352PZHEsJbmfhWRil9Pnb/65JoIQTsmsYoEyEXYdGO4aV0K9Q9Pdk
kD2WWAsN3LOlSfk7m0zdyEaUY/P8Snn3k8zgvqQoybRcwp3eg/fkNdd7kYaOfq7B
2GIplUwIo2R1PTlQA1B+ldRo0jVqDw==
=Vub+
-----END PGP SIGNATURE-----

--JsihDCElWRmQcbOr--

