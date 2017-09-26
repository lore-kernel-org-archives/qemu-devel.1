Received: from eggs.gnu.org ([2001:4830:134:3::10]:50483)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1dwwaL-00060W-0R
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 16:36:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1dwwaG-0007d8-W2
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 16:36:05 -0400
Received: from mail.weilnetz.de ([37.120.169.71]:59000
	helo=v2201612906741603.powersrv.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sw@weilnetz.de>) id 1dwwaG-0007bV-Q5
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 16:36:00 -0400
References: <1506049617-25716-1-git-send-email-thuth@redhat.com>
	<20170926222730-mutt-send-email-mst@kernel.org>
From: Stefan Weil <sw@weilnetz.de>
Message-ID: <4b4c8d9e-101b-ee27-b4d2-249890c14d21@weilnetz.de>
Date: Tue, 26 Sep 2017 22:35:57 +0200
MIME-Version: 1.0
In-Reply-To: <20170926222730-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] tests/boot-sector: Increase timeout to 600
 seconds
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>, Victor Kaplansky <victork@redhat.com>

Am 26.09.2017 um 21:30 schrieb Michael S. Tsirkin:
> On Fri, Sep 22, 2017 at 05:06:57AM +0200, Thomas Huth wrote:
>> If QEMU has been compiled with the flags --enable-tcg-interpreter and
>> --enable-debug, the guest is running incredibly slow. The pxe boot tes=
t
>> can take up to 400 seconds when testing the pseries ppc64 machine. Whi=
le
>> we should still look for ways to speed up the test on the pseries mach=
ine,
>> it's better to increase the timeout in this test to 600 seconds anyway=
 to
>> allow the test to pass successfully now with this unusal configuration
>> already.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>=20
> Well I do break things sometimes and I won't be happy about
> spending 10 minutes waiting for a test to fail.
>=20
> Can we break out of the test if all CPUs are halted with
> interrupts disabled?

Yes, that sounds like a scenario where no more progress
can be expected.

Any fixed timeout is either too long (when you expect a failing
test) or too short (when you need time for the test to pass).

Would it be possible to get some speed factor (like Linux
bogomips) at the beginning of all tests? Then that factor
could be used later for all tests which currently use a
hard timeout.

Regards
Stefan
