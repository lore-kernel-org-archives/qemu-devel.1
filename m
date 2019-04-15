Return-Path: <SRS0=VGOL=SR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30068C282CE
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 09:54:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E43252070D
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 09:54:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V51EKFrk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E43252070D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47468 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hFyKG-0003un-66
	for qemu-devel@archiver.kernel.org; Mon, 15 Apr 2019 05:54:56 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59579)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hFyJQ-0003a4-42
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 05:54:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hFyJP-0005uC-7p
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 05:54:04 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:33316)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1hFyJO-0005tj-VG
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 05:54:03 -0400
Received: by mail-wr1-x436.google.com with SMTP id q1so21106303wrp.0
	for <qemu-devel@nongnu.org>; Mon, 15 Apr 2019 02:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=IoDrJ1YNFEzfxURP885irVULx9NqTXOpvdmPDDHT0oI=;
	b=V51EKFrkQDDZWVdDx5DZb7e0YOubv3TFAXVdHnBM8G+rF3jLzzfpXP+1/qMVG0yLdL
	Nn8BSjRQasjZVWD7waUPi2K0w6vdo8bYXI/aqEQAe8IKjslzL0dQBTUCkc90DdgopRE2
	hPGXJBICY7y19rMVljIXvMSczmRvPZkCi+3TS4AiwpT1l1pTBMlHmVsAGxKvbAXxnHN5
	i4dEs5g5MgKt2oU6gRI4cNkxlx1H58vy/CoLp/I47BsfcLqUdNK80ZbH1TfSPyEEPUIw
	Fh3z45oKzlICpiWZIpj/5/vWwWfvhVhmKCyCBAbZjH1yUIVVqQz7n2TKZUEljm2eig9T
	LsVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=IoDrJ1YNFEzfxURP885irVULx9NqTXOpvdmPDDHT0oI=;
	b=jO/8t2TbaQGAwXnG6pLGnJwAsVLmwlnfqubjGHCpH03ISLxAx9pdNnJNSu6CxFd9kv
	kNPvU/uUrCn5ui+8tztBsAmyEkCl1X0wKPlTDe+3/Nnd0ol/NhGejVKtEeCoPQHJzbiP
	6KNp6U/UU5Bubbw64m5HETGMXiIqS+JflRFThpbeI/QpNc8DXwmIuNfy/XfN6j+pWCNu
	oxsZnzVlEu3HH+QEoLJ8kknmVcHulRn+LSVc84nRx5t5yJnkYJ4IHMMVWagXNms0DOve
	gkALCObRfurljC2EUj99T/98oVksOZyjLlEGGiImGRQ249yGEvmMBnnBp/cisAR+g3ei
	v+sw==
X-Gm-Message-State: APjAAAU8fwF9fb0+YdxTsiYlHahTV75uO7elbiuSe0TxlpCMAlcV70cX
	BwGdxi8gdPw7oRI5B1WuAkw=
X-Google-Smtp-Source: APXvYqyQQD9IFqgmNcIYRTWZcOAfRyDDsfZwZBXyUONt5QDbUmCC2VLywnKA1wFSbZomE5JoA9Lvrg==
X-Received: by 2002:adf:b458:: with SMTP id v24mr46338400wrd.46.1555322041918; 
	Mon, 15 Apr 2019 02:54:01 -0700 (PDT)
Received: from localhost ([51.15.41.238]) by smtp.gmail.com with ESMTPSA id
	r16sm36778562wrx.37.2019.04.15.02.54.01
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Mon, 15 Apr 2019 02:54:01 -0700 (PDT)
Date: Mon, 15 Apr 2019 10:54:00 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Programmingkid <programmingkidx@gmail.com>
Message-ID: <20190415095400.GD29134@stefanha-x1.localdomain>
References: <839EC771-5973-4B05-BC76-D6CC5EE63A43@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cHMo6Wbp1wrKhbfi"
Content-Disposition: inline
In-Reply-To: <839EC771-5973-4B05-BC76-D6CC5EE63A43@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::436
Subject: Re: [Qemu-devel] Booting from a Bootcamp partition
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
Cc: John Snow <jsnow@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190415095400.FoRoZNACKp_yoWk0RGVuTeJkqAQh9Pj5Y1-iN7sSfmY@z>


--cHMo6Wbp1wrKhbfi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 14, 2019 at 07:33:17PM -0400, Programmingkid wrote:
> Hi I was wondering if anyone has been able to boot from a bootcamp partit=
ion inside of QEMU. I know this partition can be used in QEMU but my own at=
tempts at booting Windows 7 on my bootcamp partition did not work. I always=
 see "A disk read error occurred". Has anyone else been successful at this?=
=20

Hi,
It's difficult to help without more information:
1. What is your QEMU command-line?
2. What is the partition table on the disk?

General problems with booting Windows are usually caused by a guest
configuration that doesn't match the hardware configuration that Windows
was installed under.  Can you check that the AHCI bus address of the
disk and partition numbering matches what Windows expected?

It may also be useful to enable tracing (see docs/devel/tracing.txt) to
see what the ahci_* trace event log says.  I have CCed John Snow, one of
the few people who can read this log :).

Stefan

--cHMo6Wbp1wrKhbfi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJctFS4AAoJEJykq7OBq3PIukYIAIS4icUascjT/GGtZCcQ1Xtb
YWpRKWxfq7dDcRIGeRN+kIiBim+BcV36LaEb0QfDg82KzvNI55GFy/PhfZrrf5RA
7eoIJmwqghGYOWJZaWN3dOQtnKKhy6RDNiLIhwead7Kt10XSHP5vUQm6nFKhiemt
BYbw93Oe3bLmgBNBEmykgooEr8WZinJ/iL+/lZbjdP86CuvSWEipJjzcBXoghXgR
5A5IfpYlJplM3kH/KzLGdiicw1oMyqW1Sd4/raigQKIEEPLytHpub/P2HF4ABHH4
MAb96GaYZsui/bxBF76dgmbdXHHNgwIqimwaNI/lsC6qyty5l1wGWwojh+7PPjc=
=R1Fm
-----END PGP SIGNATURE-----

--cHMo6Wbp1wrKhbfi--

