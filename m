Received: from eggs.gnu.org ([2001:4830:134:3::10]:47790)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d476P-0004tD-SK
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 10:42:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d476M-0006Xu-PD
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 10:42:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51610)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1d476M-0006Xf-Im
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 10:42:30 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170428021317.24711-1-eblake@redhat.com>
	<20170428021317.24711-2-eblake@redhat.com>
Date: Fri, 28 Apr 2017 16:42:27 +0200
In-Reply-To: <20170428021317.24711-2-eblake@redhat.com> (Eric Blake's message
	of "Thu, 27 Apr 2017 21:13:14 -0500")
Message-ID: <87shksbnl8.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v5 1/4] shutdown: Simplify shutdown_signal
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, alistair.francis@xilinx.com

Eric Blake <eblake@redhat.com> writes:

> There is no signal 0 (kill(pid, 0) has special semantics to probe whether
> a process is alive), rather than actually sending a signal 0).  So we
> can use the simpler 0, instead of -1, for our sentinel of whether a
> shutdown request due to a signal has happened.
>
> Suggested-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Eric Blake <eblake@redhat.com>

Reviewed-by: Markus Armbruster <armbru@redhat.com>
