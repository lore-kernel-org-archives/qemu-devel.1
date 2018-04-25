Received: from eggs.gnu.org ([2001:4830:134:3::10]:39772)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fB84q-0003KM-Bb
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 20:14:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fB84n-0006o0-No
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 20:14:28 -0400
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:42120)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fB84n-0006nX-H7
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 20:14:25 -0400
Received: by mail-pf0-x242.google.com with SMTP id o16so13608464pfk.9
	for <qemu-devel@nongnu.org>; Tue, 24 Apr 2018 17:14:25 -0700 (PDT)
References: <20180424152405.10304-1-alex.bennee@linaro.org>
	<20180424152405.10304-15-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <6a0a1284-59c8-9058-9d2e-38d5df3e65ba@linaro.org>
Date: Tue, 24 Apr 2018 14:14:20 -1000
MIME-Version: 1.0
In-Reply-To: <20180424152405.10304-15-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 14/46] tests/tcg/multiarch: enable
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

On 04/24/2018 05:23 AM, Alex Bennée wrote:
> Un-comment the remaining tests.
> 
> I removed the itimer value tests because I'm fairly sure a re-arming
> timer will always have a different value in it when you grab it.
> 
> I've also fixed up the clone thread flags as QEMU will only allow a
> clone to use flags which match glibc.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> ---
> v3
>   - make clone flags match CLONE_THREAD_FLAGS
> ---
>  tests/tcg/multiarch/linux-test.c | 31 +++++++++++++++++--------------
>  1 file changed, 17 insertions(+), 14 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
