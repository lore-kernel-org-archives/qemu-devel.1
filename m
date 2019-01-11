Received: from eggs.gnu.org ([209.51.188.92]:54587)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ghujM-00018n-PX
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 06:12:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ghujL-0004BP-To
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 06:12:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35112)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1ghujL-0004At-Nl
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 06:12:03 -0500
Date: Fri, 11 Jan 2019 12:03:55 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190111120355.77883a17.cohuck@redhat.com>
In-Reply-To: <20190110180458.18762-2-ehabkost@redhat.com>
References: <20190110180458.18762-1-ehabkost@redhat.com>
	<20190110180458.18762-2-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 1/2] globals: Allow global properties to
 be optional
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>, "Dr.
	David Alan Gilbert" <dgilbert@redhat.com>

On Thu, 10 Jan 2019 16:04:57 -0200
Eduardo Habkost <ehabkost@redhat.com> wrote:

> Making some global properties optional will let us simplify
> compat code when a given property works on most (but not all)
> subclasses of a given type.
> 
> Device types will be able to opt out from optional compat
> properties by simply not registering those properties.
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
> Changes v2 -> v3:
> * Don't ignore all errors, ignore property only if it doesn't
>   exist
> 
> Changes v1 -> v2:
> * (new patch)
> 
> Note: the "An error is fatal for non-hotplugged devices [...]"
> comment that appears in the diff scope is inaccurate, but I will
> fix that in a separate patch because I don't want this to get
> into the way of fixing the crash.
> ---
>  include/hw/qdev-core.h | 3 +++
>  qom/object.c           | 3 +++
>  2 files changed, 6 insertions(+)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
