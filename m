Return-Path: <SRS0=/4tE=TV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D155AC04E87
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 12:27:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E4692173C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 12:27:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qphm6/qz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E4692173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52683 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hT3ru-0002gf-Op
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 08:27:46 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45330)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hT3q2-0001SF-RD
	for qemu-devel@nongnu.org; Tue, 21 May 2019 08:25:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hT3px-0005Gh-5A
	for qemu-devel@nongnu.org; Tue, 21 May 2019 08:25:50 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:45083)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hT3pw-00051U-Rx
	for qemu-devel@nongnu.org; Tue, 21 May 2019 08:25:45 -0400
Received: by mail-wr1-x432.google.com with SMTP id b18so18327231wrq.12
	for <qemu-devel@nongnu.org>; Tue, 21 May 2019 05:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=C34wSknYfP7exmEYTYXoYIlJWoop2QGg12J54yf6OKs=;
	b=Qphm6/qzSSc7PYV0/OiYMAmewUH8YLib+97PkfnYgwWuNSBgUQbsfF2Mt7AdV3np1I
	YAAWzfKGCojyOlUYTrfCGwK6w9G9MaYbbLZXbkcQjuC2VLGI6hgbrP2Rc4i2A2q63lyT
	p1/k4WH3att8J291f8/EJC9D6uJZ5ubxc2/AI8J0IhNFpZYh57L/EgNH63tUgwAi6ZGu
	WWdZncdGGCmo4Zab7DzBc1YWYdZevtCgYd+4ooGkZqTkSf4LXApn1/JGAo4M9o8JkcY9
	OumSA+nHJmF4euEqkd7W/IZRK1e22ElKwffcRXEqU1YMdnJ+z726bztbZ/LCwK5UMpFW
	qENg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=C34wSknYfP7exmEYTYXoYIlJWoop2QGg12J54yf6OKs=;
	b=j4m33/JBDdVKAIUCkSy3Bgasux+xBSjS/dmy3CAEe6fqf9brne6ohbwTXYQliaqF0G
	uKcBMm+Q9RcL1h2HVcjnCAonFffzeILccRDBXYjuKKfGqOarl53sNJ7whnsgILWtITD+
	29O7axenKTOmKtCPcm5gkLHN5MSd3mdb4o7CgEYRrGFPBiKTV8s6Pa5o/rwiLFCWicc6
	mkqWAi7R/NqxV4xIFOZOxEQDTd94EAX9GvzDrX9BjmVdfgYqy7sDeWIH2fKYcaEWQr2f
	bp7LfLAsGloxO1cLH6mm2tPwq8z4Q5tqNAWXRNemkSthVh1DRp4gGKeuUgqKQdtnaI2r
	BCNA==
X-Gm-Message-State: APjAAAXwOThgrrZ/YgM78d6qyRA4asyKDS/fOGDKRQv7SeDoYzg2iPS/
	vz1EoakhJM6K6epK4bEUuLvjn2wKu0E=
X-Google-Smtp-Source: APXvYqyxnOrQJ/ICwXUNOeNxEwcv9pEbnhLKjqFYuDSHbQLDIqfQS3gRgl7fQB5NW2xZImhtb7gkOg==
X-Received: by 2002:a5d:54d1:: with SMTP id x17mr32251548wrv.207.1558441522248;
	Tue, 21 May 2019 05:25:22 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	u11sm12233393wrn.1.2019.05.21.05.25.20
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 21 May 2019 05:25:21 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue, 21 May 2019 13:25:09 +0100
Message-Id: <20190521122519.12573-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::432
Subject: [Qemu-devel] [RFC 00/10] Add kernel-doc support to our Sphinx setup
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
	Eduardo Habkost <ehabkost@redhat.com>,
	Gabriel Barreto <sbarreto.gabriel@gmail.com>,
	"Emilio G. Cota" <cota@braap.org>, Stefan Hajnoczi <stefanha@redhat.com>,
	Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
	John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi; this is an RFC patchset which I'm sending out mostly to provide a
