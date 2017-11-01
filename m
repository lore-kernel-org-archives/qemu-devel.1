Received: from eggs.gnu.org ([2001:4830:134:3::10]:43933)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <esb@ics.hawaii.edu>) id 1eA1by-0002k8-Fz
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 18:35:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <esb@ics.hawaii.edu>) id 1eA1bv-0006Rx-E4
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 18:35:50 -0400
Received: from maru.ics.hawaii.edu ([128.171.10.147]:55836)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <esb@ics.hawaii.edu>) id 1eA1bv-0006Py-6g
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 18:35:47 -0400
From: "Edo (Edoardo Biagioni)" <esb@hawaii.edu>
Reply-To: esb@hawaii.edu
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <27998.1509575741.1@maru>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Nov 2017 12:35:41 -1000
Message-ID: <27999.1509575741@maru>
Subject: [Qemu-devel] report on qemu unknown keycode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

> unknown keycodes `(unnamed)', please report to qemu-devel@nongnu.org

This message appears when I type the first character of my password
after booting a virtual machine that is running ubuntu 17.10 (command line
below).  The host and guest are both running ubuntu 17.10.

I did not see the message before ubuntu 17.10, perhaps because ubuntu
17.04 supported autologin (ubuntu 17.10 claims to support it, but the
autologin does not seem to work).

It doesn't seem to matter which key I press for my password.  The
message only appears once.

My command line is:

$ qemu-system-x86_64 -enable-kvm -drive file=3D[something],index=3D0,media=
=3Ddisk,format=3Draw,snapshot=3Don -m 1536 -boot c -net nic -net user -sou=
ndhw all

The first message this command line prints is one I've been getting for
a long time, and therefore, likely unrelated:

> warning: host doesn't support requested feature: CPUID.80000001H:ECX.svm=
 [bit 2]

overall:
$ qemu-system-x86_64 -enable-kvm -drive file=3D[something],index=3D0,media=
=3Ddisk,format=3Draw,snapshot=3Don -m 1536 -boot c -net nic -net user -sou=
ndhw all
warning: host doesn't support requested feature: CPUID.80000001H:ECX.svm [=
bit 2]
unknown keycodes `(unnamed)', please report to qemu-devel@nongnu.org

On the host:
$ uname -a
Linux [hostname] 4.13.0-16-generic #19-Ubuntu SMP Wed Oct 11 18:35:14 UTC =
2017 x86_64 x86_64 x86_64 GNU/Linux

On the guest (identical):
$ uname -a
Linux [hostname] 4.13.0-16-generic #19-Ubuntu SMP Wed Oct 11 18:35:14 UTC =
2017 x86_64 x86_64 x86_64 GNU/Linux

Thank you for your excellent work, and please let me know if you need
further information.

aloha

	edo

E. Biagioni             UH/ICS, POST Building, room 317,
                        1680 East-West Road, Honolulu HI 96822
tel: +1-808-956-3891    fax: +1-808-956-3548 (shared fax, include my name)
email: esb@hawaii.edu   http://www2.hawaii.edu/~esb/
