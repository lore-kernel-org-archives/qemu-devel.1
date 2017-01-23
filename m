Received: from eggs.gnu.org ([2001:4830:134:3::10]:53596)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cVjqN-0002JL-Bd
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 13:59:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cVjqJ-0001FR-W9
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 13:59:55 -0500
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:34911)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cVjqJ-0001FM-S9
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 13:59:51 -0500
Received: by mail-qt0-x241.google.com with SMTP id f4so19339789qte.2
	for <qemu-devel@nongnu.org>; Mon, 23 Jan 2017 10:59:51 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170119170507.16185-1-alex.bennee@linaro.org>
	<20170119170507.16185-5-alex.bennee@linaro.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <f89c9cb0-fbb9-4a72-5d76-1489527c968e@twiddle.net>
Date: Mon, 23 Jan 2017 10:59:47 -0800
MIME-Version: 1.0
In-Reply-To: <20170119170507.16185-5-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v7 04/27] tcg: move TCG_MO/BAR types into
 own file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, mttcg@greensocs.com, qemu-devel@nongnu.org, fred.konrad@greensocs.com, a.rigo@virtualopensystems.com, cota@braap.org, bobby.prani@gmail.com, nikunj@linux.vnet.ibm.com
Cc: peter.maydell@linaro.org, claudio.fontana@huawei.com, jan.kiszka@siemens.com, mark.burton@greensocs.com, serge.fdrv@gmail.com, pbonzini@redhat.com, bamvor.zhangjian@linaro.org

On 01/19/2017 09:04 AM, Alex Bennée wrote:
> We'll be using the memory ordering definitions to define values for
> both the host and guest. To avoid fighting with circular header
> dependencies just move these types into their own minimal header.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  tcg/tcg-mo.h | 45 +++++++++++++++++++++++++++++++++++++++++++++
>  tcg/tcg.h    | 18 +-----------------
>  2 files changed, 46 insertions(+), 17 deletions(-)
>  create mode 100644 tcg/tcg-mo.h

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
