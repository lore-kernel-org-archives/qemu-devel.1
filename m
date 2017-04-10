Received: from eggs.gnu.org ([2001:4830:134:3::10]:59166)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cxd5f-0006r5-EO
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 13:27:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cxd5e-0003Lk-Fh
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 13:26:59 -0400
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:35807)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cxd5e-0003LD-AB
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 13:26:58 -0400
Received: by mail-pg0-x243.google.com with SMTP id g2so26430828pge.2
	for <qemu-devel@nongnu.org>; Mon, 10 Apr 2017 10:26:56 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170410060655.32289-1-nikunj@linux.vnet.ibm.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <fc0b737f-738a-1bc2-1b94-aa041ab8ae6c@twiddle.net>
Date: Mon, 10 Apr 2017 10:26:52 -0700
MIME-Version: 1.0
In-Reply-To: <20170410060655.32289-1-nikunj@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH fix for-2.9] cpus: fix wrong define name
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: pbonzini@redhat.com, crosthwaite.peter@gmail.com, david@gibson.dropbear.id.au, alex.bennee@linaro.org

On 04/09/2017 11:06 PM, Nikunj A Dadhania wrote:
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

This sort of thing is why glibc moved to using -Wundef.

It would be a huge amount of work to convert our existing sources, but it would 
probably pay off in the long run.


r~
