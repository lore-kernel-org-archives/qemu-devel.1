Received: from eggs.gnu.org ([2001:4830:134:3::10]:56737)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Alexandru.Avadanii@enea.com>) id 1ctji5-0001Ys-M8
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 19:42:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Alexandru.Avadanii@enea.com>) id 1ctji2-0006d7-JD
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 19:42:33 -0400
Received: from smtp-out11.electric.net ([185.38.181.36]:52706)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Alexandru.Avadanii@enea.com>)
	id 1ctji2-0006Yo-CQ
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 19:42:30 -0400
Received: from 1ctjhp-000183-VB by out11b.electric.net with emc1-ok (Exim 4.87)
	(envelope-from <Alexandru.Avadanii@enea.com>) id 1ctjhp-00018L-Vm
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 16:42:17 -0700
Received: from [192.36.1.72] (helo=mx-3.enea.com)
	by out11b.electric.net with esmtps (TLSv1:ECDHE-RSA-AES256-SHA:256)
	(Exim 4.87) (envelope-from <Alexandru.Avadanii@enea.com>)
	id 1ctjhp-000183-VB
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 16:42:17 -0700
From: Alexandru Avadanii <Alexandru.Avadanii@enea.com>
Date: Thu, 30 Mar 2017 23:42:17 +0000
Message-ID: <058D52979F67BF47BCD9EA78EAECA6DC7779F2D5@SESTOEX04.enea.se>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] rbd: Possible regression in 2.9 RCs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: svc-armband <armband@enea.com>

Hi,
While testing out 2.9.0-rc2 on AArch64, we noticed a possible regression in=
 QEMU, related to parsing -drive 'file=3Drbd/...':
> "conf option 6789 has no value".

Instance logs [1].
Occasionally, we get "conf option too long", with the same effect.

We bisected this manually between 2.8.0 (working ok with the above cmd) and=
 2.9.0-rc2, and the problematic change seems to be the merge point [2].
The problem is not arch-specific, i.e. it applies to x86 too, but our set u=
p is based on AArch64, so I attached the logs I had lying around.

I would digg deeper into this myself, but I'm quite burnt out for today.

BR,
Alex

[1] http://paste.openstack.org/show/604938/
[2] https://github.com/qemu/qemu/commit/9a81b79
