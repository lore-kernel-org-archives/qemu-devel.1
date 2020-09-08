Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 777A3C43461
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 09:15:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09DF8206A2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 09:15:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h3zeFddq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09DF8206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36176 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFwCZ-0002jW-3m
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 05:15:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50096)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1kFw9R-0006fs-ET; Wed, 09 Sep 2020 05:12:25 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:33471)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1kFw9P-0003Sk-Vw; Wed, 09 Sep 2020 05:12:25 -0400
Received: by mail-wm1-x343.google.com with SMTP id e11so1379507wme.0;
 Wed, 09 Sep 2020 02:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=Ft3F3PRm3THMqbpuiEV3MHtv0PAFRe8qhKl/kQomtjA=;
 b=h3zeFddq371Ur2seXtQphd0iafKVILvB3iVrppVPQFjuqhR+gZrZPIKph2GQiiylUH
 XIwHFC3tDkrb/BKSKOduH7vcowMLG+fxUFiCgabxinuwGNhjLYfRScxlZryyE7qX4qYL
 kSNmPi+piEHJX+JeWpMZlfw3YRzkf5T0n92y7xmOp7x6/X1VpYry9+84ZPJDR4QQH/jQ
 7qFpRJnyAGwB70ViIoOL4z95TMsKL+zFcc3a+TjcHBBQxXM5QNb2J4+85z2vv+9ayM8W
 LqQYEB43PJ9VVBsDQVXi0b/ZZZGlDTyzM8iaEbNW3bz0gl/WzyFSnlG/AEg3peAhEmUB
 pejw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Ft3F3PRm3THMqbpuiEV3MHtv0PAFRe8qhKl/kQomtjA=;
 b=fVwPaOGK0cQVUVWh97eeYB4RSw8O+5jP2wRxBxRr5VrAe7pBEh0NEP1lZHWnLv5twn
 h50F77H21VZo2TfBv1szkdznf+BGyLRmT/FQNHk6GjNOCMMwnog/jKrQCAPM4jajkavt
 jeO1sIKwMs0g2WYr8hTpKc5LxyTaTWV7nxUxa+QlcRIo3PnnUqfS6o6ascNtOliNTpQ9
 wK/w3GQfhOM2isWcB2Aodl1jX/UcALG5SIoQnoXdV9NwgJQ4U5Xl900H2fpsrmZRpV5d
 eD/Ecuskxy9c3R4HISxWQSfd4OKstS0l3blft3wNVVldYeb1BDfe+0HkNazbJ9OFupN2
 A+jA==
X-Gm-Message-State: AOAM533FiuffcAsFKU0OwigYEfCYmNjJAEXepLNpuLYAlZXH9RPZdit3
 trtYGq7+dEqkgUPbqHgqNho=
X-Google-Smtp-Source: ABdhPJw7GHIBcmzcRzBLvaFfxRB+WImHEQSmMIJtu+jqoTMJpkQTihkC/B/UEkf1XJlwXkWZtJRaiQ==
X-Received: by 2002:a1c:6a08:: with SMTP id f8mr2641445wmc.151.1599642741284; 
 Wed, 09 Sep 2020 02:12:21 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id m3sm3490439wme.31.2020.09.09.02.12.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2020 02:12:20 -0700 (PDT)
Date: Tue, 8 Sep 2020 15:37:25 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [RFC PATCH 00/12] hw: Forbid DMA write accesses to MMIO regions
Message-ID: <20200908143725.GD7154@stefanha-x1.localdomain>
References: <20200903110831.353476-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="u65IjBhB3TIa72Vp"
Content-Disposition: inline
In-Reply-To: <20200903110831.353476-1-philmd@redhat.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=stefanha@gmail.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 Peter Xu <peterx@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, qemu-block@nongnu.org,
 Li Qiang <liq3ea@163.com>, "Emilio G . Cota" <cota@braap.org>,
 Joel Stanley <joel@jms.id.au>, David Gibson <david@gibson.dropbear.id.au>,
 Laszlo Ersek <lersek@redhat.com>, Robert Foley <robert.foley@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 Richard Henderson <richard.henderson@linaro.org>,
 Beniamino Galvani <b.galvani@gmail.com>, Eric Auger <eric.auger@redhat.com>,
 qemu-arm@nongnu.org, Peter Chubb <peter.chubb@nicta.com.au>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>, Tony Nguyen <tony.nguyen@bt.com>,
 Prasad J Pandit <pjp@fedoraproject.org>, Alexander Bulekov <alxndr@bu.edu>,
 Andrew Jeffery <andrew@aj.id.au>, Klaus Jensen <k.jensen@samsung.com>,
 Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>, qemu-ppc@nongnu.org,
 Jan Kiszka <jan.kiszka@web.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--u65IjBhB3TIa72Vp
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 03, 2020 at 01:08:19PM +0200, Philippe Mathieu-Daud=E9 wrote:
> The main patch is:
> "exec/memattrs: Introduce MemTxAttrs::direct_access field".
> This way we can restrict accesses to ROM/RAM by setting the
> 'direct_access' field. Illegal accesses return MEMTX_BUS_ERROR.

QEMU needs to simulate the behavior of real hardware. What is the
behavior of real hardware?

Stefan

--u65IjBhB3TIa72Vp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl9XlyUACgkQnKSrs4Gr
c8hm+Af/bAR/vQDQ3YPrHCBH7S0Tk3kYVaMaPicOdDQpuULJ+vJ7QQs8+Uh3GEDJ
QS3tNNfDKibYG1mUY4+nKUz6cU/9YbfFVIhTSIlLS8Rpt5lT3dFNkGYTTWvBkey/
qLiYGeniyVMR3WLVAMXvrlmhsdqdvvE6avkPob5ZHQDs6f5b64n1r409PEoGWsoo
Wr+UPifHdPC4XSLx59BFcj9lYRKx+QqARj1VDK3GJ6451xZ6FnGwJJyGgtc1I5HS
8mv08mKnGeHyCGIGKIN9tRSZgbkgHJxWTohHRNZMEz8GxI/o0uxlL/0sk4a5cJAL
sres8UZegMhMOj6NL3FiQ3XWrkkTOw==
=Pxw8
-----END PGP SIGNATURE-----

--u65IjBhB3TIa72Vp--

