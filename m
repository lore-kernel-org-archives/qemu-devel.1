Received: from eggs.gnu.org ([2001:4830:134:3::10]:51398)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d8CH4-0006jb-Q4
	for qemu-devel@nongnu.org; Tue, 09 May 2017 17:02:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d8CH4-0005rF-31
	for qemu-devel@nongnu.org; Tue, 09 May 2017 17:02:26 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:36330)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1d8CH3-0005r9-Ti
	for qemu-devel@nongnu.org; Tue, 09 May 2017 17:02:26 -0400
Received: by mail-qk0-x243.google.com with SMTP id y128so1899266qka.3
	for <qemu-devel@nongnu.org>; Tue, 09 May 2017 14:02:25 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170506111431.12548-1-aurelien@aurel32.net>
	<20170506111431.12548-6-aurelien@aurel32.net>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <4f0b8e1a-dde4-c8a4-b0a8-23636dd18340@twiddle.net>
Date: Tue, 9 May 2017 14:02:22 -0700
MIME-Version: 1.0
In-Reply-To: <20170506111431.12548-6-aurelien@aurel32.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 05/14] target/sh4: fix BS_STOP exit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aurelien Jarno <aurelien@aurel32.net>, qemu-devel@nongnu.org

On 05/06/2017 04:14 AM, Aurelien Jarno wrote:
> When stopping the translation because the state has changed, goto_tb
> should not be used as it might link TB with different flags.
> 
> Signed-off-by: Aurelien Jarno<aurelien@aurel32.net>
> ---
>   target/sh4/translate.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
