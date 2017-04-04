Received: from eggs.gnu.org ([2001:4830:134:3::10]:33526)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cvRiz-0001H2-F5
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 12:54:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cvRiy-0008Ep-PJ
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 12:54:33 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:35550)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cvRiy-0008Ej-LB
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 12:54:32 -0400
Received: by mail-qt0-x242.google.com with SMTP id r5so24043284qtb.2
	for <qemu-devel@nongnu.org>; Tue, 04 Apr 2017 09:54:32 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170403124524.10824-1-alex.bennee@linaro.org>
	<20170403124524.10824-7-alex.bennee@linaro.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <de8802af-69a5-ec35-a3e3-ad622411a730@twiddle.net>
Date: Tue, 4 Apr 2017 09:54:28 -0700
MIME-Version: 1.0
In-Reply-To: <20170403124524.10824-7-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH v1 6/9] cpus: check cpu->running in
 cpu_get_icount_raw()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, dovgaluk@ispras.ru, pbonzini@redhat.com
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, mttcg@greensocs.com, fred.konrad@greensocs.com, a.rigo@virtualopensystems.com, cota@braap.org, bobby.prani@gmail.com, nikunj@linux.vnet.ibm.com, Peter Crosthwaite <crosthwaite.peter@gmail.com>

On 04/03/2017 05:45 AM, Alex Bennée wrote:
> The lifetime of current_cpu is now the lifetime of the vCPU thread.
> However get_icount_raw() can apply a fudge factor if called while code
> is running to take into account the current executed instruction
> count.
>
> To ensure this is always the case we also check cpu->running.
>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  cpus.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
