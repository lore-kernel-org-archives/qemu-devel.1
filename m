Received: from eggs.gnu.org ([2001:4830:134:3::10]:33756)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1euLu5-0006U1-Oa
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 12:34:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1euLu1-0001Q2-RY
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 12:34:01 -0500
Received: from mail-wm0-x22d.google.com ([2a00:1450:400c:c09::22d]:52202)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1euLu1-0001Ph-Kq
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 12:33:57 -0500
Received: by mail-wm0-x22d.google.com with SMTP id h21so5300935wmd.1
	for <qemu-devel@nongnu.org>; Fri, 09 Mar 2018 09:33:57 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180309153654.13518-1-f4bug@amsat.org>
	<20180309153654.13518-6-f4bug@amsat.org>
	<CAFEAcA8jPcjk+sj0FVE8P5dA82GdNDNr-Zg_7T6PGqufr2157A@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <cfecf6c4-0590-f2c5-0263-1561a2633a78@amsat.org>
Date: Fri, 9 Mar 2018 18:33:54 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8jPcjk+sj0FVE8P5dA82GdNDNr-Zg_7T6PGqufr2157A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 5/8] sdcard: Implement the UHS-I
 SWITCH_FUNCTION entries (Spec v3)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

Hi Peter, Edgar.

On 03/09/2018 06:03 PM, Peter Maydell wrote:
> On 9 March 2018 at 15:36, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>> [based on a patch from Alistair Francis <alistair.francis@xilinx.com>
>>  from qemu/xilinx tag xilinx-v2015.2]
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> 
> This should ideally have a Signed-off-by: from somebody @xilinx.com as
> well as you, then.

The original commit is:

https://github.com/Xilinx/qemu/commit/02d2f0203dd#diff-4875140dbdae36a175ad74d6af9bc342R607

  commit 02d2f0203dd489ed30d9c8d90c14a52c57332b25 (tag: xilinx-v2015.2)
  Merge: aa351061db 732f348311
  Author: Alistair Francis <alistair.francis@xilinx.com>
  Date:   Thu Jul 9 14:32:46 2015 -0700

      PetaLinux QEMU v2015.2

      Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>

As you can see the changes are:

- change magic by definitions (SD_FG_MIN, SD_FN_COUNT, SD_FN_COUNT),
- used stw_be_p() in 2 places,
- added tracing.

So no logical change.

Is that enough to add Alistair S-o-b?

Thanks,

Phil.
