Return-Path: <SRS0=Rh1V=WE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1112CC0650F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 10:26:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF0F92171F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 10:26:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZDCThdys"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF0F92171F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvfd6-00089E-5Z
	for qemu-devel@archiver.kernel.org; Thu, 08 Aug 2019 06:26:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60873)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stefanha@gmail.com>) id 1hvfcH-0007je-TB
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 06:25:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1hvfcG-0008Jt-RU
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 06:25:53 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:54101)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1hvfcF-0008Ij-V3
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 06:25:52 -0400
Received: by mail-wm1-x343.google.com with SMTP id 10so1850330wmp.3
 for <qemu-devel@nongnu.org>; Thu, 08 Aug 2019 03:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=lJuPTGT0+AAohjds3hDadETmDKh/CjzCV6fWPnTNltY=;
 b=ZDCThdysdJC7yetMOysL5nH30IycMxMlUcxjYtr2+XCIhRpPBOmYBbvPtVe2PSLoi2
 XqQkLdxCeJBlYWnRSs89x3vE7HMVn0utuXL12f2Jxta9TXA+DHMeaBLJN2Y1pexJw67d
 UMT+aPNM7oTGDaa/rSttu92dqxhEtsxP6bkGrNwpQ5HYo8uBQG9rMTSlaNQ4Hv6LZdIJ
 HcWIU+HLQhMLDHzgM6KyINPKAGi6IgaegQUf0unFX5mn4VXYvnczRcaYd4dqzG3/Ys9e
 kb+mLm0X39oENclT5XNkwBrc+3MYfZcH53q4U8v3regCL+eRP3bI7BXKRhbfrJulv7kW
 i3ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=lJuPTGT0+AAohjds3hDadETmDKh/CjzCV6fWPnTNltY=;
 b=MFJzuDom3+oTGu8gmk39aPz434RgAhr7Y2mo73OZAnKkvcUpLJgpb3kojQV6/sL/Ap
 sxco3wLOAel7B7pBGaJ8Y/+3Pt/aLQe0WUGAM6NUng4TJhfGUYSV79cnzGnjenPHoClQ
 66xAz3/Qx1Z1QQ/V4hJ2ng6jGL5LlatsI6ICNI7IG+7yHX4VEdYPntzepoSal4RefaqK
 eirDJCQudYutYtu2XxitE+h8E0OUldhdRuR6Ilo9iVaFCMyF3X19K4hopW7Lto5/ZYrJ
 IJRnEZErrz7RH3VClq0VaG/DVMhn1AMzd4Lze/0Qjjd0RmkN9kGV7xUEcvoLDOwZBU9a
 vy1A==
X-Gm-Message-State: APjAAAXiJoAwhHvx8z9Q9c+frIAdy6ltohpLqxR3GAF/r1yUSCCtKJz3
 Z1SVT3veY3LqVkPxDQzv25k=
X-Google-Smtp-Source: APXvYqwrdBEbcWT3XK87AplZXHrMz9tVzQJbGur0L4GJ2LEv6SpNGXd2/TkP9Jp3Sli2UDU1y4y6jw==
X-Received: by 2002:a1c:7e90:: with SMTP id z138mr3441410wmc.128.1565259950278; 
 Thu, 08 Aug 2019 03:25:50 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id c187sm3046358wmd.39.2019.08.08.03.25.48
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 08 Aug 2019 03:25:49 -0700 (PDT)
Date: Thu, 8 Aug 2019 11:25:47 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Balamuruhan S <bala24@linux.ibm.com>
Message-ID: <20190808102547.GE1999@stefanha-x1.localdomain>
References: <20190807071445.4109-1-bala24@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="KuLpqunXa7jZSBt+"
Content-Disposition: inline
In-Reply-To: <20190807071445.4109-1-bala24@linux.ibm.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: Re: [Qemu-devel] [RFC PATCH 0/6] Enhancing Qemu MMIO emulation with
 scripting interface
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
Cc: maddy@linux.vnet.ibm.com, anju@linux.vnet.ibm.com, qemu-devel@nongnu.org,
 hari@linux.vnet.ibm.com, clg@kaod.org, pbonzini@redhat.com,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--KuLpqunXa7jZSBt+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 07, 2019 at 12:44:39PM +0530, Balamuruhan S wrote:
> This is a proposal to extend mmio callbacks in Qemu with scripting interf=
ace
> that is prototyped with python in this implementation. It gives ability to
> feed runtime data through callbacks without recompiling Qemu in generic w=
ay.
> This patchset adds library that provides APIs for Qemu to talk with python
> scripts placed in path -module-path and how existing xscom can be extended
> with python interface infrastructure.
>=20
> We have also added an hacky emulation for memory region (OCC common area =
and HOMER)
> which is shared between core and un-core engine (ideally this should be v=
ia
> sram device) to showcase the effectiveness of having the scripting interf=
ace
> (uncore engine taken for discussion here is powerpc specificed called OCC=
).
> Having scripting interface helps to emulate/test different uncore-core
> interactions including uncore engine failure or hang. It also helps in fe=
eding
> randomized data at byte level access. This patchset is primarily to exten=
d mmio
> callbacks with scripting interface and to demonstrate effectiveness it.
>=20
> Some changes are required in PowerPC skiboot tree to test these changes s=
ince
> the memory region is disabled currently for Qemu emulated PowerNV host,
> https://github.com/balamuruhans/skiboot/commit/a655514d2a730e0372a2faee27=
7d1cf01f71a524

Although writing Python is quick and easy, carefully wiring up the
Python C API for it is not.  In practice you lose much of the benefit of
Python if you need to study the Python C API every time you wish to do
some quick scripting :(.

It must be possible to compile out the Python integration code.  If the
Python integration code remains in the device model then the QEMU binary
has a dependency on libpython, which is undesirable when this feature is
not in use.

Assuming this feature can be compiled out, I think it should have a
chance to prove its usefulness and gain users.  Documentation and an
active maintainer are essential.

Stefan

--KuLpqunXa7jZSBt+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl1L+KsACgkQnKSrs4Gr
c8gvpgf+JAKL3RwserbWCgdPRFrzP+lDc1j16XV3JfTZgDgvkPzR0XXcsDn9+BWF
hGfC6nJPlTow1Iu/cXM3OqGuy125bAKrOj5sDB3UXX7RP6RaMA2AtjUUa3hecr2b
Vv2F84IiNfUxWEbd97y+mTvss/LBJ/JXeInDXdAzPWXP0Qf04fsG/MkMESFEv4pd
BZJMvz7gMvpRmkO1uDEjrcBpu2PSukU10E5f4B1ilkmxxL7IXnswF1xOrKG3oUYH
/c8wK9WkA6zJn/yIFDFrHQ6L6uaulFGIh0SUrO10wAcJNk6zllollHCgZc4gKJ2J
aIKw2HdWqKK4lJCkizD430IDLHiPLw==
=NOIR
-----END PGP SIGNATURE-----

--KuLpqunXa7jZSBt+--

