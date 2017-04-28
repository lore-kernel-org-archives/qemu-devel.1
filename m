Received: from eggs.gnu.org ([2001:4830:134:3::10]:47116)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1d3w8L-000642-Vf
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 22:59:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1d3w8H-0008Ch-2K
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 22:59:50 -0400
References: <20170428022329.30726-1-eblake@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <3f6725f5-3ec7-5a2f-0476-47bd2ae840a6@redhat.com>
Date: Fri, 28 Apr 2017 04:58:58 +0200
MIME-Version: 1.0
In-Reply-To: <20170428022329.30726-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] tests: Ignore another built executable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, dgilbert@redhat.com

On 28.04.2017 04:23, Eric Blake wrote:
> Commit 78f86a2b7 added a new test, but forgot to exclude the built
> binary from version control.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  tests/.gitignore | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tests/.gitignore b/tests/.gitignore
> index 5ab00a9..40c2e3e 100644
> --- a/tests/.gitignore
> +++ b/tests/.gitignore
> @@ -40,6 +40,7 @@ test-crypto-tlssession-server/
>  test-crypto-xts
>  test-cutils
>  test-hbitmap
> +test-hmp
>  test-int128
>  test-iov
>  test-io-channel-buffer

Ah, ok, I'm only doing out-of-tree builds, that's why I did not notice
this...

Reviewed-by: Thomas Huth <thuth@redhat.com>
