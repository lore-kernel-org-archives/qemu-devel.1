Received: from eggs.gnu.org ([2001:4830:134:3::10]:41891)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cxUBu-0002bt-HR
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 03:56:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cxUBr-0003IJ-GK
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 03:56:50 -0400
Received: from mail-wr0-x22a.google.com ([2a00:1450:400c:c0c::22a]:34968)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cxUBr-0003Hy-9h
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 03:56:47 -0400
Received: by mail-wr0-x22a.google.com with SMTP id o21so114527294wrb.2
	for <qemu-devel@nongnu.org>; Mon, 10 Apr 2017 00:56:47 -0700 (PDT)
References: <20170410060655.32289-1-nikunj@linux.vnet.ibm.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170410060655.32289-1-nikunj@linux.vnet.ibm.com>
Date: Mon, 10 Apr 2017 08:56:52 +0100
Message-ID: <87inmck857.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH fix for-2.9] cpus: fix wrong define name
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, rth@twiddle.net, pbonzini@redhat.com, crosthwaite.peter@gmail.com, david@gibson.dropbear.id.au


Nikunj A Dadhania <nikunj@linux.vnet.ibm.com> writes:

> While the configure script generates TARGET_SUPPORTS_MTTCG define, one
> of the define is cpus.c is checking wrong name: TARGET_SUPPORT_MTTCG
>
> Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
> ---
>  cpus.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/cpus.c b/cpus.c
> index 68fdbc4..58d90aa 100644
> --- a/cpus.c
> +++ b/cpus.c
> @@ -202,7 +202,7 @@ void qemu_tcg_configure(QemuOpts *opts, Error **errp)
>              } else if (use_icount) {
>                  error_setg(errp, "No MTTCG when icount is enabled");
>              } else {
> -#ifndef TARGET_SUPPORT_MTTCG
> +#ifndef TARGET_SUPPORTS_MTTCG
>                  error_report("Guest not yet converted to MTTCG - "
>                               "you may get unexpected results");
>  #endif

Opps that's embarrassing.

Applied to my tree, I'll be sending a pullreq today

--
Alex Bennée
