Received: from eggs.gnu.org ([2001:4830:134:3::10]:36395)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1duHlG-0000pw-CI
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:36:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1duHlF-0001Ce-FL
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:36:22 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170919123053.32675-1-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <da080365-a722-0885-5061-e27661fe9bb7@amsat.org>
Date: Tue, 19 Sep 2017 09:36:10 -0300
MIME-Version: 1.0
In-Reply-To: <20170919123053.32675-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] hw/audio/wm8750: move WM8750 declarations
 from i2c/i2c.h to audio/wm8750.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@web.de>, Peter Maydell <peter.maydell@linaro.org>, Andrzej Zaborowski <balrogg@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org

On 09/19/2017 09:30 AM, Philippe Mathieu-Daudé wrote:
> while here use TYPE_WM8750 and declare a data_req_cb() typedef.
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>   include/hw/audio/wm8750.h  | 30 ++++++++++++++++++++++++++++++

Also while here I could rename it wm8750_codec.h

>   include/hw/i2c/i2c.h       |  9 ---------
>   hw/arm/musicpal.c          |  3 ++-
>   hw/arm/spitz.c             |  3 ++-
>   hw/arm/z2.c                |  3 ++-
>   hw/audio/marvell_88w8618.c |  1 +
>   hw/audio/wm8750.c          |  6 ++----
>   7 files changed, 39 insertions(+), 16 deletions(-)
>   create mode 100644 include/hw/audio/wm8750.h
