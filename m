Received: from eggs.gnu.org ([2001:4830:134:3::10]:33905)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cyYqL-00021B-Oo
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 03:07:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cyYqK-00038X-Tf
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 03:07:01 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170412173203.20072-1-lvivier@redhat.com>
Date: Thu, 13 Apr 2017 09:06:53 +0200
In-Reply-To: <20170412173203.20072-1-lvivier@redhat.com> (Laurent Vivier's
	message of "Wed, 12 Apr 2017 19:32:03 +0200")
Message-ID: <87efwwrdki.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] arm: remove remaining
 cannot_destroy_with_object_finalize_yet
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, Beniamino Galvani <b.galvani@gmail.com>, qemu-arm@nongnu.org, Antony Pavlov <antonynpavlov@gmail.com>, "Edgar E . Iglesias" <edgar.iglesias@gmail.com>, Alistair Francis <alistair.francis@xilinx.com>

Laurent Vivier <lvivier@redhat.com> writes:

> With commit ce5b1bbf624b ("exec: move cpu_exec_init() calls to
> realize functions"), we can now remove all the
> remaining cannot_destroy_with_object_finalize_yet as
> unsafe references have been moved to cpu_exec_realizefn().
> (tested with QOM command provided by commit 4c315c27).

Also tested with device-introspect-test :)

> Suggested-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>

Thanks, Laurent!

Reviewed-by: Markus Armbruster <armbru@redhat.com>

Just three places marking broken devices left: versatile.c
("realview_pci" and "versatile_pci"), target/ppc/kvm.c (various ppc
CPUs).  Volunteers to fix them, so we can get rid of
cannot_destroy_with_object_finalize_yet?
