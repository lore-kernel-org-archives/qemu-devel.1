Received: from eggs.gnu.org ([2001:4830:134:3::10]:35610)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1d1kPu-0001a2-ON
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 22:04:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1d1kPr-0005p1-DU
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 22:04:54 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:3495
	helo=dggrg01-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1d1kPq-0005ob-Pt
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 22:04:51 -0400
Message-ID: <58FABA1A.6040309@huawei.com>
Date: Sat, 22 Apr 2017 10:04:10 +0800
From: "Longpeng (Mike)" <longpeng2@huawei.com>
MIME-Version: 1.0
References: <1492392806-53720-1-git-send-email-longpeng2@huawei.com>
	<1492392806-53720-14-git-send-email-longpeng2@huawei.com>
	<33183CC9F5247A488A2544077AF19020DA238C15@DGGEMA505-MBS.china.huawei.com>
	<58FAB39A.9080400@huawei.com>
	<33183CC9F5247A488A2544077AF19020DA2392E2@DGGEMA505-MBS.china.huawei.com>
In-Reply-To: <33183CC9F5247A488A2544077AF19020DA2392E2@DGGEMA505-MBS.china.huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 for-2.10 13/18] crypto: cipher: add
 afalg-backend cipher support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Cc: "berrange@redhat.com" <berrange@redhat.com>, "Huangweidong (C)" <weidong.huang@huawei.com>, "armbru@redhat.com" <armbru@redhat.com>, "eblake@redhat.com" <eblake@redhat.com>, "mst@redhat.com" <mst@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>



On 2017/4/22 9:51, Gonglei (Arei) wrote:

>>
>>
>> On 2017/4/21 20:59, Gonglei (Arei) wrote:
>>
>>>
>>>> -----Original Message-----
>>>> From: longpeng
>>>> Sent: Monday, April 17, 2017 9:33 AM
>>>> To: berrange@redhat.com
>>>> Cc: Gonglei (Arei); Huangweidong (C); armbru@redhat.com;
>>>> eblake@redhat.com; mst@redhat.com; qemu-devel@nongnu.org;
>> longpeng
>>>> Subject: [PATCH v2 for-2.10 13/18] crypto: cipher: add afalg-backend cipher
>>>> support
>>>>
>>>> Adds afalg-backend cipher support: introduces some private APIs
>>>> firstly, and then intergrates them into qcrypto_cipher_afalg_driver.
>>>>
>>>> Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
>>>> ---

>>>> +    char *name;
>>>> +
>>>> +    name = qcrypto_afalg_cipher_format_name(alg, mode, errp);
>>>> +    if (!name) {
>>>> +        return NULL;
>>>> +    }
>>>> +
>>>> +    afalg = qcrypto_afalg_comm_alloc(AFALG_TYPE_CIPHER, name, errp);
>>>> +    if (!afalg) {
>>>> +        goto error;
>>>
>>> Leak memory pointed by name.
>>>
>>
>>
>> It won't.
>>
>> If failed, the control flow is error->cleanup->return, and 'name' will be freed
>> in 'cleanup'.
>>
>> If this method success, then the control flow is cleanup->return, 'name' will
>> also be freed.
>>
> I see. I suggest you can store the name pointer in afalg, then its easily to free
> it in qcrypto_afalg_comm_free(), and we can get enough information about
> the alg/mode if needed.
> 


All right, thanks. :)

> Thanks,
> -Gonglei
> 
> .
> 


-- 
Regards,
Longpeng(Mike)
