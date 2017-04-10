Received: from eggs.gnu.org ([2001:4830:134:3::10]:42110)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cxVz5-0000KZ-Hx
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 05:51:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cxVz1-0007sE-RX
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 05:51:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51044)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cxVz1-0007rr-LQ
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 05:51:39 -0400
Date: Mon, 10 Apr 2017 10:51:33 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170410095133.GC3655@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1491814858-63428-1-git-send-email-longpeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1491814858-63428-1-git-send-email-longpeng2@huawei.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10 15/19] tests: crypto: add cipher
 speed case
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Longpeng(Mike)" <longpeng2@huawei.com>
Cc: xuquan8@huawei.com, arei.gonglei@huawei.com, qemu-devel@nongnu.org

On Mon, Apr 10, 2017 at 05:00:58PM +0800, Longpeng(Mike) wrote:
> Now we have afalg-backend and libiary-backend, it's necessary
> to add the speed test in test-crypto-cipher.
> 
> We can use "./tests/test-crypto-cipher speed" to do the speed
> test.

This is not using any of the existing code for the benchmark, so there's
no real benefit to having it in this file.

I'd suggest creating a separate test program for performance benchmarking,
eg  tests/benchmark-crypto-cipher, that would be invoked separately as &
when needed ie skipped by make check-unit, but run by a 'make check-speed'.

Likewise for the other tests you've changed later in this series.


Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
