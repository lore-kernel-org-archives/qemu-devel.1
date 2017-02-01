Received: from eggs.gnu.org ([2001:4830:134:3::10]:51741)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cZ2Sm-0003oc-Bk
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 16:29:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cZ2Sl-0001Jk-IW
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 16:29:12 -0500
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170201150553.9381-1-alex.bennee@linaro.org>
	<20170201150553.9381-17-alex.bennee@linaro.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <75cccc44-b1f6-d53c-b605-b3494df6a8a3@twiddle.net>
Date: Wed, 1 Feb 2017 13:29:06 -0800
MIME-Version: 1.0
In-Reply-To: <20170201150553.9381-17-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v9 16/25] cputlb and arm/sparc targets:
 convert mmuidx flushes from varg to bitmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, mttcg@greensocs.com, qemu-devel@nongnu.org, fred.konrad@greensocs.com, a.rigo@virtualopensystems.com, cota@braap.org, bobby.prani@gmail.com, nikunj@linux.vnet.ibm.com
Cc: mark.burton@greensocs.com, pbonzini@redhat.com, jan.kiszka@siemens.com, serge.fdrv@gmail.com, peter.maydell@linaro.org, bamvor.zhangjian@linaro.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>, "open list:ARM" <qemu-arm@nongnu.org>

On 02/01/2017 07:05 AM, Alex Bennée wrote:
> While the vargs approach was flexible the original MTTCG ended up
> having munge the bits to a bitmap so the data could be used in
> deferred work helpers. Instead of hiding that in cputlb we push the
> change to the API to make it take a bitmap of MMU indexes instead.
>
> For ARM some the resulting flushes end up being quite long so to aid
> readability I've tended to move the index shifting to a new line so
> all the bits being or-ed together line up nicely, for example:
>
>     tlb_flush_page_by_mmuidx(other_cs, pageaddr,
>                              (1 << ARMMMUIdx_S1SE1) |
>                              (1 << ARMMMUIdx_S1SE0));
>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> [AT: SPARC part only]
> Reviewed-by: Artyom Tarasenko <atar4qemu@gmail.com>

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
