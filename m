Return-Path: <SRS0=PAXx=ST=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B56A2C282DA
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 17:31:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EB03217F4
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 17:31:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tKHrPFZp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EB03217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57137 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGoOj-0000Mk-Gs
	for qemu-devel@archiver.kernel.org; Wed, 17 Apr 2019 13:31:01 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36059)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1hGoNr-0008Jn-0T
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 13:30:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1hGoNp-0005L5-Vs
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 13:30:06 -0400
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235]:42110)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <flukshun@gmail.com>) id 1hGoNp-0005KQ-M1
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 13:30:05 -0400
Received: by mail-oi1-x235.google.com with SMTP id w139so20662190oie.9
	for <qemu-devel@nongnu.org>; Wed, 17 Apr 2019 10:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=sender:mime-version:content-transfer-encoding:from:cc:user-agent:to
	:message-id:subject:date;
	bh=+EocjdX02VNcXi60FFYcsuH1DOhZgiOUPi2JYp7BBWI=;
	b=tKHrPFZpSqdju7DIiXjjIyBrE4DSLMVDC6kmIOHp9bAWe3zL8inM8AadEEB22Thmxf
	J+sKV0MsNR5MxJvM/y6fwg2yQi4xmSxXVOJY3loTPQS1WVqIae+9V+nuub6Zbe+gKBn5
	+fG7Q1KPbIv+s58d78qfo7Kp4HwhTGnoCsZnGhYY/azfODhLM9uiahZrlKmNiF3vkiRa
	HTZ9dbAiMoCzz9OjiePW0NLz77ZaTF7OkEdJ2iv7OwxiXZxsch2QFTSjl2w0OuXI3rgJ
	sPLXnf8DeAlwjRogY+kjxp+TpY4LdiPjQ83JDvzLhMi4zEOH9FpFEs7z0q5d0EwcjpVL
	nXzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:sender:mime-version:content-transfer-encoding
	:from:cc:user-agent:to:message-id:subject:date;
	bh=+EocjdX02VNcXi60FFYcsuH1DOhZgiOUPi2JYp7BBWI=;
	b=Fb0XhQFLFpJy2NIvgJRD4mWntMKnCIAb2y7/KkJrdF374iB5JgfMoFM51ySXXpi+lH
	KrkyYoHt+LwYPuKI6bLRL4v/TcM0UI7tNZLNwuYoqjbpdwlgu9dOGsuvkbBe+0okKqpk
	PmRFBJXgnpxID70bcDZdFP1y7pxYdl2k2ZGeXSuhRQcLMky05cOzzz7L0O1xdga52Arp
	U2jUptWFyT1AZE4ZB9Ez+oCkxc+FOxDwy+ghgZOsBYxSgGG4P0L9zhpoJHU0QdandnUQ
	UgUaOurIrc4NFoe1Q2QmR4NYMmWIC5fzfj139irKAkYNbP4nth9vPNRAY5AvkGJVBfZO
	maSA==
X-Gm-Message-State: APjAAAUA7hrJowO3EDhKEOBCoCb8vf4GN1HyycSamuVecVuP+VnfgdpX
	Q5/v5Yh+vJrPinsJOPPX9MQ=
X-Google-Smtp-Source: APXvYqxLVnS2tK6/kh2tanop8xX0fAXO6HddFtoOaT2aXGUKPFHtZnA1OPO7qObWRZrpGkilmvLNuQ==
X-Received: by 2002:aca:d608:: with SMTP id n8mr19675oig.35.1555522203820;
	Wed, 17 Apr 2019 10:30:03 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
	[76.251.165.188]) by smtp.gmail.com with ESMTPSA id
	s63sm20276120oif.52.2019.04.17.10.30.02
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 17 Apr 2019 10:30:02 -0700 (PDT)
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
User-Agent: alot/0.7
To: qemu-devel@nongnu.org
Message-ID: <155552219818.15309.1691620619742559575@sif>
Date: Wed, 17 Apr 2019 12:29:58 -0500
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::235
Subject: [Qemu-devel] [ANNOUNCE] QEMU 4.0.0-rc4 is now available
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190417172958.v7Vb7rrqaDLdKGN0EpwH4EGZmcNwW_xmilHCE6oH9aA@z>

Hello,

On behalf of the QEMU Team, I'd like to announce the availability of the
fifth release candidate for the QEMU 4.0 release.  This release is meant
for testing purposes and should not be used in a production environment.

  http://download.qemu-project.org/qemu-4.0.0-rc4.tar.xz
  http://download.qemu-project.org/qemu-4.0.0-rc4.tar.xz.sig

A note from the maintainer:

  rc4 has a small set of bugfixes for a few late-breaking
  release blockers; the final release is planned for
  Tuesday 23rd.

You can help improve the quality of the QEMU 4.0 release by testing this
release and reporting bugs on Launchpad:

  https://bugs.launchpad.net/qemu/

The release plan, as well a documented known issues for release
candidates, are available at:

  http://wiki.qemu.org/Planning/4.0

Please add entries to the ChangeLog for the 4.0 release below:

  http://wiki.qemu.org/ChangeLog/4.0

Thank you to everyone involved!

Changes since rc3:

eeba63fc7f: Update version for v4.0.0-rc4 release (Peter Maydell)
375cb86d9f: usb-mtp: fix bounds check for guest provided filename (Daniel P=
. Berrang=C3=A9)
93e32b3e20: qcow2: Fix preallocation bdrv_pwrite to wrong file (Kevin Wolf)
a9b305ba29: socket: allow wait=3Dfalse for client socket (Marc-Andr=C3=A9 L=
ureau)
6fabae61a9: slirp: Gcc 9 -O3 fix (Dr. David Alan Gilbert)
9749636b00: iotest: Fix 241 to run in generic directory (Eric Blake)
23e1d05411: iotests: Let 245 pass on tmpfs (Max Reitz)
13c24edaa7: qemu-img: fix .hx and .texi disparity (John Snow)
e1be98540e: curses: fix wchar_t printf warning (Gerd Hoffmann)
4560116e42: spapr_pci: Fix broken naming of PCI bus (Greg Kurz)

