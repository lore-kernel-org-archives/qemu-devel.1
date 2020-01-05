Return-Path: <SRS0=Lm/k=22=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFD6CC32767
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jan 2020 01:59:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1A4020866
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jan 2020 01:59:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B3ru6CRd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1A4020866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38386 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1invCE-0006GD-Qa
	for qemu-devel@archiver.kernel.org; Sat, 04 Jan 2020 20:59:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47579)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <programmingkidx@gmail.com>) id 1invBJ-0005Xy-6k
 for qemu-devel@nongnu.org; Sat, 04 Jan 2020 20:58:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <programmingkidx@gmail.com>) id 1invBI-0005Qn-4T
 for qemu-devel@nongnu.org; Sat, 04 Jan 2020 20:58:17 -0500
Received: from mail-yb1-xb44.google.com ([2607:f8b0:4864:20::b44]:44255)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
 id 1invBH-0005OX-UJ
 for qemu-devel@nongnu.org; Sat, 04 Jan 2020 20:58:16 -0500
Received: by mail-yb1-xb44.google.com with SMTP id f136so17403249ybg.11
 for <qemu-devel@nongnu.org>; Sat, 04 Jan 2020 17:58:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:content-transfer-encoding:mime-version:subject:message-id:date
 :cc:to; bh=ZDAO1zv9Bbp9cjrM5wNYhwpTXFyw3uLoMgBYt0qKqXU=;
 b=B3ru6CRdttTLst5VBiEiCxal+FGnkuehDnlfkOozmgggy8gMi3WDFSkwqJw2TpntH/
 SQ+C5lLNkTPJtRm/amnLDdRJJIpZFI3ZsYJFTuJ9UUKCt7SHRWu1ASwE2Ni09Npjodg4
 zx/9gHq/VNMom8A6OHjhzZULKnPlDHdx02bg3th0vtk2l+G2sd1mAhE1V77IhDDDzJBw
 0JcqYlaD1Mae0OsbTj2OAPm0BaThlZpVuzpKWWObkRG0dEYBqLb5MQr7E0ewA4WrEcMo
 vi16Dg46httmB6ZTSufwDO4Afbw0XUmIG3EPTb73xdnR9qck8kL6zr0I0BsGQDDACdgm
 T4Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:content-transfer-encoding:mime-version
 :subject:message-id:date:cc:to;
 bh=ZDAO1zv9Bbp9cjrM5wNYhwpTXFyw3uLoMgBYt0qKqXU=;
 b=B9FwTotkevgiv3L1iflQR5hi4Z9011BA2IYEuysG7Q1/sAf46PiOdu91A6S6L1NKMQ
 XdkcceJHSvZ5fxgeEYV424r+xa5GKavYDodYFI4DS6STvJiI+52jIXQZcY10tTmi5MLK
 Lxhesr5/QEWfF8NGbpgdMwG9jroxn+mkyZq+3hoG7bm3SzkhDmMP/ie8hLQyKgVBcnxM
 FZFuEINEv6836iNHrAH+Y977nyBqtnGqM5ua/G6+gWFnsOxsuC6oFk8sfFIPXHDMan19
 YW0Vmrk8j2vlIn30I79icxzwP8d9weAq+5StOH6vm9XxL/ZCFzVr5VUqKDWl1uDP/I+u
 6+Jg==
X-Gm-Message-State: APjAAAV012dSb/NgrxcJB+WiRx2gUjzzWYMPo5Ceb4oOs3NMBOYKjWJd
 FYvwcS+eVC698pyt0iI0nSa399M/
X-Google-Smtp-Source: APXvYqyqUrTmO/211vqZhPfsAt+lDEqNBM30N20lPUpXQKuqYc5XE239uoAQ3a79aDajPvst/vnhWQ==
X-Received: by 2002:a25:d493:: with SMTP id
 m141mr59510952ybf.201.1578189494697; 
 Sat, 04 Jan 2020 17:58:14 -0800 (PST)
Received: from [192.168.0.2] (d14-69-20-184.try.wideopenwest.com.
 [69.14.184.20])
 by smtp.gmail.com with ESMTPSA id e76sm26016641ywe.25.2020.01.04.17.58.13
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 04 Jan 2020 17:58:14 -0800 (PST)
From: Programmingkid <programmingkidx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v2] Implement the Screamer sound chip for the mac99
 machine type
Message-Id: <43D423C6-78D4-4DCE-B97C-0658D3D2E3BD@gmail.com>
Date: Sat, 4 Jan 2020 20:58:11 -0500
To: qemu Developers <qemu-devel@nongnu.org>,
 Howard Spoelstra <hsp.cat7@gmail.com>,
 =?utf-8?Q?Zolt=C3=A1n?= <dirty.ice.hu@gmail.com>,
 mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
X-Mailer: Apple Mail (2.3273)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b44
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
Cc: Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I found the patch that breaks Screamer sound support for =
qemu-system-ppc. It is this:

commit 2ceb8240fa4e4e30fb853565eb2bed3032d74f62
Author: K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n <dirty.ice.hu@gmail.com>
Date:   Thu Sep 19 23:24:11 2019 +0200

    coreaudio: port to the new audio backend api
   =20
    Signed-off-by: K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n =
<DirtY.iCE.hu@gmail.com>
    Message-id: =
586a1e66de5cbc6c5234f9ae556d24befb6afada.1568927990.git.DirtY.iCE.hu@gmail=
.com
    Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>


Reversing this patch should make the Screamer patch work with the =
current git version of QEMU.=

