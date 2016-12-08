Received: from eggs.gnu.org ([2001:4830:134:3::10]:59660)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cEv4y-0005NM-4S
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 04:33:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cEv4u-00023l-H5
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 04:33:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44346)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cEv4u-00023E-CA
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 04:33:24 -0500
Date: Thu, 8 Dec 2016 09:33:16 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20161208093316.GA26641@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1481164408-194252-1-git-send-email-longpeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1481164408-194252-1-git-send-email-longpeng2@huawei.com>
Subject: Re: [Qemu-devel] [PATCH for-2.9 v2] crypto: add 3des-ede support
 when using libgcrypt/nettle
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Longpeng(Mike)" <longpeng2@huawei.com>
Cc: eblake@redhat.com, armbru@redhat.com, wu.wubin@huawei.com, jianjay.zhou@huawei.com, arei.gonglei@huawei.com, qemu-devel@nongnu.org

On Thu, Dec 08, 2016 at 10:33:28AM +0800, Longpeng(Mike) wrote:
> Libgcrypt and nettle support 3des-ede, so this patch add 3des-ede
> support when using libgcrypt or nettle.
> 
> Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
> ---
> Changes since v1:
>     - rename 3des-ede to 3des. [Daniel]
>     - add (since 2.9) in comment. [Gonglei]
>     - add ctr(3des) testcase. [Gonglei]
>     - split original patchset. [Gonglei]
> 
> ---
>  crypto/cipher-gcrypt.c     |   6 +++
>  crypto/cipher-nettle.c     |  37 ++++++++++++++
>  crypto/cipher.c            |   7 ++-
>  qapi/crypto.json           |   3 +-
>  tests/test-crypto-cipher.c | 119 +++++++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 169 insertions(+), 3 deletions(-)

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>

Added to my crypto-next queue


Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
