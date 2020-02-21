Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 131AAC35647
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 11:51:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D05AE208C4
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 11:51:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OLkDBmKG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D05AE208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j56qU-0004iA-15
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 06:51:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41166)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <changbin.du@gmail.com>) id 1j56pu-0004GU-Mk
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 06:51:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <changbin.du@gmail.com>) id 1j56pt-0006at-Fh
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 06:51:14 -0500
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:33943)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <changbin.du@gmail.com>)
 id 1j56pt-0006aT-7f
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 06:51:13 -0500
Received: by mail-pf1-x441.google.com with SMTP id i6so1096497pfc.1
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2020 03:51:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=qbzjQ5AyuM014TuI2Kg5dK/S/2sXeBj4i5PIb923gIE=;
 b=OLkDBmKGI3m9mmyOEbdX38NiiaOmyZN35313RlDoyUtbJqrKxLf0wsUGGEab5ZLk0T
 j7dgfbDujcHPxZZJROoTE3zTZKLTRFaJaXogKULg2IGJ9XkYJeFWRMLWcUHHHTWxzgiY
 BXqjoNs8kFafJxsz4+rd6R+1bJHgaMk//BczQFlC62JFH2IZtg0WsP3q3uKYDKjPXzwO
 xB8tl4M4D3JCGiPgSFGsmNoP0FrrVWcTk1jxgDQNDtJpE8ZvbNEWGMBf/piMye/k/p4g
 VAfPkpy+sSOoMC87mGEeSkYThwpbT7rP33fDEfbqrXDunExU0kkuypfp+J/g+egge1Ze
 nBZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=qbzjQ5AyuM014TuI2Kg5dK/S/2sXeBj4i5PIb923gIE=;
 b=n1ysE1520mVgjuU1pgHImBl0KdJZzM86Y++ZrDGe2e2fOliWIQEmUiavsfAc/q6IdZ
 ejuEPkqZE6Gm4WpMCrjG1JmW4SDMVZnvTqiEZ1cGzzp5rY2AjOS571dIRt5HgEkFJHRp
 YEaPIcuXws1RsE2NqAmRs/9u6ds9qRuwcvLax8slfYKItKjKceFHVwjeg2d4J6//183m
 bx4rUqXt7/7C33nKJmCIrUkY5smoRCAQ9n6XaCknMD71mvzBCseVbEHjit6naoy9b5Aq
 M/TXboEIOYoREeDGAai1JR2Xp9dFq80C55HA/1zIGzU8lLF/BtUrI5sGJT6JhNdDGphB
 CBng==
X-Gm-Message-State: APjAAAU4Qhg4hZ0hFn4T5IJ71ptC7Czeu4xjKrz/uTS/vNm+1TDqEQ97
 7GUNwp4bN9zA8nUVO1LgQng=
X-Google-Smtp-Source: APXvYqz/lg9PDmkgNAqCA9xaKLShKaRKDMF4qL8acFlt5GOS8GRCLDBYNAOiVAPEk9x/nBmudJXaSw==
X-Received: by 2002:a63:be09:: with SMTP id l9mr16257584pgf.439.1582285871833; 
 Fri, 21 Feb 2020 03:51:11 -0800 (PST)
Received: from mail.google.com ([149.248.10.52])
 by smtp.gmail.com with ESMTPSA id p16sm2300781pgi.50.2020.02.21.03.51.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2020 03:51:11 -0800 (PST)
Date: Fri, 21 Feb 2020 19:51:04 +0800
From: Changbin Du <changbin.du@gmail.com>
To: Luc Michel <luc.michel@greensocs.com>
Subject: Re: [PATCH] tcg: gdbstub: Fix single-step issue on arm target
Message-ID: <20200221115104.x3af4cfjin553jun@mail.google.com>
References: <20200220155834.21905-1-changbin.du@gmail.com>
 <ddc8b36f-da30-faac-cab2-fad882841159@greensocs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ddc8b36f-da30-faac-cab2-fad882841159@greensocs.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
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
Cc: Peter Maydell <peter.maydell@linaro.org>, philmd@redhat.com,
 alex.bennee@linaro.org, qemu-devel@nongnu.org,
 Changbin Du <changbin.du@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Feb 20, 2020 at 10:24:37PM +0100, Luc Michel wrote:
> I'm curious, I never experienced this behaviour from GDB. What GDB and
> QEMU versions are you using?
> 
> On my side (GDB 9.1), even without 'vContSupported+' in the 'qSupported'
> answer, GDB sends a 'vCont?' packet on the first stepi:
> 
> 0x00000000 in ?? ()
> (gdb) si
> Sending packet: $m0,4#fd...Ack
> Packet received: 00000000
> Sending packet: $vCont?#49...Ack
> Packet received: vCont;c;C;s;S
> Packet vCont (verbose-resume) is supported
> Sending packet: $vCont;s:p1.1;c:p1.-1#f7...Ack
> Packet received: T05thread:p01.01;
> 
> Your second issue (wrong PC value) should be investigated though. Does
> it happen on QEMU vanilla? Do you have a way to reproduce this bug?
> 
Just confirmed this issue. This is an endianness problem for gdb. I was
debugging an big-endian elf and my host cpu is little-endian. QEMU gdbstub
always uses host cpu endian but gdb client treats it as big-endian by
inspecting elf info.

I can mannually set it to little-endian but it is painful. The gdb complains
abount invalid opcode error in debuginfo.

I also noticed that someoneelse has already tried to resolve this issue.
https://patchwork.kernel.org/patch/9528947/

> Anyway after re-reading the GDB remote protocol documentation, I think
> your patch is right, the feature should be advertised.
> 
> However I think your commit message needs some modifications. This fix
> is not specific to ARM or TCG, but to the gdbstub itself. You also
> mention this bug you have with PC, which is not related to the bug you
> are fixing here. Could you rewrite it in a more generic way? You simply
> need to emphasis the effect of advertising the 'vContSupported+' feature
> on GDB.
> 
> Thanks.
> 
> -- 
> Luc

-- 
Cheers,
Changbin Du

