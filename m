Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47AB4C432C0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 13:20:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10296205F4
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 13:20:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eQeD3et4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10296205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ic86N-0000pM-5N
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 08:20:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48366)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <buraksrc@gmail.com>) id 1ic83y-0007qW-Fv
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 08:18:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <buraksrc@gmail.com>) id 1ic83w-0000CH-Ai
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 08:17:58 -0500
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d]:40499)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <buraksrc@gmail.com>) id 1ic83u-00008m-Al
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 08:17:55 -0500
Received: by mail-lf1-x12d.google.com with SMTP id y5so2924477lfy.7
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2019 05:17:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:sender:from:date:message-id:subject:to;
 bh=om/lOJ/3SR5e2M2oS+aoHZhlXdrmRLH43DNF5vxr/DE=;
 b=eQeD3et4Vlmbto8O/zNj1DkjLcTQBfSf3FwyO+Ks513DalFZuS8CEIbXYUgApYvDpW
 Su7pJY2kLdsnn8u0k6A80D2TXf9nmcNcZJaOgdNTsEzz0qCX55c0exgAyI0seT5bmOG0
 qfflaKg4LsnQE3dShJRsRa12RbSlHwstNLSd7pkyijo37wSHHl7O+BXf44nFvZxefU+s
 tEbpE0p4lPKuu9/EBhtVfSWNrIMDZHisi9vNyhm1XXNXuOcMn25JjTZpv1OJmXsUgFTL
 WBCrMlUKBLo92dp6T70+mxsAu+tX5LRyaY4OmRjKRYV8gi5Gnd5pptYz9xBZ0F8/Qk7F
 cS+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
 :to; bh=om/lOJ/3SR5e2M2oS+aoHZhlXdrmRLH43DNF5vxr/DE=;
 b=ABoBk3w/M0cJW+Jx4aRjN1Z0qj1vBD4Dw+DjHd+9ZcIdiTEFxxb4r16JCS+g8pvgdz
 rVp8Wu2T/NpmPo0gI6t0XwRXw1mEqsJGdj8xo7KfQxv4sCmZ2nbYC922/jXHxhgADm6s
 HsWu4wE2AVH/AqMWCLb8lq1hHnA5FBVly3ao599C2VSE2YVRlyOi3Z4FTPRgsXXdbGxk
 pWJwre0gdRddPaGQkVKwTGAY5dolxvXXxLArLb9ois0G03x6K4Uju9KO/HJnI0Rc/eo8
 lylkdiYtvPRFjb6PyPsrBVyysn7IWgGYngFyMe+rDLnEjbOtapHSv8iMjRNjfevJCul8
 81iw==
X-Gm-Message-State: APjAAAXC44Qb7s5AECaJvKgjlOgvljXGBTLUW8bBPQPukjddL4btVlbg
 0ki15vtKxJ2tnMnXsSoHsc9MAHEQuolizpqkbmuKzZC0
X-Google-Smtp-Source: APXvYqw6GQfjKKaAljcYyqHcb/02ayKNXuTzBjMkuUKD9SZnWKCU4uNQZO7b/FTuRuphAB8UchzBqHqSwixntClzIas=
X-Received: by 2002:a19:ac43:: with SMTP id r3mr2725519lfc.156.1575379068993; 
 Tue, 03 Dec 2019 05:17:48 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a19:2293:0:0:0:0:0 with HTTP;
 Tue, 3 Dec 2019 05:17:47 -0800 (PST)
From: burak sarac <burak@linux.com>
Date: Tue, 3 Dec 2019 14:17:47 +0100
X-Google-Sender-Auth: 8mqS-fdqKFlQSzANKQUwdDelbZo
Message-ID: <CALS5s18QBnPsv3TbtbM7ie__zekvH1T59c-o8FRd+f0EtiwqFg@mail.gmail.com>
Subject: Custom logic gates on user space emulation
To: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::12d
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

Hello All,
 Currently I am studying qemu and I want to figure out how I can use
custom logic gates on user space emulation.  I am searching very basic
'hello world' kind of tutorial or some resources to i.e. adding left
or LOR : 1 | 0 = 1 but 0 | 1 = 0 to existing x86 arch
((https://en.wikibooks.org/wiki/X86_Assembly/Logic) ?). What I want to
try is run this extended x86 version with qemu user space emulation.
Do I need a custom toolchain also for this? I found this book:
https://subscription.packtpub.com/book/hardware_and_creative/9781783289455/1/ch01lvl1sec15/generating-a-custom-toolchain-become-an-expert

Sorry for my ignorance in case it is totally irrelevant and I would
appreciate any guidance! Or pseudo kind of road map for me!

Thank you & have a nice day
Burak

