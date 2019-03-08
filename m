Received: from eggs.gnu.org ([209.51.188.92]:43404)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1h2Fkk-000267-TZ
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 08:41:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1h2Fkk-0001n1-5q
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 08:41:34 -0500
Received: from mail-qk1-f181.google.com ([209.85.222.181]:40222)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1h2Fkj-0001ez-UU
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 08:41:34 -0500
Received: by mail-qk1-f181.google.com with SMTP id h28so11139927qkk.7
	for <qemu-devel@nongnu.org>; Fri, 08 Mar 2019 05:41:32 -0800 (PST)
Date: Fri, 8 Mar 2019 08:41:29 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190308083958-mutt-send-email-mst@kernel.org>
References: <20190308131445.17502-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190308131445.17502-1-armbru@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 00/12] pc: Support firmware
 configuration with -blockdev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, lersek@redhat.com, kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org, pkrempa@redhat.com, marcel.apfelbaum@gmail.com, marcandre.lureau@redhat.com, philmd@redhat.com

On Fri, Mar 08, 2019 at 02:14:33PM +0100, Markus Armbruster wrote:
> Based-on: <20190308094610.21210-1-armbru@redhat.com>
> 
> v3:
> * PATCH 05: Commit message tidied up [Philippe, László]
> * PATCH 06: Comment tidied up [checkpatch]
> * PATCH 12: Comment polish [László]
> 
> v2:
> * PATCH 05,06: New [Philippe]
> * PATCH 07: Old PATCH 5 rebased onto new patches, with new comment
>   [Philippe]
> * PATCH 08+10: New, factored out of old PATCH 6 [by Philippe]
> * PATCH 09: New [by Philippe]
> * PATCH 11: Remainder of old PATCH 6, with FIXME resolved, literal
>   4096 de-duplicated [László], extraneous error check deleted
>   [László], and comment typos fixed
> * PATCH 12: New
> 
> Markus Armbruster (9):
>   qdev: Fix latent bug with compat_props and onboard devices
>   qom: Move compat_props machinery from qdev to QOM
>   vl: Fix latent bug with -global and onboard devices
>   sysbus: Fix latent bug with onboard devices
>   vl: Improve legibility of BlockdevOptions queue
>   vl: Factor configure_blockdev() out of main()
>   vl: Create block backends before setting machine properties
>   pc: Support firmware configuration with -blockdev
>   docs/interop/firmware.json: Prefer -machine to if=pflash
> 
> Philippe Mathieu-Daudé (3):
>   pflash_cfi01: Add pflash_cfi01_get_blk() helper
>   pc_sysfw: Remove unused PcSysFwDevice
>   pc_sysfw: Pass PCMachineState to pc_system_firmware_init()

OK looks good to me.

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

Paolo will you be merging this?


>  accel/accel.c              |   1 +
>  docs/interop/firmware.json |  20 ++-
>  hw/block/pflash_cfi01.c    |   5 +
>  hw/core/qdev.c             |  21 +---
>  hw/core/sysbus.c           |   3 -
>  hw/i386/pc.c               |   4 +-
>  hw/i386/pc_sysfw.c         | 249 ++++++++++++++++++++++++-------------
>  include/hw/block/flash.h   |   1 +
>  include/hw/i386/pc.h       |   6 +-
>  include/hw/qdev-core.h     |   2 -
>  include/qom/object.h       |   3 +
>  qom/object.c               |  39 ++++++
>  vl.c                       | 125 ++++++++++---------
>  13 files changed, 303 insertions(+), 176 deletions(-)
> 
> -- 
> 2.17.2
