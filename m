Received: from eggs.gnu.org ([2001:4830:134:3::10]:47571)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYN3w-0007pf-H2
	for qemu-devel@nongnu.org; Sun, 07 Jan 2018 21:21:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYN3t-0004mV-DG
	for qemu-devel@nongnu.org; Sun, 07 Jan 2018 21:21:20 -0500
Received: from mail-qk0-x236.google.com ([2607:f8b0:400d:c09::236]:42192)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYN3t-0004lq-8F
	for qemu-devel@nongnu.org; Sun, 07 Jan 2018 21:21:17 -0500
Received: by mail-qk0-x236.google.com with SMTP id d202so12491236qkc.9
	for <qemu-devel@nongnu.org>; Sun, 07 Jan 2018 18:21:17 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180106153730.30313-1-hpoussin@reactos.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <b82e40e0-9202-81b4-3298-a9a37fbb12a0@amsat.org>
Date: Sun, 7 Jan 2018 23:21:12 -0300
MIME-Version: 1.0
In-Reply-To: <20180106153730.30313-1-hpoussin@reactos.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 00/16] piix4: cleanup and improvements
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

On 01/06/2018 12:37 PM, Hervé Poussineau wrote:
> Hi,
> 
> This patchset is a cleanup of the PIIX4 PCI-ISA bridge. Lots of devices
> are moved from MIPS Malta board (which has a PIIX4) to PIIX4, where devices
> belong. This lets us reuse PIIX4 in other machines, while not loosing any
> functionality.
> 
> Last patch allows adding a new PIIX4 device directly from command line.
> Note that this will work only as long no other ISA bus already exist on the
> machine.

I awoke my previous "i386/pc cleanup" series and will respin it RFC with
your patches included, except the last one "piix4: we can now
instanciate a PIIX4 with -device" I need to improve/QOM'ify the generic
superio device.
