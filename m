Received: from eggs.gnu.org ([2001:4830:134:3::10]:56402)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fJPku-0007k1-0h
	for qemu-devel@nongnu.org; Thu, 17 May 2018 16:44:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fJPkp-0002Cm-4m
	for qemu-devel@nongnu.org; Thu, 17 May 2018 16:44:08 -0400
Received: from mail-pl0-x242.google.com ([2607:f8b0:400e:c01::242]:41687)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fJPko-0002CV-UW
	for qemu-devel@nongnu.org; Thu, 17 May 2018 16:44:03 -0400
Received: by mail-pl0-x242.google.com with SMTP id az12-v6so3222474plb.8
	for <qemu-devel@nongnu.org>; Thu, 17 May 2018 13:44:02 -0700 (PDT)
References: <20180517174718.10107-1-alex.bennee@linaro.org>
	<20180517174718.10107-47-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <e3a15d4b-696d-6631-02ef-dc465f830757@linaro.org>
Date: Thu, 17 May 2018 13:43:58 -0700
MIME-Version: 1.0
In-Reply-To: <20180517174718.10107-47-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 46/49] tests/tcg/Makefile: update to be
 called from Makefile.target
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de
Cc: qemu-devel@nongnu.org

On 05/17/2018 10:47 AM, Alex Bennée wrote:
> This make is now invoked from each individual target make with the
> appropriate CC and EXTRA_CFLAGS set for each guest. It then includes
> additional Makefile.targets from:
> 
>   - tests/tcg/multiarch (always)
>   - tests/tcg/$(TARGET_BASE_ARCH) (if available)
>   - tests/tcg/$(TARGET_NAME)
> 
> The order is important as the later Makefile's may want to suppress
> TESTS from its base arch profile. Each included Makefile.target is
> responsible for adding TESTS as well as defining any special build
> instructions for individual tests.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> ---
> v2
>   - cleaner approach to include sub makefiles
>   - move TESTS/VPATH manipulation into sub-makefile
>   - avoid double inclusion when TARGET_BASE_ARCH==TARGET_NAME
> v4
>   - add timeout to default runner
>   - clean-up comments about build flags
>   - update to handle BUILD_STATIC
>   - add MAINTAINERS entry
> ---

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
