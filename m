Received: from eggs.gnu.org ([209.51.188.92]:53270)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gjks5-0003Rn-SG
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 08:04:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gjks3-0004w7-IF
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 08:04:41 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35692)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gjks3-0004oM-9E
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 08:04:39 -0500
Received: by mail-wm1-f67.google.com with SMTP id t200so1934007wmt.0
	for <qemu-devel@nongnu.org>; Wed, 16 Jan 2019 05:04:38 -0800 (PST)
References: <20190116121350.23863-1-alex.bennee@linaro.org>
	<0dbd67c55295400980f87a191fc5d22c@AMSPEX02CL03.citrite.net>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <43cd4cd7-6874-5331-5d91-32a7272855ac@redhat.com>
Date: Wed, 16 Jan 2019 14:04:34 +0100
MIME-Version: 1.0
In-Reply-To: <0dbd67c55295400980f87a191fc5d22c@AMSPEX02CL03.citrite.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] hw/block/xen: use proper format string for
 printing sectors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paul Durrant <Paul.Durrant@citrix.com>, =?UTF-8?B?J0FsZXggQmVubsOpZSc=?= <alex.bennee@linaro.org>, "peter.maydell@linaro.org" <peter.maydell@linaro.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:X86" <xen-devel@lists.xenproject.org>, "open list:Block layer core" <qemu-block@nongnu.org>

On 1/16/19 1:19 PM, Paul Durrant wrote:
>> -----Original Message-----
>> From: Alex Bennée [mailto:alex.bennee@linaro.org]
>> Sent: 16 January 2019 12:14
>> To: peter.maydell@linaro.org
>> Cc: qemu-devel@nongnu.org; Alex Bennée <alex.bennee@linaro.org>; Stefano
>> Stabellini <sstabellini@kernel.org>; Anthony Perard
>> <anthony.perard@citrix.com>; Paul Durrant <Paul.Durrant@citrix.com>; Kevin
>> Wolf <kwolf@redhat.com>; Max Reitz <mreitz@redhat.com>; open list:X86
>> <xen-devel@lists.xenproject.org>; open list:Block layer core <qemu-
>> block@nongnu.org>
>> Subject: [PATCH] hw/block/xen: use proper format string for printing
>> sectors
>>
>> The %lu format string is different depending on the host architecture
>> which causes builds like the debian-armhf-cross build to fail. Use the
>> correct PRi64 format string.
>>
>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> This does the same thing as "xen: Fix format string" from Philippe, but this variant is better...

OK.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> 
> Reviewed-by: Paul Durrant <paul.durrant@citrix.com>
> 
>> ---
>>  hw/block/xen-block.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/hw/block/xen-block.c b/hw/block/xen-block.c
>> index be28b63442..a636487b3e 100644
>> --- a/hw/block/xen-block.c
>> +++ b/hw/block/xen-block.c
>> @@ -215,7 +215,7 @@ static void xen_block_realize(XenDevice *xendev, Error
>> **errp)
>>
>>      xen_device_backend_printf(xendev, "sector-size", "%u",
>>                                conf->logical_block_size);
>> -    xen_device_backend_printf(xendev, "sectors", "%lu",
>> +    xen_device_backend_printf(xendev, "sectors", "%"PRIi64,
>>                                blk_getlength(conf->blk) /
>>                                conf->logical_block_size);
>>
>> --
>> 2.17.1
> 
