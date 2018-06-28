Received: from eggs.gnu.org ([2001:4830:134:3::10]:40020)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fYXjW-0000td-UY
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 10:17:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fYXjS-00024E-00
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 10:17:14 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:42852)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fYXjR-00023i-RO
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 10:17:09 -0400
Received: by mail-qt0-x242.google.com with SMTP id y31-v6so4833249qty.9
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 07:17:09 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180627212152.26525-1-laurent@vivier.eu>
	<20180627212152.26525-2-laurent@vivier.eu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <0f465bb6-317e-b664-3dc7-688471482673@amsat.org>
Date: Thu, 28 Jun 2018 11:16:32 -0300
MIME-Version: 1.0
In-Reply-To: <20180627212152.26525-2-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/2] linux-user: add netlink
 CARRIER_UP_COUNT/CARRIER_DOWN_COUNT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>

On 06/27/2018 06:21 PM, Laurent Vivier wrote:
> Error is reported with libuv test suite:
> 
>  not ok 311 - udp_multicast_interface6
>  # exit code 134
>  # Output from process `udp_multicast_interface6`:
>  # Unknown host QEMU_IFLA type: 47
>  # Unknown host QEMU_IFLA type: 48
>  # Unknown host QEMU_IFLA type: 47
>  # Unknown host QEMU_IFLA type: 48
>  # Unknown host QEMU_IFLA type: 47
>  # Unknown host QEMU_IFLA type: 48
>  # Unknown host QEMU_IFLA type: 47
>  # Unknown host QEMU_IFLA type: 48
>  # Unknown host QEMU_IFLA type: 47
>  # Unknown host QEMU_IFLA type: 48
> 
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  linux-user/syscall.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 2117fb13b4..4460f1e39a 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -2522,6 +2522,8 @@ static abi_long host_to_target_data_link_rtattr(struct rtattr *rtattr)
>      case QEMU_IFLA_NUM_VF:
>      case QEMU_IFLA_GSO_MAX_SEGS:
>      case QEMU_IFLA_GSO_MAX_SIZE:
> +    case QEMU_IFLA_CARRIER_UP_COUNT:
> +    case QEMU_IFLA_CARRIER_DOWN_COUNT:
>          u32 = RTA_DATA(rtattr);
>          *u32 = tswap32(*u32);
>          break;
> 
