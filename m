Return-Path: <SRS0=1I+v=SH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0BBBC4360F
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 01:07:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70041206B7
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 01:07:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PbHenSj4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70041206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33503 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hCDK9-0002RK-8v
	for qemu-devel@archiver.kernel.org; Thu, 04 Apr 2019 21:07:17 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54749)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1hCDIw-0001pp-Fo
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 21:06:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1hCDIt-0003Av-Q8
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 21:06:02 -0400
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331]:38929)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
	id 1hCDIm-0002uM-6w
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 21:05:54 -0400
Received: by mail-ot1-x331.google.com with SMTP id f10so4153383otb.6
	for <qemu-devel@nongnu.org>; Thu, 04 Apr 2019 18:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:from:date:message-id:subject:to;
	bh=zx0JVDdbe2kLUj36ajkY3Bqpj7X+xh5R79U0/VreK/I=;
	b=PbHenSj4vzlv1WK8o4vQNhyHBk7wrNxxcR5vxCkJTCxfCweW42pz3qNG56XFLAkRQw
	5RE3stDUHhWDobOh/jiBMGCwybefnkHrGcOu+sOeaqzoJaZVsZzZDyRTJdglIEOyB88g
	5BFez/y69DxrN4xxz0icwtwboduaz0yuysNBab8vqZ5QATCYHUoF49ib093KaP/4cZ1T
	rq9qnMb4CB7sW4xJJzu2OrPkx083XNGaFcMAF1qVlaChNEIlT9iOymTBGN8dnc25DT+x
	waRaUD4HMpbXzViRTSgx2F5DTeUnpjn2XJmfzb+lrAbXPB3MU+jOP7BPPRQYMskO+4Ux
	erXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
	bh=zx0JVDdbe2kLUj36ajkY3Bqpj7X+xh5R79U0/VreK/I=;
	b=Nm3Zyd9iJBc3vAok1r6LyrWp7G3mmDZzAfqxZ+S/EDC+CHrn3hVhG1Obz8IeHrBKzC
	jUibsNut3Zk+87b86SGDOSHOAuQDR7CCxTImPRS6VRF3Y6nk41QXIJdDTN1Zj/V9kWoq
	ed7/CCSNA2Bue5gw2flnAVqyNnVFjyf38EzlVMthV5oXKWDCuAJzMxtz22eRNQcWjig1
	LisczLMNx7FXgbMFxpefC/FTzcORnMXPSlkTthLK2jufT/tCtU5FfFs1YR0xS0B8ehae
	JnvvDIBgowLYgaQLracvc6jl7Of7vw9LsbNY7Xshbbb2Bij2yEddcwMNPfb4wCO00OMz
	mqFw==
X-Gm-Message-State: APjAAAUlLpEptNFR5n8F0Ji+IiuqaoBYlYwmVgtiMng+igqH7CFQb103
	PW0PDH54LubkL683FozczqUDLZI7u2PXCkak+JQTLQ==
X-Google-Smtp-Source: APXvYqwc0HObqbcjOiLD16yCWTI8ZmJUZTL1jz8eYu502CrXksdcipQ22xIdD5JZq9i7Ds2y68CFUXRXttcUji3NL9I=
X-Received: by 2002:a05:6830:1418:: with SMTP id
	v24mr6550730otp.273.1554426350089; 
	Thu, 04 Apr 2019 18:05:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:220e:0:0:0:0:0 with HTTP;
	Thu, 4 Apr 2019 18:05:49 -0700 (PDT)
Received: by 2002:a9d:220e:0:0:0:0:0 with HTTP;
	Thu, 4 Apr 2019 18:05:49 -0700 (PDT)
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Fri, 5 Apr 2019 03:05:49 +0200
Message-ID:
 <CAL1e-=i3-uUNfQhrgxtty2EzgmPOiU9YNAEw+TDjXCwgmkmi0Q@mail.gmail.com>
To: qemu-devel@nongnu.org
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::331
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: [Qemu-devel] QUESTION: How to measure performance of the emulation
 of a single target instruction?
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
Message-ID: <20190405010549.uP_PvKhzLc-V0ZFQzpzZR6ttIWlfW8oMnIlX6zq95QQ@z>

Hello, folks.

There is some optimization activity in MIPS target, and we have some simple
micro-benchmarks for measuring speed of emulation of a single target
instruction, but I am not particulary happy with them. They are just a
single instruction assembly within a =E2=80=9Cfor=E2=80=9C loop. I tried so=
me other
approaches, but couldnt get results that made sense.

Do you have some suggestion or idea what would be a good way for such
measurements?

Grateful,

Aleksandar
