Return-Path: <SRS0=sqIQ=4K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69AADC35669
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Feb 2020 02:53:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 330C0206E2
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Feb 2020 02:53:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gzHGgwNv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 330C0206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j5KvO-0003lK-Ac
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 21:53:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48256)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bmeng.cn@gmail.com>) id 1j5Kui-0003A1-Fn
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 21:53:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1j5Kuh-0002Le-J1
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 21:53:08 -0500
Received: from mail-yw1-xc41.google.com ([2607:f8b0:4864:20::c41]:36603)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1j5Kuh-0002LQ-D8; Fri, 21 Feb 2020 21:53:07 -0500
Received: by mail-yw1-xc41.google.com with SMTP id n184so2305204ywc.3;
 Fri, 21 Feb 2020 18:53:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=4dG8h8k4fdojn5DEA0WC0ZTpoWYItaC0wu6qjxJwy9E=;
 b=gzHGgwNvvI9rqmJ21ELUe5hP4+LokAj+sxV0PYl97YYnbJRpZAxIQ8/lTgiMQKJd7L
 8FFhcsJqBl9/buxellF4O+F3URlctU6WvTajqnd2PvOiA8M76a7p4g+lVDKiXH4WLpx/
 o7VWF+1rBJVkmFAvvoiNNlCDaWq0q7o/Tte+aZjYVQzCPIDL/DRuE8iK1Vel7jNFnsw8
 71RxL0CLZE4jkErjUum2HQ0bHAdiIM80uJxhYTLc2bzRyjfZkpA/wfQVBOMiyL5XHuNo
 fD9x5RgYL0cshurTWlwe8kkqBaA2W+Yad+Vc+mSs2tDpyQS7a2ofVzLPVyoWht1sOPzD
 zqXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=4dG8h8k4fdojn5DEA0WC0ZTpoWYItaC0wu6qjxJwy9E=;
 b=Qixh0hnQlSzqj8+0rQywz2LkIe4caeJuZWTKkARxLotH4gLmCb14RylXqYyvaw9AVq
 YjLDrIQDeXFxvnxiit9qAxHMybn8oayjIL8e+yKlTPeUhJVC4yt6jrOnGxv7WCmq20Dp
 eQidaHmkbSrU/y/9RJ9Ryp1OQTxTEAJvQfTUK2Ry+vvqOzxIhYeyx0g0iZ+VrAAd/yDH
 CPOGXq0830uLCdua+8v7OrHuPfd1It+tfhFLOkSrw7mnx+GyxsRTIrIfCgoNHoPfMSdS
 CxZ8pXcXR4GQNPrsbC38vi4TuAddvkBUKvE0qcMBCiCESIy54755+KfkN777wUUrgJWN
 6VYQ==
X-Gm-Message-State: APjAAAUb2o+Xm1OtwkRxfU8y+kcTZGatXYKNwAOSmmEXHlDZgP2HQRn6
 oytlc1mRnSCual12ki52gntX6dZQrFlxOlJDkT4=
X-Google-Smtp-Source: APXvYqwmGwN7efrv4Wz96xIYWhaq8t2s5xNYrFxlZ4Js1PRXZcBIyk5GpsmM0i/qYAlZMHPl/WJsH46jJ90W4j/nQu0=
X-Received: by 2002:a25:d348:: with SMTP id e69mr37606116ybf.203.1582339986397; 
 Fri, 21 Feb 2020 18:53:06 -0800 (PST)
MIME-Version: 1.0
References: <1582209758-2996-1-git-send-email-bmeng.cn@gmail.com>
 <1582209758-2996-2-git-send-email-bmeng.cn@gmail.com>
 <CAKmqyKOHyix_J-T=sFdwX=jTnxG8TO0r6i6edFixVdMZjZy7yQ@mail.gmail.com>
In-Reply-To: <CAKmqyKOHyix_J-T=sFdwX=jTnxG8TO0r6i6edFixVdMZjZy7yQ@mail.gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Sat, 22 Feb 2020 10:52:56 +0800
Message-ID: <CAEUhbmUJ9gvX0paRF8o5PY_DWvT=16sVmrrnota+PqqEJHV2dg@mail.gmail.com>
Subject: Re: [PATCH 2/2] riscv: sifive_u: Update BIOS_FILENAME for 32-bit
To: Alistair Francis <alistair23@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c41
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmerdabbelt@google.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Feb 22, 2020 at 3:51 AM Alistair Francis <alistair23@gmail.com> wrote:
>
> On Thu, Feb 20, 2020 at 6:43 AM Bin Meng <bmeng.cn@gmail.com> wrote:
> >
> > Update BIOS_FILENAME to consider 32-bit bios image file name.
> >
> > Tested booting Linux v5.5 32-bit image (built from rv32_defconfig
> > plus CONFIG_SOC_SIFIVE) with the default 32-bit bios image.
>
> Do we really want to support a 32-bit sifive_u machine?
>

QEMU is an emulator, why not? With 32-bit sifive_u machine, we can
have 32-bit test coverage for SiFive specific drivers that cannot be
done with the 'virt' machine.

Regards,
Bin

