Received: from eggs.gnu.org ([2001:4830:134:3::10]:39264)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jiahuanzhang90@gmail.com>) id 1cj5Sh-0004hr-0Z
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 09:42:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jiahuanzhang90@gmail.com>) id 1cj5Sg-0004ey-5Y
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 09:42:39 -0500
Received: from mail-qk0-x230.google.com ([2607:f8b0:400d:c09::230]:35152)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jiahuanzhang90@gmail.com>)
	id 1cj5Sg-0004eN-0l
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 09:42:38 -0500
Received: by mail-qk0-x230.google.com with SMTP id u188so73318812qkc.2
	for <qemu-devel@nongnu.org>; Wed, 01 Mar 2017 06:42:37 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CL7VPrbwevNXioH5-gSz6DWRMzZN=OK0qnCn--T7sHC0A@mail.gmail.com>
References: <CAJy91CZO+XOyzyhG5yKYcYQsfG_jwRF7W_4sxp6Fen=4gNr+YA@mail.gmail.com>
	<CAJ+F1CL7VPrbwevNXioH5-gSz6DWRMzZN=OK0qnCn--T7sHC0A@mail.gmail.com>
From: Jiahuan Zhang <jiahuanzhang90@gmail.com>
Date: Wed, 1 Mar 2017 15:42:37 +0100
Message-ID: <CAJy91CYYrj58whBJFKKdo-dkQ=3UcXSvJem1qXas=qPeFtX46w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Windows Pipe
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org

Hi,

I agree with you about win_chr_poll(). But what I wonder is how to write
data into the pipe for the host to get. I see "writeFile()" in
"win_chr_write()", but have no idea how to use it. Or I have to write
something for this writing. In this case, I don't know what the right
buffer pointer for WriteFile() is.

Any clue is greatly appreciated!

On 1 March 2017 at 15:25, Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.co=
m>
wrote:

> Hi
>
> On Wed, Mar 1, 2017 at 5:16 PM Jiahuan Zhang <jiahuanzhang90@gmail.com>
> wrote:
>
>> Dear QEMU developers,
>>
>> I want the host-guest communication for QEMU. I want to achieve
>> it via serial port redirection to a pipe. My host is windows and guest i=
s
>> Linux. QEMU is in version 2.8.50
>>
>> I looked into char-pipe.c and char-win.c, and find that the current QEMU
>> only supports reading data on the pipe from host to guest for Windows.
>> See *win_chr_pipe_init
>> () *in char-pipe.c
>>
>> Is it true?
>>
>
> Not exactly, for some reason, the win-chr-pipe uses a poll, win_chr_poll(=
)
> that read from the pipe and write to the frontend (the vm serial).  I
> haven't tested the windows pipe implementation, only the console one, but
> it looks like it should work. Hopefully someone using qemu on windows can
> help you.
>
>
>> I don't know how to use *win_chr_write() *in char-win.c.
>> Can you please present an example?
>>
>> best regards,
>> Jiahuan
>>
> --
> Marc-Andr=C3=A9 Lureau
>
