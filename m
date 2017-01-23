Received: from eggs.gnu.org ([2001:4830:134:3::10]:55259)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cVjxZ-0006EB-F7
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 14:07:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cVjxY-0003qZ-8B
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 14:07:21 -0500
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:35077)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cVjxY-0003qO-4X
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 14:07:20 -0500
Received: by mail-qt0-x243.google.com with SMTP id f4so19385050qte.2
	for <qemu-devel@nongnu.org>; Mon, 23 Jan 2017 11:07:20 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170119170507.16185-1-alex.bennee@linaro.org>
	<20170119170507.16185-15-alex.bennee@linaro.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <ba083303-3123-00ab-66fc-bc1c9c764bbe@twiddle.net>
Date: Mon, 23 Jan 2017 11:07:15 -0800
MIME-Version: 1.0
In-Reply-To: <20170119170507.16185-15-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v7 14/27] cputlb: tweak
 qemu_ram_addr_from_host_nofail reporting
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
> This moves the helper function closer to where it is called and updates
> the error message to report via error_report instead of the deprecated
> fprintf.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  cputlb.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
