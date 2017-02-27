Received: from eggs.gnu.org ([2001:4830:134:3::10]:48323)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ciPUo-0003HS-Db
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 12:54:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ciPUn-0006xu-HJ
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 12:54:02 -0500
Received: from mail-wr0-x230.google.com ([2a00:1450:400c:c0c::230]:36191)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ciPUn-0006xV-7f
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 12:54:01 -0500
Received: by mail-wr0-x230.google.com with SMTP id u108so27672766wrb.3
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 09:53:59 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <76dcc6f2-f888-ad42-eb72-56940b5a7f87@redhat.com>
References: <1485333658-23035-1-git-send-email-thuth@redhat.com>
	<0eca8185-8e94-46f8-6b7a-36c4a21bc28d@redhat.com>
	<d40da5e8-c48f-a35b-6c3c-b6164ae38040@redhat.com>
	<76dcc6f2-f888-ad42-eb72-56940b5a7f87@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Feb 2017 17:53:37 +0000
Message-ID: <CAFEAcA_k_7wCaUv8eRNvpNVeh7JExEMx_69De5rVs1Cu9eES+Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH] null-machine: Add support for the
 "-kernel" parameter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Marcel Apfelbaum <marcel@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>, Laurent Vivier <laurent@vivier.eu>, Alistair Francis <alistair.francis@xilinx.com>

On 27 February 2017 at 17:49, Thomas Huth <thuth@redhat.com> wrote:
> On 27.02.2017 14:16, Marcel Apfelbaum wrote:
>> Why do we need the "-kernel" parameter for the null-machine? I mean -
>> what are the use cases?
>
> Since it is now possible to instantiate a CPU and memory with the
> null-machine, you can use it as a simple instruction set simulator board
> now. Start QEMU with something like "-M none -cpu xxx -m 1G -S -s" and
> then connect a remote GDB to interact with the emulated CPU. This is
> e.g. useful for CPU models that do not have a matching emulated machine
> yet. Adding the possibility to use the "-kernel" parameter for this,
> too, would make things a little bit more comfortable on certain targets,
> since you then don't have to fiddle with the generic-loader device.

But it still won't do the expected magic -kernel does for you on x86
or ARM or..., so it's just confusing to use the same option. We have
a command line option for "just load the binary please", and that's
the generic-loader. If you think generic-loader's syntax is a bit
tedious you could argue for a convenience option that was syntactic
sugar for it (in the same way that -hda is sugar for -drive and
-device options), but that shouldn't be limited to the null-machine.

thanks
-- PMM
