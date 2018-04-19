Received: from eggs.gnu.org ([2001:4830:134:3::10]:48787)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f9Gyh-0004ec-RY
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 17:20:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f9Gyc-0006qU-Ld
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 17:20:27 -0400
Received: from mail-pg0-x231.google.com ([2607:f8b0:400e:c05::231]:44841)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1f9Gyc-0006mY-Ey
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 17:20:22 -0400
Received: by mail-pg0-x231.google.com with SMTP id l12so3071402pgp.11
	for <qemu-devel@nongnu.org>; Thu, 19 Apr 2018 14:20:22 -0700 (PDT)
References: <20180419135901.30035-1-alex.bennee@linaro.org>
	<20180419135901.30035-13-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <fb2feaf5-740b-9d6e-5895-b11e0020a66c@linaro.org>
Date: Thu, 19 Apr 2018 11:20:16 -1000
MIME-Version: 1.0
In-Reply-To: <20180419135901.30035-13-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 12/43] tests/tcg: move architecture
 independent tests into subdir
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
> We will want to build these for all supported guest architectures so
> lets move them all into one place. We also drop test_path at this
> point because it needs qemu utils and glib bits which is hard to
> support for cross compiling.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> 
> ---
> v2
>   - move VPATH and TESTs setup into multiarch/Makefile.target
>   - remove moved bits from tests/tcg/Makefile
> ---

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
