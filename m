Received: from eggs.gnu.org ([2001:4830:134:3::10]:45008)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fwlOG-0005qj-LP
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 05:43:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fwlOD-0003ic-Og
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 05:43:24 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40744 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fwlOD-0003iI-Hq
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 05:43:21 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <1535778675-32170-3-git-send-email-wei@redhat.com> (Wei Huang's
	message of "Sat, 1 Sep 2018 01:11:13 -0400")
References: <1535778675-32170-1-git-send-email-wei@redhat.com>
	<1535778675-32170-3-git-send-email-wei@redhat.com>
Reply-To: quintela@redhat.com
Date: Mon, 03 Sep 2018 11:43:16 +0200
Message-ID: <87tvn63oi3.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH V8 2/4] tests/migration: Support cross
 compilation in generating boot header file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Huang <wei@redhat.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, lvivier@redhat.com, drjones@redhat.com, dgilbert@redhat.com

Wei Huang <wei@redhat.com> wrote:
> Recently a new configure option, CROSS_CC_GUEST, was added to
> $(TARGET)-softmmu/config-target.mak to support TCG-related tests. This
> patch tries to leverage this option to support cross compilation when the
> migration boot block file is being re-generated:
>
>  * The x86_64 related files are moved to a new sub-dir (named ./x86_64).
>  * A new top-layer Makefile is created in tests/migration/ directory.
>    This Makefile searches and parses CROSS_CC_GUEST to generate CROSS_PREFIX.
>    The CROSS_PREFIX, if available, is then passed to migration/$ARCH/Makefile.
>
> Signed-off-by: Wei Huang <wei@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>
