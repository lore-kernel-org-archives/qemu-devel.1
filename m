Received: from eggs.gnu.org ([2001:4830:134:3::10]:50242)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f9H0r-0006N4-KL
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 17:22:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f9H0m-00028o-NA
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 17:22:41 -0400
Received: from mail-pl0-x242.google.com ([2607:f8b0:400e:c01::242]:33411)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1f9H0m-000284-HM
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 17:22:36 -0400
Received: by mail-pl0-x242.google.com with SMTP id w12-v6so3996152plp.0
	for <qemu-devel@nongnu.org>; Thu, 19 Apr 2018 14:22:36 -0700 (PDT)
References: <20180419135901.30035-1-alex.bennee@linaro.org>
	<20180419135901.30035-15-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <a99f5fe3-584a-c91b-6ff7-fe63da2793db@linaro.org>
Date: Thu, 19 Apr 2018 11:22:31 -1000
MIME-Version: 1.0
In-Reply-To: <20180419135901.30035-15-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 14/43] tests/tcg/multiarch: enable
 additional linux-test tests
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
> Un-comment the remaining tests. I removed the itimer value tests
> because I'm fairly sure a re-arming timer will always have a different
> value in it when you grab it.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  tests/tcg/multiarch/linux-test.c | 20 ++++++++------------
>  1 file changed, 8 insertions(+), 12 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
