Received: from eggs.gnu.org ([2001:4830:134:3::10]:45893)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1cEQZ5-0005QM-AO
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 19:58:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1cEQZ2-0003cO-9y
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 19:58:31 -0500
Received: from szxga02-in.huawei.com ([119.145.14.65]:20329)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1cEQZ1-0003Uw-Ll
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 19:58:28 -0500
Message-ID: <58475E9E.9030704@huawei.com>
Date: Wed, 7 Dec 2016 08:58:06 +0800
From: "Longpeng (Mike)" <longpeng2@huawei.com>
MIME-Version: 1.0
References: <1480928380-161760-1-git-send-email-longpeng2@huawei.com>
	<1480928380-161760-2-git-send-email-longpeng2@huawei.com>
	<50e11e16-6378-8ce0-241a-252272f5b99a@redhat.com>
In-Reply-To: <50e11e16-6378-8ce0-241a-252272f5b99a@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.9 1/3] crypto: add standard des
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: berrange@redhat.com, armbru@redhat.com, arei.gonglei@huawei.com, qemu-devel@nongnu.org, wu.wubin@huawei.com, jianjay.zhou@huawei.com

Hi Eric,

On 2016/12/6 3:15, Eric Blake wrote:

> On 12/05/2016 02:59 AM, Longpeng(Mike) wrote:
>> This patch add standart DES support.
> 
> s/standart/standard/
> 
>>
>> Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
>> ---
> 
>> +++ b/qapi/crypto.json
>> @@ -75,7 +75,7 @@
>>  { 'enum': 'QCryptoCipherAlgorithm',
>>    'prefix': 'QCRYPTO_CIPHER_ALG',
>>    'data': ['aes-128', 'aes-192', 'aes-256',
>> -           'des-rfb',
>> +           'des-rfb', 'des',
> 
> Missing documentation that includes a (since 2.9) blurb
> 

Thanks, but I decide to disable standard single-DES in cryptodev, as suggested
by Daniel.

>>             'cast5-128',
>>             'serpent-128', 'serpent-192', 'serpent-256',
>>             'twofish-128', 'twofish-192', 'twofish-256']}
>>
> 


-- 
Regards,
Longpeng(Mike)
