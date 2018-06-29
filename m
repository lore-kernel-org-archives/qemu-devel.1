Received: from eggs.gnu.org ([2001:4830:134:3::10]:43494)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fYvKL-0003z7-Pk
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 11:28:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fYvKK-0000GF-D0
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 11:28:49 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:33769)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fYvKK-0000F3-5O
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 11:28:48 -0400
Received: by mail-oi0-x243.google.com with SMTP id c6-v6so8818321oiy.0
	for <qemu-devel@nongnu.org>; Fri, 29 Jun 2018 08:28:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <489d8470-c12f-a441-4e87-b2b3013a3ab8@vivier.eu>
References: <20180626165658.31394-1-peter.maydell@linaro.org>
	<20180626165658.31394-24-peter.maydell@linaro.org>
	<50e46f22-1e3d-10ce-5b5b-a10af49a95f1@vivier.eu>
	<CAFEAcA8141WC556H1fZLM4AEaz62o4qb7JOOVB-+75N9vugi+g@mail.gmail.com>
	<a46a8b06-c780-0c22-b9f7-8eaae73dd26d@vivier.eu>
	<CAFEAcA8gKWG9O7rjhC1+n_Bqce+CGQvUEiM+mc7wu-1C7no2ug@mail.gmail.com>
	<489d8470-c12f-a441-4e87-b2b3013a3ab8@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 29 Jun 2018 16:28:26 +0100
Message-ID: <CAFEAcA-Md2yKBcxqapmmROE5mX8eg9z_X=80Uk=bOjzhPft8Tw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 23/32] tcg: Support MMU protection regions
 smaller than TARGET_PAGE_SIZE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 28 June 2018 at 23:26, Laurent Vivier <laurent@vivier.eu> wrote:
> Le 28/06/2018 =C3=A0 22:05, Peter Maydell a =C3=A9crit :
>> Do you have a repro case (images, command line) that I can
>> use to investigate ?
> - checkout the branch q800-dev-part1 from
>   git://github.com/vivier/qemu-m68k.git
>
> - configure and build
>
>  './configure' '--target-list=3Dm68k-softmmu' '--enable-debug' \
>                '--enable-debug-tcg' '--enable-debug-info'
>
>   my gcc is from Fedora 27, version 7.3.1 20180303 (Red Hat 7.3.1-5)
>
> - get the kernel from the debian installer:
>
> wget
> https://cdimage.debian.org/mirror/cdimage/ports/9.0/m68k/iso-cd/debian-9.=
0-m68k-NETINST-1.iso
>
> guestfish --add debian-9.0-m68k-NETINST-1.iso --ro \
>           --mount /dev/sda:/ <<_EOF_
> copy-out /install/kernels/vmlinux-4.15.0-2-m68k .
> _EOF_
>
> - and run
>
> ./m68k-softmmu/qemu-system-m68k -M q800 \
>     -serial none -serial mon:stdio \
>     -kernel vmlinux-4.15.0-2-m68k \
>     -nographic

What is this testcase supposed to print when it works?
I tried reverting 55df6fcf5476b44bc1b9, but that just prints
"ABCFGHIJK" and then nothing else.

thanks
-- PMM
