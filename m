Received: from eggs.gnu.org ([2001:4830:134:3::10]:55484)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eLi2S-0005VQ-D8
	for qemu-devel@nongnu.org; Sun, 03 Dec 2017 23:07:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eLi2P-00019c-8y
	for qemu-devel@nongnu.org; Sun, 03 Dec 2017 23:07:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39884)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eLi2P-00018b-2F
	for qemu-devel@nongnu.org; Sun, 03 Dec 2017 23:07:25 -0500
Date: Mon, 4 Dec 2017 12:07:11 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20171204040711.GB7916@xz-mi>
References: <20171114231350.286025-1-prasad.singamsetty@oracle.com>
	<20171114231350.286025-3-prasad.singamsetty@oracle.com>
	<20171128193156-mutt-send-email-mst@kernel.org>
	<cdbe8732-88fa-512e-481b-250abc18bf92@oracle.com>
	<20171130032551.GA18017@xz-mi>
	<367bb386-2885-2ea2-b766-d5bde2c79bcf@oracle.com>
	<20171130205443-mutt-send-email-mst@kernel.org>
	<fb9c086b-2b95-d09e-1c3f-d2274a347de6@oracle.com>
	<20171201044338.GB2712@xz-mi>
	<736c9e99-0d17-6122-0460-805148567e9d@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <736c9e99-0d17-6122-0460-805148567e9d@oracle.com>
Subject: Re: [Qemu-devel] [PATCH v1 2/2] intel-iommu: Extend address width
 to 48 bits
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Prasad Singamsetty <prasad.singamsetty@oracle.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, ehabkost@redhat.com, konrad.wilk@oracle.com, qemu-devel@nongnu.org, imammedo@redhat.com, pbonzini@redhat.com, rth@twiddle.net

On Fri, Dec 01, 2017 at 09:02:30AM -0800, Prasad Singamsetty wrote:

[...]

> 
> > 
> > And... you may also need to create that PC_COMPAT_2_11 macro after
> > 2.11 is released.  For that you can refer to a6fd5b0e050a.
> > 
> > Anyway, I think this "set default" work can be postponed after recent
> > release, which can be a separate work besides current series.
> 
> OK. To be clear, are you suggesting that we can change the default
> value to 48 bits as a separate patch and not include it with the
> current patch set?

Yes.  Thanks,

-- 
Peter Xu
