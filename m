Received: from eggs.gnu.org ([2001:4830:134:3::10]:49352)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cTRjG-000142-QO
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 06:15:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cTRjB-00015J-UM
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 06:15:06 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:62048)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1cTRjB-00014z-Lu
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 06:15:01 -0500
References: <1477530049-15676-1-git-send-email-laurent@vivier.eu>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <9d04ee0e-ddb8-d42a-0509-80bab83294a1@vivier.eu>
Date: Tue, 17 Jan 2017 12:14:51 +0100
MIME-Version: 1.0
In-Reply-To: <1477530049-15676-1-git-send-email-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] linux-user: manage two new IFLA host
 message types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Riku Voipio <riku.voipio@iki.fi>
Cc: qemu-devel@nongnu.org

Ping?

Laurent

Le 27/10/2016 à 03:00, Laurent Vivier a écrit :
> Add QEMU_IFLA_GSO_MAX_SEGS and QEMU_IFLA_GSO_MAX_SIZE
> in host_to_target_data_link_rtattr().
> 
> These two messages are sent by the host kernel when
> we use "sudo".
> 
> Found with qemu-m68k and Debian etch-m68k (sudo 1.6.8p12-4) and
> host kernel 4.7.6-200.fc24.x86_64
> 
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  linux-user/syscall.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index db697c0..521bdb5 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -2320,6 +2320,8 @@ static abi_long host_to_target_data_link_rtattr(struct rtattr *rtattr)
>      case QEMU_IFLA_GROUP:
>      case QEMU_IFLA_MASTER:
>      case QEMU_IFLA_NUM_VF:
> +    case QEMU_IFLA_GSO_MAX_SEGS:
> +    case QEMU_IFLA_GSO_MAX_SIZE:
>          u32 = RTA_DATA(rtattr);
>          *u32 = tswap32(*u32);
>          break;
> 
