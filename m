Received: from eggs.gnu.org ([2001:4830:134:3::10]:34589)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fsWAw-00059T-Nz
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 12:40:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fsWAw-0000oO-0U
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 12:40:06 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:53210)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1fsWAv-0000nt-PP
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 12:40:05 -0400
Received: by mail-wm0-x242.google.com with SMTP id y139-v6so2586165wmc.2
	for <qemu-devel@nongnu.org>; Wed, 22 Aug 2018 09:40:05 -0700 (PDT)
MIME-Version: 1.0
References: <20180822142956.6859-1-marcandre.lureau@redhat.com>
	<20180822142956.6859-4-marcandre.lureau@redhat.com>
	<20180822154611.GN12750@redhat.com>
	<CAMxuvawr-ooy91ZHTHx+aLYhgpH5gBoAKQz_pvF=kcHzadjLog@mail.gmail.com>
	<20180822160614.GQ12750@redhat.com>
	<CAJ+F1CK65vU4pkX9w8gbMfJdMfEXv5OZyXv6yRJbJjG1J1OYmg@mail.gmail.com>
In-Reply-To: <CAJ+F1CK65vU4pkX9w8gbMfJdMfEXv5OZyXv6yRJbJjG1J1OYmg@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 22 Aug 2018 18:39:52 +0200
Message-ID: <CAJ+F1CLdOsxLu+cHScTDMPUm9iq=3NO6=F4wQJi2FSssVZBVuA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 3/3] seccomp: set the seccomp filter to
 all threads
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: pmoore@redhat.com, Eduardo Otubo <otubo@redhat.com>, QEMU <qemu-devel@nongnu.org>

Hi

On Wed, Aug 22, 2018 at 6:37 PM Marc-Andr=C3=A9 Lureau
<marcandre.lureau@gmail.com> wrote:
>
> Hi
>
> On Wed, Aug 22, 2018 at 6:08 PM Daniel P. Berrang=C3=A9 <berrange@redhat.=
com> wrote:
> > We would have to make libvirt probe for tsync support too, because it
> > now unconditionally uses -sandbox for new enough QEMU.
>
> sigh :( that's where the -sandbox tsync option could have been helpful
> keeping the compatibility.

So what can libvirt do if tsync is not available?


--=20
Marc-Andr=C3=A9 Lureau
