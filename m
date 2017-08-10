Received: from eggs.gnu.org ([2001:4830:134:3::10]:51045)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dfjc2-0003GC-TP
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 05:18:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dfjc1-0002Re-UD
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 05:18:42 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170809215510.22802-1-pbonzini@redhat.com>
	<20170809215510.22802-10-pbonzini@redhat.com>
Date: Thu, 10 Aug 2017 11:18:29 +0200
In-Reply-To: <20170809215510.22802-10-pbonzini@redhat.com> (Paolo Bonzini's
	message of "Wed, 9 Aug 2017 23:55:07 +0200")
Message-ID: <87zib7g4re.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 09/12] qemu-iotests: do not search for
 binaries in the current directory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, qemu-block@nongnu.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> Looking in the build root is enough.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

It's actually *better*.  I hate it when tests pick up random garbage I
have lying around.
