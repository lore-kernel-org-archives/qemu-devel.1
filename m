Received: from eggs.gnu.org ([2001:4830:134:3::10]:49841)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d3LeE-0003wS-NX
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 08:02:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d3LeB-0007kV-Mf
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 08:02:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59582)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1d3LeB-0007kL-HH
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 08:02:15 -0400
Date: Wed, 26 Apr 2017 13:02:03 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170426120203.GG18933@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1492845627-4384-1-git-send-email-longpeng2@huawei.com>
	<1492845627-4384-2-git-send-email-longpeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1492845627-4384-2-git-send-email-longpeng2@huawei.com>
Subject: Re: [Qemu-devel] [PATCH v3 01/18] crypto: cipher: introduce context
 free function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Longpeng(Mike)" <longpeng2@huawei.com>
Cc: arei.gonglei@huawei.com, longpeng.mike@gmail.com, qemu-devel@nongnu.org, weidong.huang@huawei.com

On Sat, Apr 22, 2017 at 03:20:10PM +0800, Longpeng(Mike) wrote:
> Refactors the qcrypto_cipher_free(), splits it into two parts. One
> is gcrypt/nettle__cipher_free_ctx() to free the special context.
> 
> This makes code more clear, what's more, it would be used by the
> later patch.
> 
> Reviewed-by: Gonglei <arei.gonglei@huawei.com>
> Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>

Reviewed-by: Daniel P. Berrange <berrange@redhat.com>


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
