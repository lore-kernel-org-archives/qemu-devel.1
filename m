Received: from eggs.gnu.org ([2001:4830:134:3::10]:41260)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fsAT6-0002ni-0x
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:29:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fsAT0-0001AF-Tm
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:29:23 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:44493)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fsAT0-000175-68
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:29:18 -0400
References: <20180818190118.12911-1-richard.henderson@linaro.org>
	<20180818190118.12911-9-richard.henderson@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <40365d14-0267-89e2-3051-3e6474774d1a@vivier.eu>
Date: Tue, 21 Aug 2018 19:29:14 +0200
MIME-Version: 1.0
In-Reply-To: <20180818190118.12911-9-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 08/16] configure: Use
 -Wunused-const-variable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org

Le 18/08/2018 à 21:01, Richard Henderson a écrit :
> For the linux-user syscall split, we have static const structs
> that must be matched up with a switch statement that uses them.
> By default, gcc will not warn for such a variable, but silently
> remove them.
> 
> For C++, such objects are sometimes declared for their constructor
> side effects.  Do not propagate this flag into QEM_CXXFLAGS.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  configure | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
