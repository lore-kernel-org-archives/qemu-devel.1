Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12354C43603
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 12:37:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB8692077B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 12:37:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB8692077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icTuF-0000pN-U3
	for qemu-devel@archiver.kernel.org; Wed, 04 Dec 2019 07:37:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44782)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <buraksrc@gmail.com>) id 1icTAo-0002nw-AJ
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 06:50:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <buraksrc@gmail.com>) id 1icTAe-0002eS-Cv
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 06:50:21 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:46167)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <buraksrc@gmail.com>) id 1icTAd-0002EQ-VS
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 06:50:16 -0500
Received: by mail-lf1-f68.google.com with SMTP id a17so5830957lfi.13
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2019 03:50:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to
 :content-transfer-encoding;
 bh=HGvzauIwnStUS9xIYONJWNptIJN6kkdMiHiRIV5o1Kc=;
 b=OXa8qyZK2KjFW/dzPa0q7VLyxPRfiCLtfx574brLBZAiBrpyTWRQORPk/mqxxwg0bF
 tXaPJa+5vv7MKBkw6Krkxp678BwexJmj9U6bqPRLmImbr8NkNIK6iaXCeSE2UT5eMzP/
 h9eGW2zNOhwMz4BWXKgV10xAP7m/9j5/KrJWRluzkvWrD2rwcWcvvrJoOdrniHpRUgRR
 mHGuI1mx1IeOjTZdO7KDvrWXJ8ZEjzPG1d65Vqy06SUrc0z7X1RbUBXVwCNvEBTxx2+x
 Ey6rrIXEt6wif9zqaYj3BPpYfHf954bH95VhE9+laPV1WVSlFH7/QhxRkZECCR3ty4ss
 tIjg==
X-Gm-Message-State: APjAAAWynDNCpk61ZryM/vqY8bGlI0lV6OVvm9q6k7iVXE81mWRF0RJ0
 NQO/WqL7ypSYTjcfftP88VMKu5FVt8rpddSPStVMj7aZmZ8=
X-Google-Smtp-Source: APXvYqzUQUzgqEol6m51SZblSh4sux/8eGPBuxIfpL2JOLxJq2B8JfU4NRxpZv5WldOUyVCIjDAIP56lOLeq04x4d+4=
X-Received: by 2002:ac2:498e:: with SMTP id f14mr1817701lfl.172.1575460210833; 
 Wed, 04 Dec 2019 03:50:10 -0800 (PST)
MIME-Version: 1.0
From: burak sarac <burak@linux.com>
Date: Wed, 4 Dec 2019 12:49:44 +0100
Message-ID: <CALS5s1_NR4sfeWVWi2C7Dg=oCEOLEK8zovzVSzqjcY5eXNzgng@mail.gmail.com>
Subject: Re: Custom logic gates on user space emulation
To: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.167.68
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

Hello Alex,
 Thank you for your response, if I am on the right path I want to add
hadamard or one of pauli gate to gnu assembler then I want to run this
extended GAS via qemu using user space emulation. i.e.
https://en.wikipedia.org/wiki/Quantum_logic_gate#Hadamard_(H)_gate.
The idea is there are many quantum computer emulators i.e. here
https://www.quantiki.org/wiki/list-qc-simulators , yet I couldnt find
any one of them uses qemu. For beginning I wanted to try to port
libquantum hadamard impl.  There is https://github.com/Qiskit/openqasm
but source is not present.

Burak

burak sarac <address@hidden> writes:

> Hello All,
>  Currently I am studying qemu and I want to figure out how I can use
> custom logic gates on user space emulation.  I am searching very basic
> 'hello world' kind of tutorial or some resources to i.e. adding left
> or LOR : 1 | 0 =3D 1 but 0 | 1 =3D 0 to existing x86 arch
> ((https://en.wikibooks.org/wiki/X86_Assembly/Logic) ?).

It's not clear what you want to do. Are you looking to extend an
existing instruction set with additional custom instructions? Can you
explain why you want to do this?

> What I want to
> try is run this extended x86 version with qemu user space emulation.
> Do I need a custom toolchain also for this? I found this book:
> https://subscription.packtpub.com/book/hardware_and_creative/978178328945=
5/1/ch01lvl1sec15/generating-a-custom-toolchain-become-an-expert

For testing you don't need a custom toolchain - you can use inline
assembly with data statements to insert your custom instructions into a
program. Again it depends on what your eventual aim is here.

>
> Sorry for my ignorance in case it is totally irrelevant and I would
> appreciate any guidance! Or pseudo kind of road map for me!
>
> Thank you & have a nice day
> Burak


--=20
Alex Benn=C3=A9e

