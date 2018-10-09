Received: from eggs.gnu.org ([2001:4830:134:3::10]:51436)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g9w1C-0001hj-7V
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 13:42:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g9w17-0003t3-Lf
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 13:42:02 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:35728)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1g9w17-0003sc-2d
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 13:41:57 -0400
Received: by mail-pg1-x544.google.com with SMTP id v133-v6so1171417pgb.2
	for <qemu-devel@nongnu.org>; Tue, 09 Oct 2018 10:41:56 -0700 (PDT)
References: <20181009161814.21257-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <d2d9a0ed-dd13-f804-a394-e37843cdbfb0@linaro.org>
Date: Tue, 9 Oct 2018 10:41:52 -0700
MIME-Version: 1.0
In-Reply-To: <20181009161814.21257-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] linux-user: Suppress
 address-of-packed-member warnings in __get/put_user_e
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>, patches@linaro.org

On 10/9/18 9:18 AM, Peter Maydell wrote:
> Our __get_user_e() and __put_user_e() macros cause newer versions
> of clang to generate false-positive -Waddress-of-packed-member
> warnings if they are passed the address of a member of a packed
> struct (see https://bugs.llvm.org/show_bug.cgi?id=39113).
> Suppress these using the _Pragma() operator. Unfortunately
> _Pragma() support in gcc is broken in some gcc versions and
> in some usage contexts, so we limit the pragma usage here to clang.
> 
> To put in the pragmas we need to convert the macros from
> expressions to statements, but all the callsites effectively
> treat them as statements already so this is OK.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Changes v1->v2: _Pragma() in gcc appears to be a disaster area;
> limit the use of it to clang only, since it's just clang that
> emits the bogus warning in this case. Tested on clang-3.8.0,
> clang-7, gcc 5.4.0 and gcc 8.0.1.
> 
>  linux-user/qemu.h | 70 ++++++++++++++++++++++++++++++++++-------------
>  1 file changed, 51 insertions(+), 19 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
