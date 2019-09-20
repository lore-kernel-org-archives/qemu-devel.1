Return-Path: <SRS0=nDBX=XQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9436C3A5A2
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Sep 2019 01:14:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC3A82086A
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Sep 2019 01:14:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZAvwBMeE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC3A82086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36606 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBTyh-0005ma-Tk
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 21:14:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56113)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <incredible.tack@gmail.com>) id 1iBOAG-0007Mf-Bi
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 15:01:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <incredible.tack@gmail.com>) id 1iBOAE-0003gY-85
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 15:01:56 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:53836)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <incredible.tack@gmail.com>)
 id 1iBOAC-0003e6-74
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 15:01:54 -0400
Received: by mail-wm1-x32e.google.com with SMTP id i16so3629031wmd.3
 for <qemu-devel@nongnu.org>; Fri, 20 Sep 2019 12:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=oxdvlxxBL97ZJrjo/qzPpYv9v7YPNbs+U5iOTGBBQ9c=;
 b=ZAvwBMeE5F6n5JV+RZmWcjezoi4b7nqcJqJTFdmVsoQ+t2VTYwJ1z8c9tq8cXXFzKQ
 eDkPIq+ZrHIJJzh7T99WcevEDkEjej2A0r3M8cisOVpt/B8BuWcOQUovOpeHhIWxrPYD
 4ErRC9efFdgzC7gFZbdRiAV/hcm05IXIYJr7r6jxhi+32vvVKnzA+YjXEvuuHbVKBmVw
 dnXsZ61TRMPrbMSRSrCMtfqdEYy8oFzC/OgA/80xdmji0PNhJOda+HT9ytDH1ppiJAze
 7vMNuzIKgdVMVfo99muCWrrqGarOKjQMtUiuQ96H1vWLpEojvptBN2KJpktyb8mf4O++
 GNwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=oxdvlxxBL97ZJrjo/qzPpYv9v7YPNbs+U5iOTGBBQ9c=;
 b=h3Vyi915m5j6Jf0PKxx3xclrSf6Uxs7X26YlJeArRQ3CqW20NeDogkgV5hd9reEBNx
 rWGk7mpNO0xvx3IPf841IfnGesvcoXKtRDSVoPrP4RBPC2NrtSANUPjR0uFWyIOCkkcD
 nHlB71w4vzmGSlAxZe3GgVHsKJagsNCpDXz6hDbj+k8baFqNjwXgINjHW1IThdV62l4R
 PEai5ZCZd9LAjHp4uiWfV/XJ9WlRbvFh2NRrpJzvF3NvjnATKtjnzg3Xn5T1Y7zeXuQq
 nHbxd9pEC32a5Xzh+M41a9ubQVixI37EStxd4t6VnBDvHVO8ltOx2DyvfoOiw3gpvXWV
 qVBw==
X-Gm-Message-State: APjAAAXPRxHgNPHfgn3tvlyXy1RsjsxtMfepWj8gDgiHACslg/iGkQ13
 GJFZfjeR7td0TdOn+xKY5yeoHGYNkkmB22ZSGAsfBJEVpgI=
X-Google-Smtp-Source: APXvYqwQr4G/hi9tFcOoJB+jML5ZhKhFXqPafxS5PY8Ka6tooY47PGAmqKxVLTCz+WC9M6RrYQsbvhB3eJC0/McB6j8=
X-Received: by 2002:a7b:c5c5:: with SMTP id n5mr4424538wmk.69.1569006108070;
 Fri, 20 Sep 2019 12:01:48 -0700 (PDT)
MIME-Version: 1.0
From: Jintack Lim <incredible.tack@gmail.com>
Date: Fri, 20 Sep 2019 12:01:36 -0700
Message-ID: <CAHyh4xhYrUbK0aEJmKp3_kOJG2E+AQLMUjyf7_pXVJgbqgv5JA@mail.gmail.com>
Subject: Migration failure when running nested VMs
To: QEMU Devel Mailing List <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32e
X-Mailman-Approved-At: Fri, 20 Sep 2019 21:10:46 -0400
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

Hi,

I'm seeing VM live migration failure when a VM is running a nested VM.
I'm using latest Linux kernel (v5.3) and QEMU (v4.1.0). I also tried
v5.2, but the result was the same. Kernel versions in L1 and L2 VM are
v4.18, but I don't think that matters.

The symptom is that L2 VM kernel crashes in different places after
migration but the call stack is mostly related to memory management
like [1] and [2]. The kernel crash happens almost all the time. While
L2 VM gets kernel panic, L1 VM runs fine after the migration. Both L1
and L2 VM were doing nothing during migration.

I found a few clues about this issue.
1) It happens with a relatively large memory for L1 (24G), but it does
not with a smaller size (3G).

2) Dead migration worked; when I ran "stop" command in the qemu
monitor for L1 first and did migration, migration worked always. It
also worked when I only stopped L2 VM and kept L1 live during the
migration.

With those two clues, I guess maybe some dirty pages made by L2 are
not transferred to the destination correctly, but I'm not really sure.

3) It happens on Intel(R) Xeon(R) Silver 4114 CPU, but it does not on
Intel(R) Xeon(R) CPU E5-2630 v3 CPU.

This makes me confused because I thought migrating nested state
doesn't depend on the underlying hardware.. Anyways, L1-only migration
with the large memory size (24G) works on both CPUs without any
problem.

I would appreciate any comments/suggestions to fix this problem.

Thanks,
Jintack


[1]https://paste.ubuntu.com/p/XGDKH45yt4/
[2]https://paste.ubuntu.com/p/CpbVTXJCyc/

