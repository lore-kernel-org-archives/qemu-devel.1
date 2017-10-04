Received: from eggs.gnu.org ([2001:4830:134:3::10]:35654)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dzgI5-0008KN-2M
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 05:48:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dzgI1-0003RU-V8
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 05:48:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35666)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dzgI1-0003QK-Pv
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 05:48:29 -0400
References: <1507109497-5365-1-git-send-email-thuth@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f7a56c6d-c66b-7ee5-48f1-e33c140c7bce@redhat.com>
Date: Wed, 4 Oct 2017 11:48:24 +0200
MIME-Version: 1.0
In-Reply-To: <1507109497-5365-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-web PATCH] Add a blog post about the release
 of version 2.10.1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>

On 04/10/2017 11:31, Thomas Huth wrote:
> Content is based on Michael Roth's announce e-mail for this release.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  _posts/2017-10-04-qemu-2-10-1.md | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>  create mode 100644 _posts/2017-10-04-qemu-2-10-1.md
> 
> diff --git a/_posts/2017-10-04-qemu-2-10-1.md b/_posts/2017-10-04-qemu-2-10-1.md
> new file mode 100644
> index 0000000..6fa00fa
> --- /dev/null
> +++ b/_posts/2017-10-04-qemu-2-10-1.md
> @@ -0,0 +1,21 @@
> +---
> +layout: post
> +title:  "QEMU stable version 2.10.1 released"
> +date:   2017-10-04 11:00:00 +0200
> +categories: [releases, 'qemu 2.10']
> +---
> +We are pleased to announce that the QEMU v2.10.1 stable release
> +is now available! You can grab the tarball from our
> +[download page](https://www.qemu.org/download/#source).
> +
> +Version 2.10.1 is now tagged in the official
> +[qemu.git repository](https://git.qemu.org/?p=qemu.git;a=shortlog;h=v2.10.1)
> +(where you can also find the changelog with details), and the
> +[stable-2.10 branch](https://git.qemu.org/?p=qemu.git;a=shortlog;h=refs/heads/stable-2.10)
> +has been updated accordingly.
> +
> +Apart from the normal range of general fixes, this update contains security
> +fixes addressing guest-induced crashing of host QEMU process (CVE-2017-13672,
> +CVE-2017-13673) and possible code injection into host QEMU process via a
> +crafted multiboot ELF kernel when specified directly via QEMU command-line
> +option (CVE-2017-14167). Please update accordingly.
> 

Looks good, thanks!

Paolo
