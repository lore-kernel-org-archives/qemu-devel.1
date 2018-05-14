Received: from eggs.gnu.org ([2001:4830:134:3::10]:43794)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fIFj8-0005RS-Si
	for qemu-devel@nongnu.org; Mon, 14 May 2018 11:49:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fIFj7-0003H4-U4
	for qemu-devel@nongnu.org; Mon, 14 May 2018 11:49:30 -0400
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:44566)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fIFj7-0003Gm-Ni
	for qemu-devel@nongnu.org; Mon, 14 May 2018 11:49:29 -0400
Received: by mail-ot0-x241.google.com with SMTP id g7-v6so14828607otj.11
	for <qemu-devel@nongnu.org>; Mon, 14 May 2018 08:49:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <c4fdaf83-bf53-a1bb-72ad-6617da1280eb@amsat.org>
References: <20180509060104.4458-1-f4bug@amsat.org>
	<20180509060104.4458-2-f4bug@amsat.org>
	<CAKmqyKO8BsN2P9FCOyh0=nwx+4kcPf7nz=ym=ZF6hiwxKOdXaQ@mail.gmail.com>
	<c4fdaf83-bf53-a1bb-72ad-6617da1280eb@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 May 2018 16:49:08 +0100
Message-ID: <CAFEAcA8nBe-vVZGGMDJ+6Y8FYDVFsWJ_w4hEtEnU=hst7nQwzg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/4] sdcard: Update the SDState
 documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Alistair Francis <alistair23@gmail.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Alistair Francis <alistair@alistair23.me>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On 10 May 2018 at 01:24, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrot=
e:
> On 05/09/2018 12:42 PM, Alistair Francis wrote:
>> On Tue, May 8, 2018 at 11:01 PM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsa=
t.org> wrote:
>>> Add more descriptive comments to keep a clear separation
>>> between static property vs runtime changeable.

>> Why do we need a # here?
>
> I used the CPUState as a documentation example, but this might not be
> the correct use...

Our doc-comment syntax is rather inconsistent, because we've never
actually run a tool over it to autogenerate documentation from the
comments, and so there hasn't been anything syntax-checking them.
The original intention for the syntax was gtkdoc, I think, where
a leading '#' indicates a symbol that isn't a function, constant or
parameter. However, I think the most recent consensus is that we
should use kernel-doc format, which is similar but doesn't use the
'#' markup:
 https://www.kernel.org/doc/Documentation/kernel-doc-nano-HOWTO.txt

(The plan being that as we switch over to Sphinx for our docs
tool workflow we can use the kernel's integration of kernel-doc
into sphinx.)

For this structure in particular, it is not a public struct,
but local to a .c file. I think that for those there is not
really any point in having any kind of doc-comment markup in
it at all (ie no '#', no leading '/**').

thanks
-- PMM
