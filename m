Received: from eggs.gnu.org ([209.51.188.92]:38613)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ndragazis@arrikto.com>) id 1hGlC0-0002DD-HY
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 10:05:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ndragazis@arrikto.com>) id 1hGlBx-0006v7-Il
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 10:05:39 -0400
Received: from mx0.arrikto.com ([2a01:7e00::f03c:91ff:fe6e:d7ab]:42221)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ndragazis@arrikto.com>)
	id 1hGlBv-0006sQ-U2
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 10:05:36 -0400
From: Nikos Dragazis <ndragazis@arrikto.com>
Message-ID: <6021647b-20c7-2801-4f3e-a91a297f36e2@arrikto.com>
Date: Wed, 17 Apr 2019 17:05:31 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] revising virtio-vhost-user device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Vangelis Koukis <vkoukis@arrikto.com>, "Stojaczyk, Dariusz" <dariusz.stojaczyk@intel.com>, Stefan Hajnoczi <stefanha@redhat.com>

Hi everyone,

as you may already know, there is an experimental feature in QEMU wiki
page called =E2=80=9Cvirtio-vhost-user=E2=80=9D [1]. Stefan Hajnoczi laun=
ched this
feature a year ago. He even wrote an RFC implementation [2]. However,
this feature is still a WIP.

At present, I am working with Dariusz Stojaczyk from Intel in order to
integrate the virtio-vhost-user device with SPDK/DPDK. Part of the plan
is to finish up and merge the virtio-vhost-user device with the latest
QEMU. Thereby, I have been working on Stefan=E2=80=99s device code [3] ov=
er the
last few weeks. Stefan has already made a TODO list [2] with all the
missing parts.

The updated device code is here [4]. In short, I have done the following
things so far:

- implement the virtio PCI capabilities for the additional device
=C2=A0 resources

- add support for guest notifications in response to master virtqueue
=C2=A0 kicks

- use ioeventfd mechanism for the callfds in order to avoid entering
=C2=A0 QEMU

- add UUID configuration field

- rebase on top of latest qemu:master

- update the virtio device spec [5][6]

I have deliberately kept the commits separate in order to clearly
demonstrate the above changes.

There is still some work to be done. However, given the fact that I am
not familiar with QEMU code and development process, I thought about
sharing this with the community at an early stage. Hopefully, I could
receive from you some reviews/pointers/comments/suggestions.

Looking forward to your feedback.

Best regards,
Nikos

[1] https://wiki.qemu.org/Features/VirtioVhostUser
[2] http://lists.nongnu.org/archive/html/qemu-devel/2018-01/msg04806.html
[3] https://github.com/stefanha/qemu/tree/virtio-vhost-user
[4] https://github.com/arrikto/qemu-qemu/commits/virtio-vhost-user
[5] https://github.com/ndragazis/virtio/commits
[6] https://ndragazis.github.io/virtio-v1.0-cs04.html#x1-2830007
