Received: from eggs.gnu.org ([2001:4830:134:3::10]:39505)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fB83z-0002b6-8i
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 20:13:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fB83w-0006H4-Iy
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 20:13:35 -0400
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:42114)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fB83w-0006Gg-Cm
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 20:13:32 -0400
Received: by mail-pf0-x243.google.com with SMTP id o16so13606899pfk.9
	for <qemu-devel@nongnu.org>; Tue, 24 Apr 2018 17:13:32 -0700 (PDT)
References: <20180424152405.10304-1-alex.bennee@linaro.org>
	<20180424152405.10304-14-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <ab647602-cf8a-443f-2f52-5294619ee2b2@linaro.org>
Date: Tue, 24 Apr 2018 14:13:27 -1000
MIME-Version: 1.0
In-Reply-To: <20180424152405.10304-14-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 13/46] tests/tcg/multiarch: Build fix
 for linux-test
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
> From: Fam Zheng <famz@redhat.com>
> 
> To keep the compiler happy, and to fit in our buildsys flags:
> 
> - Make local functions "static"
> - #ifdef out unused functions
> - drop cutils/osdep dependencies
> 
> Signed-off-by: Fam Zheng <famz@redhat.com>
> [AJB: drop cutils/osdep dependencies]
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> ---
>  tests/tcg/multiarch/linux-test.c | 68 ++++++++++----------------------
>  1 file changed, 21 insertions(+), 47 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
