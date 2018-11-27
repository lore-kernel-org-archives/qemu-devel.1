Received: from eggs.gnu.org ([2001:4830:134:3::10]:36886)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gRX2v-0005m0-Km
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 01:40:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gRX2s-0005Jb-E6
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 01:40:33 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <1543295605-2709-1-git-send-email-liq3ea@gmail.com>
Date: Tue, 27 Nov 2018 07:40:23 +0100
In-Reply-To: <1543295605-2709-1-git-send-email-liq3ea@gmail.com> (Li Qiang's
	message of "Mon, 26 Nov 2018 21:13:25 -0800")
Message-ID: <878t1ff2g8.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] target: hax: fix errors in comment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@gmail.com>
Cc: pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, laurent@vivier.eu, alex.bennee@linaro.org, philmd@redhat.com, qemu-trivial@nongnu.org, qemu-devel@nongnu.org

Li Qiang <liq3ea@gmail.com> writes:

> Cc: qemu-trivial@nongnu.org
>
> Signed-off-by: Li Qiang <liq3ea@gmail.com>
> ---
>  target/i386/hax-all.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/i386/hax-all.c b/target/i386/hax-all.c
> index 502ce6f0af..70213ebcf5 100644
> --- a/target/i386/hax-all.c
> +++ b/target/i386/hax-all.c
> @@ -205,7 +205,7 @@ int hax_vcpu_destroy(CPUState *cpu)
>      }
>  
>      /*
> -     * 1. The hax_tunnel is also destroied when vcpu destroy
> +     * 1. The hax_tunnel is also destroyed when vcpu is destroy

when vcpu is destroyed

>       * 2. close fd will cause hax module vcpu be cleaned
>       */
>      hax_close_fd(vcpu->fd);
