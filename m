Received: from eggs.gnu.org ([2001:4830:134:3::10]:37719)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d1Uip-0003qU-Na
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 05:19:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d1Uim-00029N-Jb
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 05:19:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58382)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1d1Uim-00029H-DN
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 05:19:20 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170412135312.1686-2-lvivier@redhat.com> (Laurent Vivier's
	message of "Wed, 12 Apr 2017 15:53:11 +0200")
References: <20170412135312.1686-1-lvivier@redhat.com>
	<20170412135312.1686-2-lvivier@redhat.com>
Reply-To: quintela@redhat.com
Date: Fri, 21 Apr 2017 11:19:14 +0200
Message-ID: <87tw5idsod.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 1/2] migration: don't close a file
 descriptor while it can be in use
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>
Cc: "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Amit Shah <amit@kernel.org>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>

Laurent Vivier <lvivier@redhat.com> wrote:
> If we close the QEMUFile descriptor in process_incoming_migration_co()
> while it has been stopped by an error, the postcopy_ram_listen_thread()
> can try to continue to use it. And as the memory has been freed
> it is working with an invalid pointer and crashes.
>
> Fix this by releasing the memory after having managed the error
> case (which, in fact, calls exit())
>
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>
