Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A6E8C04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 06:42:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6D0E2085A
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 06:42:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iU4bG9jR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6D0E2085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37809 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOzEs-0002Eb-4W
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 02:42:38 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44598)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hqm03ster@gmail.com>) id 1hOzE7-0001hv-Ns
	for qemu-devel@nongnu.org; Fri, 10 May 2019 02:41:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hqm03ster@gmail.com>) id 1hOzE6-0000IH-KJ
	for qemu-devel@nongnu.org; Fri, 10 May 2019 02:41:51 -0400
Received: from mail-qt1-x842.google.com ([2607:f8b0:4864:20::842]:39379)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <hqm03ster@gmail.com>) id 1hOzE6-0000Ht-G4
	for qemu-devel@nongnu.org; Fri, 10 May 2019 02:41:50 -0400
Received: by mail-qt1-x842.google.com with SMTP id y42so5391247qtk.6
	for <qemu-devel@nongnu.org>; Thu, 09 May 2019 23:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=I8DVTPiEajXY09+yUGkYAl0QbaDnG9OnuYAgYLszVH4=;
	b=iU4bG9jRVF/GFXFnqkxrqq7M+byBQh8opcK+1MVDaYZ7N1DktVOPoIt3Ru7IBNjk72
	fnArNMs9QtypG5WqDzrFMd7wB6GGTCw/1OzjdjWW0XnMyYp2EbPrTVC2aSJkyoQppPTQ
	84+m/PCVglSe9betoAogd/T7KNqdp8EhiUWvCylBeWJy9DgvPhLobGHjiGcnbvFKCxSd
	8gI1n4KR1XKTnYF3k5wRRTQt5G7ig3LfEI4YE1wXp+3bjJBUVoqrnWPzb0lZbCsSOU9B
	bo7rknXptgbxHrN4v3g3pJwpk419Np4g0HlxGHF3rjtI0ze8RtYkCV2tyJoAxOt+a1ST
	zsGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=I8DVTPiEajXY09+yUGkYAl0QbaDnG9OnuYAgYLszVH4=;
	b=r19qqQztEAKbJFb0V8CUtKZ7E/N7J7325uJFE1ojeJV8An1oQhTlB313zc+exdAlCb
	s7nTeqA4LiO+AAEwBUtelL1Zd89u2fX0ZoyS6UzyGX/SgRKKimTKZvwuEAURqaS1jOk2
	n0tRwlsO0LDrlG7g2LRmSWqsu2N+oXYrevrcgehszDgd7bJdH+kZO3IfWPUPZWw0eP5k
	ovx4491l/FXdYk+O6z5JmkFWjE1YZCo6SeNCEaCFMQxFNGZ1AlXAj4kjiaArEXSCYBP8
	Z6gb7DHeVuovywj6PuzUCSHCMZiInQMbzaNsEdIdbs+2sT0nrLs+0P6BQ+fzP66FPvIA
	RaXQ==
X-Gm-Message-State: APjAAAUSIUPoUwrLEOtYXILG/I7R6wSEBsBRVONUhIc8ALPTp1XQs4q/
	SbIWjDZve0jrTUFnRpOXLprrb7kOt9+/kUp3oCs=
X-Google-Smtp-Source: APXvYqzRRG7QiUV+7JyzMGizT/+xMwPgF9sXPcH08gPbjfCNM+v+KC6xgTN784IEoDDaZVYIlNEAGI0FtS4T/Kkk0mU=
X-Received: by 2002:aed:224d:: with SMTP id o13mr7786915qtc.56.1557470509747; 
	Thu, 09 May 2019 23:41:49 -0700 (PDT)
MIME-Version: 1.0
References: <CABSdmrnNW6f=P64PviPP8CTJ5SVfYS8_6kmAtpw9yPObTEkpxg@mail.gmail.com>
	<CABSdmrnocrqLKWncgy_Lak33__GRPYfs-RzSA14e=vh4cRn2ag@mail.gmail.com>
	<20190509064848.wjhchsfov7q6komj@sirius.home.kraxel.org>
	<CABSdmrmm+wJ=+Ccav=X5Gw_oueQvPRejCWVG2SQeCw=K4BM9EA@mail.gmail.com>
	<CABSdmrn073Y6UTbbgs00y5-DCdF1ROK9zAg5JURD4SoUZAk2Mw@mail.gmail.com>
	<20190510050139.jpxrghxzahejpteu@sirius.home.kraxel.org>
In-Reply-To: <20190510050139.jpxrghxzahejpteu@sirius.home.kraxel.org>
From: Hou Qiming <hqm03ster@gmail.com>
Date: Fri, 10 May 2019 14:41:36 +0800
Message-ID: <CABSdmrmU7FK90Bupq_ySowcc9Uk=8nQxNLHgzvDsNYdp_QLogA@mail.gmail.com>
To: Gerd Hoffmann <kraxel@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::842
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH 2/3] ramfb enhancement
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> Only allow one resolution change per guest boot, which prevents a

> > crash when the guest writes garbage to the configuration space (e.g.
> > when rebooting).
>
> Hmm?  Did you see that happen in practice?
> It is not easy to write to fw_cfg by accident ...
>
>
Yes, this does happen in practice. It's observed in KVMGT setups by another
github user and me, when the guest Intel driver loads or when the guest
reboots. Link:
https://github.com/intel/gvt-linux/issues/23#issuecomment-483651476

Now that you mentioned it, I start to feel that it's not accidental. A
closer look at the "garbage" in that post shows that the overwriting
content are valid resolution values in the wrong endian. It could be a
misguided attempt to "resize ramfb" by the guest Intel driver.

-----

I'll fix the addr / length thing and remove the test part in vfio-pci in V2.

Qiming
