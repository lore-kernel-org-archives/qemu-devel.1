Received: from eggs.gnu.org ([2001:4830:134:3::10]:48589)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f9GyP-0004NN-Eq
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 17:20:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f9GyO-0005Pe-LU
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 17:20:09 -0400
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:46287)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1f9GyO-0005Mx-Ft
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 17:20:08 -0400
Received: by mail-pg0-x241.google.com with SMTP id t12so3074849pgp.13
	for <qemu-devel@nongnu.org>; Thu, 19 Apr 2018 14:20:08 -0700 (PDT)
References: <20180419135901.30035-1-alex.bennee@linaro.org>
	<20180419135901.30035-14-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <195829cf-e423-e4fe-dfd8-7d11b5cf74c5@linaro.org>
Date: Thu, 19 Apr 2018 11:20:03 -1000
MIME-Version: 1.0
In-Reply-To: <20180419135901.30035-14-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 13/43] tests/tcg/multiarch: Build fix
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

On 04/19/2018 03:58 AM, Alex Bennée wrote:
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
