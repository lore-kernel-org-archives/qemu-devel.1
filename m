Received: from eggs.gnu.org ([2001:4830:134:3::10]:51326)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fFigy-0007ul-1s
	for qemu-devel@nongnu.org; Mon, 07 May 2018 12:08:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fFigt-0005IA-Uk
	for qemu-devel@nongnu.org; Mon, 07 May 2018 12:08:48 -0400
Received: from 12.mo3.mail-out.ovh.net ([188.165.41.191]:60435)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fFigt-0005Hy-NA
	for qemu-devel@nongnu.org; Mon, 07 May 2018 12:08:43 -0400
Received: from player738.ha.ovh.net (unknown [10.109.120.75])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id 8D19B1B6AAF
	for <qemu-devel@nongnu.org>; Mon,  7 May 2018 18:08:41 +0200 (CEST)
Date: Mon, 7 May 2018 18:08:35 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180507180835.4b7b9222@bahia.lan>
In-Reply-To: <20180507134806.33043-1-leandro.lupori@gmail.com>
References: <20180507134806.33043-1-leandro.lupori@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH] Allow PIR read in privileged
 mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: luporl <leandro.lupori@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

Hi Leandro,

You seem to be a newcomer to QEMU development. Welcome ! :)

Please find a few remarks below, so that you can improve your patch submission
skills.

First, it is good practice to provide the subsystem name in the subject, as
stated in:

 https://wiki.qemu.org/Contribute/SubmitAPatch#Write_a_meaningful_commit_message

ie,

[PATCH] target/ppc: Allow PIR read in privileged mode


Then, this is your second shot for this patch, so you should have added:

- a version tag, as stated in:

 https://wiki.qemu.org/Contribute/SubmitAPatch#When_resending_patches_add_a_version_tag

 ie,

 [PATCH v2] target/ppc: Allow PIR read in privileged mode

- a summary of changes since previous versions, as stated in:

 https://wiki.qemu.org/Contribute/SubmitAPatch#Include_version_history_in_patchset_revisions

 ie,

Signed-off-by: Leandro Lupori <leandro.lupori@gmail.com>
Reviewed-by: Jose Ricardo Ziviani <joserz@linux.ibm.com>
---
Changes in v2:
 - added my Signed-off-by, maintainers CC and Jose's Reviewed-by tags


Pay attention that this summary of changes MUST be added below the '---',
because it is only relevant for the review process and we don't want to
record in the git changelog.

On Mon,  7 May 2018 10:48:06 -0300
luporl <leandro.lupori@gmail.com> wrote:

> According to PowerISA, the PIR register should be readable in privileged
> mode also, not only in hypervisor privileged mode.
> 

True.

PowerISA 3.0 - 4.3.3 Processor Identification Register

"Read access to the PIR is privileged; write access is not provided."

> Cc: David Gibson <david@gibson.dropbear.id.au>
> Cc: Alexander Graf <agraf@suse.de>
> Cc: qemu-ppc@nongnu.org
> Signed-off-by: Leandro Lupori <leandro.lupori@gmail.com>
> Reviewed-by: Jose Ricardo Ziviani <joserz@linux.ibm.com>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  target/ppc/translate_init.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
> index a72be6d121..7b56e3ffb9 100644
> --- a/target/ppc/translate_init.c
> +++ b/target/ppc/translate_init.c
> @@ -7816,7 +7816,7 @@ static void gen_spr_book3s_ids(CPUPPCState *env)
>      /* Processor identification */
>      spr_register_hv(env, SPR_PIR, "PIR",
>                   SPR_NOACCESS, SPR_NOACCESS,
> -                 SPR_NOACCESS, SPR_NOACCESS,
> +                 &spr_read_generic, SPR_NOACCESS,
>                   &spr_read_generic, NULL,
>                   0x00000000);
>      spr_register_hv(env, SPR_HID0, "HID0",
