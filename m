Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2391C34022
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 08:13:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D419222D9
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 08:13:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=aepfle.de header.i=@aepfle.de header.b="BFy6efzl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D419222D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aepfle.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47032 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4KUQ-0000XJ-So
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 03:13:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56455)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <olaf@aepfle.de>) id 1j4KTo-0008No-T9
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 03:13:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <olaf@aepfle.de>) id 1j4KTn-00025Z-Uc
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 03:13:12 -0500
Received: from mo6-p01-ob.smtp.rzone.de ([2a01:238:20a:202:5301::2]:30008)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <olaf@aepfle.de>) id 1j4KTn-00023I-9A
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 03:13:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1582099987;
 s=strato-dkim-0002; d=aepfle.de;
 h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:
 X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
 bh=uXOIhyMfQWFk8NQbUwW1WVoOv0FfLbxq3rF9wCPCsxY=;
 b=BFy6efzlKuFaKR1oCwh7Xu+Lvdil2/YOPN0cRh5arPU0i8prjqQe8DToL6uH8cNLzk
 k9yiIyG+AxqlAj+d0AcvqYvLEMo7MxY4i9+aSMXjaVC1TdyVqCgDSWv1R0gERPAyXuoj
 nxX+S/9C3J0nYwkskCyxE+Bid31P6c6UF1Ou2V5gfLfqpF7DSirf3pH1OGdT83R979OK
 4EfSHn2UAKz/6mdjDjbFhyZnxH88xjGybvltKYeGjkPZrP4wrtKHUnB81TjGLQC9Ecnd
 3TqPSSVgdeTbq04O9HenFW3ApuDRJB1MSM0E+xST2AcTvINZX3kjQAYRiKbZkRugruHU
 /l4A==
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QED/SSGq+wjGiUC4AUztn93FPS2dyuYMlkjQ=="
X-RZG-CLASS-ID: mo00
Received: from sender by smtp.strato.de (RZmta 46.1.12 SBL|AUTH)
 with ESMTPSA id 605caew1J8D6GPi
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
 (Client did not present a certificate);
 Wed, 19 Feb 2020 09:13:06 +0100 (CET)
Date: Wed, 19 Feb 2020 09:13:00 +0100
From: Olaf Hering <olaf@aepfle.de>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2] hw/i386: disable smbus migration for xenfv
Message-ID: <20200219091300.07e71a49.olaf@aepfle.de>
In-Reply-To: <49a2f35d-cc78-762b-39c3-0340bbebcf84@redhat.com>
References: <20200113174521.3336-1-olaf@aepfle.de>
 <20200116180321.24968-1-olaf@aepfle.de>
 <0335edd2-3d33-88f8-2ab4-4791f7289885@redhat.com>
 <20200117102244.22edd8a6.olaf@aepfle.de>
 <ea3a65c3-bd69-7815-6893-cb1cd8b9cfd6@redhat.com>
 <20200117140616.18cb8c45.olaf@aepfle.de>
 <CACCGGhCO_OqPq__t+V9RrFMYhXCJ5N4PPkq9CASJULV2rTkT-g@mail.gmail.com>
 <20200127100951.0803d167.olaf@aepfle.de>
 <20200218182728.4b7f17b7.olaf@aepfle.de>
 <b1313071-0eae-0465-4b3f-85c49c77a256@redhat.com>
 <20200218204405.17047092.olaf@aepfle.de>
 <49a2f35d-cc78-762b-39c3-0340bbebcf84@redhat.com>
X-Mailer: Claws Mail 2019.12.31 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/8B=6Keu+4xHwJzcrc/BAXcy"; protocol="application/pgp-signature"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 2a01:238:20a:202:5301::2
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
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 Paul Durrant <pdurrant@gmail.com>, Anthony Perard <anthony.perard@citrix.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/8B=6Keu+4xHwJzcrc/BAXcy
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Am Wed, 19 Feb 2020 09:05:49 +0100
schrieb Paolo Bonzini <pbonzini@redhat.com>:

> Has any version of Xen been released with a QEMU version above 3.1?

Xen 4.13 has a copy of qemu4. But, Xen can use an external qemu. It is unkn=
own how many supposed-to-be-migrated domUs with qemu4+ are out there. But t=
here is a six digit number of running domUs with qemu3 out there.

Olaf

--Sig_/8B=6Keu+4xHwJzcrc/BAXcy
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE97o7Um30LT3B+5b/86SN7mm1DoAFAl5M7gwACgkQ86SN7mm1
DoC7hA//XyWEZMut9O7QDs/iQDkjUNcHQ11O0EPiNkarqcYkZ4kWQq7Ri1WaExgr
5qRAO+UpNu7JpfozzJQ6dJiMMFMoiif4Cgt9T+YnjqzmcsyQn/FwcuLJKoD3b+hs
6dMbbXPbIWcAPamP/Uz/M7+GJJto1Kk91Iu05R5nbHM/TZJYJ+QIlatgTD+KWqsN
aP6nC6Mdh925p/U2ENAbxOLeCpsu/xG+WW87RKdYiWPLJ986zsG5bHPmTZezVggp
wm5hi2yyGBQGUtpvibH5d5xyBXFotn2yERr5cAhhLq0zqAjaenrF8OMfFJyVzF9i
9fvEWNsQZ1sWEUXg4nki4ezZdyXA9NsU+6RFBDNKlHMNcI3wQ4NQVgXg9BIETPOM
7ZV35k/Bsx2TIDLXXh4t9cK6gL3Qn7W5GQmf87DefhvaPlaCqS/tdBjaOjZ9kZpr
jdRKofZhvje7LQyHxDwa9P47s4JrvVDV5Egub4Hf+/Ktm9fS5tNEzxZjl9Hw05fP
dLBt4+AprvkVJEQp9wUblVCCzoYkoWAtNm8pzV8yHwDL9mDXtwPF7nEGJ33HgOYs
m/ptGYvod3REMRVZuwWS1272HrjLr/nNLLMQT3HgD3q4D7P0M81cTjNiSiQee4W7
Td/AaDP1uXDfcnp/6i0BZ8puvE5EJUTwFELIFLTAI6aNxcSkT5c=
=jA/+
-----END PGP SIGNATURE-----

--Sig_/8B=6Keu+4xHwJzcrc/BAXcy--

