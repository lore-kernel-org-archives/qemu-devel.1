Received: from eggs.gnu.org ([2001:4830:134:3::10]:45294)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1f1WNB-0003BN-Ab
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 08:09:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1f1WN7-00063i-9A
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 08:09:41 -0400
Date: Thu, 29 Mar 2018 14:09:23 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180329140923.7b6f1c9e.cohuck@redhat.com>
In-Reply-To: <152231460685.69730.14860451936216690693.stgit@bahia.lan>
References: <152231456507.69730.15601462044394150786.stgit@bahia.lan>
	<152231460685.69730.14860451936216690693.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/3] hw/s390x: fix memory leak in
 s390_init_ipl_dev()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, David Hildenbrand <david@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu-s390x@nongnu.org, qemu-stable@nongnu.org

On Thu, 29 Mar 2018 11:10:06 +0200
Greg Kurz <groug@kaod.org> wrote:

> The string returned by object_property_get_str() is dynamically allocated.
> 
> Fixes: 3c4e9baacf4d9
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  hw/s390x/s390-virtio-ccw.c |    5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Thanks, queued to s390-fixes.
