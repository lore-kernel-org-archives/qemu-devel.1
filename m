Received: from eggs.gnu.org ([2001:4830:134:3::10]:39137)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cYdrv-0003X5-GO
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 14:13:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cYdru-0001lg-Ep
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 14:13:31 -0500
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:34119)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cYdru-0001lW-BE
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 14:13:30 -0500
Received: by mail-qt0-x241.google.com with SMTP id w20so27695609qtb.1
	for <qemu-devel@nongnu.org>; Tue, 31 Jan 2017 11:13:30 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170127103922.19658-1-alex.bennee@linaro.org>
	<20170127103922.19658-4-alex.bennee@linaro.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <cfcdb82a-fb1b-f48b-0ba4-963ee465e8b7@twiddle.net>
Date: Tue, 31 Jan 2017 11:13:24 -0800
MIME-Version: 1.0
In-Reply-To: <20170127103922.19658-4-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v8 03/25] mttcg: Add missing
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
Cc: mark.burton@greensocs.com, pbonzini@redhat.com, jan.kiszka@siemens.com, serge.fdrv@gmail.com, peter.maydell@linaro.org, claudio.fontana@huawei.com, bamvor.zhangjian@linaro.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>

On 01/27/2017 02:39 AM, Alex Bennée wrote:
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

(Didn't I give a r-b for v7 on this?)


r~
