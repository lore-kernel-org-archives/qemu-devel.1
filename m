Received: from eggs.gnu.org ([209.51.188.92]:59914)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h2KvV-0006qD-OG
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 14:13:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h2KvT-0002kt-Q2
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 14:13:01 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52887)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1h2KvS-0002ih-0P
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 14:12:59 -0500
Received: by mail-wm1-f67.google.com with SMTP id f65so13514031wma.2
	for <qemu-devel@nongnu.org>; Fri, 08 Mar 2019 11:12:56 -0800 (PST)
References: <20190220010232.18731-1-philmd@redhat.com>
	<20190220010232.18731-21-philmd@redhat.com>
	<20190220115316.3e471bff.cohuck@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <a1b27f90-5c20-c23a-ce1b-30e06d06fa08@redhat.com>
Date: Fri, 8 Mar 2019 20:12:53 +0100
MIME-Version: 1.0
In-Reply-To: <20190220115316.3e471bff.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 20/25] s390x/sclp: Use a const variable
 to improve readability
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel@nongnu.org, Prasad J Pandit <pjp@fedoraproject.org>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>, Anthony Perard <anthony.perard@citrix.com>, qemu-ppc@nongnu.org, Stefan Berger <stefanb@linux.ibm.com>, David Gibson <david@gibson.dropbear.id.au>, Gerd Hoffmann <kraxel@redhat.com>, Zhang Chen <zhangckid@gmail.com>, xen-devel@lists.xenproject.org, Samuel Thibault <samuel.thibault@ens-lyon.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Amit Shah <amit@kernel.org>, Li Zhijian <lizhijian@cn.fujitsu.com>, Corey Minyard <minyard@acm.org>, "Michael S. Tsirkin" <mst@redhat.com>, Paul Durrant <paul.durrant@citrix.com>, Halil Pasic <pasic@linux.ibm.com>, Stefano Stabellini <sstabellini@kernel.org>, qemu-s390x@nongnu.org, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>

On 2/20/19 11:53 AM, Cornelia Huck wrote:
> On Wed, 20 Feb 2019 02:02:27 +0100
> Philippe Mathieu-Daudé <philmd@redhat.com> wrote:
> 
>> We will reuse this variable in the next patch.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> ---
>>  hw/char/sclpconsole-lm.c | 7 ++++---
>>  1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/hw/char/sclpconsole-lm.c b/hw/char/sclpconsole-lm.c
>> index dbc91a1e5b..49543e2c83 100644
>> --- a/hw/char/sclpconsole-lm.c
>> +++ b/hw/char/sclpconsole-lm.c
>> @@ -210,13 +210,14 @@ static int process_mdb(SCLPEvent *event, MDBO *mdbo)
>>      int rc;
>>      int len;
>>      uint8_t buffer[SIZE_BUFFER];
>> -
>> -    len = be16_to_cpu(mdbo->length);
>> -    len -= sizeof(mdbo->length) + sizeof(mdbo->type)
>> +    const size_t hlen = sizeof(mdbo->length)
>> +            + sizeof(mdbo->type)
>>              + sizeof(mdbo->mto.line_type_flags)
>>              + sizeof(mdbo->mto.alarm_control)
>>              + sizeof(mdbo->mto._reserved);
>>  
>> +    len = be16_to_cpu(mdbo->length);
>> +    len -= hlen;
>>      assert(len <= SIZE_BUFFER);
>>  
>>      /* convert EBCDIC SCLP contents to ASCII console message */
> 
> I'd probably merge this with the next patch, though.

The context is easier to review in 2 different patches IMHO.

> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> 

Thanks!

Phil.
