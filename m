Received: from eggs.gnu.org ([2001:4830:134:3::10]:50077)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cahsz-0006G2-6X
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 06:55:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cahsy-0003qk-7f
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 06:55:09 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:35755)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cahsy-0003og-0U
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 06:55:08 -0500
Received: by mail-wm0-x242.google.com with SMTP id u63so21443106wmu.2
	for <qemu-devel@nongnu.org>; Mon, 06 Feb 2017 03:55:07 -0800 (PST)
MIME-Version: 1.0
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 6 Feb 2017 11:55:05 +0000
Message-ID: <CAJSP0QWT14J-cqwLqPCr0iC95pSLaiZJgPkqr1VBU=pqYF6kqQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Qemu-devel] libslirp and QEMU slirp
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Thibault <samuel.thibault@ens-lyon.org>, renzo@cs.unibo.it
Cc: virtualsquare@cs.unibo.it, Jan Kiszka <jan.kiszka@web.de>, qemu-devel <qemu-devel@nongnu.org>

Hi,
There was a talk about new developments in VDEplug at FOSDEM 2017.
The QEMU slirp code has been extracted into a library:
https://fosdem.org/2017/schedule/event/iaas_modvde/

QEMU's slirp code does not have many contributors.  Other projects
using slirp are probably in this situation too.  Spinning the QEMU
slirp code out into an external library seems like a good idea because
it could help focus on new developments like IPv6 support and ease the
maintenance burden.

I'm proposing this topic for discussion because there might be common
ground for Samuel from QEMU and the VDE folks to collaborate.

Samuel: Should QEMU join forces with libslirp?

If you would like to speak rather than email, QEMU has a developer
conference call on Tuesday 14th of February at 13:00-14:00 UTC.  The
agenda is open for topics and it would be a good forum to share ideas
on slirp code maintenance and future direction.  All that's required
is an email to Juan Quintela <quintela@redhat.com> and he can schedule
the call and provide dial-in details.

Stefan
