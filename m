Received: from eggs.gnu.org ([209.51.188.92]:55128)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gvqqS-0002ro-4k
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 16:53:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gvqqR-0001V4-6V
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 16:53:00 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54219)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gvqqQ-0001MU-1f
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 16:52:58 -0500
Received: by mail-wm1-f67.google.com with SMTP id d15so545058wmb.3
	for <qemu-devel@nongnu.org>; Mon, 18 Feb 2019 13:52:37 -0800 (PST)
References: <cover.1550491301.git.balaton@eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <5166bb43-045e-9f39-8305-50a01aac2115@redhat.com>
Date: Mon, 18 Feb 2019 22:52:35 +0100
MIME-Version: 1.0
In-Reply-To: <cover.1550491301.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 0/3] Misc MIPS fulong2e improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>, Aleksandar Markovic <amarkovic@wavecomp.com>, Huacai Chen <zltjiangshi@gmail.com>

On 2/18/19 1:01 PM, BALATON Zoltan wrote:
> v2 of
> http://lists.nongnu.org/archive/html/qemu-devel/2019-02/msg02477.html
> Addressed review comments and removed last patch (sending it
> separately) to make this series not depend on my ati-vga patch so it
> can be applied independently.
> 
> BALATON Zoltan (3):
>   hw/pci-host/bonito.c: Add PCI mem region mapped at the correct address
>   mips_fulong2e: Fix bios flash size
>   mips_fulong2e: Dynamically generate SPD EEPROM data
> 
>  hw/mips/mips_fulong2e.c | 40 +++++++++++++++++-----------------------
>  hw/pci-host/bonito.c    |  7 ++++++-
>  2 files changed, 23 insertions(+), 24 deletions(-)

For whoever who takes this series, please replace my mojibaked lastname
with:

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

Thanks,

Phil.
