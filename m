Received: from eggs.gnu.org ([2001:4830:134:3::10]:44123)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dVvyX-0007nQ-HW
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 04:29:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dVvyW-0005fF-Pp
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 04:29:25 -0400
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170713163219.9024-1-marcandre.lureau@redhat.com>
	<20170713163219.9024-7-marcandre.lureau@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <5943fdc0-cacd-a93a-d9c8-f65b1e8d00ca@twiddle.net>
Date: Thu, 13 Jul 2017 22:29:15 -1000
MIME-Version: 1.0
In-Reply-To: <20170713163219.9024-7-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 06/29] pcspk: use QEMU_ALIGN_DOWN
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, peter.maydell@linaro.org, Gerd Hoffmann <kraxel@redhat.com>

On 07/13/2017 06:31 AM, Marc-André Lureau wrote:
> -        s->samples = (PCSPK_BUF_LEN * PIT_FREQ / m * m / (PIT_FREQ >> 1) + 1) >> 1;
> +        s->samples = (QEMU_ALIGN_DOWN(PCSPK_BUF_LEN * PIT_FREQ, m) / (PIT_FREQ >> 1) + 1) >> 1;

Wow.  Um.  Two divisions?

Irritatingly, "m" appears to be the only non-constant.

This a true and correct conversion, so

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
