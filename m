Received: from eggs.gnu.org ([2001:4830:134:3::10]:47475)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gMyCy-00048t-Kb
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 11:40:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gMyCr-0002zP-GF
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 11:40:04 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46282)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gMyCr-0002xL-88
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 11:39:57 -0500
Received: by mail-wr1-f68.google.com with SMTP id l9so5144097wrt.13
	for <qemu-devel@nongnu.org>; Wed, 14 Nov 2018 08:39:55 -0800 (PST)
References: <20181114132931.22624-1-marcandre.lureau@redhat.com>
	<16b78816-f2cc-a1e5-0d21-906fc2dbaa3d@redhat.com>
	<a2d9a2fd-2c1a-66e3-86ba-17da9f564e79@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <c0601dcb-142f-3033-b11f-1b951aaf0e3f@redhat.com>
Date: Wed, 14 Nov 2018 17:39:52 +0100
MIME-Version: 1.0
In-Reply-To: <a2d9a2fd-2c1a-66e3-86ba-17da9f564e79@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] vmstate: constify VMStateField
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Fam Zheng <famz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Cornelia Huck <cohuck@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, dgilbert@redhat.com, quintela@redhat.com, "open list:S390" <qemu-s390x@nongnu.org>, "open list:ARM" <qemu-arm@nongnu.org>, "open list:PowerPC" <qemu-ppc@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Paolo Bonzini <pbonzini@redhat.com>, Stafford Horne <shorne@gmail.com>, Richard Henderson <rth@twiddle.net>, Christian Borntraeger <borntraeger@de.ibm.com>, Artyom Tarasenko <atar4qemu@gmail.com>, David Gibson <david@gibson.dropbear.id.au>

Hi Thomas,

On 14/11/18 17:29, Thomas Huth wrote:
> On 2018-11-14 16:32, Philippe Mathieu-Daudé wrote:
>>
>> What about enforcing the constness in the typedef?
>>
>> -- >8 --
>> @@ -32 +32 @@ typedef struct VMStateDescription VMStateDescription;
>> -typedef struct VMStateField VMStateField;
>> +typedef const struct VMStateField VMStateField;
>> ---
> 
> Please don't. For rationale, see:
> https://www.kernel.org/doc/html/v4.19/process/coding-style.html#typedefs

Thanks for the pointer, I am interested in understanding why not do 
that. However in the link you pasted I don't see a rational about 
enforcing constness, I understand that since this case doesn't match the 
5 rules, we should use 'struct VMStateField' directly and remove the 
typedef.
