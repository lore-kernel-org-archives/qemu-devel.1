Received: from eggs.gnu.org ([2001:4830:134:3::10]:46626)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fspoJ-0006rE-Vg
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 09:38:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fspoJ-0001uD-42
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 09:38:03 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:35385)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1fspoI-0001tv-U0
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 09:38:03 -0400
Received: by mail-wm0-x242.google.com with SMTP id o18-v6so5922332wmc.0
	for <qemu-devel@nongnu.org>; Thu, 23 Aug 2018 06:38:02 -0700 (PDT)
MIME-Version: 1.0
References: <20180823113659.21737-1-pbonzini@redhat.com>
	<CAFEAcA9GTsKcteYCLC2jk0icxGYGX9R=Hbrph7CK3bugc3+kVQ@mail.gmail.com>
In-Reply-To: <CAFEAcA9GTsKcteYCLC2jk0icxGYGX9R=Hbrph7CK3bugc3+kVQ@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 23 Aug 2018 15:37:49 +0200
Message-ID: <CAJ+F1CK=M3bX+8mo=AwkBj7Rd2ViqV1Y4q6WfQfS4_OFNDrdKA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL v2 00/73] Misc patches for 2018-08-21
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, QEMU <qemu-devel@nongnu.org>

Hi
On Thu, Aug 23, 2018 at 3:31 PM Peter Maydell <peter.maydell@linaro.org> wr=
ote:
>
> On 23 August 2018 at 12:36, Paolo Bonzini <pbonzini@redhat.com> wrote:
> > The following changes since commit 659b11e7a7239529cfdb4968418268ff9aa2=
2d88:
> >
> >   Merge remote-tracking branch 'remotes/vivier2/tags/linux-user-for-3.1=
-pull-request' into staging (2018-08-21 11:36:15 +0100)
> >
> > are available in the Git repository at:
> >
> >   git://github.com/bonzini/qemu.git tags/for-upstream
> >
> > for you to fetch changes up to 07c8c1c9311b81cbf3bcc49d4fed18e1d889a8f2=
:
> >
> >   test-char: add socket reconnect test (2018-08-23 13:32:50 +0200)
> >
> > I removed the offending patch.
>
> Test failure on FreeBSD:
>
> MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> gtester -k --verbose -m=3Dquick tests/test-char
> TEST: tests/test-char... (pid=3D16190)
>   /char/null:                                                          OK
>   /char/invalid:                                                       OK
>   /char/ringbuf:                                                       OK
>   /char/mux:                                                           OK
>   /char/stdio:                                                         OK
>   /char/pipe:                                                          OK
>   /char/file:                                                          OK
>   /char/file-fifo:                                                     OK
>   /char/udp:                                                           OK
>   /char/serial:                                                        OK
>   /char/hotswap:                                                       OK
>   /char/socket/basic:                                                  OK
>   /char/socket/reconnect:                                              FA=
IL
> GTester: last random seed: R02S521380d9c12f1dac3ad1763bf5665c27
> (pid=3D16367)
>   /char/socket/fdpass:                                                 OK
> FAIL: tests/test-char
> **
> ERROR:tests/test-char.c:353:char_socket_test_common: assertion failed:
> (object_property_get_bool(OBJECT(chr_client), "connected",
> &error_abort))
>

Hmm, it looks like a race that pre-existed char_socket_test_common(),
we wait for the server to be connected, and check both client and
server have the connected option set. It may be that the client hasn't
yet processed the connection event.

Paolo, can you drop the test?

> thanks
> -- PMM
>


--=20
Marc-Andr=C3=A9 Lureau
