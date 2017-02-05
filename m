Received: from eggs.gnu.org ([2001:4830:134:3::10]:53335)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1caRa2-0008B5-Tf
	for qemu-devel@nongnu.org; Sun, 05 Feb 2017 13:30:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1caRZy-0003fy-0y
	for qemu-devel@nongnu.org; Sun, 05 Feb 2017 13:30:30 -0500
References: <20170203170729.12399-1-pbonzini@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <1c3e6016-1a6d-6d97-ce0b-4afb3e9b981b@vivier.eu>
Date: Sun, 5 Feb 2017 19:30:18 +0100
MIME-Version: 1.0
In-Reply-To: <20170203170729.12399-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH] test-vmstate: remove
 yield_until_fd_readable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org

Le 03/02/2017 à 18:07, Paolo Bonzini a écrit :
> The function is not needed anymore now that migration is built on
> top of QIOChannel.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  tests/test-vmstate.c | 11 -----------
>  1 file changed, 11 deletions(-)
> 
> diff --git a/tests/test-vmstate.c b/tests/test-vmstate.c
> index 9d87faf..0c2af4d 100644
> --- a/tests/test-vmstate.c
> +++ b/tests/test-vmstate.c
> @@ -33,17 +33,6 @@
>  static char temp_file[] = "/tmp/vmst.test.XXXXXX";
>  static int temp_fd;
>  
> -/* Fake yield_until_fd_readable() implementation so we don't have to pull the
> - * coroutine code as dependency.
> - */
> -void yield_until_fd_readable(int fd)
> -{
> -    fd_set fds;
> -    FD_ZERO(&fds);
> -    FD_SET(fd, &fds);
> -    select(fd + 1, &fds, NULL, NULL, NULL);
> -}
> -
>  
>  /* Duplicate temp_fd and seek to the beginning of the file */
>  static QEMUFile *open_test_file(bool write)
> 

Tested-by: Laurent Vivier <laurent@vivier.eu>
