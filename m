Received: from eggs.gnu.org ([2001:4830:134:3::10]:58427)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eEIWE-0006B8-6C
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 12:27:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eEIWA-0002sy-Sx
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 12:27:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49386)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1eEIWA-0002sp-N3
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 12:27:30 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20171110173421.17904-1-lprosek@redhat.com>
	<20171110173421.17904-4-lprosek@redhat.com>
Date: Mon, 13 Nov 2017 18:27:26 +0100
In-Reply-To: <20171110173421.17904-4-lprosek@redhat.com> (Ladi Prosek's
	message of "Fri, 10 Nov 2017 18:34:21 +0100")
Message-ID: <878tfaytq9.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 3/3] ivshmem: Improve MSI irqfd error
 handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ladi Prosek <lprosek@redhat.com>
Cc: qemu-devel@nongnu.org, geoff@hostfission.com, pbonzini@redhat.com, marcandre.lureau@redhat.com

Ladi Prosek <lprosek@redhat.com> writes:

> Adds a rollback path to ivshmem_enable_irqfd() and fixes
> ivshmem_disable_irqfd() to bail if irqfd has not been enabled.
>
> Signed-off-by: Ladi Prosek <lprosek@redhat.com>

Is this a theoretical bug, or can you trigger it?
