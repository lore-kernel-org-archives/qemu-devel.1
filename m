Received: from eggs.gnu.org ([2001:4830:134:3::10]:49415)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gSRaH-0004mu-L4
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 14:02:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gSRaB-0001tx-SV
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 14:02:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60452)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gSRa9-0001sX-Uz
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 14:02:39 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20181129152552.14363-1-liq3ea@163.com>
Date: Thu, 29 Nov 2018 20:02:34 +0100
In-Reply-To: <20181129152552.14363-1-liq3ea@163.com> (Li Qiang's message of
	"Thu, 29 Nov 2018 07:25:52 -0800")
Message-ID: <87ftvj4shh.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] Hot-pluggable device without ->unrealize() is highly
 suspect (was: [PATCH] hw: scsi: dc390: add device unrealize function)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@163.com>
Cc: pbonzini@redhat.com, Fam Zheng <fam@euphon.net>, liq3ea@gmail.com, qemu-devel@nongnu.org

Li Qiang <liq3ea@163.com> writes:

> Currently the dc390 device has no unrealize function. This
> can cause memory leak when hotplug/unplug device. Also more
> serious, it will trigger an assert when rehotplug. 
[...]

When a hot-pluggable device doesn't have an ->unrealize() method, unplug
is probably broken.  I think we should track down such devices for
review.  Any takers?
