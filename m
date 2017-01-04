Received: from eggs.gnu.org ([2001:4830:134:3::10]:39430)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cOsym-0007po-Ba
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 16:20:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cOsyl-0007VR-86
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 16:20:16 -0500
Received: from mail-yw0-x241.google.com ([2607:f8b0:4002:c05::241]:34142)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1cOsyl-0007VH-2Y
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 16:20:15 -0500
Received: by mail-yw0-x241.google.com with SMTP id a10so42956994ywa.1
	for <qemu-devel@nongnu.org>; Wed, 04 Jan 2017 13:20:15 -0800 (PST)
MIME-Version: 1.0
References: <20161212224325.20790-1-marcandre.lureau@redhat.com>
	<4315c23d-0c4b-4341-90aa-54d186eaa251@redhat.com>
In-Reply-To: <4315c23d-0c4b-4341-90aa-54d186eaa251@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 04 Jan 2017 21:20:03 +0000
Message-ID: <CAJ+F1C+qoZrmMgsiEC+=xNVVaJFV+fUxk8ZmjSQTxnDXpKb6Dg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 00/54] WIP: chardev: qom-ify
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>

Hi

On Mon, Jan 2, 2017 at 11:27 AM Paolo Bonzini <pbonzini@redhat.com> wrote:

>
>
> On 12/12/2016 23:42, Marc-Andr=C3=A9 Lureau wrote:
> >
> > Note: this series has been tested with Linux and cross-building with
> > mingw. It mostly breaks on other platforms,
>
> What breaks exactly?
>
>
Not much that I know. I was afraid it would break on BSD (in particular the
move to own file and last patch), so I tested on FreeBSD. The last version
of the series works on win32, linux and freebsd. It can be found on
https://github.com/elmarco/qemu/commits/chrfe It's slightly over 80 patches
now, and needs some win32 fixes I sent earlier (subprocess tests, and
main-loop busy loop fix)

Since Erik started reviewing the series, I suggest to resend the first part
until "qom-ify" patch. Erik, feel free to review the remaining part of the
WIP series, but more changes happened after iirc. What do you think?


Paolo
>
> > help welcome for
> > testing. I'd also like to write more chardev backend tests to ensure
> > no regression (test-char.c is quite limited for now)
>
> --
Marc-Andr=C3=A9 Lureau
