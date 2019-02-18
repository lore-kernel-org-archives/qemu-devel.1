Received: from eggs.gnu.org ([209.51.188.92]:60458)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gvfH3-0007kB-U7
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 04:31:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gvfGy-0007TK-6Z
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 04:31:38 -0500
Date: Mon, 18 Feb 2019 10:31:14 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190218103114.1f77fe5d.cohuck@redhat.com>
In-Reply-To: <20190218092202.26683-5-david@redhat.com>
References: <20190218092202.26683-1-david@redhat.com>
	<20190218092202.26683-5-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 4/6] tests/device-plug: Add CCW unplug
 test for s390x
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, David Gibson <david@gibson.dropbear.id.au>, Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Collin Walling <walling@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>, "Michael S .
	Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Greg Kurz <groug@kaod.org>, Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

On Mon, 18 Feb 2019 10:22:00 +0100
David Hildenbrand <david@redhat.com> wrote:

> As CCW unplugs are surprise removals without asking the guest first,
> we can test this without any guest interaction.
> 
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  tests/device-plug-test.c | 41 +++++++++++++++++++++++++++++++++++-----
>  1 file changed, 36 insertions(+), 5 deletions(-)

No in-depth review, but looks reasonable.

Acked-by: Cornelia Huck <cohuck@redhat.com>
