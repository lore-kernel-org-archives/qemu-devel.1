Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41CDEC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 11:33:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CE3F24125
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 11:33:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iHeYwFo0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CE3F24125
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuaja-0000v3-7U
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 06:33:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:32898)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1iuair-0000Mf-Dc
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:32:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1iuaiq-0008GC-G1
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:32:29 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:42513)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>)
 id 1iuaiq-0008Fj-9a; Thu, 23 Jan 2020 06:32:28 -0500
Received: by mail-wr1-x441.google.com with SMTP id q6so2649812wro.9;
 Thu, 23 Jan 2020 03:32:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=+sHDYTYXY35BbDvLrvUf+80RBIsbR7QucjDuIeFfGLU=;
 b=iHeYwFo0sRcHmLzXzphM6YVrSo/wHe3wVvuHklMvtHwuyerEOJl12+Jp9plTWkmbSS
 KqYsyhuHxt9TGwy4ZeY+P440Dcp3Lc/Ul3exLTZw/K1txJDxNlS+KRYmG7WWnplW0tel
 KRbnGGvU9VRsv73ZjhLJf3ZAOb/V3ZK94xBg68Oqid1DuSFV/Pk+5Jixu9KrJKb12RBW
 i5JPRU20/vDqT5qTOsF02a37KBWU/tGcsrFeaKRo1WA+CTheAqyhhIsJeZujKOvTHgmd
 v/5NLzctZOhNE1eTWuJ10ktzbHUi7k62A/9ESHawXuhFTkvYaX6GYhmx20f+ePc2hbiI
 u0ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=+sHDYTYXY35BbDvLrvUf+80RBIsbR7QucjDuIeFfGLU=;
 b=A0FAHHPuoQ0xp6YL/EKjKbF54vzdQKoPQL8rBfZpWtw0xiQbOu00bH7zfhZJvPRENJ
 +sWBDhOkTCWKHO16t8bOXJ4/0olcxIDYJ5YajDpHv/Fla8tacCVv3of4TsDzY+UmKKwL
 vUz52412v94Vsl7mkCi9ZmgNyFYJW8bfIStlqqWni+EhPseJjq31U86npy7eA8IXYylH
 xKCjh4nY+KdQn6MAw64j4cfIjc1Ou5sFmgYKgBkXMadojoPjTQe9bKiYZI39y1XNhCdg
 3GjHpF18XcJTLrfmKZXW+/zX7nR0i9fRSpRLV2d3fJ6JMQFRRyGVahW1jnROYCq3xOLH
 AFuw==
X-Gm-Message-State: APjAAAWwk3UBlYjKtK9Ttjufb7brLlnWhniu5jKMoSJF9HdmgNgg0wsp
 NLmTh8AhQnW60f9SNoPRkn4=
X-Google-Smtp-Source: APXvYqyN0eazphPlACZXOg5rPKXPtmORa7TOhbvGUgAVx1p7rO52dWV64t+Pnv2/f9ZW07aaPwCqRQ==
X-Received: by 2002:adf:ea42:: with SMTP id j2mr16378983wrn.270.1579779147157; 
 Thu, 23 Jan 2020 03:32:27 -0800 (PST)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id x10sm2641839wrv.60.2020.01.23.03.32.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jan 2020 03:32:26 -0800 (PST)
Date: Thu, 23 Jan 2020 11:32:25 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: salvador@qindel.com
Subject: Re: [PATCH] qemu_set_log_filename: filename argument may be NULL
Message-ID: <20200123113225.GB691377@stefanha-x1.localdomain>
References: <20200122210812.17124-1-salvador@qindel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="2B/JsCI69OhZNC5r"
Content-Disposition: inline
In-Reply-To: <20200122210812.17124-1-salvador@qindel.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: qemu-trivial@nongnu.org, sfandino@yahoo.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--2B/JsCI69OhZNC5r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 22, 2020 at 10:08:12PM +0100, salvador@qindel.com wrote:

Existing callers like vl.c:main() do:

   if (log_file) {
        qemu_set_log_filename(log_file, &error_fatal);
   }

Please fix up existing callers.  They won't need to check for NULL
anymore before calling qemu_set_log_filename().

> +    /* else, let logfilename be NULL indicating we want to use stderr */

Please update the doc comment instead.  That way callers know that
passing NULL is allowed without reading the implementation.

--2B/JsCI69OhZNC5r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl4phEgACgkQnKSrs4Gr
c8h+sgf+KkMPkPO5J0HmxHNTO6txcYkrkVJvcvWBc2dSnvCDumfzAMHIB2cC3mjG
JTa5RAob1heDKJGEWlGyf6m5KLFUlWvyeFq3EEhdirThHqTtV73gY8NMZ8aOhdgS
RPUZlI8ISYkHjCtyVaVU3hIOHGjX/8s0BM1bfyERrxIfDNvQBNQsEQuVi38IBDdP
H83DBuIYNcmSl3QXBztS2d0QdOOpXR4zvqm0zwZ8xHqokzIuDadW5RcmiV4KrTYe
jc43g+SW0P4GkrCibyA8rtcwfW40pOTX4RjRoTJZRBdJNUTcwoDPJ56iMcdXtUWS
xOz68N+Fgmvje6Y96vj0VldgvWWpsQ==
=bbIk
-----END PGP SIGNATURE-----

--2B/JsCI69OhZNC5r--

