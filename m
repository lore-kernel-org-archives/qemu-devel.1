Received: from eggs.gnu.org ([2001:4830:134:3::10]:60474)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dn1nA-0002BE-5v
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 08:08:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dn1n7-0005Ut-15
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 08:08:20 -0400
Received: from fanzine.igalia.com ([91.117.99.155]:47756)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <berto@igalia.com>) id 1dn1n6-0005UZ-KV
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 08:08:16 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <1504016587-39779-1-git-send-email-pradeep.jagadeesh@huawei.com>
References: <1504016587-39779-1-git-send-email-pradeep.jagadeesh@huawei.com>
Date: Wed, 30 Aug 2017 14:07:59 +0200
Message-ID: <w51fuc98di8.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v8 0/6] fsdev: qmp interface for io
 throttling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pradeep Jagadeesh <pradeepkiruvale@gmail.com>, eric blake <eblake@redhat.com>, greg kurz <groug@kaod.org>
Cc: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, jani kokkonen <jani.kokkonen@huawei.com>, qemu-devel@nongnu.org

On Tue 29 Aug 2017 04:23:01 PM CEST, Pradeep Jagadeesh wrote:
> These patches provide the qmp interface, to query the io throttle 
> status of the all fsdev devices that are present in a vm.

I'm trying to read from an 9p share that has limits set with hmp
fsdev_set_io_throttle and I'm having some problems.

For example if I'm reading a large file and I change the I/O limits
while the file is still being read then the guest process freezes.

Can you try to reproduce that scenario?

Berto
