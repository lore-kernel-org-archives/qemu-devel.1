Received: from eggs.gnu.org ([2001:4830:134:3::10]:51653)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1eqEl4-0002Ey-M7
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 04:07:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1eqEkz-0006bt-OV
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 04:07:42 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37038 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <drjones@redhat.com>) id 1eqEkz-0006bd-J7
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 04:07:37 -0500
Date: Mon, 26 Feb 2018 10:07:34 +0100
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20180226090734.gawjrlkorbimn6ze@kamzik.brq.redhat.com>
References: <20180223215858.16987-1-wei@redhat.com>
	<20180223215858.16987-3-wei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180223215858.16987-3-wei@redhat.com>
Subject: Re: [Qemu-devel] [PATCH V5 2/4] tests/migration: Convert the boot
 block compilation script into Makefile
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

On Fri, Feb 23, 2018 at 03:58:56PM -0600, Wei Huang wrote:
> The x86 boot block header currently is generated with a shell script.
> To better support other CPUs (e.g. aarch64), we convert the script
> into Makefile. This allows us to 1) support cross-compilation easily,
> and 2) avoid creating a script file for every architecture.
> 
> Signed-off-by: Wei Huang <wei@redhat.com>
> ---
>  tests/migration/Makefile                 | 36 ++++++++++++++++++++++++++++++++
>  tests/migration/rebuild-x86-bootblock.sh | 33 -----------------------------
>  tests/migration/x86-a-b-bootblock.h      |  2 +-
>  tests/migration/x86-a-b-bootblock.s      |  5 ++---
>  4 files changed, 39 insertions(+), 37 deletions(-)
>  create mode 100644 tests/migration/Makefile
>  delete mode 100755 tests/migration/rebuild-x86-bootblock.sh
>

Reviewed-by: Andrew Jones <drjones@redhat.com>
