Received: from eggs.gnu.org ([2001:4830:134:3::10]:57099)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1cEYoD-00013U-UR
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 04:46:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1cEYoA-0005up-Tz
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 04:46:42 -0500
Received: from szxga02-in.huawei.com ([119.145.14.65]:48062)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1cEYoA-0005rP-GL
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 04:46:38 -0500
Message-ID: <5847DA6D.20404@huawei.com>
Date: Wed, 7 Dec 2016 17:46:21 +0800
From: "Longpeng (Mike)" <longpeng2@huawei.com>
MIME-Version: 1.0
References: <1481099622-188132-1-git-send-email-longpeng2@huawei.com>
	<1481099622-188132-2-git-send-email-longpeng2@huawei.com>
	<20161207093702.GD21167@redhat.com>
In-Reply-To: <20161207093702.GD21167@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.9 1/2] crypto: add 3des-ede support
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
Cc: eblake@redhat.com, armbru@redhat.com, arei.gonglei@huawei.com, qemu-devel@nongnu.org, wu.wubin@huawei.com, jianjay.zhou@huawei.com

Hi Daniel,

On 2016/12/7 17:37, Daniel P. Berrange wrote:

> On Wed, Dec 07, 2016 at 04:33:41PM +0800, Longpeng(Mike) wrote:
......
>> diff --git a/qapi/crypto.json b/qapi/crypto.json
>> index 5c9d7d4..848b6cd 100644
>> --- a/qapi/crypto.json
>> +++ b/qapi/crypto.json
>> @@ -63,6 +63,7 @@
>>  # @aes-192: AES with 192 bit / 24 byte keys
>>  # @aes-256: AES with 256 bit / 32 byte keys
>>  # @des-rfb: RFB specific variant of single DES. Do not use except in VNC.
>> +# @3des-ede: 3DES-EDE with 192 bit / 24 byte keys
> 
> Lets just call this '3des' as 'ede' is can be assumed, eg
> 
>     # @3des: 3DES (EDE) with 192 bit / 24 byte keys
> 

Okay, I will fix it in V2, thanks. :)

> 
> Regards,
> Daniel


-- 
Regards,
Longpeng(Mike)
