Received: from eggs.gnu.org ([2001:4830:134:3::10]:36960)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dIyYk-0002zQ-NQ
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 10:37:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dIyYf-0002vm-Sq
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 10:37:14 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <1496931482-29914-1-git-send-email-thuth@redhat.com> (Thomas
	Huth's message of "Thu, 8 Jun 2017 16:18:02 +0200")
References: <1496931482-29914-1-git-send-email-thuth@redhat.com>
Reply-To: quintela@redhat.com
Date: Thu, 08 Jun 2017 16:37:06 +0200
Message-ID: <87tw3qa6lp.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] Makefile: Move balloon.o,
 numa.o and bootdevice.o to common-obj-y
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Andrew Jones <drjones@redhat.com>

Thomas Huth <thuth@redhat.com> wrote:
> There does not seem to be any target specific code in these files, so
> we can put them into "common-obj" instead of "obj" to compile them only
> once for all targets.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>

Again, nothing strange on that files that looks target specific.
