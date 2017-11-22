Received: from eggs.gnu.org ([2001:4830:134:3::10]:35656)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1eHcFb-0007FT-EJ
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 16:08:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1eHcFa-0005hd-HF
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 16:08:07 -0500
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_Ug=6cYD0VD93CorVt+rv_u4WWsa_Gk3k+c18G07bDRg@mail.gmail.com>
References: <20171106154813.19936-1-andrew.smirnov@gmail.com>
	<20171106154813.19936-20-andrew.smirnov@gmail.com>
	<CAFEAcA_Ug=6cYD0VD93CorVt+rv_u4WWsa_Gk3k+c18G07bDRg@mail.gmail.com>
From: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Wed, 22 Nov 2017 13:08:03 -0800
Message-ID: <CAHQ1cqGxtN=hK51v+Gtq7wngp_HKxXJv4tdRin+bKYeEKv1NKw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 19/30] i.MX: Add code to emulate SDMA IP
 block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, Jason Wang <jasowang@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, QEMU Developers <qemu-devel@nongnu.org>, Andrey Yurovsky <yurovsky@gmail.com>

On Tue, Nov 21, 2017 at 10:20 AM, Peter Maydell
<peter.maydell@linaro.org> wrote:
> On 6 November 2017 at 15:48, Andrey Smirnov <andrew.smirnov@gmail.com> wr=
ote:
>> Add minimal code needed to allow upstream Linux guest to boot.
>>
>> Cc: Peter Maydell <peter.maydell@linaro.org>
>> Cc: Jason Wang <jasowang@redhat.com>
>> Cc: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> Cc: qemu-devel@nongnu.org
>> Cc: qemu-arm@nongnu.org
>> Cc: yurovsky@gmail.com
>> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
>> ---
>>  hw/dma/Makefile.objs      |  1 +
>>  hw/dma/imx_sdma.c         | 99 ++++++++++++++++++++++++++++++++++++++++=
+++++++
>>  include/hw/dma/imx_sdma.h | 22 +++++++++++
>>  3 files changed, 122 insertions(+)
>>  create mode 100644 hw/dma/imx_sdma.c
>>  create mode 100644 include/hw/dma/imx_sdma.h
>>
>
> Does Linux really insist on reads-as-written behaviour?
> (ie can you get away with just using
> create_unimplemented_device() ?)
>

Not sure. I'll give it a try for v4.

Thanks,
Andrey Smirnov
