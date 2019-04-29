Received: from eggs.gnu.org ([209.51.188.92]:51986)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hLAsO-0006Ta-Fy
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 14:19:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hLAsN-00017D-L5
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 14:19:40 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42260)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hLAsN-00016u-8K
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 14:19:39 -0400
Received: by mail-wr1-f66.google.com with SMTP id l2so1778636wrb.9
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 11:19:39 -0700 (PDT)
References: <20190412165416.7977-1-philmd@redhat.com>
	<CAFEAcA90Pv=zEqaonGV=c022T=CYMo11nkqNwBnGgocESnBNmA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <f56687f4-434e-0e6d-77a8-fec6c33c9a62@redhat.com>
Date: Mon, 29 Apr 2019 20:19:36 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA90Pv=zEqaonGV=c022T=CYMo11nkqNwBnGgocESnBNmA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v3 00/12] hw: Remove
 "hw/devices.h"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>, qemu-arm <qemu-arm@nongnu.org>, Jan Kiszka <jan.kiszka@web.de>, Andrzej Zaborowski <balrogg@gmail.com>

On 4/29/19 6:51 PM, Peter Maydell wrote:
> On Fri, 12 Apr 2019 at 17:55, Philippe Mathieu-Daudé <philmd@redhat.com> wrote:
>>
>> Hi,
>>
>> As his first comment describes itself, the "hw/devices.h" contains
>> declarations for "Devices that have nowhere better to go."
>> This series remove it, creating new headers for devices covered there.
>> MAINTAINERS is updated.
>> I also included 2 cleanups while working on this, in "qemu/typedefs.h"
>> and "hw/net/ne2000-isa.h" header guard.
>>
>> v3:
>> - rebased
>> - added 2 patches suggested by Markus
>> - addressed Markus review comments
>> - added Markus's R-b
> 
> Since these are almost all arm devices I'll take this via the
> target-arm tree (I'm going to make a pullreq later today).

Thanks Peter!
