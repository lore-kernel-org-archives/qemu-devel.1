Received: from eggs.gnu.org ([2001:4830:134:3::10]:45554)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1evnO9-0001eP-2N
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 13:07:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1evnO8-0004RG-62
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 13:07:01 -0400
Received: from mail-oi0-x22f.google.com ([2607:f8b0:4003:c06::22f]:35980)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1evnO8-0004Qk-0g
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 13:07:00 -0400
Received: by mail-oi0-x22f.google.com with SMTP id u73so302878oie.3
	for <qemu-devel@nongnu.org>; Tue, 13 Mar 2018 10:06:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <MWHPR21MB01894A8E274ED18E666D43019ED20@MWHPR21MB0189.namprd21.prod.outlook.com>
References: <20180313153458.26822-1-peter.maydell@linaro.org>
	<20180313153458.26822-8-peter.maydell@linaro.org>
	<MWHPR21MB01894A8E274ED18E666D43019ED20@MWHPR21MB0189.namprd21.prod.outlook.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 13 Mar 2018 17:06:38 +0000
Message-ID: <CAFEAcA_KQJQdfTWUfihdesXL12_Xbi8nPCaZ9=Djwz_GvYaFew@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 7/9] hw/arm/bcm2836: Use correct affinity
 values for BCM2837
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Baumann <Andrew.Baumann@microsoft.com>
Cc: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, Pekka Enberg <penberg@iki.fi>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>

On 13 March 2018 at 16:48, Andrew Baumann <Andrew.Baumann@microsoft.com> wrote:
>> From: Peter Maydell <peter.maydell@linaro.org>
>> Sent: Tuesday, 13 March 2018 08:35
>>
>> The BCM2837 sets the Aff1 field of the MPIDR affinity values for the
>> CPUs to 0, whereas the BCM2836 uses 0xf. Set this correctly, as it
>> is required for Linux to boot.
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

>> @@ -119,7 +124,7 @@ static void bcm2836_realize(DeviceState *dev, Error
>> **errp)
>>          /* Mirror bcm2836, which has clusterid set to 0xf
>
> The first line of this comment should probably move or just be deleted. It's not relevant here.

Yeah, simplest just to delete it.

thanks
-- PMM
