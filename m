Received: from eggs.gnu.org ([2001:4830:134:3::10]:44957)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cYeFW-0001sm-Jb
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 14:37:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cYeFV-0001kd-N8
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 14:37:54 -0500
Received: from mail-yb0-x22f.google.com ([2607:f8b0:4002:c09::22f]:34317)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1cYeFV-0001kM-Ht
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 14:37:53 -0500
Received: by mail-yb0-x22f.google.com with SMTP id j82so130891316ybg.1
	for <qemu-devel@nongnu.org>; Tue, 31 Jan 2017 11:37:53 -0800 (PST)
MIME-Version: 1.0
References: <20170131162122.29408-1-marcandre.lureau@redhat.com>
	<CAFEAcA9jzxGZXXoFWxrDztb4or=0LaqpeNa3YH9rpZePa2mFdA@mail.gmail.com>
	<CAJ+F1CJzchr6f9nfCsHyOUFmz-08e4R-8BLi4QWc3q0h0+9Quw@mail.gmail.com>
	<3fdd19c5-2017-7c5d-22ad-a44bd15414d6@redhat.com>
In-Reply-To: <3fdd19c5-2017-7c5d-22ad-a44bd15414d6@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 31 Jan 2017 19:37:41 +0000
Message-ID: <CAJ+F1CKmAKmiiM5LvLGaT51kJUp4=jKU_=QAqo7JOtxDuso9CQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 00/41] Chr split patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

Hi

On Tue, Jan 31, 2017 at 11:00 PM Eric Blake <eblake@redhat.com> wrote:

> On 01/31/2017 12:55 PM, Marc-Andr=C3=A9 Lureau wrote:
>
> >> 'make check' fails on a linux-user-targets-only build:
> >>
> >> tests/test-char.o: In function `char_stdio_test_subprocess':
> >> /home/petmay01/linaro/qemu-for-merges/tests/test-char.c:47: undefined
> >> reference to `qemu_chr_new'
> >> /home/petmay01/linaro/qemu-for-merges/tests/test-char.c:50: undefined
> >> reference to `qemu_chr_fe_init'
> >> /home/petmay01/linaro/qemu-for-merges/tests/test-char.c:51: undefined
> >> reference to `qemu_chr_fe_set_open'
> >> /home/petmay01/linaro/qemu-for-merges/tests/test-char.c:52: undefined
> >> reference to `qemu_chr_fe_write'
> >> [etc etc etc]
> >>
> >>
> > Oh good catch. We want to have chardev-obj-y defined globally, but only
> > linked with -softmmu target.
> >
> > A possible fix to squash with chardev-obj-j patch is:
> >
> > Eric, do you want me to resend the patch for review or is that enough f=
or
> > you to ack?
> >
>
> I'm okay ack'ing the interdiff (that is, squash this in, and you can
> keep the R-b you already have).
>
>
Thanks, patch updated, tag updated.

Peter, let me know if you want me to resend the pull request.

--=20
Marc-Andr=C3=A9 Lureau