work-in-progress snapshot that might be useful for Gabriel's GSoC
project on API documentation generation. You can find the equivalent
git branch here:
https://git.linaro.org/people/peter.maydell/qemu-arm.git/log/?h=sphinx-docs
(git url/branch for cloning:
  https://git.linaro.org/people/peter.maydell/qemu-arm.git sphinx-docs )

The patchset starts by pulling in the kernel-doc script from the
kernel sources and wiring it up in our Sphinx config.  The version of
the script is just from head-of-kernel-git from when I was working on
this at the beginning of the year; we should probably check whether
we should update it to something newer and/or something from a more
specific kernel release.

The patchset then demonstrates the functionality with two documents:
a standalone file that just has API docs of the functions from
bitops.h, and an extension of the existing memory.rst doc to include
a "detailed API docs" section at the end with the generated docs from
memory.h.  In both cases to get the build to not error out we need to
fix up syntax issues in the header comments.  For the memory.h stuff
in particular some of the fixes are a bit ropy, and I also ended up
using a big "disable nitpick mode" hammer to shut up an error
(leaving some non-fatal warnings still generated).

Broadly speaking the earlier patches in the series are more
"solid" than the later ones which are a little more hacky.

Some specific notes:

(1) our Makefile rune runs sphinx-build with -n, which enables
"nitpick mode", where sphinx will complain about references that it
wanted to hyperlink but which it doesn't have anywhere te link them
to.  This is something that I think I got from the kernel's makefile
rules, and it's obviously nice for catching typos, but sphinx also
complains about references to "uint8_t" and other system types
because obviously there are no definitions of those in our headers. 
I have a patch in there which tries to whitelist these, but this may
not be the best approach. (Nitpick mode might also be awkward if we
want to generate docs for API A which uses some types from API B
which we have not yet started generating docs for.)

(2) kernel-doc assumes the kernel C coding style which always uses
explicit 'struct'.  This clashes with QEMU's style which usually
hides 'struct' behind typedefs, and seems to result in needing to
write 'struct' in the doc comment to get it recognised as being
documentation of the struct (see eg "memory.h: attempted kernel-doc
fixes") and also failure to recognize that "#MemoryRegion" is a
reference to the MemoryRegion struct type (resulting in errors about
references not being found).  I'm not sure exactly what to do here --
it may be some combination of making kernel-doc more flexible in
coping with structs that hide behind typedefs, and fixing up syntax
in our doc comments.

(3) There are definitely some other syntax issues that still need
fixing -- for instance if you look at the generated documentation for
memory_region_init_ram_nomigrate() the "Description" section is just
a sentence fragment, because the doc comment has been misparsed due
to the way the descriptive text following "function() - " is split
over multiple lines.  We would need to do a more thorough
proofreading check and fix up the syntax as needed.

(4) Some Sphinx warnings generated are legitimate -- it complains
correctly that we don't have doc comments covering all the fields in
some of the structs in memory.h, for instance.  In an ideal world we
would fix these too :-)

thanks
-- PMM

Peter Maydell (10):
  scripts/kernel-doc: Import kernel-doc script from Linux
  docs: Add kerneldoc sphinx module from Linux
  docs/conf.py: Enable use of kerneldoc sphinx extension
  docs/conf.py: Ignore some missing references in nitpick mode
  bitops.h: Silence kernel-doc complaints
  docs: Create bitops.rst as example of kernel-docs
  memory.h: Fix kerneldoc syntax issues
  docs: Add kernel-doc API documentation to memory.rst
  memory.h: attempted kernel-doc fixes
  Makefile: disable Sphinx nitpicking

 Makefile                 |    2 +-
 include/exec/memory.h    |   31 +-
 include/qemu/bitops.h    |   52 +-
 docs/conf.py             |   22 +-
 docs/devel/bitops.rst    |    8 +
 docs/devel/index.rst     |    1 +
 docs/devel/memory.rst    |    5 +
 docs/sphinx/kerneldoc.py |  150 +++
 scripts/kernel-doc       | 2223 ++++++++++++++++++++++++++++++++++++++
 9 files changed, 2458 insertions(+), 36 deletions(-)
 create mode 100644 docs/devel/bitops.rst
 create mode 100644 docs/sphinx/kerneldoc.py
 create mode 100755 scripts/kernel-doc

-- 
2.20.1


