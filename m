Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F13FAC5DF63
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 15:03:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B455B2178F
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 15:03:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZUftE8JA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B455B2178F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59858 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSMpp-00075i-Sz
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 10:03:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38506)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1iSMot-0006cS-1O
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 10:02:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1iSMos-0004xi-0U
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 10:02:02 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:54892)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1iSMop-0004mP-UZ
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 10:02:00 -0500
Received: by mail-wm1-x343.google.com with SMTP id z26so3823125wmi.4
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2019 07:01:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=33+z7TvLrfiCWtDBsn2EKMxDoGkq5yGyfTEH4iPZjiU=;
 b=ZUftE8JAbn7OkmQuhngu/EWL6j/84Wl1rHlO9cWtXHzX6gYWVw0jWAyr2k/oOnOfWo
 q6qJUsqKcPG6EVWKJaP60yrFt4wJ9uqxpPXDDbvRQbFx+n0uMjRqxXE7TLFAFAInVkdj
 9OSn/8q4TxbO0G4N0my2ann1V3zqaasJN2fvW3lr/2K1litfZdVSvx1KdrJssQSQTprH
 iigj7XH93BcVWs+a/ofBy1dDvhc3LDHFyl8/xYl1WgX5OyUEz9g1Aw7YAWiG3XaTqWZO
 hLGj8DNhw4icIeVnkEAiqGO/MZ861VZ60JW1udGCWXzAwSNnvzhjfWOYd4JuNLh/jJ4P
 nMuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=33+z7TvLrfiCWtDBsn2EKMxDoGkq5yGyfTEH4iPZjiU=;
 b=pe7f6DNkmwNnO8DvT/JKk5kFPK7JcfRDMht7Si1WhaZvsRisP9YSOJU1NwY+KWSedG
 Cq/JURApf/SF7ZYqU5j5klGmUH6n2++5TJ136cR7tllW+NP5scz8sq03+rfW9b1wLwrv
 ZJqHEAfKS1iZyqj1vqNZi0RNcH6QP6xuKpTJIKxBGVGGsGeGoNDanDTGlyS91SLPUH5B
 yCCrnxeKsBehFLP8gJPr5W2L19mK9VNZV0r9yGANWNYkshL2OMsLErO9zy/SdJHqYcY3
 dDOOfw7xu3kAOuiTLYoAIL/1u/ViSUR6KYxP7qUYpghP8JUkJi29GJXUrG+MCxs9EzMI
 9pUg==
X-Gm-Message-State: APjAAAUuinwbYPBgGIJyVQPHeTshUQBPLcv2gBF2XozHbLX+j3ENZ41E
 bztD09v7K1PQDYHlyts1Bmw=
X-Google-Smtp-Source: APXvYqwOzfUAd1AjP2QeITpNe8xIqvY2bBHxjdR/o0AQuTQ/1ECzmEHHjclnziSdfjsiV6w2SOeYAA==
X-Received: by 2002:a7b:c642:: with SMTP id q2mr2881532wmk.169.1573052516357; 
 Wed, 06 Nov 2019 07:01:56 -0800 (PST)
Received: from localhost (178.165.129.116.wireless.dyn.drei.com.
 [178.165.129.116])
 by smtp.gmail.com with ESMTPSA id v128sm4141929wmb.14.2019.11.06.07.01.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Nov 2019 07:01:55 -0800 (PST)
Date: Wed, 6 Nov 2019 16:01:48 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: "Oleinik, Alexander" <alxndr@bu.edu>
Subject: Re: [PATCH v4 01/20] softmmu: split off vl.c:main() into main.c
Message-ID: <20191106150148.GA340561@stefanha-x1.localdomain>
References: <20191030144926.11873-1-alxndr@bu.edu>
 <20191030144926.11873-2-alxndr@bu.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ZPt4rx8FFjLCG7dd"
Content-Disposition: inline
In-Reply-To: <20191030144926.11873-2-alxndr@bu.edu>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 30, 2019 at 02:49:48PM +0000, Oleinik, Alexander wrote:
> diff --git a/main.c b/main.c
> new file mode 100644
> index 0000000000..ecd6389424
> --- /dev/null
> +++ b/main.c
> @@ -0,0 +1,52 @@
> +/*
> + * QEMU System Emulator
> + *
> + * Copyright (c) 2003-2008 Fabrice Bellard
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a copy
> + * of this software and associated documentation files (the "Software"), to deal
> + * in the Software without restriction, including without limitation the rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
> + * copies of the Software, and to permit persons to whom the Software is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
> + * THE SOFTWARE.
> + */
> +
> +#include "qemu/osdep.h"

Perhaps this should be added:

  #include "qemu-common.h"

It has:

  /* main function, renamed */
  #if defined(CONFIG_COCOA)
  int qemu_main(int argc, char **argv, char **envp);
  #endif

This way the compiler can check prototypes.

--ZPt4rx8FFjLCG7dd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl3C4FwACgkQnKSrs4Gr
c8gn5Af/VpAWn+rZ7CeOBWAVyeq0Wz045tQuQiEe5hOh4j/VZav8Cgkbi7XZqHBh
L23vBMVGVAB9iUH9IDzpjQTeBUB7UEHIjGLa5xQ/iXCoKkmKTBdKZW//g1HUfaqg
/X2m2WS0/swCe9G0q6jMx9rLSU7OHsQCKqi3sM+wY/DsCd6onid937rjOmzZ8dR0
MTFCPrYuKn/r55afrCeeRI3UcRQ1Csmm+h0doIUaYcBct+k8ccgP1reyYpV0cvvB
qXbJr3GSEu9hc/Ug7wwHgkQZO2U/sEiI6+nEibjSpVF6/pnGqFTLG1BSHRpOD0K6
qJ77YYzukxseMO9FHmHXhfMQJ28OCw==
=CCFV
-----END PGP SIGNATURE-----

--ZPt4rx8FFjLCG7dd--

