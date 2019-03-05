Received: from eggs.gnu.org ([209.51.188.92]:59488)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h1LGA-0004jf-SV
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 20:22:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h1LGA-0004Lk-6K
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 20:22:14 -0500
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:35407)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1h1LGA-0004LX-04
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 20:22:14 -0500
Received: by mail-pf1-x442.google.com with SMTP id j5so7114756pfa.2
	for <qemu-devel@nongnu.org>; Tue, 05 Mar 2019 17:22:13 -0800 (PST)
References: <20190305172139.32662-1-peter.maydell@linaro.org>
	<20190305172139.32662-10-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b45d8f38-4832-fca8-8e42-6410081c8f7f@linaro.org>
Date: Tue, 5 Mar 2019 14:45:52 -0800
MIME-Version: 1.0
In-Reply-To: <20190305172139.32662-10-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 09/12] Makefile,
 configure: Support building rST documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Aleksandar Markovic <amarkovic@wavecomp.com>

On 3/5/19 9:21 AM, Peter Maydell wrote:
> Add support to our configure and makefile machinery for building
> our rST docs into HTML files.
> 
> Building the documentation now requires that sphinx-build is
> available; this seems better than allowing half the docs to
> be built if it is not present but having half of them missing.
> (In particular it means that assuming that distros configured with
> --enable-docs they'll get a helpful error from configure telling
> them the new build dependency.)
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Acked-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Message-id: 20190228145624.24885-10-peter.maydell@linaro.org
> ---
>  configure  | 15 +++++++++++++--
>  Makefile   | 45 ++++++++++++++++++++++++++++++++++++++++++---
>  .gitignore |  1 +
>  3 files changed, 56 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
