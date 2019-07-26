Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1073C7618B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 13:20:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F8F122BEF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 13:20:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yq0N083d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F8F122BEF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39844 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hr08l-0003jI-EB
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 09:20:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60343)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stefanha@gmail.com>) id 1hr08a-0003KU-8u
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 09:19:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1hr08Z-0007t6-5U
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 09:19:56 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:51459)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1hr08Y-0007rM-UB
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 09:19:55 -0400
Received: by mail-wm1-x335.google.com with SMTP id 207so48016927wma.1
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 06:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=esljtPaOykpHzdLRy7pBsZlsbCNrrhoWQ4vzmHlKkhw=;
 b=Yq0N083dNIYkqjwWGVqEYCVXmC9CIMkbWfrq5qYkCgEwynIvHxU8UrblzVTe856Z8m
 OFS6MW5nPe3QOzXBHusMLM08C6HytQRZxf0P6tKI4E7JUdycUa7KvZVHIAjrsYaMYvFE
 r33aYKI+RIBtrM0rR0c9AgPLOVMpA7sd6EERuFs5rU+/WvEbBRwida56nAE1T/ndcnya
 2olIBb23a7yCLS2pFk7u+nNvq1H7Za4okKFbnkRQUdy2pcPAtifbW1dz94s13GoYwmcK
 tGsvnDpxS58LqaaYvmSCE/63yzua1zmztuW/CVrOqSvPi3R9zNmyffw+zUdwqqAqEXkY
 03Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=esljtPaOykpHzdLRy7pBsZlsbCNrrhoWQ4vzmHlKkhw=;
 b=V98eCKJzE9PLtQqPux/FcQ6a/PWpqPz6hpRhH/AvWMoMWa4w+M/GM2v//qTYhwdtmm
 P/jewlByPW9QntJUaPQbUJKqfdCPpeQ37VCRdtYLQYmKA6KY3yYcj4/aQE3awUFXExro
 8DirnSCm1jnTsO3a86Ol49JzmqThcf7Pp79CA8WEz34PSuBr7kiTFumqxaVY/hlNjeos
 itNI/BZOYK2Ur0y9pgVfum5f2ccV7QQR5NduOFLtghLIKhCEHJX2zp+zLTsG4VVVsurj
 X8PExhkWT8tpJgmc26ylCXSiSS4IKpmmM5eSLK0Zk1FXGjHeLb/PJJ87ULWO0/B2FcHU
 kMGQ==
X-Gm-Message-State: APjAAAVhz/SP9UFWSbCxTivpWBbauJTiUSKnHXvli9sByh51kBv3Rdyb
 VGyqVdLSuMWUIzWiKGELne4=
X-Google-Smtp-Source: APXvYqxQR2lZNCfECumEcWOA0OkyCprPTBFahco4f107gpbw7VjEdst90ViaYQgJ/IEosKKVSoRshw==
X-Received: by 2002:a1c:9cd1:: with SMTP id
 f200mr83181171wme.157.1564147193787; 
 Fri, 26 Jul 2019 06:19:53 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id o7sm45235267wmf.43.2019.07.26.06.19.52
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 26 Jul 2019 06:19:52 -0700 (PDT)
Date: Fri, 26 Jul 2019 14:19:51 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: "Oleinik, Alexander" <alxndr@bu.edu>
Message-ID: <20190726131951.GI25977@stefanha-x1.localdomain>
References: <20190725032321.12721-1-alxndr@bu.edu>
 <20190725032321.12721-20-alxndr@bu.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="xGGVyNQdqA79rdfn"
Content-Disposition: inline
In-Reply-To: <20190725032321.12721-20-alxndr@bu.edu>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::335
Subject: Re: [Qemu-devel] [RFC 19/19] fuzz: Add documentation about the
 fuzzer to docs/
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
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "bsd@redhat.com" <bsd@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "superirishdonkey@gmail.com" <superirishdonkey@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--xGGVyNQdqA79rdfn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 25, 2019 at 03:24:00AM +0000, Oleinik, Alexander wrote:
> +== Main Modifications required for Fuzzing ==
> +
> +Fuzzing is enabled with the -enable-fuzzing flag, which adds the needed cflags
> +to enable Libfuzzer and AddressSanitizer. In the code, most of the changes to
> +existing qemu source are surrounded by #ifdef CONFIG_FUZZ statements. Here are
> +the key areas that are changed:
> +
> +=== General Changes ===

The audience of this file are people wishing to run existing fuzz tests
and/or add new fuzz tests.  Changes are of limited use to someone who
wants to write fuzz tests but isn't familiar with QEMU internals.

Instead I suggest documenting fuzzing in terms of:

1. How to run existing fuzz tests.
2. How to add new fuzz tests.
3. Advice on achieving good code coverage and explanation of the fuzz
   test development cycle.

Focus less on the fuzz infrastructure internals and more on how to use
fuzzing.

--xGGVyNQdqA79rdfn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl06/fcACgkQnKSrs4Gr
c8gOwQf/WLtIDVLDrqmhX4InWB2Yuw5u/wTrZAGpsYWT3JNePwaNG+MS+hcOghPO
tdTtwmrQlpOpikPYWRsKBi3tEZq7uVofpR75S1bvZquTb3bexVX83Se/tNCQePq7
kqSYBi7PaZiB2YcLoAEWt0TIYncK3cFwbwfhQ+T79EcfC+YT09L9i5gQHEXNYYwf
m86Bq6++K5duAT/9vMccq9+xk9aqqiyPEbf/Axm7SBQRsYMzAT8p34Z/Nu1z9bqI
dTsmcWuI3jlWBuRc6dlVcCANBt77ug5RF1iQbA0l7P1HZ+vMql1LIojB4JyOSPIo
S1Tyjf66U6WJXfhONnW5QpmMGisVTw==
=oc7y
-----END PGP SIGNATURE-----

--xGGVyNQdqA79rdfn--

