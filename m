Received: from eggs.gnu.org ([2001:4830:134:3::10]:37544)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fIGwb-0002iK-Vy
	for qemu-devel@nongnu.org; Mon, 14 May 2018 13:07:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fIGwX-00067h-V2
	for qemu-devel@nongnu.org; Mon, 14 May 2018 13:07:29 -0400
Received: from mail-qt0-x22e.google.com ([2607:f8b0:400d:c0d::22e]:35511)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fIGwX-00067R-QR
	for qemu-devel@nongnu.org; Mon, 14 May 2018 13:07:25 -0400
Received: by mail-qt0-x22e.google.com with SMTP id f5-v6so17091344qth.2
	for <qemu-devel@nongnu.org>; Mon, 14 May 2018 10:07:25 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180509060104.4458-1-f4bug@amsat.org>
	<20180509060104.4458-2-f4bug@amsat.org>
	<CAKmqyKO8BsN2P9FCOyh0=nwx+4kcPf7nz=ym=ZF6hiwxKOdXaQ@mail.gmail.com>
	<c4fdaf83-bf53-a1bb-72ad-6617da1280eb@amsat.org>
	<CAFEAcA8nBe-vVZGGMDJ+6Y8FYDVFsWJ_w4hEtEnU=hst7nQwzg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <06e5cb82-13d1-8abb-6ef6-8e57f5557113@amsat.org>
Date: Mon, 14 May 2018 14:07:20 -0300
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8nBe-vVZGGMDJ+6Y8FYDVFsWJ_w4hEtEnU=hst7nQwzg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Alistair Francis <alistair23@gmail.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Alistair Francis <alistair@alistair23.me>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On 05/14/2018 12:49 PM, Peter Maydell wrote:
> On 10 May 2018 at 01:24, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>> On 05/09/2018 12:42 PM, Alistair Francis wrote:
>>> On Tue, May 8, 2018 at 11:01 PM, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>>>> Add more descriptive comments to keep a clear separation
>>>> between static property vs runtime changeable.
> 
>>> Why do we need a # here?
>>
>> I used the CPUState as a documentation example, but this might not be
>> the correct use...
> 
> Our doc-comment syntax is rather inconsistent, because we've never
> actually run a tool over it to autogenerate documentation from the
> comments, and so there hasn't been anything syntax-checking them.
> The original intention for the syntax was gtkdoc, I think, where
> a leading '#' indicates a symbol that isn't a function, constant or
> parameter. However, I think the most recent consensus is that we
> should use kernel-doc format, which is similar but doesn't use the
> '#' markup:
>  https://www.kernel.org/doc/Documentation/kernel-doc-nano-HOWTO.txt

Ok, I'll use this guide from now on.

> (The plan being that as we switch over to Sphinx for our docs
> tool workflow we can use the kernel's integration of kernel-doc
> into sphinx.)
> 
> For this structure in particular, it is not a public struct,
> but local to a .c file. I think that for those there is not
> really any point in having any kind of doc-comment markup in
> it at all (ie no '#', no leading '/**').

Ok.
