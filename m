Received: from eggs.gnu.org ([2001:4830:134:3::10]:56336)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cxWze-0007ZA-TQ
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 06:56:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cxWzW-0004li-4t
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 06:56:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:10591)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cxWzV-0004lD-VD
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 06:56:14 -0400
Date: Mon, 10 Apr 2017 11:56:08 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170410105608.GK3655@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1491814852-62512-1-git-send-email-longpeng2@huawei.com>
	<20170410101853.GI3655@redhat.com> <58EB63ED.4020504@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <58EB63ED.4020504@huawei.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10 14/19] crypto: cipher: add af_alg
 cipher support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Longpeng (Mike)" <longpeng2@huawei.com>
Cc: xuquan8@huawei.com, arei.gonglei@huawei.com, qemu-devel@nongnu.org

On Mon, Apr 10, 2017 at 06:52:29PM +0800, Longpeng (Mike) wrote:
> 
> On 2017/4/10 18:18, Daniel P. Berrange wrote:
> 
> > On Mon, Apr 10, 2017 at 05:00:52PM +0800, Longpeng(Mike) wrote:
> >> Adds afalg-backend cipher support: introduces some private APIs
> >> firstly, and then intergrates them into qcrypto_cipher_afalg_driver.
> >>
> >> Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
> >> ---
> >>  crypto/Makefile.objs        |   1 +
> >>  crypto/cipher-afalg.c       | 229 ++++++++++++++++++++++++++++++++++++++++++++
> >>  crypto/cipher.c             |  30 +++++-
> >>  include/crypto/afalg-comm.h |  11 +++
> >>  include/crypto/cipher.h     |   7 ++
> >>  tests/test-crypto-cipher.c  |  10 +-
> >>  6 files changed, 286 insertions(+), 2 deletions(-)
> >>  create mode 100644 crypto/cipher-afalg.c
> >>
> > 
> 
> ...
> 
> > 
> > 
> > All methods in this file should be named 'qcrypto_afalg_...'
> > 
> 
> 
> Hi Daniel,
> 
> Now the libiary-backend methods are named as "nettle(gcrypt,glib,builtin)_...",
> so if I rename them with "qcrypto_afalg_" prefix , then the libiary-backend
> methods need with "qcrypto_nettle(gcrypt,glib,builtin)_" prefix , right ?

Yep, that's right - every method in the crypto/ directory should have a
qcrypto_ name prefix, even if it is a static method.


Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
