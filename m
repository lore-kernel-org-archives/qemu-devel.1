Received: from eggs.gnu.org ([2001:4830:134:3::10]:55391)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1clWvB-00061e-JJ
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 03:26:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1clWv7-0006IO-I7
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 03:26:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48424)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1clWv7-0006IG-Bs
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 03:26:05 -0500
From: Thomas Huth <thuth@redhat.com>
Message-ID: <3d1c16a1-ec05-0367-e569-64a63b34f2e3@redhat.com>
Date: Wed, 8 Mar 2017 09:26:00 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] What's the next QEMU version after 2.9 ? (or: when is
 a good point in time to get rid of old interfaces)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>


 Hi everybody,

what will be the next version of QEMU after 2.9? Will we go for a 2.10
(as I've seen it mentioned a couple of times on the mailing list
already), or do we dare to switch to 3.0 instead?

I personally dislike two-digit minor version numbers like 2.10 since the
non-experienced users sometimes mix it up with 2.1 ... and there have
been a couple of new cool features in the past releases that would
justify a 3.0 now, too, I think.

But anyway, the more important thing that keeps me concerned is: Someone
 once told me that we should get rid of old parameters and interfaces
(like HMP commands) primarily only when we're changing to a new major
version number. As you all know, QEMU has a lot of legacy options, which
are likely rather confusing than helpful for the new users nowadays,
e.g. things like the "-net channel" option (which is fortunately even
hardly documented), but maybe also even the whole vlan/hub concept in
the net code, or legacy parameters like "-usbdevice". If we switch to
version 3.0, could we agree to remove at least some of them?

 Thomas
