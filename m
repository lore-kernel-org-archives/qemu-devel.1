Received: from eggs.gnu.org ([2001:4830:134:3::10]:58174)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dYTGS-0004K4-Qx
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 04:26:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dYTGP-00032V-N9
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 04:26:24 -0400
Received: from chuckie.co.uk ([82.165.15.123]:33019
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1dYTGP-00030w-HB
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 04:26:21 -0400
References: <768886e5-c27a-a6d9-b5f1-b6712c76b7a0@ilande.co.uk>
	<7ca287e3-c496-b58f-7df6-e0e82ea56ff0@ilande.co.uk>
	<CAFEAcA9=Rs1iB9kns0rAg-dTatho0Pa+yELFxGvYyvmEBPF-sg@mail.gmail.com>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <14094daa-0eb4-e818-9e01-998c5c07460e@ilande.co.uk>
Date: Fri, 21 Jul 2017 09:26:11 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9=Rs1iB9kns0rAg-dTatho0Pa+yELFxGvYyvmEBPF-sg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Build failure on git master
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>

On 20/07/17 22:09, Peter Maydell wrote:

>> The fix is seemingly quite simple:
>>
>> diff --git a/block/vpc.c b/block/vpc.c
>> index 10e6519..574879b 100644
>> --- a/block/vpc.c
>> +++ b/block/vpc.c
>> @@ -649,7 +649,7 @@ vpc_co_pwritev(BlockDriverState *bs, uint64_t
>> offset, uint64_t bytes,
>>      int64_t image_offset;
>>      int64_t n_bytes;
>>      int64_t bytes_done = 0;
>> -    int ret;
>> +    int ret = 0;
>>      VHDFooter *footer =  (VHDFooter *) s->footer_buf;
> 
> Yeah, I think 4.7.2 isn't smart enough to realize this is
> a false positive (and that compiler is getting old enough
> that it's not in the set I usually test with).
> 
> Do you want to send a proper patch?

Done. Hopefully one of these days I'll be able to figure out how to
migrate everything on the laptop across to something a bit more modern...


ATB,

Mark.
