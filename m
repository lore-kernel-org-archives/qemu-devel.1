Received: from eggs.gnu.org ([209.51.188.92]:40310)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gzlQ9-0006je-1v
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 11:54:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gzlQ8-0003Sg-7L
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 11:54:01 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:36640)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gzlQ8-0003Ry-07
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 11:54:00 -0500
Received: by mail-wr1-x442.google.com with SMTP id o17so26638807wrw.3
	for <qemu-devel@nongnu.org>; Fri, 01 Mar 2019 08:53:59 -0800 (PST)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	t14sm23243012wrr.49.2019.03.01.08.53.57 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Fri, 01 Mar 2019 08:53:57 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 6669A1FF82
	for <qemu-devel@nongnu.org>; Fri,  1 Mar 2019 16:53:57 +0000 (UTC)
References: <1549390526-24246-1-git-send-email-pbonzini@redhat.com>
	<1549390526-24246-14-git-send-email-pbonzini@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <1549390526-24246-14-git-send-email-pbonzini@redhat.com>
Date: Fri, 01 Mar 2019 16:53:57 +0000
Message-ID: <87sgw6k02i.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
To: qemu-devel@nongnu.org


Paolo Bonzini <pbonzini@redhat.com> writes:

> From: Liam Merwick <Liam.Merwick@oracle.com>
>
> The x86/HVM direct boot ABI permits Qemu to be able to boot directly
> into the uncompressed Linux kernel binary with minimal firmware involveme=
nt.
>
> 	https://xenbits.xen.org/docs/unstable/misc/pvh.html
>
> This commit adds the header file that defines the start_info struct
> that needs to be populated in order to use this ABI.
>
> The canonical version of start_info.h is in the Xen codebase.
> (like QEMU, the Linux kernel uses a copy as well).
>
> Signed-off-by: Liam Merwick <Liam.Merwick@oracle.com>
> Reviewed-by: Konrad Rzeszutek Wilk <Konrad.Wilk@oracle.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

This has changed behaviour of a boot. Previously:

  qemu-system-i386 -serial mon:stdio -nographic -device \
     isa-debugcon,chardev=3Dserial0 -kernel ./tests/hello

would boot seabios which then loads the -kernel. Now we get:

  qemu-system-i386: Error loading uncompressed kernel without PVH ELF Note

I'm personally not overly concerned (and being able to boot directly
sounds like a win for my test case). However is this likely to break
anybodies existing workflow?

Are there any examples of the minimum setup for a directly booted i386
kernel image anywhere?

--
Alex Benn=C3=A9e
