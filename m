Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 025FEC5DF61
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 13:42:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAB462077C
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 13:42:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qde8kWHN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAB462077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSi32-0000NM-QW
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 08:42:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39830)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1iSi1p-0008At-Qs
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 08:40:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1iSi1n-0007ar-W3
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 08:40:49 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:42673)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1iSi1m-0007a6-MO
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 08:40:47 -0500
Received: by mail-wr1-x443.google.com with SMTP id a15so3041057wrf.9
 for <qemu-devel@nongnu.org>; Thu, 07 Nov 2019 05:40:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=5rmkeQrX2UIVKj4sHb5a6VW9hkM0cbxJ3rF8G+83GzQ=;
 b=qde8kWHNmWdMUjvnJW19krKULiltKqEIHYnZ0Jd4Y1BFLyRZD6si/DLaQ1kYe0uSNc
 YQCZpRm6tyznJve6Re9u4+0tnI+yka6QARhvhfOlhcYGGLEm+MT3AYF4643tOnyJUJ+Y
 tYkIp/KOihTxWKhM2l8uDjIJpzQV6tDMO4/gLcxN/QxXFSSEKAtjoOlER/gAvvwOGr9p
 AKlbcf1CoivUzAE71k7dlCHkTjQs9smK29My23cJmO88dYWseHRjwTZ6S2gxCB0GbYnA
 SfHNvLY5T7BYlXfJ24iN/ZBEv1GIU9S2hnhmeBPIUn2RFLMuiqJxCB+c/GhaOSF2Y4l/
 hgqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=5rmkeQrX2UIVKj4sHb5a6VW9hkM0cbxJ3rF8G+83GzQ=;
 b=YHOT9vchzOGxF+KabrDanM6rlv8OGfg603WFKZy0LyP75gw14vVclS4hrdfAbM1E0B
 357RqwvZ31C1ZSS9E6W2C0vx/jzgQNMP5vqSQkYDZ4mN0JjShL9l6Tu3jGOfKllCbLdS
 3PRnIDFUNJ3GADu8+qiDv9hDbrfnjC30ogxi2kPTEpiwJXrzP4FdH2hmB4p/7FDRO+Fj
 qd5mvJs/GVD9vElSAu/WfUj0pgenYEKsRUmqEuCCbKiLuprxy2q08X4zekvgyv4UCfye
 6Lgl33x1iPjvOXVnFNW0SADApEl9PbgOWQd7PSZgO2W/as1W+OraDzG7dT8ZYm2EyNN0
 rrmg==
X-Gm-Message-State: APjAAAWEVuSWf6grLb3zkVSOquOtjj2xA2BL/KxBriKS94iT2FXs9WU+
 0WaGAKM6xTg76iRZw7seKG8=
X-Google-Smtp-Source: APXvYqwOTbJusGAa19WxQW+KO5NutQXacHRh+dxbulMMvGOGHuxxg5ERchDCfTJkzgF4YvEQed0nwQ==
X-Received: by 2002:adf:de86:: with SMTP id w6mr2992131wrl.220.1573134045546; 
 Thu, 07 Nov 2019 05:40:45 -0800 (PST)
Received: from localhost (77.119.131.75.wireless.dyn.drei.com. [77.119.131.75])
 by smtp.gmail.com with ESMTPSA id n23sm2022190wmc.18.2019.11.07.05.40.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Nov 2019 05:40:44 -0800 (PST)
Date: Thu, 7 Nov 2019 14:40:36 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: "Oleinik, Alexander" <alxndr@bu.edu>
Subject: Re: [PATCH v4 20/20] fuzz: add documentation to docs/devel/
Message-ID: <20191107134036.GF365089@stefanha-x1.localdomain>
References: <20191030144926.11873-1-alxndr@bu.edu>
 <20191030144926.11873-21-alxndr@bu.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="GLp9dJVi+aaipsRk"
Content-Disposition: inline
In-Reply-To: <20191030144926.11873-21-alxndr@bu.edu>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--GLp9dJVi+aaipsRk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 30, 2019 at 02:50:04PM +0000, Oleinik, Alexander wrote:
> +== Building the fuzzers ==
> +
> +NOTE: If possible, build a 32-bit binary. When forking, the 32-bit fuzzer is
> +much faster, since the page-map has a smaller size. This is due to the fact that
> +AddressSanitizer mmaps ~20TB of memory, as part of its detection. This results
> +in a large page-map, and a much slower fork(). O
> +
> +To build the fuzzers, install a recent version of clang:
> +Configure with (substitute the clang binaries with the version you installed):
> +
> +    CC=clang-8 CXX=clang++-8 /path/to/configure --enable-fuzzing
> +
> +Fuzz targets are built similarly to system/softmmu:
> +
> +    make i386-softmmu/fuzz
> +
> +This builds ./i386-softmmu/qemu-fuzz-i386

I'm surprised that "make i386-softmmu/fuzz" builds
i386-softmmu/qemu-fuzz-i386.  Should that be "make
i386-softmmu/qemu-fuzz-i386"?

> += Implmentation Details =

s/Implmentation/Implementation/

> +
> +== The Fuzzer's Lifecycle ==
> +
> +The fuzzer has two entrypoints that libfuzzer calls. libfuzzer provides it's
> +own main(), which performs some setup, and calls the entrypoints:
> +
> +LLVMFuzzerInitialize: called prior to fuzzing. Used to initialize all of the
> +necessary state
> +
> +LLVMFuzzerTestOneInput: called for each fuzzing run. Processes the input and
> +resets the state at the end of each run.
> +
> +In more detail:
> +
> +LLVMFuzzerInitialize parses the arguments to the fuzzer (must start with two
> +dashes, so they are ignored by libfuzzer main()). Currently, the arguments
> +select the fuzz target. Then, the qtest client is initialized. If the target
> +requires qos, qgraph is set up and the QOM/LIBQOS modules are initailized.

s/initailized/initialized/

--GLp9dJVi+aaipsRk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl3EHtMACgkQnKSrs4Gr
c8jeaAf9HYqE7SMBP7PFdENcsoKozdtbwH2dJPiNta+u9yfK2yoxuo3IVIDbZcNP
C1mG3hiNsWSuL5OacEKgdacOVfeJl0Eu6G7/srY17AHILBekPWRoqQpzNvdx3qjV
jfKUYkXT+7LBvPHEDCfG1V0v1Gs5oFScOdydeJQMvekI0oA4B+1L+VDt9ykPKupS
CuCWQY7/YOJ5VBCo/KHHWQ/QVpaSvhzWvG94w9ejVBXdLUqu+1JM/KOS+xSJJFa1
tgmJsqzt2pkKAxaF3uEeOyySXK5K4QdlyEDn78tNPhGpcX0NWMEz/anoJTjnuPkQ
e5TTWrG0ZNtFPp2E65KaViU1ihIoUQ==
=RzVZ
-----END PGP SIGNATURE-----

--GLp9dJVi+aaipsRk--

