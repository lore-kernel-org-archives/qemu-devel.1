Received: from eggs.gnu.org ([2001:4830:134:3::10]:37434)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cYsb9-0000Uq-9q
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 05:57:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cYsb6-00013f-8T
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 05:57:11 -0500
Received: from mail-wm0-x234.google.com ([2a00:1450:400c:c09::234]:37657)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cYsb6-00013Z-0o
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 05:57:08 -0500
Received: by mail-wm0-x234.google.com with SMTP id v77so32291922wmv.0
	for <qemu-devel@nongnu.org>; Wed, 01 Feb 2017 02:57:07 -0800 (PST)
References: <20170127103922.19658-1-alex.bennee@linaro.org>
	<20170127103922.19658-4-alex.bennee@linaro.org>
	<cfcdb82a-fb1b-f48b-0ba4-963ee465e8b7@twiddle.net>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <cfcdb82a-fb1b-f48b-0ba4-963ee465e8b7@twiddle.net>
Date: Wed, 01 Feb 2017 10:57:06 +0000
Message-ID: <87fujy41rx.fsf@linaro.org>
MIME-Version: 1.0
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
To: Richard Henderson <rth@twiddle.net>
Cc: mttcg@greensocs.com, qemu-devel@nongnu.org, fred.konrad@greensocs.com, a.rigo@virtualopensystems.com, cota@braap.org, bobby.prani@gmail.com, nikunj@linux.vnet.ibm.com, mark.burton@greensocs.com, pbonzini@redhat.com, jan.kiszka@siemens.com, serge.fdrv@gmail.com, peter.maydell@linaro.org, claudio.fontana@huawei.com, bamvor.zhangjian@linaro.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>


Richard Henderson <rth@twiddle.net> writes:

> On 01/27/2017 02:39 AM, Alex Bennée wrote:
>> From: Pranith Kumar <bobby.prani@gmail.com>
>>
>> The recent patch enabling lock assertions uncovered the missing lock
>> acquisition in cpu_exec_step(). This patch adds them.
>>
>> CC: Richard Henderson <rth@twiddle.net>
>> CC: Alex Bennée <alex.bennee@linaro.org>
>> Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
>> ---
>>  cpu-exec.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>
> Reviewed-by: Richard Henderson <rth@twiddle.net>
>
> (Didn't I give a r-b for v7 on this?)

You did but my tooling dropped the ball recalling this :-/

(I keep tags in an org-mode file which re-writes (foo) to {foo}
in the subject which was confusing the script looking for un-applied tags).

Anyway done now thanks :-)

--
Alex Bennée
