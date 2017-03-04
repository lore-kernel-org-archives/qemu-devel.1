Received: from eggs.gnu.org ([2001:4830:134:3::10]:37334)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ckCaT-0003ZD-NA
	for qemu-devel@nongnu.org; Sat, 04 Mar 2017 11:31:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ckCaS-0001kg-NW
	for qemu-devel@nongnu.org; Sat, 04 Mar 2017 11:31:17 -0500
Received: from mail-wm0-x236.google.com ([2a00:1450:400c:c09::236]:33398)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ckCaS-0001kU-Fs
	for qemu-devel@nongnu.org; Sat, 04 Mar 2017 11:31:16 -0500
Received: by mail-wm0-x236.google.com with SMTP id i17so12453762wmf.0
	for <qemu-devel@nongnu.org>; Sat, 04 Mar 2017 08:31:16 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1488558530-21016-3-git-send-email-pbonzini@redhat.com>
References: <1488558530-21016-3-git-send-email-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 4 Mar 2017 16:30:54 +0000
Message-ID: <CAFEAcA_o3m6q_66EwJQuVbESvFu5ccCm1voioZh6OGiLS2yqTw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH] ppc: avoid typedef redefinitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, David Gibson <dgibson@redhat.com>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>

On 3 March 2017 at 16:28, Paolo Bonzini <pbonzini@redhat.com> wrote:
> These cause compilation failures on CentOS 6 or other operating
> systems with older GCCs.
>
> Cc: David Gibson <dgibson@redhat.com>
> Cc: qemu-ppc@nongnu.org
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>         It would probably be better to remove the
>         sPAPRMachineState typedef from xics.h instead,
>         but this is a quick fix to restore the centos6
>         docker target.
>
>  include/hw/ppc/spapr.h | 1 -
>  include/hw/ppc/xics.h  | 4 ++--
>  2 files changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index cfd2711..15f4371 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -21,7 +21,6 @@ typedef struct sPAPREventSource sPAPREventSource;
>  #define SPAPR_TIMEBASE_FREQ     512000000ULL
>
>  typedef struct sPAPRMachineClass sPAPRMachineClass;
> -typedef struct sPAPRMachineState sPAPRMachineState;
>
>  #define TYPE_SPAPR_MACHINE      "spapr-machine"
>  #define SPAPR_MACHINE(obj) \
> diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
> index 1945913..9a5e715 100644
> --- a/include/hw/ppc/xics.h
> +++ b/include/hw/ppc/xics.h
> @@ -139,9 +139,9 @@ struct ICSIRQState {
>      uint8_t flags;
>  };
>
> -typedef struct XICSFabric {
> +struct XICSFabric {
>      Object parent;
> -} XICSFabric;
> +};
>
>  #define TYPE_XICS_FABRIC "xics-fabric"
>  #define XICS_FABRIC(obj)                                     \
> --
> 1.8.3.1

Applied to master as a buildfix, thanks.

-- PMM
