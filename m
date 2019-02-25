Received: from eggs.gnu.org ([209.51.188.92]:35664)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gyDa1-0004M3-8C
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 05:33:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gyDZx-0007i0-IT
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 05:33:47 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:51235)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1gyDZx-0007Ih-0V
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 05:33:45 -0500
Received: by mail-wm1-x341.google.com with SMTP id n19so7484063wmi.1
	for <qemu-devel@nongnu.org>; Mon, 25 Feb 2019 02:33:38 -0800 (PST)
MIME-Version: 1.0
References: <VI1PR0602MB32452A8FD128F63FFAC0CEADA4920@VI1PR0602MB3245.eurprd06.prod.outlook.com>
	<VI1PR0602MB32453A8B5CBC0308C7D18F1DA47E0@VI1PR0602MB3245.eurprd06.prod.outlook.com>
	<CAJSP0QVxaW3tezjBN9owJHsxzE9h8_qcaeRr5zHHKxKJOeFnkQ@mail.gmail.com>
	<CAJSP0QVXoZJ9MJ0qp4RM_m2fGJ8iFSyJMAU_X7mdiQvpOK59KA@mail.gmail.com>
	<VI1PR0602MB324516419266A934FE7759C6A47E0@VI1PR0602MB3245.eurprd06.prod.outlook.com>
	<VI1PR0602MB324516419266A934FE7759C6A47E0@VI1PR0602MB3245.eurprd06.prod.outlo>
	<VI1PR0602MB32454C17192EFA863E29CC49A47E0@VI1PR0602MB3245.eurprd06.prod.outlo>
	<VI1PR0602MB324547F72DA9EDEB1613C888A47E0@VI1PR0602MB3245.eurprd06.prod.outlook.com>
	<CAJSP0QUg=cq3tCSLidQ9BR2hxAo3K6gA6LKtpx5Rjb=_6XgJ6Q@mail.gmail.com>
	<28e6b4ed-9afd-3a79-6267-86c7385c23ce@redhat.com>
	<VI1PR0602MB324578F91F1AF9390D03022FA47F0@VI1PR0602MB3245.eurprd06.prod.outlook.com>
	<CAJSP0QWouR43wVi0guTuASP9gc24_CPucbBvtfE5_htkDkmsrQ@mail.gmail.com>
	<20190223165523.1d674224@ncopa-desktop.copa.dup.pw>
	<CAJSP0QUndr5i5iu3tha8W4_4X763--9+V3tR_QUq5ZmtSO1-rA@mail.gmail.com>
In-Reply-To: <CAJSP0QUndr5i5iu3tha8W4_4X763--9+V3tR_QUq5ZmtSO1-rA@mail.gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 25 Feb 2019 10:33:25 +0000
Message-ID: <CAJSP0QVFYfiN0WHaVs+CRaZcvE22p0sdWmGCAaJ4fsopFQayVA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-block] Guest unresponsive after Virtqueue
 size exceeded error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Natanael Copa <ncopa@alpinelinux.org>
Cc: =?UTF-8?Q?Fernando_Casas_Sch=C3=B6ssow?= <casasfernando@outlook.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, qemu-devel <qemu-devel@nongnu.org>

On Mon, Feb 25, 2019 at 10:30 AM Stefan Hajnoczi <stefanha@gmail.com> wrote=
:
> On Sat, Feb 23, 2019 at 3:55 PM Natanael Copa <ncopa@alpinelinux.org> wro=
te:
> > On Fri, 22 Feb 2019 14:04:20 +0000
> > Stefan Hajnoczi <stefanha@gmail.com> wrote:
> > > On Fri, Feb 22, 2019 at 12:57 PM Fernando Casas Sch=C3=B6ssow
> > > <casasfernando@outlook.com> wrote:
> > I tried to find this section. How do you get the assembly listing of
> > relevant secion? I tried to do "disas virtio_pop" from
> > `gdb /usr/bin/qemu-system-x86_64` from the binary in alpine edge. I
> > could find 2 memcpy but none of them look like a 16 bit operation after=
:
> >
> >    0x00000000004551f1 <+353>:   mov    0x10(%rsp),%rdi
> >    0x00000000004551f6 <+358>:   mov    $0x10,%edx
> >    0x00000000004551fb <+363>:   callq  0x3879e0 <memcpy@plt>
> >    0x0000000000455200 <+368>:   movzwl 0x5c(%rsp),%eax
> >    0x0000000000455205 <+373>:   test   $0x4,%al
> >    0x0000000000455207 <+375>:   je     0x4552aa <virtqueue_pop+538>
> >
> > ....
> >
> >    0x0000000000455291 <+513>:   mov    0x10(%rsp),%rdi
> >    0x0000000000455296 <+518>:   mov    $0x10,%edx
> >    0x000000000045529b <+523>:   callq  0x3879e0 <memcpy@plt>
> >    0x00000000004552a0 <+528>:   mov    %rbp,0x20(%rsp)
> >    0x00000000004552a5 <+533>:   movzwl 0x5c(%rsp),%eax
> >    0x00000000004552aa <+538>:   lea    0x20e0(%rsp),%rdi
> >    0x00000000004552b2 <+546>:   xor    %r11d,%r11d
> >    0x00000000004552b5 <+549>:   mov    %r15,0x38(%rsp)
>
> Here is the beginning of the function:

This was built from the docker alpine image:
REPOSITORY          TAG                 IMAGE ID            CREATED
         SIZE
docker.io/alpine    latest              caf27325b298        3 weeks
ago         5.52 MB

aports git commit: be41538f0061b406a374564a0043a363efcb0293
gcc (Alpine 8.2.0) 8.2.0

Stefan
