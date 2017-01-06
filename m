Received: from eggs.gnu.org ([2001:4830:134:3::10]:46025)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cPShY-0000m3-S1
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 06:28:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cPShV-0003Wk-Jz
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 06:28:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39202)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cPShV-0003V4-E3
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 06:28:49 -0500
Date: Fri, 6 Jan 2017 11:28:41 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170106112841.GH31112@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1483577381-38088-1-git-send-email-longpeng2@huawei.com>
	<1483577381-38088-7-git-send-email-longpeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1483577381-38088-7-git-send-email-longpeng2@huawei.com>
Subject: Re: [Qemu-devel] [PATCH RESEND 6/6] crypto: add AEAD algorithms
 testcases
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Longpeng(Mike)" <longpeng2@huawei.com>
Cc: wu.wubin@huawei.com, jianjay.zhou@huawei.com, arei.gonglei@huawei.com, qemu-devel@nongnu.org

On Thu, Jan 05, 2017 at 08:49:41AM +0800, Longpeng(Mike) wrote:
> This patch add some AEAD algorithms testcases
> 
> Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
> ---
>  tests/Makefile.include   |   2 +
>  tests/test-crypto-aead.c | 357 +++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 359 insertions(+)
>  create mode 100644 tests/test-crypto-aead.c

This should also be just part of test-crypto-cipher.c


Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
