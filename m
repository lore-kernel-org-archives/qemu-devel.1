Received: from eggs.gnu.org ([2001:4830:134:3::10]:52846)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1cPlX3-0002Jf-KM
	for qemu-devel@nongnu.org; Sat, 07 Jan 2017 02:35:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1cPlX0-0008Ew-CP
	for qemu-devel@nongnu.org; Sat, 07 Jan 2017 02:35:17 -0500
Received: from szxga01-in.huawei.com ([58.251.152.64]:16804)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1cPlWz-00089X-KE
	for qemu-devel@nongnu.org; Sat, 07 Jan 2017 02:35:14 -0500
Message-ID: <587099D2.5070209@huawei.com>
Date: Sat, 7 Jan 2017 15:33:38 +0800
From: "Longpeng (Mike)" <longpeng2@huawei.com>
MIME-Version: 1.0
References: <1483577381-38088-1-git-send-email-longpeng2@huawei.com>
	<1483577381-38088-3-git-send-email-longpeng2@huawei.com>
	<20170106112803.GG31112@redhat.com>
In-Reply-To: <20170106112803.GG31112@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RESEND 2/6] crypto: add AEAD algorithms
 framework
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: wu.wubin@huawei.com, jianjay.zhou@huawei.com, arei.gonglei@huawei.com, qemu-devel@nongnu.org

Hi Daniel,

On 2017/1/6 19:28, Daniel P. Berrange wrote:

> On Thu, Jan 05, 2017 at 08:49:37AM +0800, Longpeng(Mike) wrote:
>> This patch introduce AEAD algorithms framework.
> 
> So AEAD is essentially just encryption with extra metadata on
> input and output stages. As such I don't think this should be
> implemented via new objects in QEMU.
> 
> Instead, we should add the extra APIs to the existing
> cipher.{c,h} file.
> 
> You've only implemented AES support here, so the code duplication
> is not obvious, but if we were to extend AEAD to other algorithms
> we'd see alot of duplication with the way you've done things.
> 
> So....
> 


All right, I will rework this recently. :)

>> ......

>> -  'data': ['ecb', 'cbc', 'xts', 'ctr']}
>> +  'data': ['ccm', 'gcm', 'ecb', 'cbc', 'xts', 'ctr']}
> 
> This is fine.
> 
> Regards,
> Daniel


-- 
Regards,
Longpeng(Mike)
