Received: from eggs.gnu.org ([2001:4830:134:3::10]:45773)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anatol.pomozov@gmail.com>) id 1dIecN-0003EF-Rx
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 13:19:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anatol.pomozov@gmail.com>) id 1dIecN-0001oG-2b
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 13:19:39 -0400
Received: from mail-it0-x244.google.com ([2607:f8b0:4001:c0b::244]:36654)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <anatol.pomozov@gmail.com>)
	id 1dIecM-0001oA-U7
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 13:19:38 -0400
Received: by mail-it0-x244.google.com with SMTP id i206so1764002ita.3
	for <qemu-devel@nongnu.org>; Wed, 07 Jun 2017 10:19:38 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170607044148.10481-1-anatol.pomozov@gmail.com>
References: <20170607044148.10481-1-anatol.pomozov@gmail.com>
From: Anatol Pomozov <anatol.pomozov@gmail.com>
Date: Wed, 7 Jun 2017 10:19:37 -0700
Message-ID: <CAOMFOmXKgPiGwxieXfXXM=B9yodTaMU0zwB8k_-m_Jj37kv0LA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] Remove restriction that prevents bootimg
 elf64 images
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, avi@redhat.com, adam@os.inf.tu-dresden.de, vlad.lungu@windriver.com

+ more folks who made changes to hw/i386/multiboot.c

On Tue, Jun 6, 2017 at 9:41 PM, Anatol Pomozov <anatol.pomozov@gmail.com> wrote:
> It is possible to create a 64 bit elf image that has valid multiboot header.
> qemu should be able to boot such images.
>
> Tested with homemade 64bit OS - now it boots fine with 'qemu -kernel'
> and as a grub image.
>
> Signed-off-by: Anatol Pomozov <anatol.pomozov@gmail.com>
> ---
>  hw/i386/multiboot.c | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/hw/i386/multiboot.c b/hw/i386/multiboot.c
> index 663f35a658..cf1b4f5fb3 100644
> --- a/hw/i386/multiboot.c
> +++ b/hw/i386/multiboot.c
> @@ -192,11 +192,6 @@ int load_multiboot(FWCfgState *fw_cfg,
>          int kernel_size;
>          fclose(f);
>
> -        if (((struct elf64_hdr*)header)->e_machine == EM_X86_64) {
> -            fprintf(stderr, "Cannot load x86-64 image, give a 32bit one.\n");
> -            exit(1);
> -        }
> -
>          kernel_size = load_elf(kernel_filename, NULL, NULL, &elf_entry,
>                                 &elf_low, &elf_high, 0, I386_ELF_MACHINE,
>                                 0, 0);
> --
> 2.13.1
>
