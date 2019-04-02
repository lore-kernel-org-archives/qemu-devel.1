Received: from eggs.gnu.org ([209.51.188.92]:44058)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Mateja.Marjanovic@rt-rk.com>) id 1hBGIu-0003bH-Nw
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 06:06:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Mateja.Marjanovic@rt-rk.com>) id 1hBG7o-0008IM-V1
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 05:54:37 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:60626 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Mateja.Marjanovic@rt-rk.com>)
	id 1hBG7o-0007fu-Kd
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 05:54:36 -0400
References: <1554129501-27175-1-git-send-email-mateja.marjanovic@rt-rk.com>
	<1554129501-27175-3-git-send-email-mateja.marjanovic@rt-rk.com>
	<CY4PR2201MB125458E09253D73F9E85D3E7C6550@CY4PR2201MB1254.namprd22.prod.outlook.com>
From: Mateja Marjanovic <Mateja.Marjanovic@rt-rk.com>
Message-ID: <a66b4c12-bc5e-b864-f968-36f695772f4c@rt-rk.com>
Date: Tue, 2 Apr 2019 11:53:34 +0200
MIME-Version: 1.0
In-Reply-To: <CY4PR2201MB125458E09253D73F9E85D3E7C6550@CY4PR2201MB1254.namprd22.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/2] target/mips: MOD_<U|S>.<B|H|W|D> MSA
 insturctions fixed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <amarkovic@wavecomp.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "aurelien@aurel32.net" <aurelien@aurel32.net>, Aleksandar Rikalo <arikalo@wavecomp.com>


On 1.4.19. 19:30, Aleksandar Markovic wrote:
>> From: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
>> Subject: [PATCH 2/2] target/mips: MOD_<U|S>.<B|H|W|D> MSA insturctions=
 fixed
>>
>> From: Mateja Marjanovic <Mateja.Marjanovic@rt-rk.com>
>>
>> In case of dividing integers by zero, the result is unpredictable [1],
>> but according to the hardware, the result is not zero, but the dividen=
d.
>>
>> [1] MIPS=C2=AE Architecture for Programmers
>>     Volume IV-j: The MIPS64=C2=AE SIMD
>>     Architecture Module, Revision 1.12
>>
>> Signed-off-by: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
>> ---
> See the review of the patch 1/2.
Same goes for this, I will change the title in v2.
>
> Thanks,
> Aleksandar
Thanks,
Mateja
