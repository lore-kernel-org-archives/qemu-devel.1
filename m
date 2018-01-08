Received: from eggs.gnu.org ([2001:4830:134:3::10]:46247)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYN1a-0006ld-Tn
	for qemu-devel@nongnu.org; Sun, 07 Jan 2018 21:18:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYN1X-00034k-QJ
	for qemu-devel@nongnu.org; Sun, 07 Jan 2018 21:18:54 -0500
Received: from mail-qk0-x22c.google.com ([2607:f8b0:400d:c09::22c]:41337)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYN1X-00034Z-Lx
	for qemu-devel@nongnu.org; Sun, 07 Jan 2018 21:18:51 -0500
Received: by mail-qk0-x22c.google.com with SMTP id a8so12490134qkb.8
	for <qemu-devel@nongnu.org>; Sun, 07 Jan 2018 18:18:51 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
References: <20180106153730.30313-1-hpoussin@reactos.org>
	<20180106153730.30313-11-hpoussin@reactos.org>
	<ada7b851-7191-6f53-f450-211a08b18c6f@amsat.org>
Message-ID: <3b9082a2-71e9-c846-4a9c-86a22ee435cf@amsat.org>
Date: Sun, 7 Jan 2018 23:18:46 -0300
MIME-Version: 1.0
In-Reply-To: <ada7b851-7191-6f53-f450-211a08b18c6f@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 10/16] piix4: add a i8042 keyboard/mouse
 controller as specified in datasheet
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@mips.com>, "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

Hi Hervé,

> Even if this works, I'm not 100% sure this is correct, since the Malta
> board uses the i8042 from the FDC37M817 superio, not from the PIIX4E
> southbridge.

I checked the datasheet and indeed the PIIX4 is a PCI-ISA bridge but
doesn't provide slow devices such serial/parallel/floppy.
