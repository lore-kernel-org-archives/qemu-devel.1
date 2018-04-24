Received: from eggs.gnu.org ([2001:4830:134:3::10]:45064)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1fB2gJ-0007fb-C7
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 14:28:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1fB2gG-0004DL-7p
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 14:28:47 -0400
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:42945)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1fB2gG-0004D9-1u
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 14:28:44 -0400
Received: by mail-pf0-x243.google.com with SMTP id o16so12963855pfk.9
	for <qemu-devel@nongnu.org>; Tue, 24 Apr 2018 11:28:43 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20180424152405.10304-1-alex.bennee@linaro.org>
	<20180424152405.10304-37-alex.bennee@linaro.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <58540476-c2fc-81b7-d806-bad0db73e440@twiddle.net>
Date: Tue, 24 Apr 2018 08:28:37 -1000
MIME-Version: 1.0
In-Reply-To: <20180424152405.10304-37-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 36/46] tests/tcg/alpha: add Alpha
 specific tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, peter.maydell@linaro.org, cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de
Cc: qemu-devel@nongnu.org

On 04/24/2018 05:23 AM, Alex Bennée wrote:
> These tests are a little strange as they use their own crt.o stub
> instead of the system supplied one. We also disable the multiarch
> testthread test as that requires a dynamically linked build.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  tests/tcg/alpha/Makefile         | 35 --------------------------------
>  tests/tcg/alpha/Makefile.target  | 32 +++++++++++++++++++++++++++++
>  tests/tcg/alpha/{crt.s => crt.S} |  0
>  3 files changed, 32 insertions(+), 35 deletions(-)
>  delete mode 100644 tests/tcg/alpha/Makefile
>  create mode 100644 tests/tcg/alpha/Makefile.target
>  rename tests/tcg/alpha/{crt.s => crt.S} (100%)

Now that you have a cross-environment, you could simply drop the crt.o.

There's nothing special in there at all; it was just someone's attempt to
produce tests *without* a fill cross-environment.


r~
