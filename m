Received: from eggs.gnu.org ([2001:4830:134:3::10]:47243)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g8qGl-0003KA-3E
	for qemu-devel@nongnu.org; Sat, 06 Oct 2018 13:21:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g8qAi-0005of-0b
	for qemu-devel@nongnu.org; Sat, 06 Oct 2018 13:15:23 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634]:35931)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1g8qAh-0005mV-Qe
	for qemu-devel@nongnu.org; Sat, 06 Oct 2018 13:15:19 -0400
Received: by mail-pl1-x634.google.com with SMTP id y11-v6so5076522plt.3
	for <qemu-devel@nongnu.org>; Sat, 06 Oct 2018 10:15:19 -0700 (PDT)
References: <20181005154910.3099-1-alex.bennee@linaro.org>
	<20181005154910.3099-5-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <753ba406-bf96-e0ee-10ca-26d65956e556@linaro.org>
Date: Sat, 6 Oct 2018 10:15:16 -0700
MIME-Version: 1.0
In-Reply-To: <20181005154910.3099-5-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH 04/21] trace: enable the exec_tb trace
 events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: Peter Crosthwaite <crosthwaite.peter@gmail.com>, cota@braap.org, Pavel.Dovgaluk@ispras.ru, Paolo Bonzini <pbonzini@redhat.com>, vilanova@ac.upc.edu, Richard Henderson <rth@twiddle.net>

On 10/5/18 8:48 AM, Alex Bennée wrote:
> Our performance isn't so critical that we can't spare a simple flag
> check when we exec a TB considering everything else we check in the
> outer loop.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  accel/tcg/trace-events | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
