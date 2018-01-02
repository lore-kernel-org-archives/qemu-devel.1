Received: from eggs.gnu.org ([2001:4830:134:3::10]:57236)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eWPEa-0004MK-H7
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 11:16:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eWPEZ-0006rw-OD
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 11:16:12 -0500
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:46234)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eWPEZ-0006rE-IP
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 11:16:11 -0500
Received: by mail-pf0-x242.google.com with SMTP id c204so25810691pfc.13
	for <qemu-devel@nongnu.org>; Tue, 02 Jan 2018 08:16:11 -0800 (PST)
References: <20180102011032.30056-1-laurent@vivier.eu>
	<20180102011032.30056-7-laurent@vivier.eu>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <e59dcc83-6982-9cb3-0573-f584b0f5e6fa@linaro.org>
Date: Tue, 2 Jan 2018 08:16:07 -0800
MIME-Version: 1.0
In-Reply-To: <20180102011032.30056-7-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 06/17] target/m68k: manage 680x0 stack
 frames
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: Thomas Huth <huth@tuxfamily.org>

On 01/01/2018 05:10 PM, Laurent Vivier wrote:
> 680x0 manages several stack frame formats:
>   - format 0: four-word stack frame
>   - format 1: four-word throwaway stack frame
>   - format 2: six-word stack frame
>   - format 3: Floating-Point post-instruction stack frame
>   - format 4: eight-word stack frame
>   - format 7: access-error stack frame
> 
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  target/m68k/op_helper.c | 158 +++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 155 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
