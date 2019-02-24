Received: from eggs.gnu.org ([209.51.188.92]:44065)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amagdy.afifi@gmail.com>) id 1gxooy-0004NI-Tf
	for qemu-devel@nongnu.org; Sun, 24 Feb 2019 03:07:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amagdy.afifi@gmail.com>) id 1gxoox-0002BQ-R1
	for qemu-devel@nongnu.org; Sun, 24 Feb 2019 03:07:36 -0500
MIME-Version: 1.0
References: <20190222162555.13764-1-amagdy.afifi@gmail.com>
	<20190222162555.13764-2-amagdy.afifi@gmail.com>
	<8f36a26e-7e20-1b9c-18bd-a5ce4b3d9c14@redhat.com>
In-Reply-To: <8f36a26e-7e20-1b9c-18bd-a5ce4b3d9c14@redhat.com>
From: Amed Magdy <amagdy.afifi@gmail.com>
Date: Sun, 24 Feb 2019 10:07:23 +0200
Message-ID: <CAKV=O7=JK4t7VxQ74LvjVpM9+TQ6MJ0hA9_XX40ud7OEsh30hQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] riscv: Add proper alignment check and
 pending 'C' extension upon misa writes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, sagark@eecs.berkeley.edu, kbastian@mail.uni-paderborn.de, palmer@sifive.com, mjc@sifive.com, Alistair.Francis@wdc.com

Thank you so much, Eric.

Sorry about this unclear description.
I forgot to fix user name in git configuration before submitting the patch.

Sorry about any inconvenience.
Thanks,
Ahmed

On Sat, 23 Feb 2019 at 23:46, Eric Blake <eblake@redhat.com> wrote:

> On 2/22/19 10:25 AM, amagdy.afifi@gmail.com wrote:
> > From: ahmed_magdy <amagdy.afifi@gmail.com>
> >
> > Signed-off-by: ahmed_magdy <amagdy.afifi@gmail.com>
>
> This appears to be your first contribution to qemu. Welcome to the
> community!
>
> Typically, a Signed-off-by designation should be a proper name (what you
> would sign a legal document with, as it has a legal significance on your
> right to contribute the code).  Using all lowercase and _ instead of
> space looks like a username, and while I am not one to tell you it can't
> be a legal name, it is unusual enough to at least raise my suspicions.
>
> Furthermore, your commit message doesn't give any details beyond the
> "what" in the subject line. The body of the commit message should
> explain the "why" (what bug are you fixing, how to reproduce it), so
> that a reviewer stands a chance of determining if the code matches the
> description you gave, and if the issue you describe really does warrant
> the inclusion of your patch.  You gave a brief "why" in your cover letter:
>
> "I'm submiting this patch to properly check the next instruction
> alignment and scheduale compression extenstion enable upon 'MISA'
> register writes to later aligned instruction through exporting next
> instruction 'pc' to riscv cpu state"
>
> where it would be wise to include an improved version of that text with
> this commit proper (since the cover letter does not get applied to git).
>  For that matter, when sending a single patch, a cover letter is
> optional (it is only mandatory when sending a multi-patch series).
>
> For more patch submission hints, see:
> https://wiki.qemu.org/Contribute/SubmitAPatch
>
> --
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3226
> Virtualization:  qemu.org | libvirt.org
>
