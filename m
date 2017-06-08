Received: from eggs.gnu.org ([2001:4830:134:3::10]:33114)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dIyLb-0005HS-DR
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 10:23:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dIyLa-0004uK-Mn
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 10:23:39 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <1496927934-21815-1-git-send-email-thuth@redhat.com> (Thomas
	Huth's message of "Thu, 8 Jun 2017 15:18:54 +0200")
References: <1496927934-21815-1-git-send-email-thuth@redhat.com>
Reply-To: quintela@redhat.com
Date: Thu, 08 Jun 2017 16:23:34 +0200
Message-ID: <871squblsp.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] hw/cpu: core.c can be compiled as common
 object
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Bharata B Rao <bharata@linux.vnet.ibm.com>, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Andrew Jones <drjones@redhat.com>

Thomas Huth <thuth@redhat.com> wrote:
> There does not seem to be any target specific code in core.c, so we can
> put it into "common-obj" instead of "obj" to compile it only once for
> all targets.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

It compiles.
I can't see anything that is target dependent on core.c.

So

Reviewed-by: Juan Quintela <quintela@redhat.com>
