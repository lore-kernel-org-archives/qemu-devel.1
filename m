Received: from eggs.gnu.org ([2001:4830:134:3::10]:49921)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eswierk@skyportsystems.com>) id 1cYgmI-0002LT-Mh
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 17:19:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eswierk@skyportsystems.com>) id 1cYgmI-0001RE-12
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 17:19:54 -0500
Received: from mail-ua0-x22e.google.com ([2607:f8b0:400c:c08::22e]:34581)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <eswierk@skyportsystems.com>)
	id 1cYgmH-0001RA-RX
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 17:19:53 -0500
Received: by mail-ua0-x22e.google.com with SMTP id 35so283693311uak.1
	for <qemu-devel@nongnu.org>; Tue, 31 Jan 2017 14:19:53 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <421566746.771522.1485871592528.JavaMail.zimbra@redhat.com>
References: <1485870329-79428-1-git-send-email-eswierk@skyportsystems.com>
	<421566746.771522.1485871592528.JavaMail.zimbra@redhat.com>
From: Ed Swierk <eswierk@skyportsystems.com>
Date: Tue, 31 Jan 2017 14:19:12 -0800
Message-ID: <CAO_EM_=PLhSB4JxQitC1zev+RQuSdJqpYyo8rOdVDSvyuoCgkw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] char: drop data written to a disconnected
 pty
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <mlureau@redhat.com>
Cc: qemu-devel@nongnu.org, libvir-list@redhat.com, "Daniel P. Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, marcandre lureau <marcandre.lureau@redhat.com>, Eric Blake <eblake@redhat.com>, Benjamin Warren <ben@skyportsystems.com>

On Tue, Jan 31, 2017 at 6:06 AM, Marc-Andr=C3=A9 Lureau <mlureau@redhat.com=
> wrote:
> I think this can be confusing if some backends silently drop the data (un=
der disconnected state), while other don't. Perhaps we should have instead =
a new common chardev property "hup-drop" ? (suggestions for better name wel=
come)

Either way, when a pty is disconnected data will get dropped, whether
by the pty backend (as proposed) or by the serial port device or other
frontend (as currently).

The only difference from a user's perspective is whether the dropped
data gets written to the log file, which is the main motivation for
this change. The backward compatibility concern would be an existing
application that relies on data not being logged when the pty is
disconnected.

--Ed
