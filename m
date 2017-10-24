Received: from eggs.gnu.org ([2001:4830:134:3::10]:42477)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jan.dakinevich@virtuozzo.com>) id 1e73Kh-00054e-AG
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 13:49:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jan.dakinevich@virtuozzo.com>) id 1e73Ke-0000vX-OV
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 13:49:43 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:23489 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jan.dakinevich@virtuozzo.com>)
	id 1e73Ke-0000ul-C9
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 13:49:40 -0400
From: Jan Dakinevich <jan.dakinevich@virtuozzo.com>
Date: Tue, 24 Oct 2017 20:50:02 +0300
Message-Id: <1508867404-18046-1-git-send-email-jan.dakinevich@virtuozzo.com>
Subject: [Qemu-devel] [RFC v5 0/2] virtio: introduce `info virtio' hmp
 command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Jan Dakinevich <jan.dakinevich@virtuozzo.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, "Denis V. Lunev" <den@virtuozzo.com>, Cornelia Huck <cohuck@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Previously, it was suggested to use QAPI unions/enums to declare feature 
bits. Some of weak parts of my code (such `get_feature_name' callback) 
went away. But a lot of of dummy code with feature declaration is still 
here, it just migrated to json file.

So, I would be glad to get a responce if my understanging of using QAPI
structures was correct, or there was another way to do that cleaner?

v5:
 Use QAPI enums/unions to declare virtio feature bits

v4: http://lists.nongnu.org/archive/html/qemu-devel/2017-10/msg00393.html
v3: http://lists.nongnu.org/archive/html/qemu-devel/2017-09/msg07565.html
v2: http://lists.nongnu.org/archive/html/qemu-devel/2017-09/msg07527.html
v1: http://lists.nongnu.org/archive/html/qemu-devel/2017-09/msg07247.html

Jan Dakinevich (2):
  virtio: introduce `query-virtio' QMP command
  virtio: add `info virtio' HMP command

 hmp-commands-info.hx    |  14 ++
 hmp.c                   | 122 +++++++++++++
 hmp.h                   |   1 +
 hw/virtio/Makefile.objs |   3 +
 hw/virtio/virtio-qmp.c  | 223 +++++++++++++++++++++++
 hw/virtio/virtio-stub.c |   9 +
 qapi-schema.json        | 466 ++++++++++++++++++++++++++++++++++++++++++++++++
 7 files changed, 838 insertions(+)
 create mode 100644 hw/virtio/virtio-qmp.c
 create mode 100644 hw/virtio/virtio-stub.c

-- 
2.1.4
