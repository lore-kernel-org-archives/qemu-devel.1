Received: from eggs.gnu.org ([2001:4830:134:3::10]:49686)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cw9k2-0005IO-N5
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 11:54:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cw9k1-0000WY-Jg
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 11:54:34 -0400
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170406102249.20383-1-nikunj@linux.vnet.ibm.com>
	<20170406102249.20383-3-nikunj@linux.vnet.ibm.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <4d279bc9-05d6-7fa2-4e65-7547aee74f22@twiddle.net>
Date: Thu, 6 Apr 2017 08:54:30 -0700
MIME-Version: 1.0
In-Reply-To: <20170406102249.20383-3-nikunj@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC v1 2/3] cputlb: handle first atomic
 write to the page
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au
Cc: qemu-devel@nongnu.org, alex.bennee@linaro.org, programmingkidx@gmail.com, bharata@linux.vnet.ibm.com

On 04/06/2017 03:22 AM, Nikunj A Dadhania wrote:
> In case where the conditional write is the first write to the page,
> TLB_NOTDIRTY will be set and stop_the_world is triggered. Handle this as
> a special case and set the dirty bit. After that fall through to the
> actual atomic instruction below.
>
> Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
> ---
>  cputlb.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
