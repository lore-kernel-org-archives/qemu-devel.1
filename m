Received: from eggs.gnu.org ([2001:4830:134:3::10]:47030)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eAcr6-0004Vz-ED
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 10:21:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eAcr5-00018W-A6
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 10:21:56 -0400
Date: Fri, 3 Nov 2017 14:21:44 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171103142144.GJ20155@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <cover.1509718618.git.berto@igalia.com>
	<ae3d77f312fc0c5e0ac2bbd71676c0112eebe2e5.1509718618.git.berto@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ae3d77f312fc0c5e0ac2bbd71676c0112eebe2e5.1509718618.git.berto@igalia.com>
Subject: Re: [Qemu-devel] [PATCH v2 7/7] qcow2: Assert that the crypto
 header does not overlap other metadata
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, "R . Nageswara Sastry" <nasastry@in.ibm.com>

On Fri, Nov 03, 2017 at 04:18:56PM +0200, Alberto Garcia wrote:
> The crypto header is initialized only when QEMU is creating a new
> image, so there's no chance of this happening on a corrupted image.
> 
> If QEMU is really trying to allocate the header overlapping other
> existing metadata sections then this is a serious bug in QEMU itself
> so let's add an assertion.
> 
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block/qcow2.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Daniel P. Berrange <berrange@redhat.com>


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
