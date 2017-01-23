Received: from eggs.gnu.org ([2001:4830:134:3::10]:52614)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cVjo0-0000eI-FB
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 13:57:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cVjnx-0008TZ-6S
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 13:57:28 -0500
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:35512)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cVjnx-0008Sj-2N
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 13:57:25 -0500
Received: by mail-qt0-x241.google.com with SMTP id f4so19322266qte.2
	for <qemu-devel@nongnu.org>; Mon, 23 Jan 2017 10:57:24 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170119170507.16185-1-alex.bennee@linaro.org>
	<20170119170507.16185-3-alex.bennee@linaro.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <3424cc87-fe1f-321d-8afe-39a579a76b36@twiddle.net>
Date: Mon, 23 Jan 2017 10:57:20 -0800
MIME-Version: 1.0
In-Reply-To: <20170119170507.16185-3-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v7 02/27] mttcg: translate-all: Enable
 locking debug in a debug build
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, mttcg@greensocs.com, qemu-devel@nongnu.org, fred.konrad@greensocs.com, a.rigo@virtualopensystems.com, cota@braap.org, bobby.prani@gmail.com, nikunj@linux.vnet.ibm.com
Cc: peter.maydell@linaro.org, claudio.fontana@huawei.com, Peter Crosthwaite <crosthwaite.peter@gmail.com>, jan.kiszka@siemens.com, mark.burton@greensocs.com, serge.fdrv@gmail.com, pbonzini@redhat.com, bamvor.zhangjian@linaro.org

On 01/19/2017 09:04 AM, Alex Bennée wrote:
> From: Pranith Kumar <bobby.prani@gmail.com>
> 
> Enable tcg lock debug asserts in a debug build by default instead of
> relying on DEBUG_LOCKING. None of the other DEBUG_* macros have
> asserts, so this patch removes DEBUG_LOCKING and enable these asserts
> in a debug build.
> 
> CC: Richard Henderson <rth@twiddle.net>
> Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
> [AJB: tweak ifdefs so can be early in series]
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  translate-all.c | 52 ++++++++++++++++------------------------------------
>  1 file changed, 16 insertions(+), 36 deletions(-)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
