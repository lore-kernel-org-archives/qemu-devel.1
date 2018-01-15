Received: from eggs.gnu.org ([2001:4830:134:3::10]:40275)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eb1I6-0008Gm-Io
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 04:42:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eb1I5-0003Sb-Tq
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 04:42:54 -0500
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:45845)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eb1I5-0003Rv-O9
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 04:42:53 -0500
Received: by mail-ot0-x242.google.com with SMTP id r4so6308777oti.12
	for <qemu-devel@nongnu.org>; Mon, 15 Jan 2018 01:42:53 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <f7aa6594-c3a3-fb42-9147-de8fcbddc848@amsat.org>
References: <1512742372-31517-1-git-send-email-peter.maydell@linaro.org>
	<f7aa6594-c3a3-fb42-9147-de8fcbddc848@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 15 Jan 2018 09:42:32 +0000
Message-ID: <CAFEAcA-6vSyVtwGgGMHYQHd=ebMWi1+0Nheq6=Oc3Mfa0NuGhw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH] hw/intc/armv7m: Support byte
 and halfword accesses to CFSR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Andy Gross <andy.gross@linaro.org>, "patches@linaro.org" <patches@linaro.org>

On 15 January 2018 at 02:34, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> =
wrote:
> Hi Peter,
>
> On 12/08/2017 11:12 AM, Peter Maydell wrote:
>> The Configurable Fault Status Register for ARMv7M and v8M is
>> supposed to be byte and halfword accessible, but we were only
>
> "aligned halfword"

"halfword" is the phrasing the v8M Arm ARM uses. If unaligned
is meant it's always explicitly stated.

>> implementing word accesses. Add support for the other access
>> sizes, which are used by the Zephyr RTOS.

> we have:
>
> static const MemoryRegionOps nvic_sysreg_ops =3D {
>     .read_with_attrs =3D nvic_sysreg_read,
>     .write_with_attrs =3D nvic_sysreg_write,
>     .endianness =3D DEVICE_NATIVE_ENDIAN,
> };
>
> with:
>     /* If true, unaligned accesses are supported.  Otherwise unaligned
>      * accesses throw machine checks.
>      */
>     bool unaligned;
>
> So unaligned halfword should throw excp.
>
> We could add an explicit ".unaligned =3D false,"

That is the default, and assumed by practically every
MemoryRegionOps struct in QEMU...

thanks
-- PMM
