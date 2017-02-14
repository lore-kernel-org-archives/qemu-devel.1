Received: from eggs.gnu.org ([2001:4830:134:3::10]:41345)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cdcM2-0004sn-Lq
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 07:37:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cdcLz-0000iJ-Ur
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 07:37:10 -0500
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:33602)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cdcLz-0000i0-Nw
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 07:37:07 -0500
Received: by mail-wr0-x243.google.com with SMTP id i10so27502093wrb.0
	for <qemu-devel@nongnu.org>; Tue, 14 Feb 2017 04:37:07 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <1487067971-10443-1-git-send-email-armbru@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <68685152-8129-878c-369f-b86788afdf61@redhat.com>
Date: Tue, 14 Feb 2017 13:37:08 +0100
MIME-Version: 1.0
In-Reply-To: <1487067971-10443-1-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 00/24] QemuOpts util/cutils: Fix and clean
 up number conversions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org



On 14/02/2017 11:25, Markus Armbruster wrote:
> QemuOpts has its own code to convert strings to numbers, and being
> QemuOpts, it gets it wrong.  util/cutils is less wrong.  Fix it up
> some, and reuse it for QemuOpts.

Nice.  I only had a couple minor remarks.

Paolo

> Markus Armbruster (24):
>   tests/test-qemu-opts: Cover qemu_opts_parse()
>   QemuOpts: Assert value string isn't null
>   tests/test-cutils: Add missing qemu_strtol()... endptr checks
>   tests/test-cutils: Clean up qemu_strtoul() result checks
>   util/cutils: Rewrite documentation of qemu_strtol() & friends
>   util/cutils: Rename qemu_strtoll(), qemu_strtoull()
>   util/cutils: Clean up variable names around qemu_strtol()
>   util/cutils: Clean up control flow around qemu_strtol() a bit
>   QemuOpts: Fix to reject numbers that overflow uint64_t
>   tests/test-cutils: Add missing qemu_strtosz()... endptr checks
>   tests/test-cutils: Cover qemu_strtosz() invalid input
>   tests/test-cutils: Cover qemu_strtosz() with trailing crap
>   tests/test-cutils: Cover qemu_strtosz() around range limits
>   util/cutils: New qemu_strtosz_metric()
>   util/cutils: Rename qemu_strtosz() to qemu_strtosz_mebi()
>   util/cutils: New qemu_strtosz()
>   util/cutils: Drop QEMU_STRTOSZ_DEFSUFFIX_* macros
>   tests/test-cutils: Use qemu_strtosz() more often
>   tests/test-cutils: Drop suffix from test_qemu_strtosz_simple()
>   qemu-img: Wrap cvtnum() around qemu_strtosz()
>   util/cutils: Let qemu_strtosz*() optionally reject trailing crap
>   util/cutils: Return qemu_strtosz*() error and value separately
>   util/cutils: Change qemu_strtosz*() from int64_t to uint64_t
>   QemuOpts: Fix checking of sizes for overflow and trailing crap
