Received: from eggs.gnu.org ([2001:4830:134:3::10]:35389)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ceB4e-0004KS-Gm
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 20:41:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ceB4d-00060W-Q6
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 20:41:32 -0500
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:34323)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1ceB4d-0005za-J7
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 20:41:31 -0500
Received: by mail-pf0-x244.google.com with SMTP id o64so299240pfb.1
	for <qemu-devel@nongnu.org>; Wed, 15 Feb 2017 17:41:31 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170207005930.28327-1-laurent@vivier.eu>
	<20170207005930.28327-15-laurent@vivier.eu>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <fb2f3f67-bc4d-ac83-68b9-28d85481e219@twiddle.net>
Date: Thu, 16 Feb 2017 12:41:22 +1100
MIME-Version: 1.0
In-Reply-To: <20170207005930.28327-15-laurent@vivier.eu>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 14/16] target-m68k: add explicit single
 and double precision operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>

On 02/07/2017 11:59 AM, Laurent Vivier wrote:
> +    case 0: /* fmove */
> +        break;
> +    case 0x40: /* fsmove */
> +        gen_helper_redf32_FP0(cpu_env);
> +        gen_helper_extf32_FP0(cpu_env);
> +        break;
> +    case 0x44: /* fdmove */
> +        gen_helper_redf64_FP0(cpu_env);
> +        gen_helper_extf64_FP0(cpu_env);
>          break;

This is going to produce double-rounding errors.  Better to properly set the 
rounding precision first and convert once.


r~
