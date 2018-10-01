Received: from eggs.gnu.org ([2001:4830:134:3::10]:40346)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g6uGL-0000fJ-51
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 05:13:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g6uGG-0004k0-4D
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 05:13:08 -0400
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335]:38958)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1g6uGF-0004YR-DX
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 05:13:03 -0400
Received: by mail-ot1-x335.google.com with SMTP id c20-v6so5737849otl.6
	for <qemu-devel@nongnu.org>; Mon, 01 Oct 2018 02:12:49 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <a5cba9d8-1004-626e-b9c3-5e975f07ca54@amsat.org>
References: <CAFEAcA_gCh-uSbMMbtbH9DsOLgzHhUgMABBSnLOYy7avW7DXxg@mail.gmail.com>
	<a5cba9d8-1004-626e-b9c3-5e975f07ca54@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 1 Oct 2018 10:12:28 +0100
Message-ID: <CAFEAcA8-PmAX4xoC=+gSqFVLTU41dZh-d5GCLHiGBZaHCGF4UQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] finishing the transition away from SysBus init
 methods
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 1 October 2018 at 09:52, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> w=
rote:
> On 9/27/18 10:11 AM, Peter Maydell wrote:
>> I had a look at how many devices are still using the SysBus init
>> method (rather than the instance-init/realize pair), and it turns out
>> to be only 41, which I think is reasonably tractable for doing some
>> more conversions and completing this API transation.
>
> Next would be convert qemu_register_reset() calls from hw/ to use
> DeviceClass::reset().

Yes, where there is a device around. Many of the qemu_register_reset
calls though I think are either devices that haven't been converted
to QOM at all yet, or for parts of the system that aren't devices
at all.

thanks
-- PMM
