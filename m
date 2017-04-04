Received: from eggs.gnu.org ([2001:4830:134:3::10]:33273)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cvRiN-0000pZ-CO
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 12:53:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cvRiL-00086Q-Q4
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 12:53:55 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:35168)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cvRiL-00086G-MD
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 12:53:53 -0400
Received: by mail-qk0-x243.google.com with SMTP id k139so13118820qke.2
	for <qemu-devel@nongnu.org>; Tue, 04 Apr 2017 09:53:53 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170403124524.10824-1-alex.bennee@linaro.org>
	<20170403124524.10824-6-alex.bennee@linaro.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <cd71e975-4ca7-65ec-33d1-fb63a96e14f2@twiddle.net>
Date: Tue, 4 Apr 2017 09:53:49 -0700
MIME-Version: 1.0
In-Reply-To: <20170403124524.10824-6-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH v1 5/9] cpus: remove icount handling
 from qemu_tcg_cpu_thread_fn
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
> We should never be running in multi-threaded mode with icount enabled.
> There is no point calling handle_icount_deadline here so remove it and
> assert !use_icount.
>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  cpus.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
