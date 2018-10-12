Received: from eggs.gnu.org ([2001:4830:134:3::10]:56407)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gB2Gi-0000fa-7x
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 14:34:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gB2Gd-0006ga-2T
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 14:34:36 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:42203)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1gB2Gc-0006fq-O9
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 14:34:30 -0400
References: <20181009161814.21257-1-peter.maydell@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <48b8d25c-3d51-2148-3e52-f5967f8db350@vivier.eu>
Date: Fri, 12 Oct 2018 20:33:48 +0200
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
Cc: patches@linaro.org, Riku Voipio <riku.voipio@iki.fi>

On 09/10/2018 18:18, Peter Maydell wrote:
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
> 

Applied to my branch linux-user-for-3.1

Thanks,
Laurent
