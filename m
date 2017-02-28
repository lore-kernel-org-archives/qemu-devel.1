Received: from eggs.gnu.org ([2001:4830:134:3::10]:55003)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cii49-0007y9-N0
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 08:43:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cii48-0003Qe-Ez
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 08:43:45 -0500
Received: from mail-wm0-x233.google.com ([2a00:1450:400c:c09::233]:36481)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cii48-0003QQ-9M
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 08:43:44 -0500
Received: by mail-wm0-x233.google.com with SMTP id v77so85411813wmv.1
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 05:43:44 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1488224492-20316-3-git-send-email-joserz@linux.vnet.ibm.com>
References: <1488224492-20316-1-git-send-email-joserz@linux.vnet.ibm.com>
	<1488224492-20316-3-git-send-email-joserz@linux.vnet.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Feb 2017 13:43:22 +0000
Message-ID: <CAFEAcA_DD1KmSR+U-4jSVbycO+QwZ9ebc_k4RJ2+TqZD2jiB5w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH Risu 2/5] risu_reginfo_ppc64le: Remove
 unused code from PPC64 register comparison
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>

On 27 February 2017 at 19:41, Jose Ricardo Ziviani
<joserz@linux.vnet.ibm.com> wrote:
> Signed-off-by: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
> ---
>  risu_reginfo_ppc64le.c | 8 --------
>  1 file changed, 8 deletions(-)
>
> diff --git a/risu_reginfo_ppc64le.c b/risu_reginfo_ppc64le.c
> index e6bc0e0..a76f296 100644
> --- a/risu_reginfo_ppc64le.c
> +++ b/risu_reginfo_ppc64le.c
> @@ -86,14 +86,6 @@ int reginfo_is_eq(struct reginfo *m, struct reginfo *a, ucontext_t *uc)
>                  m->vrregs.vrregs[i][1] != a->vrregs.vrregs[i][1] ||
>                  m->vrregs.vrregs[i][2] != a->vrregs.vrregs[i][2] ||
>                  m->vrregs.vrregs[i][3] != a->vrregs.vrregs[i][3]) {
> -
> -            if (uc != NULL && (m->gregs[CCR] & 0x10)) {
> -                uc->uc_mcontext.v_regs->vrregs[i][0] = a->vrregs.vrregs[i][0];
> -                uc->uc_mcontext.v_regs->vrregs[i][1] = a->vrregs.vrregs[i][1];
> -                uc->uc_mcontext.v_regs->vrregs[i][2] = a->vrregs.vrregs[i][2];
> -                uc->uc_mcontext.v_regs->vrregs[i][3] = a->vrregs.vrregs[i][3];
> -                return 1;
> -            }
>              return 0;
>          }
>      }
> --

I have a variation on this patch already in my set of refactoring
patches that I posted last week:

https://lists.gnu.org/archive/html/qemu-devel/2017-02/msg06152.html

thanks
-- PMM
