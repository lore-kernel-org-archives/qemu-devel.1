Received: from eggs.gnu.org ([2001:4830:134:3::10]:43671)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dV29W-0005B8-12
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 16:53:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dV29S-0001u4-5z
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 16:53:02 -0400
Received: from mail-wr0-f175.google.com ([209.85.128.175]:33804)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dV29S-0001tj-03
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 16:52:58 -0400
Received: by mail-wr0-f175.google.com with SMTP id 77so5630369wrb.1
	for <qemu-devel@nongnu.org>; Tue, 11 Jul 2017 13:52:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <6cee176b-a624-4f1d-aba6-e1c9fa011209@amsat.org>
References: <1499771839-32518-1-git-send-email-peter.maydell@linaro.org>
	<1499771839-32518-3-git-send-email-peter.maydell@linaro.org>
	<6cee176b-a624-4f1d-aba6-e1c9fa011209@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 11 Jul 2017 21:51:36 +0100
Message-ID: <CAFEAcA-S7Dr2PuuaReiT0jRps-L=1Zc0uHB87yq8Z5EkR6+pzw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/7] hw/char/cmsdk-apb-uart.c: Implement
 CMSDK APB UART
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>

On 11 July 2017 at 21:42, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wro=
te:
> Hi Peter,
>
> There is probably no need yet, but we could model a generic APB slave wit=
h
> this code, as an overlapping subregion (device top 0x30 bytes).
>
> For now only PID0 differs, but since all ID are 8bit the device could eve=
n
> instantiate the subregion with some u64 PID, 32 CID args.
>
> (thinking about watchdog and dualtimers).

If you look at the pl* primecell devices you'll see that's not
historically how we've done them. I think it would be more
code in each device to instantiate a generic device to
handle the ID register section and a container to put it
in than just to deal with the IDs by hand...

thanks
-- PMM
