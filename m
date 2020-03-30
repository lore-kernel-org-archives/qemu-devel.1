Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7D01C43331
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 17:25:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F66220578
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 17:25:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HNfHbE+O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F66220578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53676 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jIyA5-0001b2-J6
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 13:25:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60550)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <programmingkidx@gmail.com>) id 1jIy8z-0008Dw-41
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 13:24:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <programmingkidx@gmail.com>) id 1jIy8x-0002Se-QY
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 13:24:12 -0400
Received: from mail-qt1-x82f.google.com ([2607:f8b0:4864:20::82f]:42500)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
 id 1jIy8x-0002SF-KR
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 13:24:11 -0400
Received: by mail-qt1-x82f.google.com with SMTP id t9so15756318qto.9
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2020 10:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:content-transfer-encoding:mime-version:subject:message-id:date
 :cc:to; bh=uL60V5wofLmL6JK+6Z3GSWdruUZ4x5g/c3jPk5EtCfI=;
 b=HNfHbE+O3ryTgw+wz1AwiKezYWYiFMDq8REQM9L9b0RiZ8AWmN9UhQbt+auoWfU1bB
 jGuEmqLCMd/b9u7Awp/7E+ODJxECvnJopKmcta16QrXdq08utdXvqAGOyPuTWk+J6/qQ
 p3nGUwneK+rfGIuySUVxfPSEuydx7cuTbnfR2fK/rr0x81efCuAz0j+t7OK2oih1qoUT
 rnjXAij9KN5vTQSHiWD1eqHf4vM3FVTq8o5YT4oGK5iUgW8EnThQaUuJT+cmXkO4Wuwg
 E2+ef09ao7B8QScAVYHGKrWdjLknHQxLEJl9h/Dm1jdOiNyVLafTEjKzfxMmYEtDqJzu
 I7EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:content-transfer-encoding:mime-version
 :subject:message-id:date:cc:to;
 bh=uL60V5wofLmL6JK+6Z3GSWdruUZ4x5g/c3jPk5EtCfI=;
 b=ic7nv6iqjHbBblMlMI8EUR8ZhmB3C8rjpJ6kra5ugUQFLGdwCQg8+IfGacDV3rgNfm
 2yFnZ3VLRR9kK7IEm36FKb4fg4vdCUPzxkob0w62ztT9ks934QA7xSnRu2PT2UcFZ2Iz
 FhYD40a34v8CEn3tYApd1GV3cBOqUzE6atAkc15v6c7UopvM/sMk9747KuAPsUi+8ljO
 YTaKPuCO9TSEYqpdC3lAHrfKxFLVF7eX9rJVorctXTtxW7K5bbXUj0HvkTKGPDs1rS3O
 S02R0TZVagpX+uBKNNv27562gwcO90T0zaEjDp3ahHDORkoHUXwwIfWJ2ED+43RnizZm
 IkYA==
X-Gm-Message-State: ANhLgQ1RDOrIseJTaVYzUiuQ4wkenCzLrbB9R7nNTDIFTxTiLqYS0Bx3
 RxWUd0VMFzz0slIaa2+PcL+cH9hh
X-Google-Smtp-Source: ADFU+vsM03cJ/5IivQS4NHSMN1X4d2HeAtzwzxrC15UFxtLVbacDAMw/sdrZwHiP+G7gbT81SkqTvw==
X-Received: by 2002:ac8:3550:: with SMTP id z16mr1035552qtb.217.1585589050398; 
 Mon, 30 Mar 2020 10:24:10 -0700 (PDT)
Received: from [192.168.0.7] (d149-67-30-58.try.wideopenwest.com.
 [67.149.58.30])
 by smtp.gmail.com with ESMTPSA id h47sm11985818qtb.75.2020.03.30.10.24.09
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 30 Mar 2020 10:24:09 -0700 (PDT)
From: Programmingkid <programmingkidx@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Sound support for Mac OS guests
Message-Id: <17987AFB-512F-4EAC-851D-A346DD859029@gmail.com>
Date: Mon, 30 Mar 2020 13:24:08 -0400
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
X-Mailer: Apple Mail (2.3273)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::82f
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Mark,=20

I was just wondering what it is going to take to have Mac OS sound =
support in qemu-system-ppc? I have made four versions of my Screamer =
sound chip patch and you ignored each one. Did you plan on committing =
your version of Screamer?=20=

