Received: from eggs.gnu.org ([209.51.188.92]:33546)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gwQBi-0001cB-0y
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 06:37:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gwQBg-0000vB-7W
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 06:37:16 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35189)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gwQBf-0000qF-V6
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 06:37:16 -0500
Received: by mail-wm1-f65.google.com with SMTP id y15so6110877wma.0
	for <qemu-devel@nongnu.org>; Wed, 20 Feb 2019 03:37:15 -0800 (PST)
References: <20190220010232.18731-1-philmd@redhat.com>
	<20190220010232.18731-20-philmd@redhat.com>
	<20190220104051.72f1aca0.cohuck@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <6c470f3f-3678-8d79-e092-02bfe20dc84d@redhat.com>
Date: Wed, 20 Feb 2019 12:37:12 +0100
MIME-Version: 1.0
In-Reply-To: <20190220104051.72f1aca0.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 19/25] s390/ebcdic: Use size_t to
 iterate over arrays
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Prasad J Pandit <pjp@fedoraproject.org>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>, Anthony Perard <anthony.perard@citrix.com>, qemu-ppc@nongnu.org, Stefan Berger <stefanb@linux.ibm.com>, David Gibson <david@gibson.dropbear.id.au>, Gerd Hoffmann <kraxel@redhat.com>, Zhang Chen <zhangckid@gmail.com>, xen-devel@lists.xenproject.org, Samuel Thibault <samuel.thibault@ens-lyon.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Amit Shah <amit@kernel.org>, Li Zhijian <lizhijian@cn.fujitsu.com>, Corey Minyard <minyard@acm.org>, "Michael S. Tsirkin" <mst@redhat.com>, Paul Durrant <paul.durrant@citrix.com>, Halil Pasic <pasic@linux.ibm.com>, Stefano Stabellini <sstabellini@kernel.org>, qemu-s390x@nongnu.org, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>

On 2/20/19 10:40 AM, Cornelia Huck wrote:
> On Wed, 20 Feb 2019 02:02:26 +0100
> Philippe Mathieu-Daudé <philmd@redhat.com> wrote:
> 
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> ---
>>  include/hw/s390x/ebcdic.h | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/include/hw/s390x/ebcdic.h b/include/hw/s390x/ebcdic.h
>> index 69a04cab62..d89174e113 100644
>> --- a/include/hw/s390x/ebcdic.h
>> +++ b/include/hw/s390x/ebcdic.h
>> @@ -83,18 +83,18 @@ static const uint8_t ascii2ebcdic[] = {
>>      0x90, 0x3F, 0x3F, 0x3F, 0x3F, 0xEA, 0x3F, 0xFF
>>  };
>>  
>> -static inline void ebcdic_put(uint8_t *p, const char *ascii, int len)
>> +static inline void ebcdic_put(uint8_t *p, const char *ascii, size_t len)
>>  {
>> -    int i;
>> +    size_t i;
>>  
>>      for (i = 0; i < len; i++) {
>>          p[i] = ascii2ebcdic[(uint8_t)ascii[i]];
>>      }
>>  }
>>  
>> -static inline void ascii_put(uint8_t *p, const char *ebcdic, int len)
>> +static inline void ascii_put(uint8_t *p, const char *ebcdic, size_t len)
>>  {
>> -    int i;
>> +    size_t i;
>>  
>>      for (i = 0; i < len; i++) {
>>          p[i] = ebcdic2ascii[(uint8_t)ebcdic[i]];
> 
> Making the passed len parameter a size_t makes sense; but using a
> size_t as an array iterator looks a bit unidiomatic... it's not wrong,
> though.

This is to silent the "-Wsign-conversion -Wsign-compare" warnings...
I am still not sure what is the best to do.

> Acked-by: Cornelia Huck <cohuck@redhat.com>

Thanks!

Phil.
