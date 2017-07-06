Received: from eggs.gnu.org ([2001:4830:134:3::10]:37163)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dT7QP-0004px-Jp
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 10:06:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dT7QM-0001fQ-DI
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 10:06:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52960)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dT7QM-0001eU-3V
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 10:06:30 -0400
Date: Thu, 6 Jul 2017 15:06:23 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170706140623.GP3988@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1499158630-75260-1-git-send-email-longpeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1499158630-75260-1-git-send-email-longpeng2@huawei.com>
Subject: Re: [Qemu-devel] [PATCH v4 00/18] crypto: add afalg-backend support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Longpeng(Mike)" <longpeng2@huawei.com>
Cc: arei.gonglei@huawei.com, weidong.huang@huawei.com, wangxinxin.wang@huawei.com, qemu-devel@nongnu.org, longpeng.mike@gmail.com

On Tue, Jul 04, 2017 at 04:56:52PM +0800, Longpeng(Mike) wrote:
> The AF_ALG socket family is the userspace interface for linux
> crypto API, users can use it to access hardware accelerators.
> 
> This patchset adds a afalg-backend for qemu crypto subsystem. Currently
> when performs encrypt/decrypt, we'll try afalg-backend first and will
> back to libiary-backend if it failed.
> 
> In the next step, It would support a command parameter to specifies
> which backends prefer to and some other improvements.
> 
> I measured the performance about the afalg-backend impls, I tested
> how many data could be encrypted in 5 seconds.
> 
> NOTE: If we use specific hardware crypto cards, I think afalg-backend
>       would even faster.
> 
> test-environment: Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz
> 
> *sha256*
> chunk_size(bytes)   MB/sec(afalg:sha256-ssse3)  MB/sec(nettle)
> 512                 93.03                       185.87
> 1024                146.32                      201.78
> 2048                213.32                      210.93
> 4096                275.48                      215.26
> 8192                321.77                      217.49
> 16384               349.60                      219.26
> 32768               363.59                      219.73
> 65536               375.79                      219.99
> 
> *hmac(sha256)*
> chunk_size(bytes)   MB/sec(afalg:sha256-ssse3)  MB/sec(nettle)
> 512                 71.26                       165.55
> 1024                117.43                      189.15
> 2048                180.96                      203.24
> 4096                247.60                      211.38
> 8192                301.99                      215.65
> 16384               340.79                      218.22
> 32768               365.51                      219.49
> 65536               377.92                      220.24
> 
> *cbc(aes128)*
> chunk_size(bytes)   MB/sec(afalg:cbc-aes-aesni)  MB/sec(nettle)
> 512                 371.76                       188.41
> 1024                559.86                       189.64
> 2048                768.66                       192.11
> 4096                939.15                       192.40
> 8192                1029.48                      192.49
> 16384               1072.79                      190.52
> 32768               1109.38                      190.41
> 65536               1102.38                      190.40

Thanks for the updated series. I've not had time to look at it yet, but
its on my todo list. I'd like to aim to get this mergable in time for
the 2.10 soft freeze on July 18th.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
