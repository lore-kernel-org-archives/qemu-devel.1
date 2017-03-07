Received: from eggs.gnu.org ([2001:4830:134:3::10]:58199)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1clJDa-000786-03
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 12:48:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1clJDW-00039v-Rf
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 12:48:14 -0500
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:36073)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1clJDW-00039l-NS
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 12:48:10 -0500
Received: by mail-qk0-x243.google.com with SMTP id n141so2947321qke.3
	for <qemu-devel@nongnu.org>; Tue, 07 Mar 2017 09:48:10 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170307155054.5833-1-alex.bennee@linaro.org>
	<20170307155054.5833-4-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <9a7b4384-73c3-f3b0-3f18-45c781f14b13@amsat.org>
Date: Tue, 7 Mar 2017 14:48:05 -0300
MIME-Version: 1.0
In-Reply-To: <20170307155054.5833-4-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 03/11] cpus.c: add additional
 error_report when !TARGET_SUPPORT_MTTCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, peter.maydell@linaro.org, rth@twiddle.net, pbonzini@redhat.com
Cc: mttcg@listserver.greensocs.com, nikunj@linux.vnet.ibm.com, Peter Crosthwaite <crosthwaite.peter@gmail.com>, a.rigo@virtualopensystems.com, qemu-devel@nongnu.org, cota@braap.org, bobby.prani@gmail.com, fred.konrad@greensocs.com

On 03/07/2017 12:50 PM, Alex Bennée wrote:
> While we may fail the memory ordering check later that can be
> confusing. So in cases where TARGET_SUPPORT_MTTCG has yet to be
> defined we should say so specifically.
>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Reviewed-by: Richard Henderson <rth@twiddle.net>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  cpus.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/cpus.c b/cpus.c
> index 6a817fec13..69e21858b8 100644
> --- a/cpus.c
> +++ b/cpus.c
> @@ -202,6 +202,10 @@ void qemu_tcg_configure(QemuOpts *opts, Error **errp)
>              } else if (use_icount) {
>                  error_setg(errp, "No MTTCG when icount is enabled");
>              } else {
> +#ifndef TARGET_SUPPORT_MTTCG
> +                error_report("Guest not yet converted to MTTCG - "
> +                             "you may get unexpected results");
> +#endif
>                  if (!check_tcg_memory_orders_compatible()) {
>                      error_report("Guest expects a stronger memory ordering "
>                                   "than the host provides");
>
