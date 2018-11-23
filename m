Received: from eggs.gnu.org ([2001:4830:134:3::10]:58551)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gQ3qv-0001No-Oa
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 00:18:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gQ3qq-0003Cz-SO
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 00:18:05 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34419)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gQ3qq-0003Bz-Lx
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 00:18:00 -0500
Received: by mail-wm1-f66.google.com with SMTP id y185so6790929wmd.1
	for <qemu-devel@nongnu.org>; Thu, 22 Nov 2018 21:18:00 -0800 (PST)
References: <87mw8rumhb.fsf@blackfin.pond.sub.org>
	<87y4s8h5rh.fsf@blackfin.pond.sub.org>
	<876132olyi.fsf@blackfin.pond.sub.org>
	<87a8fucx33.fsf@dusky.pond.sub.org> <87muq2fgbw.fsf@dusky.pond.sub.org>
	<a7902403-7572-9b64-235e-cb6f9e0efbae@redhat.com>
	<alpine.BSF.2.21.9999.1811222249030.51852@zero.eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <30197297-c327-36a9-89f6-6a27eaef4cdf@redhat.com>
Date: Fri, 23 Nov 2018 06:17:57 +0100
MIME-Version: 1.0
In-Reply-To: <alpine.BSF.2.21.9999.1811222249030.51852@zero.eik.bme.hu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] MAINTAINERS leaves too many files uncovered
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>, Thomas Huth <thuth@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu-devel <qemu-devel@nongnu.org>

Hi Zoltan,

On 22/11/18 22:56, BALATON Zoltan wrote:
> On Thu, 22 Nov 2018, Thomas Huth wrote:
>>>      19 hw/display/sm501.c
>>
>> Maybe Balaton wants to adopt this file?
> 
> As discussed before this was originally part of SH4 but since that seems
> to be not actively maintained any more and latest changes were for
> sam460ex I can add it to sam460ex. I planned to do that when I make any
> changes in the future but if needed I can send a patch for this now.
> 
> While we're there, should I also add pc-bios/canyonlands.dts which is
> the device tree for sam460ex?

Yes, I suggest this set:

pc-bios/canyonlands.dt?
pc-bios/u-boot-sam460*
roms/u-boot-sam460ex

Regards,

Phil.
