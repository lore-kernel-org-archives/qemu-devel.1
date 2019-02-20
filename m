Received: from eggs.gnu.org ([209.51.188.92]:60988)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gwXvt-0003ZF-HU
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 14:53:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gwXvr-00030a-Iw
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 14:53:29 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:40585)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gwXvr-0002yR-Dj
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 14:53:27 -0500
Received: by mail-qt1-f194.google.com with SMTP id j36so28684533qta.7
	for <qemu-devel@nongnu.org>; Wed, 20 Feb 2019 11:53:26 -0800 (PST)
Date: Wed, 20 Feb 2019 14:53:22 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190220145309-mutt-send-email-mst@kernel.org>
References: <1550677621-10139-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1550677621-10139-1-git-send-email-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] fixup! vhost-user-test: create a main loop
 per TestServer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org

On Wed, Feb 20, 2019 at 04:47:01PM +0100, Paolo Bonzini wrote:
> Fix a hang that is only latent until qgraph is merged.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

I squashed this in, thanks!

> ---
>  tests/vhost-user-test.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/vhost-user-test.c b/tests/vhost-user-test.c
> index 33030e0..527d3b3 100644
> --- a/tests/vhost-user-test.c
> +++ b/tests/vhost-user-test.c
> @@ -557,8 +557,6 @@ static void test_server_free(TestServer *server)
>      while (g_main_context_pending(NULL)) {
>          g_main_context_iteration(NULL, TRUE);
>      }
> -    g_main_loop_unref(server->loop);
> -    g_main_context_unref(server->context);
>  
>      qemu_chr_fe_deinit(&server->chr, true);
>  
> @@ -580,6 +578,8 @@ static void test_server_free(TestServer *server)
>      g_assert(server->bus);
>      qpci_free_pc(server->bus);
>  
> +    g_main_loop_unref(server->loop);
> +    g_main_context_unref(server->context);
>      g_free(server);
>  }
>  
> -- 
> 1.8.3.1
