Received: from eggs.gnu.org ([2001:4830:134:3::10]:36866)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fcUK6-00039b-Bu
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 07:27:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fcUK3-0000EA-5V
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 07:27:18 -0400
Received: from mail-eopbgr700131.outbound.protection.outlook.com
	([40.107.70.131]:38544
	helo=NAM04-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1fcUK2-0000DG-Lf
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 07:27:14 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Mon, 9 Jul 2018 11:27:11 +0000
Message-ID: <BN7PR08MB4868570BBE04A506513CD9E7C6440@BN7PR08MB4868.namprd08.prod.outlook.com>
References: <20180706174309.27110-1-peter.maydell@linaro.org>
In-Reply-To: <20180706174309.27110-1-peter.maydell@linaro.org>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-3.0] hw/net/dp8393x: don't make prom
 region 'nomigrate'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "patches@linaro.org" <patches@linaro.org>, Jason Wang <jasowang@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>

> Currently we use memory_region_init_rom_nomigrate() to create
> the "dp3893x-prom" memory region, and we don't manually register
> it with vmstate_register_ram(). This currently means that its
> contents are migrated but as a ram block whose name is the empty
> string; in future it may mean they are not migrated at all. Use
> memory_region_init_ram() instead.
>
> Note that this is a a cross-version migration compatibility break
> for the MIPS "magnum" and "pica61" machines.
>

As far as MIPS jazz ("magnum" and "pica61") boards are concerned:

Reviewed-by: Aleksandar Markovic <aleksandar.markovic@wavecomp.com>

> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> This is I think the last device that creates a RAM memory
> region and never registers it for migration.  Only used on
> the MIPS 'jazz' boards.
>
>  hw/net/dp8393x.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
