Received: from eggs.gnu.org ([2001:4830:134:3::10]:45518)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dUeRK-0005GN-Cj
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 15:33:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dUeRJ-0003Nx-O3
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 15:33:50 -0400
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170710192128.9048-1-alex.bennee@linaro.org>
	<20170710192128.9048-3-alex.bennee@linaro.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <9cb61dcf-d7b9-9b64-7f94-9e85a87c433d@twiddle.net>
Date: Mon, 10 Jul 2017 09:32:38 -1000
MIME-Version: 1.0
In-Reply-To: <20170710192128.9048-3-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 2/5] target/arm/translate: make
 DISAS_UPDATE match declared semantics
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, peter.maydell@linaro.org, cota@braap.org
Cc: qemu-devel@nongnu.org, "open list:ARM" <qemu-arm@nongnu.org>

On 07/10/2017 09:21 AM, Alex Bennée wrote:
> -        case DISAS_UPDATE:
> -            gen_set_pc_im(dc, dc->pc);
> -            /* fall through */
>           case DISAS_JUMP:
>               gen_goto_ptr();
>               break;
> +        case DISAS_UPDATE:
> +            gen_set_pc_im(dc, dc->pc);
>           default:

Modulo missing fallthru markup,

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
