Received: from eggsout.gnu.org ([209.51.188.92]:49417 helo=eggs.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gfnw7-0002Ev-SD
	for qemu-devel@nongnu.org; Sat, 05 Jan 2019 10:32:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gfnw6-0006Di-VU
	for qemu-devel@nongnu.org; Sat, 05 Jan 2019 10:32:31 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:38685)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gfnw6-00069v-Qh
	for qemu-devel@nongnu.org; Sat, 05 Jan 2019 10:32:30 -0500
Received: by mail-oi1-x243.google.com with SMTP id a77so32669856oii.5
	for <qemu-devel@nongnu.org>; Sat, 05 Jan 2019 07:32:25 -0800 (PST)
MIME-Version: 1.0
References: <20181227063419.12981-1-yang.zhong@intel.com>
	<20181227063419.12981-24-yang.zhong@intel.com>
In-Reply-To: <20181227063419.12981-24-yang.zhong@intel.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 5 Jan 2019 15:32:13 +0000
Message-ID: <CAFEAcA9c3VRmcUiiHFZ-5BW6kQ3ACGkVE6ZLTyJ=KgA=YGws=w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RFC PATCH 23/25] x86_64-softmmu.mak: remove
 i386-softmmu.mak include
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yang Zhong <yang.zhong@intel.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Samuel Ortiz <sameo@linux.intel.com>, Eduardo Habkost <ehabkost@redhat.com>, Thomas Huth <thuth@redhat.com>

On Thu, 27 Dec 2018 at 06:35, Yang Zhong <yang.zhong@intel.com> wrote:
>
> Only keep same boards definitions as i386-softmmu.mak in
> x86_64-softmmu.mak.
>
> Signed-off-by: Yang Zhong <yang.zhong@intel.com>
> ---
>  default-configs/x86_64-softmmu.mak | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/default-configs/x86_64-softmmu.mak b/default-configs/x86_64-softmmu.mak
> index 64b2ee2960..0c69c2930c 100644
> --- a/default-configs/x86_64-softmmu.mak
> +++ b/default-configs/x86_64-softmmu.mak
> @@ -1,3 +1,7 @@
>  # Default configuration for x86_64-softmmu
>
> -include i386-softmmu.mak
> +# Boards:
> +#
> +CONFIG_ISAPC=y
> +CONFIG_I440FX=y
> +CONFIG_Q35=y

Could you explain the rationale for doing this? Now
any new i386 board has to be added in two places,
doesn't it?

thanks
-- PMM
