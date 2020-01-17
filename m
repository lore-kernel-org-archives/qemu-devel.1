Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D68C8C33CB1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 10:29:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1CF72083E
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 10:29:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dme-org.20150623.gappssmtp.com header.i=@dme-org.20150623.gappssmtp.com header.b="BzMrtSKK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1CF72083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dme.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54972 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isOsY-0003Qb-Oi
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 05:29:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55668)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dme@dme.org>) id 1isOrX-0002HY-Ky
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 05:28:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dme@dme.org>) id 1isOrW-00089b-II
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 05:28:23 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:34340)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dme@dme.org>) id 1isOrW-000889-42
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 05:28:22 -0500
Received: by mail-wr1-x436.google.com with SMTP id t2so22172170wrr.1
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2020 02:28:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dme-org.20150623.gappssmtp.com; s=20150623;
 h=to:subject:in-reply-to:references:from:date:message-id:mime-version;
 bh=U7KmxzvVqdcER3V8vwzwrSZAgdisHy/4SoLCFnAuZrE=;
 b=BzMrtSKKvU7Afb7yYHtT+Ik2ig06C/wdHM2xf2GRxLF7uLOEjNu7RHTVLTSgMaQ7+c
 xZbwzORVRFqVgdRizakphETPTkruqsutzFSLKPMK7rTMvyQtI9v9PRAP7Uu7xN3HyECe
 2iwLPY40kWyN1UDAF2QRk0weAHIslP34DFrUt7WC7XVCyxaew31xqehRNWuiNP0MGfHm
 oj5yebgbH+qjvyHK81wCkXWMnDTRcw4chglZpf7bZM0khmF67ZgJDymlT411f7k+EslB
 IGnvoIc5USLCFGcKoK5W7snQugan0U05kXJX9eIw5kzsyMvh4qfTQaucx2hmK8A1j+yY
 Qiyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:subject:in-reply-to:references:from:date
 :message-id:mime-version;
 bh=U7KmxzvVqdcER3V8vwzwrSZAgdisHy/4SoLCFnAuZrE=;
 b=gbzzAVvCBJkpawq32E5ouy6pjZbsGok/931otRiKNz2ZQcDLC2dg4jx54eqzJYj9Df
 AjZ5+9wEKAiegRGa/mxOvNlmtCYfnl8jZFW7931D2actDsVo62B8lgOl9uPT0gl+FRS4
 GwBngAPl/Yln+kbd7QmSL/ZsG+7S6XMmb+2wU/Rn02hJS662+oV7vdX/DvT4BFBHAwzJ
 MtA3X8R1PHoWy2vCobGHJbdKcfSrSWUwo+2V9NzXkKodNiw6OhSb+Iy8yWYt62hHlpWU
 vjcWjf7qEL6wucrypoAcfblK/DEG7Ea390PGAhEz66XQTWJbcl4HPUEEnHEb/W4MAJZD
 QExA==
X-Gm-Message-State: APjAAAUikEc1/niosBkaRLu6WHsVGlTrcJFC+nZhmaepUALFEP6SIWx1
 9nwcBGqzACRpsvd8NewZZDx6Pw==
X-Google-Smtp-Source: APXvYqwyMtROBmjdflraqrjX8lpoww1Si017EEpVc6zvXicB9pXromcxwur9GJ/y4ZARcYN1PvZ/6g==
X-Received: by 2002:adf:fe0e:: with SMTP id n14mr2422915wrr.116.1579256900344; 
 Fri, 17 Jan 2020 02:28:20 -0800 (PST)
Received: from disaster-area.hh.sledj.net (disaster-area.hh.sledj.net.
 [81.149.164.25])
 by smtp.gmail.com with ESMTPSA id b10sm34206790wrt.90.2020.01.17.02.28.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2020 02:28:19 -0800 (PST)
Received: from localhost (disaster-area.hh.sledj.net [local])
 by disaster-area.hh.sledj.net (OpenSMTPD) with ESMTPA id 32e39b41;
 Fri, 17 Jan 2020 10:28:18 +0000 (UTC)
To: Max Reitz <mreitz@redhat.com>, "Richard W.M. Jones" <rjones@redhat.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org, mlevitsk@redhat.com,
 sgarzare@redhat.com
Subject: Re: Bug? qemu-img convert to preallocated image makes it sparse
In-Reply-To: <7586b832-ecd2-e766-6781-3a25f382c9ed@redhat.com>
References: <20200116141352.GA32053@redhat.com>
 <7586b832-ecd2-e766-6781-3a25f382c9ed@redhat.com>
X-HGTTG: heart-of-gold
From: David Edmondson <dme@dme.org>
Date: Fri, 17 Jan 2020 10:28:18 +0000
Message-ID: <m21rryz8al.fsf@dme.org>
MIME-Version: 1.0
Content-Type: text/plain
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::436
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

On Thursday, 2020-01-16 at 15:37:22 +01, Max Reitz wrote:

> So I suppose the best idea I can come up with is indeed a
> --target-is-zero flag for qemu-img convert -n.  Would that work for you?

I was looking at adding this for a slightly different reason (converting
sparse images to newly provisioned LUNs).

Followup is a naive patch (I'm new to hacking on qemu and the block
layer seems complex due to maturity) that works in my tests. Feedback
much appreciated.

The patch specifically targets the initial blanking of the image rather
than any other attempt to write zeroes, as I couldn't convince myself
that there was no control flow where qemu-img convert might need to
overwrite (with zeroes) data that it itself had previously written.

dme.
-- 
Stop the music and go home.

