Received: from eggs.gnu.org ([2001:4830:134:3::10]:49325)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fQcU8-0002Ou-Pd
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 13:44:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fQcU4-0000Me-U2
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 13:44:36 -0400
Received: from mail-qt0-x22d.google.com ([2607:f8b0:400d:c0d::22d]:35158)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fQcU4-0000Lw-QK
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 13:44:32 -0400
Received: by mail-qt0-x22d.google.com with SMTP id s9-v6so7264596qtg.2
	for <qemu-devel@nongnu.org>; Wed, 06 Jun 2018 10:44:32 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <alpine.BSF.2.21.1806061909150.94568@zero.eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <a580663a-87aa-6423-289c-427ced5175b3@amsat.org>
Date: Wed, 6 Jun 2018 14:44:27 -0300
MIME-Version: 1.0
In-Reply-To: <alpine.BSF.2.21.1806061909150.94568@zero.eik.bme.hu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Stair step trace output since 12fb0ac05
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org

On 06/06/2018 02:15 PM, BALATON Zoltan wrote:
> Since 12fb0ac05 (char: Remove unwanted crlf conversion) trace output is
> printed in stair steps when using -trace and -serial stdio together. E.g.
> $ qemu-system-i386 -trace 'pci*' -serial stdio

True! I'm seeing this too, didn't mind to bisect.

$ arm-softmmu/qemu-system-arm -M lm3s6965evb -serial vc -kernel
sd_card.bin -sd sdcard.img -d trace:sd* -S -monitor stdio
WARNING: Image format was not specified for 'sdcard.img' and probing
guessed raw.

                 Automatically detecting the format is dangerous for raw
images, write operations on block 0 will be restricted.

Specify the 'raw' format explicitly to remove the restrictions.

                                                        QEMU 2.12.50
monitor - type 'help' for more information
(qemu) 24447@1528302742.804868:sdcard_hard_reset power-on

24447@1528302742.804880:sdcard_set_voltage 3.300V (UHS:0)


24447@1528302742.804887:sdcard_soft_reset reset
