Received: from eggs.gnu.org ([209.51.188.92]:35823)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h0Tkr-0000yk-Uc
	for qemu-devel@nongnu.org; Sun, 03 Mar 2019 11:14:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h0Tkr-0007AC-6G
	for qemu-devel@nongnu.org; Sun, 03 Mar 2019 11:14:21 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35070)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1h0Tkr-000798-05
	for qemu-devel@nongnu.org; Sun, 03 Mar 2019 11:14:21 -0500
Received: by mail-wm1-f66.google.com with SMTP id y15so2413053wma.0
	for <qemu-devel@nongnu.org>; Sun, 03 Mar 2019 08:14:20 -0800 (PST)
References: <20190303000025.3496D7456A0@zero.eik.bme.hu>
	<0ba3b4c7-c0bc-f8d8-66d5-1f3b15eed6ce@redhat.com>
	<alpine.BSF.2.21.9999.1903031316220.1059@zero.eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <33561dc6-a70d-65cd-2c63-27bac14e0a1f@redhat.com>
Date: Sun, 3 Mar 2019 17:14:18 +0100
MIME-Version: 1.0
In-Reply-To: <alpine.BSF.2.21.9999.1903031316220.1059@zero.eik.bme.hu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4] hw/display: Add basic ATI VGA emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

On 3/3/19 1:46 PM, BALATON Zoltan wrote:
> On Sun, 3 Mar 2019, Philippe Mathieu-Daudé wrote:
>> Hi Zoltan,
>>
>> On 3/3/19 12:34 AM, BALATON Zoltan wrote:
>>> At least two machines, the PPC mac99 and MIPS fulong2e, have an ATI
>>> gfx chip by default (Rage 128 Pro and M6/RV100 respectively) and
>>> guests running on these and the PMON2000 firmware of the fulong2e
>>> expect this to be available. Fortunately these are very similar chips
>>> so they can be mostly emulated in the same device model. This patch
>>> adds basic emulation of these ATI VGA chips.
>>>
>>> While this is incomplete and currently only enough to run the MIPS
>>> firmware and get framebuffer output with Linux, it allows the fulong2e
>>> board to work more like the real hardware and having it in QEMU in
>>> this state provides a way to experiment with it and allows others to
>>> contribute to improve it. It is compiled for all archs but only the
>>> fulong2e (which currently has no display output at all) is set to use
>>> it by default (in a patch sent separately).
>>
>> Patch looks good, trivial comment inlined.
> 
> Hello,
> Thanks for yhe review. I took what I liked, [...]

So for your next version:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
