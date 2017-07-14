Received: from eggs.gnu.org ([2001:4830:134:3::10]:49147)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dVwE5-0005zM-BA
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 04:45:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dVwE4-0005C4-If
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 04:45:29 -0400
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170713163219.9024-1-marcandre.lureau@redhat.com>
	<20170713163219.9024-30-marcandre.lureau@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <075cac00-9a83-4ad3-2e1e-0278ecf36a69@twiddle.net>
Date: Thu, 13 Jul 2017 22:45:21 -1000
MIME-Version: 1.0
In-Reply-To: <20170713163219.9024-30-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 29/29] eepro100: replace
 g_malloc()+memcpy() with g_memdup()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, peter.maydell@linaro.org, Jason Wang <jasowang@redhat.com>

On 07/13/2017 06:32 AM, Marc-André Lureau wrote:
> I found these pattern via grepping the source tree. I don't have a
> coccinelle script for it!
> 
> Signed-off-by: Marc-André Lureau<marcandre.lureau@redhat.com>
> Reviewed-by: Stefan Weil<sw@weilnetz.de>
> Reviewed-by: Jason Wang<jasowang@redhat.com>
> ---
>   hw/net/eepro100.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
