Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 201DEC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 09:17:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF93A22283
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 09:17:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=aepfle.de header.i=@aepfle.de header.b="FckB2Eg9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF93A22283
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aepfle.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44240 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUnlX-0005JI-Kp
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 05:17:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54954)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <olaf@aepfle.de>) id 1kUnke-0004gH-2J
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 05:16:16 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.161]:27750)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <olaf@aepfle.de>) id 1kUnkb-0007fQ-QX
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 05:16:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1603185369;
 s=strato-dkim-0002; d=aepfle.de;
 h=Message-ID:Subject:To:From:Date:X-RZG-CLASS-ID:X-RZG-AUTH:From:
 Subject:Sender;
 bh=dXlDQJPDO+wMHe79PpLS2sKjop5QKPKG39Fpjc56hLE=;
 b=FckB2Eg9yw7WyedZfM2MPV+LEEnnAWf0is1/InzmI0ueFfdvaqQve+XqsLVJk/cXX+
 lMLmtKZjK1hqipItiX0rUNYkqQrbioqhVtmCJM98NAmEzgbVpT1eAJxzneuKMPUe+A5H
 vjCsIyt4crCPW94Y8O7KCnwlIlnwa2VfpHhPLDDeOooUMhA6pOb6KW2nY4IFTg63VCp8
 8WFkKOx4C8n9s2pt9SOfrmC0KcfVFBiIpceDxW/+JRn1UW5DqN38boTNWFApsTnhZXmx
 vqc0IhQMucyLMEPhnB8g1k32qqKjrJ3GKrFz3SPcYDbjk8/wMXKnkGjy7HSFWYZGL2s8
 S2fg==
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QXkBR9MXjAuzBW/OdlBZQ4AHSS3G1Jjw=="
X-RZG-CLASS-ID: mo00
Received: from aepfle.de by smtp.strato.de (RZmta 47.2.1 DYNA|AUTH)
 with ESMTPSA id e003b5w9K9G8AtM
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
 (Client did not present a certificate);
 Tue, 20 Oct 2020 11:16:08 +0200 (CEST)
Date: Tue, 20 Oct 2020 11:16:05 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org
Subject: Re: roms/efirom, tests/uefi-test-tools: update edk2's own submodules
 first
Message-ID: <20201020091605.GA2301@aepfle.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ZGiS0Q5IWpPtfppv"
Content-Disposition: inline
Received-SPF: none client-ip=81.169.146.161; envelope-from=olaf@aepfle.de;
 helo=mo4-p00-ob.smtp.rzone.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 05:16:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This is about qemu.git#ec87b5daca761039bbcf781eedbe4987f790836f

On Mon, Sep 07, Laszlo Ersek wrote:

> In edk2 commit 06033f5abad3 ("BaseTools: Make brotli a submodule",
> 2020-04-16), part of edk2-stable202005, the Brotli compressor /
> decompressor source code that edk2 had flattened into BaseTools was
> replaced with a git submodule.
>=20
> This means we have to initialize edk2's own submodules before building
> BaseTools not just in "roms/Makefile.edk2", but in "roms/Makefile" (for
> the sake of the "efirom" target) and "tests/uefi-test-tools/Makefile" as
> well.

> +++ b/roms/Makefile
>  edk2-basetools:
> +	cd edk2/BaseTools && git submodule update --init --force
>  build-edk2-tools:
> +	cd $(edk2_dir)/BaseTools && git submodule update --init --force


This change can not possibly be correct.

With current qemu.git#master one is forced to have network access to
build the roms. This fails with exported (and complete) sources in an
offline environment.


Please revert this patch.


Olaf

--ZGiS0Q5IWpPtfppv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE97o7Um30LT3B+5b/86SN7mm1DoAFAl+Oqs8ACgkQ86SN7mm1
DoBeWA/9GWILDsXPx05epbmarzkrBBES4qSLQH5SEebOQ3nkEYgtFY59d2y24JfG
GG4akrzZPrKEzDaxThe4SW4eNEeiinqMLxNw9HpIkxpdCyOCfrJJr+IDLTTQuo0w
b0yBXQcQLT+v/2A2iStsn7tp4QxYPvpjJ6plOARblJQyFEAuNrv26R16mVGQ94Ti
DDrI37Bo/8uWeMYUnk0xVgcQpxvoIBVaF7NSfcFco+8DpUUwc8VrMyd9uJG7dAkv
ZOWKb2wLZaII1hQl47afF6cjjJqvDoT3Rr7DmwUKEqj+i9gVqYTN/GxUj7PXOeOM
osppXRZzlj9gwADeNTOlLMgzzMqjMvisIYlaPRKEgUBTHvDH1DlMjPLI3eDGg3tt
ascPTS1kqwHwCW0RuC7LjM30PFOcRZLoSVGKeEEULI5Qa9iobNkgA/RepP0a9pbD
AOB76EiJppFt83unNWV1HMgo8vPL2CJwXZ8inAlzzGVXNyxZwPETg1ye6YMCbsTG
PYiArIIfabUxBSn8MTb8UWWdxGjx/azbfltTd3jGraAmwRzfiQxmXvGEhN3cQNkw
wNx9zOmp/mkLR+EdjTtx3eJSIuJbaJVcOuf7/INTacL1kZwe4M7HYBJkahg5eQ2C
15/ER133wOzX5m74r0cpWG3UfI+kLl5dgf6RggpXjUgKp1dFtcY=
=iQa+
-----END PGP SIGNATURE-----

--ZGiS0Q5IWpPtfppv--

