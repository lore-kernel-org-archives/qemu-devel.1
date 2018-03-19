Received: from eggs.gnu.org ([2001:4830:134:3::10]:41912)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ey2gf-0001Ny-8t
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 17:51:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ey2gc-0003v5-7a
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 17:51:25 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42474 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ey2gc-0003tM-3M
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 17:51:22 -0400
References: <20180319213101.6100-1-wsa+renesas@sang-engineering.com>
	<20180319213101.6100-4-wsa+renesas@sang-engineering.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2071e85f-72b9-9fa5-e5d7-7faa41fb9074@redhat.com>
Date: Mon, 19 Mar 2018 16:51:04 -0500
MIME-Version: 1.0
In-Reply-To: <20180319213101.6100-4-wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 3/3] nvram: at24c: use standard error
 reporting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, qemu-devel@nongnu.org
Cc: linux-renesas-soc@vger.kernel.org, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

On 03/19/2018 04:31 PM, Wolfram Sang wrote:
> Replace the ERR macro with error_report() because fprintf is deprecated.
> This also fixes the prefix printed out twice.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>   hw/nvram/eeprom_at24c.c | 17 ++++++-----------
>   1 file changed, 6 insertions(+), 11 deletions(-)
> 

> @@ -63,8 +61,7 @@ int at24c_eeprom_event(I2CSlave *s, enum i2c_event event)
>           if (ee->blk && ee->changed) {
>               int len = blk_pwrite(ee->blk, 0, ee->mem, ee->rsize, 0);
>               if (len != ee->rsize) {
> -                ERR(TYPE_AT24C_EE
> -                        " : failed to write backing file\n");
> +                error_report("failed to write backing file\n");

Drop the \n here and elsewhere in your patch; error_report() already 
does that for you.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
