Received: from eggs.gnu.org ([2001:4830:134:3::10]:46135)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gDNIM-0000Ad-PR
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 01:25:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gDNIH-00037F-2f
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 01:25:56 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36312)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gDNID-0002ym-9K
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 01:25:51 -0400
Received: by mail-wr1-f66.google.com with SMTP id y16so36007710wrw.3
	for <qemu-devel@nongnu.org>; Thu, 18 Oct 2018 22:25:48 -0700 (PDT)
References: <1539926412-21831-1-git-send-email-liq3ea@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <ccd6a0d2-1938-9795-36b2-4ec02a78d440@redhat.com>
Date: Fri, 19 Oct 2018 07:25:44 +0200
MIME-Version: 1.0
In-Reply-To: <1539926412-21831-1-git-send-email-liq3ea@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 0/7] vfio: some trivial fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@gmail.com>, alex.williamson@redhat.com
Cc: qemu-devel@nongnu.org

On 19/10/2018 07:20, Li Qiang wrote:
> This patch set contains some trivial issue such as
> QOMConvetion, typo and resources leak in vfio.
> 
> Li Qiang (7):
>   vfio-pci: make "vfio-pci-nohotplug" as MACRO
>   vfio: ap-device: make it more QOMConventional
>   vfio: drop TYPE_FOO MACRO in VMStateDescription
>   vfio: paltform: fix a typo

For patches 1-4 that are indeed trivial:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

>   vfio: platform: cleanup the notifier in error path
>   vfio: platform: free timer in error path
>   vfio: platform: destory mutex in error path

Those are less trivial ;)

> 
>  hw/s390x/ap-device.c         |  2 +-
>  hw/vfio/amd-xgbe.c           |  2 +-
>  hw/vfio/ap.c                 | 12 ++++++------
>  hw/vfio/calxeda-xgmac.c      |  2 +-
>  hw/vfio/ccw.c                |  2 +-
>  hw/vfio/pci.c                |  6 ++++--
>  hw/vfio/platform.c           | 12 ++++++++----
>  include/hw/s390x/ap-device.h |  4 ++--
>  8 files changed, 24 insertions(+), 18 deletions(-)
> 
