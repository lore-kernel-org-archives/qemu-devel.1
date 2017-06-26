Received: from eggs.gnu.org ([2001:4830:134:3::10]:55699)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dPYmY-0001Cv-3J
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 14:30:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dPYmX-0005Ud-BI
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 14:30:42 -0400
Received: from mail-qk0-x235.google.com ([2607:f8b0:400d:c09::235]:34291)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dPYmX-0005UK-7n
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 14:30:41 -0400
Received: by mail-qk0-x235.google.com with SMTP id d78so8152000qkb.1
	for <qemu-devel@nongnu.org>; Mon, 26 Jun 2017 11:30:41 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170625192125.9992-1-laurent@vivier.eu>
	<20170625192125.9992-7-laurent@vivier.eu>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <dc90425c-f247-2ff4-4058-f2b878cb1cd1@twiddle.net>
Date: Mon, 26 Jun 2017 11:30:37 -0700
MIME-Version: 1.0
In-Reply-To: <20170625192125.9992-7-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 6/7] target/m68k: add explicit single and
 double precision operations (part 2)
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

On 06/25/2017 12:21 PM, Laurent Vivier wrote:
> Add fsabs, fdabs, fsneg, fdneg, fsmove and fdmove.
> 
> The value is converted using the new floatx80_round() function.
> 
> Signed-off-by: Laurent Vivier<laurent@vivier.eu>
> ---
>   target/m68k/fpu_helper.c | 48 +++++++++++++++++++++++++++++++++++++++++++++---
>   target/m68k/helper.h     |  8 +++++++-
>   target/m68k/translate.c  | 26 ++++++++++++++++++++++----
>   3 files changed, 74 insertions(+), 8 deletions(-)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
