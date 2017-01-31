Received: from eggs.gnu.org ([2001:4830:134:3::10]:59409)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cYdMr-0005Mk-Ij
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 13:41:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cYdMq-0007s6-M0
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 13:41:25 -0500
Received: from mail-ua0-x22b.google.com ([2607:f8b0:400c:c08::22b]:36469)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cYdMq-0007rp-Gw
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 13:41:24 -0500
Received: by mail-ua0-x22b.google.com with SMTP id 96so279356376uaq.3
	for <qemu-devel@nongnu.org>; Tue, 31 Jan 2017 10:41:24 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170131162122.29408-1-marcandre.lureau@redhat.com>
References: <20170131162122.29408-1-marcandre.lureau@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 31 Jan 2017 18:41:03 +0000
Message-ID: <CAFEAcA9jzxGZXXoFWxrDztb4or=0LaqpeNa3YH9rpZePa2mFdA@mail.gmail.com>
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
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 31 January 2017 at 16:20, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
> The following changes since commit a0def594286d9110a6035e02eef558cf3cf5d8=
47:
>
>   Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into s=
taging (2017-01-30 10:23:20 +0000)
>
> are available in the git repository at:
>
>   https://github.com/elmarco/qemu.git tags/chr-split-pull-request
>
> for you to fetch changes up to 3766519be2843e0947425cafd1e7e205dd63f0fd:
>
>   char: headers clean-up (2017-01-31 13:03:48 +0400)
>
> ----------------------------------------------------------------
>

'make check' fails on a linux-user-targets-only build:

tests/test-char.o: In function `char_stdio_test_subprocess':
/home/petmay01/linaro/qemu-for-merges/tests/test-char.c:47: undefined
reference to `qemu_chr_new'
/home/petmay01/linaro/qemu-for-merges/tests/test-char.c:50: undefined
reference to `qemu_chr_fe_init'
/home/petmay01/linaro/qemu-for-merges/tests/test-char.c:51: undefined
reference to `qemu_chr_fe_set_open'
/home/petmay01/linaro/qemu-for-merges/tests/test-char.c:52: undefined
reference to `qemu_chr_fe_write'
[etc etc etc]

thanks
-- PMM
