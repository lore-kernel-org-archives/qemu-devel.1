Return-Path: <SRS0=sEuR=S7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_SBL,
	URIBL_SBL_A autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51EDCC43218
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 02:16:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DD9520843
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 02:16:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UbEDkgi4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DD9520843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50810 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hKvq5-0007ck-30
	for qemu-devel@archiver.kernel.org; Sun, 28 Apr 2019 22:16:17 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45423)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1hKvpJ-0006zk-0W
	for qemu-devel@nongnu.org; Sun, 28 Apr 2019 22:15:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1hKvpD-0002yh-7Y
	for qemu-devel@nongnu.org; Sun, 28 Apr 2019 22:15:25 -0400
Received: from mail-io1-xd2f.google.com ([2607:f8b0:4864:20::d2f]:36006)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1hKvp8-0002xT-Jq
	for qemu-devel@nongnu.org; Sun, 28 Apr 2019 22:15:20 -0400
Received: by mail-io1-xd2f.google.com with SMTP id d19so7670973ioc.3
	for <qemu-devel@nongnu.org>; Sun, 28 Apr 2019 19:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:content-transfer-encoding:mime-version:subject:message-id:date
	:to; bh=KalMcbKxXJjEaHl1hOhkuxc8SYQKK5v0xpapbUI+UMw=;
	b=UbEDkgi4F6HcsO5yt6CSqyL610vZBY00T+k5kvwsN+0F28tXDdtnWBn4OycsvL0+sM
	KoUo6JytgaBHpd7wAIJWWin5ePeVqvNHhP5Z0T9qBo3MQ0ArJm66SxFOlrq3fc/WgjEp
	28vR/FpU6npuIxQ9tZy89L2Ujpg34U8JqVynW1PSs+zpCPYAA7JdToN3zK9GrPx3yZ+Q
	cDeSaeJ4191iSUFDjjbdHUOheHEOk9NdhbjEiJJFGrSYLCZVl1WlGzE/gRBXFQvmY9wq
	0tgHtP+rPxufgUqSazfI2Y1FA9v5r1bHeY2Y+sHZ89q/SCb2RY7ZeTOAUa2NkhNJOh54
	hlhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:content-transfer-encoding:mime-version
	:subject:message-id:date:to;
	bh=KalMcbKxXJjEaHl1hOhkuxc8SYQKK5v0xpapbUI+UMw=;
	b=tnSLYTVGqMxiYhskiZKXCtlGKGMa7gFFlNcaRlX7VxyJtwQUPH2SY7FRKGUzrvkqwM
	KYbrQBMrDON3CvvWwmXlnbYPBIfrXfWw84m+7/PFRLBHm9akiEG5EmoWCS/mRcfYN9aJ
	t4nGKe6fU228RNqPt1ZrXUqFcEMm4FC/RJyC1O5Mo5iXwoLial1qsL6bpORABGEiOp5l
	Um1h0D0+Bdr8zJjx8OT0fOq63s7Is8hLKCJSLG7LNs9aBCgXHnepMBLRDrYWITAN+sug
	OJXkt0UPgDLFiyU6Qb/eln3XdkDhlzn4764uFAUOOhbJ6yIHf2AP3Z6hMFezAgfaFsuK
	is0A==
X-Gm-Message-State: APjAAAUJVTs3kR2ROLECGcrzWowW+XcSdvRBvhZCjHYU41UUFkbKcu+H
	bDB6k/AyB48o2I5Ml5+WHBc6wCCY
X-Google-Smtp-Source: APXvYqzcm1RtLdiypxFv5ZtfsUtAyWR0nhU/mycQ15PwW81pc67rxgpgV/H4XqP/P54xhkrIo2dNGQ==
X-Received: by 2002:a5e:d505:: with SMTP id e5mr12588947iom.99.1556504116688; 
	Sun, 28 Apr 2019 19:15:16 -0700 (PDT)
Received: from [192.168.0.2] (d14-69-20-184.try.wideopenwest.com.
	[69.14.184.20]) by smtp.gmail.com with ESMTPSA id
	e19sm9463643ioc.13.2019.04.28.19.15.15 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sun, 28 Apr 2019 19:15:15 -0700 (PDT)
From: Programmingkid <programmingkidx@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Message-Id: <47019F45-9440-44BF-BFEF-0A35F7F230E3@gmail.com>
Date: Sun, 28 Apr 2019 22:15:13 -0400
To: QEMU Developers <qemu-devel@nongnu.org>
X-Mailer: Apple Mail (2.3273)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::d2f
Subject: [Qemu-devel] Apple Hypervisor - unimplemented handler
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190429021513.b1pip3wlHdRfnLFd_FoOTVRlGA2L3d2VBt7r1eMoBks@z>

When running Windows 7 using "-M accel=3Dhvf --cpu host", Windows 7 =
would crash. What was printed to the console was this:

Unimplemented handler (fffff8000c0c2050) for 0 (f c3)=20

This message is from target/i386/hvf/x86_emu.c. The c3 seems to indicate =
this is a problem with the MOVNTI or RETN instruction.

This is the webpage I used for figuring out this: =
http://ref.x86asm.net/coder32.html. A search of the page shows another =
instruction with the c3 opcode called RETN. So I'm not 100% sure which =
instruction is the problem instruction.

In the file target/i386/hvf/x86_decode.c, this line of code makes me =
think it is RETN:

{0xc3, X86_DECODE_RET_NEAR, 0, false, NULL,
     NULL, NULL, NULL, NULL, RFLAGS_MASK_NONE}

Any help with this issue would be appreciated.

Thank you.=

