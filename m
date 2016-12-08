Received: from eggs.gnu.org ([2001:4830:134:3::10]:45838)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1cEvch-00047u-Hg
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 05:08:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1cEvce-0006L3-DE
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 05:08:19 -0500
Received: from szxga01-in.huawei.com ([58.251.152.64]:20489)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1cEvcd-0006Gj-Qs
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 05:08:16 -0500
Message-ID: <584930EE.1020303@huawei.com>
Date: Thu, 8 Dec 2016 18:07:42 +0800
From: "Longpeng (Mike)" <longpeng2@huawei.com>
MIME-Version: 1.0
References: <1481164408-194252-1-git-send-email-longpeng2@huawei.com>
	<20161208093316.GA26641@redhat.com>
In-Reply-To: <20161208093316.GA26641@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
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
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: eblake@redhat.com, armbru@redhat.com, wu.wubin@huawei.com, jianjay.zhou@huawei.com, arei.gonglei@huawei.com, qemu-devel@nongnu.org


On 2016/12/8 17:33, Daniel P. Berrange wrote:

> On Thu, Dec 08, 2016 at 10:33:28AM +0800, Longpeng(Mike) wrote:
>> Libgcrypt and nettle support 3des-ede, so this patch add 3des-ede
>> support when using libgcrypt or nettle.
>>
>> Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
>> ---
>> Changes since v1:
>>     - rename 3des-ede to 3des. [Daniel]
>>     - add (since 2.9) in comment. [Gonglei]
>>     - add ctr(3des) testcase. [Gonglei]
>>     - split original patchset. [Gonglei]
>>
>> ---
>>  crypto/cipher-gcrypt.c     |   6 +++
>>  crypto/cipher-nettle.c     |  37 ++++++++++++++
>>  crypto/cipher.c            |   7 ++-
>>  qapi/crypto.json           |   3 +-
>>  tests/test-crypto-cipher.c | 119 +++++++++++++++++++++++++++++++++++++++++++++
>>  5 files changed, 169 insertions(+), 3 deletions(-)
> 
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> 
> Added to my crypto-next queue
> 

Thanks! :)

> 
> Regards,
> Daniel


-- 
Regards,
Longpeng(Mike)
