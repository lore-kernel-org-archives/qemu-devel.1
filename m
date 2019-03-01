Received: from eggs.gnu.org ([209.51.188.92]:44502)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1gzluv-0008BZ-Ft
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 12:25:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1gzljV-0007Mf-Fk
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 12:14:02 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33158)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1gzljN-0007D1-MF
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 12:13:57 -0500
Received: by mail-wr1-f65.google.com with SMTP id i12so26736304wrw.0
	for <qemu-devel@nongnu.org>; Fri, 01 Mar 2019 09:13:48 -0800 (PST)
Date: Fri, 1 Mar 2019 18:13:43 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
Message-ID: <20190301171343.dyuqan3ok6gzuotw@steredhat>
References: <1549390526-24246-1-git-send-email-pbonzini@redhat.com>
	<1549390526-24246-14-git-send-email-pbonzini@redhat.com>
	<87sgw6k02i.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87sgw6k02i.fsf@zen.linaroharston>
Subject: Re: [Qemu-devel] [PULL 13/76] pvh: Add x86/HVM direct boot ABI
 header file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org

On Fri, Mar 01, 2019 at 04:53:57PM +0000, Alex Bennée wrote:
> 
> Paolo Bonzini <pbonzini@redhat.com> writes:
> 
> > From: Liam Merwick <Liam.Merwick@oracle.com>
> >
> > The x86/HVM direct boot ABI permits Qemu to be able to boot directly
> > into the uncompressed Linux kernel binary with minimal firmware involvement.
> >
> > 	https://xenbits.xen.org/docs/unstable/misc/pvh.html
> >
> > This commit adds the header file that defines the start_info struct
> > that needs to be populated in order to use this ABI.
> >
> > The canonical version of start_info.h is in the Xen codebase.
> > (like QEMU, the Linux kernel uses a copy as well).
> >
> > Signed-off-by: Liam Merwick <Liam.Merwick@oracle.com>
> > Reviewed-by: Konrad Rzeszutek Wilk <Konrad.Wilk@oracle.com>
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> 
> This has changed behaviour of a boot. Previously:
> 
>   qemu-system-i386 -serial mon:stdio -nographic -device \
>      isa-debugcon,chardev=serial0 -kernel ./tests/hello
> 

Hi Alex,
is your image in multiboot format?

I sent a patch few weeks ago that fix the loading of multiboot images:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg596424.html

Thanks,
Stefano

> would boot seabios which then loads the -kernel. Now we get:
> 
>   qemu-system-i386: Error loading uncompressed kernel without PVH ELF Note
> 
> I'm personally not overly concerned (and being able to boot directly
> sounds like a win for my test case). However is this likely to break
> anybodies existing workflow?
> 
> Are there any examples of the minimum setup for a directly booted i386
> kernel image anywhere?
> 
> --
> Alex Bennée
> 

-- 

Stefano Garzarella
Software Engineer @ Red Hat
