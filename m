Received: from eggs.gnu.org ([2001:4830:134:3::10]:44700)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1cjuFX-0008JK-H6
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 15:56:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1cjuFT-0002Zd-Hv
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 15:56:27 -0500
Date: Fri, 3 Mar 2017 21:56:20 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <CAFEAcA8w9ox2KSSvky6aY3sHG=Xq=h7Wu2F_9UHRtQAKCPTrLg@mail.gmail.com>
Message-ID: <alpine.BSF.2.20.1703032154440.14293@zero.eik.bme.hu>
References: <cover.1488504063.git.balaton@eik.bme.hu>
	<7e582e5ca2aaa7b8b6c1f8a040562b099767ff81.1488504063.git.balaton@eik.bme.hu>
	<CAFEAcA8w9ox2KSSvky6aY3sHG=Xq=h7Wu2F_9UHRtQAKCPTrLg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: Re: [Qemu-devel] [PATCH v3 04/13] sm501: QOMify
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>, Magnus Damm <magnus.damm@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>

On Fri, 3 Mar 2017, Peter Maydell wrote:
> On 3 March 2017 at 01:03, BALATON Zoltan <balaton@eik.bme.hu> wrote:
>> Adding vmstate saving is not in this patch because the state structure
>> will be changed in further patches, then another patch will add
>> vmstate descriptor after those changes.
>>
>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>
>> +static void sm501_init(SM501State *s, DeviceState *dev, uint32_t base,
>> +                       uint32_t local_mem_bytes)
>> +{
>> +    s->base = base;
>> +    s->local_mem_size_index = get_local_mem_size_index(local_mem_bytes);
>> +    SM501_DPRINTF("sm501 local mem size=%x. index=%d\n", get_local_mem_size(s),
>> +                  s->local_mem_size_index);
>> +    if (get_local_mem_size(s) != local_mem_bytes) {
>> +        error_report("Warning: sm501 VRAM size adjusted to %" PRIu32,
>> +                     get_local_mem_size(s));
>> +    }
>
> Just noticed this. I think reporting the error upwards by
> failing device realize is better than adjusting the value.
> It's what we tend to do for other devices. Management tools
> like libvirt prefer to get hard errors if there's a config
> file error that means they misconfigure a device.

Making this change would need rebasing the whole series again an fixing 
conflicts. Do you insist on this or can we live with this warning which is 
closer to the original behaviour of this device?
