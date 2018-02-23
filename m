Received: from eggs.gnu.org ([2001:4830:134:3::10]:51477)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1epHgB-0003Et-11
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 13:02:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1epHgA-0002Up-1E
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 13:02:43 -0500
Received: from mail-pf0-x229.google.com ([2607:f8b0:400e:c00::229]:34306)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1epHg9-0002Ty-Ra
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 13:02:41 -0500
Received: by mail-pf0-x229.google.com with SMTP id j20so388229pfi.1
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 10:02:41 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAKmqyKNT_qBzg=uCV9C5HJbqH7yxuctBwnoGK0JRKZos+JcPdA@mail.gmail.com>
References: <d131e24b911653a945e46ca2d8f90f572469e1dd.1517856214.git.alistair.francis@xilinx.com>
	<CAKmqyKOw-bced1cbcvJmJE_WM1_W5cEScOf8U+CaD3o9uyuXaw@mail.gmail.com>
	<CAKmqyKNT_qBzg=uCV9C5HJbqH7yxuctBwnoGK0JRKZos+JcPdA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Feb 2018 18:02:20 +0000
Message-ID: <CAFEAcA_RmJJjkZ1ejyGrqF9f4-vXTf=dRrB0Mpt0pF8C8KCgAw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/1] hw: register: Run post_write hook
 on reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>

On 22 February 2018 at 19:45, Alistair Francis
<alistair.francis@xilinx.com> wrote:
> On Thu, Feb 15, 2018 at 3:05 PM, Alistair Francis <alistair23@gmail.com> =
wrote:
>> On Mon, Feb 5, 2018 at 10:44 AM, Alistair Francis
>> <alistair.francis@xilinx.com> wrote:
>>> Ensure that the post write hook is called during reset. This allows us
>>> to rely on the post write functions instead of having to call them from
>>> the reset() function.
>>>
>>> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
>>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>>
>> Ping!
>
> Ping^2

Sorry, not sure why this one got lost -- I'll put it in target-arm.next.

thanks
-- PMM
