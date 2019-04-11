Received: from eggs.gnu.org ([209.51.188.92]:54395)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hEWrw-0002Xe-5X
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 06:23:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hEWkT-0001IS-Ob
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 06:16:02 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36151)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hEWkT-0001IB-Dn
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 06:16:01 -0400
Received: by mail-wr1-f68.google.com with SMTP id y13so6590526wrd.3
	for <qemu-devel@nongnu.org>; Thu, 11 Apr 2019 03:16:01 -0700 (PDT)
References: <20190325090047.122981-1-ysato@users.sourceforge.jp>
	<20190401140318.80498-1-ysato@users.sourceforge.jp>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <655a45ed-cd6b-b8d8-72fa-d4ebca3dcd1a@redhat.com>
Date: Thu, 11 Apr 2019 12:15:59 +0200
MIME-Version: 1.0
In-Reply-To: <20190401140318.80498-1-ysato@users.sourceforge.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC v6 00/12] Add RX archtecture support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org

Hi Yoshinori,

On 4/1/19 4:03 PM, Yoshinori Sato wrote:
> Hello.
> This patch series is added Renesas RX target emulation.
> 
> Update review comments.
> 
> My git repository is bellow.
> git://git.pf.osdn.net/gitroot/y/ys/ysato/qemu.git
> 
> Testing binaries bellow.
> u-boot
> Download - https://osdn.net/users/ysato/pf/qemu/dl/u-boot.bin.gz
> 
> starting
> $ gzip -d u-boot.bin.gz
> $ qemu-system-rx -bios u-boot.bin
> 
> linux and pico-root (only sash)
> Download - https://osdn.net/users/ysato/pf/qemu/dl/zImage (kernel)
>            https://osdn.net/users/ysato/pf/qemu/dl/rx-qemu.dtb (DeviceTree)
> 
> starting
> $ qemu-system-rx -kernel zImage -dtb rx-qemu.dtb -append "earlycon"
> 
> Changes v5.
> Fix undocumented instruction behavior.
> (PUSHM/POPM/RTSD/MVFC/MVTC)
> More useful messages for invalid operands.
[...]
Please don't post your series iterations are as reply to previous
series, it makes harder to find them.

FYI I use Thunderbird as email client, with mails grouped by thread.
Since you sent v4 as reply to v3, and similar v5 -> v4 and this v6 ->
v5, my client kept all subsequent activity folded under the "v3" cover.
Then I missed to review it.

Regards,

Phil.
