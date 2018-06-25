Received: from eggs.gnu.org ([2001:4830:134:3::10]:39348)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fXUq1-0001FC-6X
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 12:59:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fXUpy-0007SD-L4
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 12:59:37 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:34515)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1fXUpy-0007S0-EL
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 12:59:34 -0400
Date: Mon, 25 Jun 2018 12:59:31 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20180625165931.GA16777@flamenco>
References: <20180623215313.1252-1-f4bug@amsat.org>
	<2f6b05fd-afb3-cc8d-6b3d-011e2fd87c47@amsat.org>
	<CAMo8BfJWemPTt3fTO5RwGub+1wzyBs3xfh_zY+LBVOhocZ-d3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMo8BfJWemPTt3fTO5RwGub+1wzyBs3xfh_zY+LBVOhocZ-d3w@mail.gmail.com>
Subject: Re: [Qemu-devel] [RFC PATCH] docker: Add debian-xtensa-cross image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Filippov <jcmvbkbc@gmail.com>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Richard Henderson <richard.henderson@linaro.org>

On Sat, Jun 23, 2018 at 20:24:09 -0700, Max Filippov wrote:
> # first bad commit: [0b5c91f74f3c83a36f37740969df8c775c997e69]
> translate-all: use per-page locking in !user-mode
> 
> Emilio, could you please take a look? The following test locks up QEMU:
> 
> qemu-system-xtensa -M sim -cpu dc232b -nographic -semihosting -icount
> 6  -kernel ./test_mmu.tst
> 
> test_mmu.tst binary may be found here:
> http://jcmvbkbc.spb.ru/~dumb/tmp/201806232022/test_mmu.tst

Thanks for the test case.

I submitted a patch that fixes this for me--see this thread:
  https://lists.gnu.org/archive/html/qemu-devel/2018-06/msg07236.html

		Emilio
