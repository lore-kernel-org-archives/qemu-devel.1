Received: from eggs.gnu.org ([2001:4830:134:3::10]:58282)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dayG4-00084k-RI
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 01:56:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dayG4-0003GL-2k
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 01:56:20 -0400
Received: from mail-it0-x22d.google.com ([2607:f8b0:4001:c0b::22d]:36262)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dayG3-0003Fy-UY
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 01:56:20 -0400
Received: by mail-it0-x22d.google.com with SMTP id v205so76295299itf.1
	for <qemu-devel@nongnu.org>; Thu, 27 Jul 2017 22:56:19 -0700 (PDT)
MIME-Version: 1.0
Sender: philippe.mathieu.daude@gmail.com
In-Reply-To: <7cdcea0f-5c26-4e18-d7f0-fa11606ba2c9@redhat.com>
References: <20170717063521.GA7393@lemon>
	<20170717103937.GD5301@noname.redhat.com>
	<CAFEAcA9zoauJw-CnNxtec48VOr6onXiCZ8BV8JJwk7ZeOLxnUw@mail.gmail.com>
	<20170717113115.GE5301@noname.redhat.com>
	<7cdcea0f-5c26-4e18-d7f0-fa11606ba2c9@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Fri, 28 Jul 2017 02:56:18 -0300
Message-ID: <CAAdtpL6w-zxQh=4TeEE1FHDuFL1FCxFWNRCtzh_MF1xfkGv+_g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Status and RFC of patchew testings on QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Fam Zheng <famz@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On Mon, Jul 17, 2017 at 10:40 AM, Max Reitz <mreitz@redhat.com> wrote:
> On 2017-07-17 13:31, Kevin Wolf wrote:
>> I think we had it in 'make check' for a while, but I seem to remember
>> that people complained about things like the disk space that some of the
>> tests needed for temporary files, and some exotic systems didn't support
>> sparse files or something like that.
>
> Wasn't that exotic system HFS+ on OS X/macOS? As far as I'm informed,
> macOS has recently switched to APFS which does have sparse files (and I
> think they have automatically converted running systems to APFS).

if anybody can run tests except those, we can add:

if $OS == OSX && $FS == HFS+; then
  "no 'make check' on OSX with HFS+, sorry"
fi

and have more ppl running tests...
