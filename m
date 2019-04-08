Return-Path: <SRS0=gAfu=SK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ADD1C282CE
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 09:10:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33B50208E3
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 09:10:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=aepfle.de header.i=@aepfle.de header.b="RlDvAfCe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33B50208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aepfle.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49817 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDQIE-00089c-Dk
	for qemu-devel@archiver.kernel.org; Mon, 08 Apr 2019 05:10:18 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36121)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <olaf@aepfle.de>) id 1hDQHN-0007pX-Ts
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 05:09:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <olaf@aepfle.de>) id 1hDQHN-0006Yn-27
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 05:09:25 -0400
Received: from mo6-p00-ob.smtp.rzone.de ([2a01:238:20a:202:5300::6]:33412)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <olaf@aepfle.de>) id 1hDQHL-0006Vg-Le
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 05:09:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1554714559;
	s=strato-dkim-0002; d=aepfle.de;
	h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:
	X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
	bh=YlxVpLVL1PFyG04eqDrW5rH0M/RUdvVrI/npG/U/OsA=;
	b=RlDvAfCeoLcspOLrEdZx7MOoJuScmZkZvaFr+pHZ44MxJtAKYotOhmAu52KnDdxeVP
	gmd+dRI9hUcw4sYCvJ9NzFDgKbKNca4sUCdyd0ye8roc1PRWV8Dx0PQ6uV5IgAvL1y6z
	EsakxnockgPQ8TGTpzPthIv2EJQ1iQr49tacCpmr10F5dSc+V6e/68SQ0Te259RBXsAF
	Wq0onGa6IrgYvljfWbqk2mozPEmN6u6ohjzlykQ3rZ8SNmspPdpbHMc8YdhdJYhsYHyA
	eerNqZxkupKB2YItYn4ZPvFziK5MT1gbE85Lbdv8z+W9hYc403bLzNg0xeDVcV7qBb8V
	hVSg==
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QED/SSGq+wjGiUC4oc0Nr2ihluivsAEtyZCGP8Vi/UsohRLg+YvpE+1XLuUIF+9kY="
X-RZG-CLASS-ID: mo00
Received: from sender by smtp.strato.de (RZmta 44.18 AUTH)
	with ESMTPSA id 3086c5v3899Jxqx
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1
	with 521 ECDH bits, eq. 15360 bits RSA))
	(Client did not present a certificate);
	Mon, 8 Apr 2019 11:09:19 +0200 (CEST)
Date: Mon, 8 Apr 2019 11:09:10 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Laszlo Ersek <lersek@redhat.com>
Message-ID: <20190408110911.46d3b9d0.olaf@aepfle.de>
In-Reply-To: <9a4ea235-29ce-2a98-a723-0a61be55433f@redhat.com>
References: <20190405123928.70da87e2.olaf@aepfle.de>
	<1cec1873-9962-f258-a052-167efec620e9@redhat.com>
	<20190405125918.462c6ae4.olaf@aepfle.de>
	<9a4ea235-29ce-2a98-a723-0a61be55433f@redhat.com>
X-Mailer: Claws Mail 2019.03.13 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/WTSsj_EH+VdbA4pv_K6_Yh5";
	protocol="application/pgp-signature"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 2a01:238:20a:202:5300::6
Subject: Re: [Qemu-devel] edk2 fails to compile in v4.0.0-rc2
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
Cc: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>,
	qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190408090910.yCwfDLtfZZuWcgkjzZU0MMHvOp0xhq39zVZ8Smr_gg0@z>

--Sig_/WTSsj_EH+VdbA4pv_K6_Yh5
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Am Mon, 8 Apr 2019 11:04:09 +0200
schrieb Laszlo Ersek <lersek@redhat.com>:

> This is not a QEMU build failure, but an issue in the downstream
> packaging that not only tries to build QEMU, but performs a maintainer
> build on binary artifacts.

I'm sure everyone will rebuild the things from source that can be rebuilt.
Who would ship random binary blobs from unknown origin?

Olaf

--Sig_/WTSsj_EH+VdbA4pv_K6_Yh5
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQSkRyP6Rn//f03pRUBdQqD6ppg2fgUCXKsPtwAKCRBdQqD6ppg2
fiTYAJ9OX04ljC0Fic+3uuNr9LuPN+WEXgCdH8RKe5cS8hmWCwUZmbsvLyMs4vg=
=nu3x
-----END PGP SIGNATURE-----

--Sig_/WTSsj_EH+VdbA4pv_K6_Yh5--

