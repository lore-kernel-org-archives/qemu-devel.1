Received: from eggs.gnu.org ([209.51.188.92]:33409)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1gkc5l-0006WI-Rj
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 16:54:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1gkc5k-0001Mh-QT
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 16:54:21 -0500
Sender: Richard Henderson <rth7680@gmail.com>
References: <20190118171848.27332-1-alex.bennee@linaro.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <79b0e53b-98c9-51e0-5d0d-4831f6f6b5f4@twiddle.net>
Date: Sat, 19 Jan 2019 08:53:57 +1100
MIME-Version: 1.0
In-Reply-To: <20190118171848.27332-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] target/s390x: define TCG_GUEST_DEFAULT_MO
 for MTTCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, "open list:S390" <qemu-s390x@nongnu.org>

On 1/19/19 4:18 AM, Alex Bennée wrote:
> MTTCG should be enabled by default whenever the memory model allows
> it. s390x was missing its definition of TCG_GUEST_DEFAULT_MO meaning
> the user had to manually specify  --accel tcg,thread=multi.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Cc: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/cpu.h | 4 ++++
>  1 file changed, 4 insertions(+)

I thought we had already done this...

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
