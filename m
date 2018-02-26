Received: from eggs.gnu.org ([2001:4830:134:3::10]:50960)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1eqEjX-00019q-Qi
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 04:06:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1eqEjS-0005We-Tr
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 04:06:07 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41598 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <drjones@redhat.com>) id 1eqEjS-0005W8-Ox
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 04:06:02 -0500
Date: Mon, 26 Feb 2018 10:05:59 +0100
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20180226090559.5sle75msmpf7ypyy@kamzik.brq.redhat.com>
References: <20180223215858.16987-1-wei@redhat.com>
	<20180223215858.16987-4-wei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180223215858.16987-4-wei@redhat.com>
Subject: Re: [Qemu-devel] [PATCH V5 3/4] tests/migration: Add migration-test
 header file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Huang <wei@redhat.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, dgilbert@redhat.com, quintela@redhat.com

On Fri, Feb 23, 2018 at 03:58:57PM -0600, Wei Huang wrote:
> This patch moves the settings related migration-test from the
> migration-test.c file to a seperate header file. It also renames the
> x86-a-b-bootblock.s file extension from .s to .S, allowing gcc
> pre-processor to include the C-style header file correctly.
> 
> Signed-off-by: Wei Huang <wei@redhat.com>
> ---
>  tests/migration-test.c                             | 28 +++++++++++-----------
>  tests/migration/Makefile                           |  4 ++--
>  tests/migration/migration-test.h                   | 18 ++++++++++++++
>  .../{x86-a-b-bootblock.s => x86-a-b-bootblock.S}   |  7 +++---
>  tests/migration/x86-a-b-bootblock.h                |  2 +-
>  5 files changed, 39 insertions(+), 20 deletions(-)
>  create mode 100644 tests/migration/migration-test.h
>  rename tests/migration/{x86-a-b-bootblock.s => x86-a-b-bootblock.S} (94%)
>

I gave this my r-b last review. Do I have to review it again? 
