Received: from eggs.gnu.org ([2001:4830:134:3::10]:44033)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dIPU0-0005pN-LJ
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 21:10:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dIPTz-0001kF-QO
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 21:10:00 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:33444)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dIPTz-0001k7-NB
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 21:09:59 -0400
Received: by mail-qk0-x242.google.com with SMTP id c206so15517343qkb.0
	for <qemu-devel@nongnu.org>; Tue, 06 Jun 2017 18:09:59 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170605100014.22981-1-laurent@vivier.eu>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <a2dedfe4-53b2-775f-195a-95827f93b8b9@twiddle.net>
Date: Tue, 6 Jun 2017 18:09:56 -0700
MIME-Version: 1.0
In-Reply-To: <20170605100014.22981-1-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] target/m68k: implement rtd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org

On 06/05/2017 03:00 AM, Laurent Vivier wrote:
> Add "Return and Deallocate" (rtd) instruction.
> 
>    RTD #d
> 
>      (SP) -> PC
>      SP + 4 + d -> SP
> 
> Signed-off-by: Laurent Vivier<laurent@vivier.eu>
> ---
>   target/m68k/cpu.c       |  2 ++
>   target/m68k/cpu.h       |  1 +
>   target/m68k/translate.c | 11 +++++++++++
>   3 files changed, 14 insertions(+)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
