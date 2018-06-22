Received: from eggs.gnu.org ([2001:4830:134:3::10]:38378)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fWTlG-0003Nc-MA
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 17:38:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fWTlD-0006p2-FP
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 17:38:30 -0400
Received: from zero.eik.bme.hu ([152.66.115.2]:40510)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1fWTlD-0006nm-4Q
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 17:38:27 -0400
Date: Fri, 22 Jun 2018 23:38:25 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <592d7d6d3bc7587bc1898c3f9647c6ea@sebastianbauer.info>
Message-ID: <alpine.BSF.2.21.1806222337350.86811@zero.eik.bme.hu>
References: <cover.1529568501.git.balaton@eik.bme.hu>
	<bbdbc993bc9e492916abce1f2a5857f0227e2720.1529568501.git.balaton@eik.bme.hu>
	<3d2dc29e-09b4-7d7e-493f-152613d0d0c0@amsat.org>
	<592d7d6d3bc7587bc1898c3f9647c6ea@sebastianbauer.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/5] sm501: Perform a full update after
 palette change
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sebastian Bauer <mail@sebastianbauer.info>
Cc: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>, David Gibson <david@gibson.dropbear.id.au>

On Fri, 22 Jun 2018, Sebastian Bauer wrote:
> Am 2018-06-22 03:34, schrieb Philippe Mathieu-Daud=C3=A9:
>> On 06/21/2018 05:08 AM, BALATON Zoltan wrote:
>>> From: Sebastian Bauer <mail@sebastianbauer.info>
>>>=20
>>> Changing the palette of a color index has as an immediate effect on
>>> all pixels with the corresponding index on real hardware. Performing =
a
>>> full update after a palette change is a simple way to emulate this
>>> effect.
>>>=20
>>> Signed-off-by: Sebastian Bauer <mail@sebastianbauer.info>
>>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>>> ---
>>>=20
>>> Notes:
>>>     v4: Updated commit message
>>>
>>>  hw/display/sm501.c | 8 ++++++++
>>>  1 file changed, 8 insertions(+)
>>>=20
>>> diff --git a/hw/display/sm501.c b/hw/display/sm501.c
>>> index 0625cf5..a2ee6e3 100644
>>> --- a/hw/display/sm501.c
>>> +++ b/hw/display/sm501.c
>>> @@ -479,6 +479,7 @@ typedef struct SM501State {
>>>      MemoryRegion twoD_engine_region;
>>>      uint32_t last_width;
>>>      uint32_t last_height;
>>> +    uint32_t do_full_update; /* perform a full update next time */
>>=20
>> Can this be a bool?
>
> Yes, this can be a bool. Let me know if you think that this is required=
.

I can take care of this in next submission, no need to resend the patch, =
I=20
can change it to bool.

Regards,
BALATON Zoltan
