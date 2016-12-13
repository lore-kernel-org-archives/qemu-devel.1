Received: from eggs.gnu.org ([2001:4830:134:3::10]:42397)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cGjPw-00080x-Sd
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 04:30:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cGjPt-0003xe-3S
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 04:30:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50822)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cGjPs-0003xB-Tz
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 04:30:33 -0500
Date: Tue, 13 Dec 2016 09:30:24 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20161213093024.GC12730@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <148161327342.226.10077965724854637760@5b492b8a941d>
	<584FA4A4.3050507@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <584FA4A4.3050507@huawei.com>
Subject: Re: [Qemu-devel] [PATCH for-2.9 v3 0/6] crypto: add HMAC algorithms
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Longpeng (Mike)" <longpeng2@huawei.com>
Cc: QEMU-DEV <qemu-devel@nongnu.org>, famz@redhat.com, arei.gonglei@huawei.com, wu.wubin@huawei.com, jianjay.zhou@huawei.com

On Tue, Dec 13, 2016 at 03:35:00PM +0800, Longpeng (Mike) wrote:
> Hi Daniel,
> 
> The error is due to auto-build environment doesn't support both gcrypt and
> nettle, and it's glibc(2.28) is too old, so I think I should add no-op in
> hmac-glib.c when glibc is older than 2.30. for example:
> 
> #include <...>
> 
> #if GLIB_CHECK_VERSION(2, 30, 0)
> 	....
> #else
> 	...(no-op func)
> #endif
> 
> Do you have any suggestion ?

Yep, you need to wrap the entire hmac-glib.c file in the #if so that you
hide the method impl too.

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
