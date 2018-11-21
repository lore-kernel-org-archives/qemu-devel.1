Received: from eggs.gnu.org ([2001:4830:134:3::10]:53283)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gPWij-0000Fg-GP
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 12:55:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gPWii-00083u-QY
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 12:55:25 -0500
References: <1542261954-4060-1-git-send-email-liq3ea@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <da889f34-09b3-6c01-050a-778b86a731fa@redhat.com>
Date: Wed, 21 Nov 2018 18:55:18 +0100
MIME-Version: 1.0
In-Reply-To: <1542261954-4060-1-git-send-email-liq3ea@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] target: hax: replace g_malloc with
 g_malloc0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@gmail.com>, rth@twiddle.net, ehabkost@redhat.com, laurent@vivier.eu
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org

On 15/11/18 07:05, Li Qiang wrote:
> And also the g_malloc doesn't need check return value,
> remove it.
> 
> Cc: qemu-trivial@nongnu.org
> 
> Signed-off-by: Li Qiang <liq3ea@gmail.com>
> ---
>  target/i386/hax-all.c | 15 +++------------
>  1 file changed, 3 insertions(+), 12 deletions(-)
> 
> diff --git a/target/i386/hax-all.c b/target/i386/hax-all.c
> index d2e512856b..a460c605af 100644
> --- a/target/i386/hax-all.c
> +++ b/target/i386/hax-all.c
> @@ -154,13 +154,7 @@ int hax_vcpu_create(int id)
>          return 0;
>      }
>  
> -    vcpu = g_malloc(sizeof(struct hax_vcpu_state));
> -    if (!vcpu) {
> -        fprintf(stderr, "Failed to alloc vcpu state\n");
> -        return -ENOMEM;
> -    }
> -
> -    memset(vcpu, 0, sizeof(struct hax_vcpu_state));
> +    vcpu = g_malloc0(sizeof(struct hax_vcpu_state));
>  
>      ret = hax_host_create_vcpu(hax_global.vm->fd, id);
>      if (ret) {
> @@ -250,11 +244,8 @@ struct hax_vm *hax_vm_create(struct hax_state *hax)
>          return hax->vm;
>      }
>  
> -    vm = g_malloc(sizeof(struct hax_vm));
> -    if (!vm) {
> -        return NULL;
> -    }
> -    memset(vm, 0, sizeof(struct hax_vm));
> +    vm = g_malloc0(sizeof(struct hax_vm));
> +
>      ret = hax_host_create_vm(hax, &vm_id);
>      if (ret) {
>          fprintf(stderr, "Failed to create vm %x\n", ret);
> 

Queued, thanks.

Paolo
