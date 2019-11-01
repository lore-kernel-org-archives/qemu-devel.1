Return-Path: <SRS0=V8KP=YZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 898C0CA9EC9
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 07:15:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EF8A2080F
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 07:15:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EF8A2080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56874 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQR9k-0004Jb-G7
	for qemu-devel@archiver.kernel.org; Fri, 01 Nov 2019 03:15:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40877)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <christian.ehrhardt@canonical.com>)
 id 1iQR8p-0003qk-4f
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 03:14:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <christian.ehrhardt@canonical.com>)
 id 1iQR8o-0005tf-4B
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 03:14:39 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:35573)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <christian.ehrhardt@canonical.com>)
 id 1iQR8n-0005tH-Um
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 03:14:38 -0400
Received: from mail-vs1-f69.google.com ([209.85.217.69])
 by youngberry.canonical.com with esmtps
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <christian.ehrhardt@canonical.com>)
 id 1iQR8l-0001WG-RG
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 07:14:35 +0000
Received: by mail-vs1-f69.google.com with SMTP id w22so1503646vsw.17
 for <qemu-devel@nongnu.org>; Fri, 01 Nov 2019 00:14:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=8tABfg5UmnAHSWW2mTQr80n+YWxQ9V8Bxko38FVQH7M=;
 b=tVLcQaxnNbp2HNkkI2fYsd4O8KWj2r8zvlP3qiLHkk1TwPQegKVRmqI7QMO5n53wFd
 6dXmSeiC7RKvPfzv+Z6CPmnbdy0BtVKWrs/aVezCEJPRDyz3HVktfBHWGTFkai7TbpYZ
 7j9bvMp2a+R4oWU3otBO/KvGEpWyiN6IQVSKzOjn3BzJtBARUC09At+6wNVltOPuqZMI
 JcpKmtToSytkWXFTCJGwOefBqlfF96vJFNCWVr5fCLRERR/reuUZZZbLg/6dffoMVm5x
 ZumO6uPbsC4pHXbKugX3HnxG2n9Hr5mglsi6M0B55mBrVdJ6NIZI0r3AzoTAVqygtHGY
 Ru/g==
X-Gm-Message-State: APjAAAVaOWEK8zRpc2r3F+vCB1kCo8U6om6k7nJHKLH8GWNYdFcBh4fi
 pEZX6dD9uPwvSNQsYuJHG9DAEjqQ4Z0mHD7e/lqJk38i8HjY06NewP3rCMl0OvPu7ScTZQHVaN0
 lp5T4UaIvjNf7m3OB3Nyi0/0CSTkktXccmX2om5aIJFcysDbk
X-Received: by 2002:a1f:8c01:: with SMTP id o1mr4607782vkd.69.1572592474770;
 Fri, 01 Nov 2019 00:14:34 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxB81QbO8B50ngTQtG6pDd6P1/eSE//XVxZBF1Brf6VgMINymshfthb6oj5ClncYVSFrEIo99VjU2HmCIM7m2k=
X-Received: by 2002:a1f:8c01:: with SMTP id o1mr4607767vkd.69.1572592474322;
 Fri, 01 Nov 2019 00:14:34 -0700 (PDT)
MIME-Version: 1.0
From: Christian Ehrhardt <christian.ehrhardt@canonical.com>
Date: Fri, 1 Nov 2019 08:14:08 +0100
Message-ID: <CAATJJ0KDOsA=Y+zLBT=PhcU0Q+gqRPSWkK0VaksisVC9_i5M_g@mail.gmail.com>
Subject: Best practices to handle shared objects through qemu upgrades?
To: qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 91.189.89.112
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

Hi everyone,
we've got a bug report recently - on handling qemu .so's through
upgrades - that got me wondering how to best handle it.
After checking with Paolo yesterday that there is no obvious solution
that I missed we agreed this should be brought up on the list for
wider discussion.
Maybe there already is a good best practise out there, or if it
doesn't exist we might want to agree upon one going forward.
Let me outline the case and the ideas brought up so far.

Case
- You have qemu representing a Guest
- Due to other constraints e.g. PT you can't live migrate (which would
be preferred)
- You haven't used a specific shared object yet - lets say RBD storage
driver as example
- Qemu gets an update, packaging replaces the .so files on disk
- The Qemu process and the .so files on disk now have a mismatch in $buildid
- If you hotplug an RBD device it will fail to load the (now new) .so

On almost any other service than "qemu representing a VM" the answer
is "restart it", some even re-exec in place to keep things up and
running.

Ideas so far:
a) Modules are checked by build-id, so keep them in a per build-id dir on disk
  - qemu could be made looking preferred in -$buildid dir first
  - do not remove the packages with .so's on upgrades
  - needs a not-too-complex way to detect which buildids running qemu processes
    have for packaging to be able to "autoclean later"
  - Needs some dependency juggling for Distro packaging but IMHO can be made
    to work if above simple "probing buildid of running qemu" would exist

b) Preload the modules before upgrade
  - One could load the .so files before upgrade
  - The open file reference will keep the content around even with the
on disk file gone
  - lacking a 'load-module' command that would require fake hotplugs
which seems wrong
  - Required additional upgrade pre-planning
  - kills most benefits of modular code without an actual need for it
being loaded

c) go back to non modular build
  - No :-)

d) anything else out there?

-- 
Christian Ehrhardt
Staff Engineer, Ubuntu Server
Canonical Ltd

