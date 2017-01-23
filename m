Received: from eggs.gnu.org ([2001:4830:134:3::10]:53135)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cVjoh-0001B3-5u
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 13:58:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cVjoY-0000YL-TR
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 13:58:11 -0500
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:34710)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cVjoY-0000XY-Pq
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 13:58:02 -0500
Received: by mail-qt0-x244.google.com with SMTP id a29so19327258qtb.1
	for <qemu-devel@nongnu.org>; Mon, 23 Jan 2017 10:58:02 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170119170507.16185-1-alex.bennee@linaro.org>
	<20170119170507.16185-4-alex.bennee@linaro.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <31e2d0be-264e-1464-9021-34d16fb278f5@twiddle.net>
Date: Mon, 23 Jan 2017 10:57:42 -0800
MIME-Version: 1.0
In-Reply-To: <20170119170507.16185-4-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v7 03/27] mttcg: Add missing
 tb_lock/unlock() in cpu_exec_step()
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
> The recent patch enabling lock assertions uncovered the missing lock
> acquisition in cpu_exec_step(). This patch adds them.
> 
> CC: Richard Henderson <rth@twiddle.net>
> CC: Alex Bennée <alex.bennee@linaro.org>
> Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
> ---
>  cpu-exec.c | 4 ++++
>  1 file changed, 4 insertions(+)


Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
