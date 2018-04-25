Received: from eggs.gnu.org ([2001:4830:134:3::10]:40162)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fB86E-0004Qn-Cv
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 20:15:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fB86B-0007cN-Op
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 20:15:54 -0400
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:41892)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fB86B-0007cB-Ie
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 20:15:51 -0400
Received: by mail-pf0-x241.google.com with SMTP id v63so4037117pfk.8
	for <qemu-devel@nongnu.org>; Tue, 24 Apr 2018 17:15:51 -0700 (PDT)
References: <20180424152405.10304-1-alex.bennee@linaro.org>
	<20180424152405.10304-17-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b7589210-3a61-7573-21fc-7124b44a63e5@linaro.org>
Date: Tue, 24 Apr 2018 14:15:45 -1000
MIME-Version: 1.0
In-Reply-To: <20180424152405.10304-17-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 16/46] tests/tcg: move i386 specific
 tests into subdir
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, peter.maydell@linaro.org, cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de
Cc: qemu-devel@nongnu.org

On 04/24/2018 05:23 AM, Alex Bennée wrote:
> These only need to be built for i386 guests. This includes a stub
> tests/tcg/i386/Makfile.target which absorbs some of what was in
> tests/tcg/Makefile.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
> v2
>   - move VPATH and TESTs setup into i386/Makefile.target
>   - set CFLAGS+=-m32 for cross building
> ---

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
