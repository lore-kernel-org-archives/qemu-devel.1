Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F698C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 01:47:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66BE420730
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 01:47:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qsRJz2vp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66BE420730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXbZP-0004WB-GI
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 20:47:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39171)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1iXbYI-0003zY-NG
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 20:46:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1iXbYH-0001Xx-4q
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 20:46:34 -0500
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131]:35526)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1iXbYG-0001XL-HU
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 20:46:32 -0500
Received: by mail-lf1-x131.google.com with SMTP id q28so1206633lfp.2
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2019 17:46:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to
 :content-transfer-encoding;
 bh=X5UbttyEYhiUdogbNrrDLOVIpqgGvJg1FfFLn9ir/sA=;
 b=qsRJz2vpYpARM0cAwpWSA8w64hHmt5dlUsK4Jy5onJHFpURshwvuyMxNSMptCUvsAG
 O2Mr1yuP3MyrFkTDDt/28ucWYJaX8vObmX0BMPvjlgVEGlVyCLgyTvF4JMdFj4wR8mBd
 h9HSURR6sKmE+LsfLv+emmgqSPlKM9Z6QhfVlfyRx/6Defa6DX/maLdrpFQQm8aFrm7P
 GdmilAZT8GoG27AxojIX6Mqz4F234NvNeQ1EidkRhfEyZNeBig6uNGvf+jT4rZwy4pPa
 5wf4nPh5RH/BprpUplAN//KUL1a+/c7cKSeJi1PMA411qzvBY0ENrNUvDKPVWLGhzX4T
 PZeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to
 :content-transfer-encoding;
 bh=X5UbttyEYhiUdogbNrrDLOVIpqgGvJg1FfFLn9ir/sA=;
 b=HEku+6owucW49mxDsXIkv33y6U140BdgVZnCoB9zWV6RR1eKCygxzO7d7cuqDuhhFT
 TBcI1SNN5sHUumFgbzOHMPJNPiMhcEEJhK6sZUL2icTE+HiY8yHXZPDYMBrLts9NMLbA
 pJPhmIfg3Y26EoVmbElasHCRpvspRzswylSRZX/nAL19LYPdJQ8LVIoClbt759Bk/qr3
 I5rI5LTcjKZNV7oNCzk/z9lP7u3hsArNUI439qoupfXxJhZ2C7L+PopCUVLc3out/tOx
 S9Rt1KUQqvIzjzTt32IdZ40fM62MetizoYTFq7fCTcz+UrcHZ1eUBRCYz9VJrxnFxPPT
 eSaQ==
X-Gm-Message-State: APjAAAX7ZP96Ja0BWk+tL53G0Gtdb8qscS3va70G62JTbS9BjuZosGNY
 67mJrTv7BBDZAzC/J7wfpVAMnmNwfW5skYLXCgfODm7CZEQ=
X-Google-Smtp-Source: APXvYqwBhPG1oOW0FU4muboVHivGc7YWof8TM3wmuAJ5FDACfBw4sCDT7dxq/3fKZjn5Xm8a9pn8n4smG3JZsjIcaoQ=
X-Received: by 2002:ac2:5210:: with SMTP id a16mr5391879lfl.156.1574300790020; 
 Wed, 20 Nov 2019 17:46:30 -0800 (PST)
MIME-Version: 1.0
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 20 Nov 2019 17:40:41 -0800
Message-ID: <CAKmqyKNvRuyyEr5aqW5ZdF+VFJJow6pE7Uy0Mb54yiCYTO3zLA@mail.gmail.com>
Subject: Open ISA (RISC-V, OpenPOWER, etc) Miniconf at LCA 2020
To: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 David Gibson <david@gibson.dropbear.id.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::131
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

Hi All,

We=E2=80=99re pleased to announce the first Open ISA miniconf at linux.conf=
.au

Open Instruction Set Architectures like RISC-V, OpenPOWER and others are
the next step in the evolution of Open Hardware.  The mini-conference
will commence with a brief overview of Open ISAs in general.

It will then introduce the two most common open ISAs, RISC-V and
OpenPOWER. This will include an overview of the ISAs, how they are
supported and why people should use them. Finally we will delve straight
into a set of curated presentations from across the Open ISA ecosystem.

The miniconf organisers, Alistair Francis and Hugh Blemings along with
the LCA 2020 team invite proposals for sessions in the Open ISA miniconf
of either 15 or 30 minutes duration.  Suggested topics include Linux
kernel support for open ISAs, RISC-V, Open POWER and any other Open ISA
related topics.  As befits LCA, sessions should have a strong technical
emphasis rather than marketing/sales focus.

Places are limited in the miniconf schedule and early submission of your
proposal will assist our planning.  The Call for Sessions formally
closes on December 8th.

For attendees - the miniconf promises a great deal of technical depth
and breadth across this relatively new aspect of the open technical
commons, we look forward to seeing you!

As an extra plus it's on the beautiful Gold Coast in the middle of Summer :=
)

Registration and details are available at:
https://linux.conf.au/programme/miniconfs/open-isa/

And don't forget there's a bunch of other awesome miniconfs scheduled
for LCA 2020 - the complete list is available here -
https://linux.conf.au/programme/miniconfs/

We look forward to seeing you!

Regards,
Hugh Blemings & Alistair Francis

