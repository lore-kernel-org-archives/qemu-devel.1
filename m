Received: from eggs.gnu.org ([2001:4830:134:3::10]:43393)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cqbok-0007FD-Nw
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 04:40:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cqboh-00054g-KY
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 04:40:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34776)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cqboh-00054W-E7
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 04:40:27 -0400
Date: Wed, 22 Mar 2017 04:40:25 -0400 (EDT)
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1322109813.6444955.1490172025040.JavaMail.zimbra@redhat.com>
In-Reply-To: <CAFEAcA_t9iLude4Vu3Zc=_wcXMTtFb4Q4oJ8O+zLAJ9isAPqHQ@mail.gmail.com>
References: <CAJy91CY1SOwi7D-kyU0ooe5SyhM414WaBCedXuPfXXhJpbo1fg@mail.gmail.com>
	<CAFEAcA_etsFstPtUzs0AZjWD35MhMLhwru0ibJzS_upgE-nsng@mail.gmail.com>
	<CAJy91CZmqEUXLKjRJ0JdUEf83E3FwE_24qmej-4C8uAGQkTPWA@mail.gmail.com>
	<CAFEAcA-mzO7vniDEaZeueVFQ7+MVBB7pnzHhahv2Yk_f3q0mJw@mail.gmail.com>
	<CAJy91CZ4Ed-HGHLkzEc1dqQbo32d-eTE1S1ovO_ZwkDdTpkQXQ@mail.gmail.com>
	<CAJy91CaCV40FgSP55qWZeZgkQ=2+E8Cr7xdbu9pn5HLEo+6JJQ@mail.gmail.com>
	<CAJy91CYEwOVT7oEdYY=21__c2kcLTyxyjAaq7Zx4VnQdeLdQQQ@mail.gmail.com>
	<CAFEAcA_t9iLude4Vu3Zc=_wcXMTtFb4Q4oJ8O+zLAJ9isAPqHQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Guest application reading from pl011 without
 device driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Jiahuan Zhang <jiahuanzhang90@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>


> > I am using a windows named pipe to get the data from a window
> > host program, which uses ReadFile () in char_win.c
>=20
> OK, bugs in the windows-specific char backend would be
> unsurprising.
>=20
> I'm not entirely sure how the chardev layer works, but
> at the pl011 end if we return 0 from our can_receive
> function then the chardev layer should decide it has
> nothing to do until the pl011 later calls
> qemu_chr_fe_accept_input(), I think.
>=20
> I've cc'd Paolo and Marc-Andr=C3=A9 Lureau as the chardev
> maintainers.

Windows named pipes do not support the equivalent of "select",
so it's possible that they cause a busy wait.  Try using a
TCP socket instead and see if the bug goes away.

Paolo
