Received: from eggs.gnu.org ([2001:4830:134:3::10]:50534)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fk8Vy-0000YJ-3h
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 09:47:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fk8Vx-0002L4-Ga
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 09:47:10 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:43299)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fk8Vx-0002KT-B7
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 09:47:09 -0400
Received: by mail-oi0-x244.google.com with SMTP id b15-v6so21287636oib.10
	for <qemu-devel@nongnu.org>; Mon, 30 Jul 2018 06:47:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180727135406.15132-1-dgilbert@redhat.com>
References: <20180727135406.15132-1-dgilbert@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 30 Jul 2018 14:46:48 +0100
Message-ID: <CAFEAcA9ta33H3LaVEC_oMrOFQ-SDOmCMF=n6+hngWguA4=MwGQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] arm/smmuv3: Fix missing VMSD terminator
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Prem Mallappa <prem.mallappa@broadcom.com>, Eric Auger <eric.auger@redhat.com>

On 27 July 2018 at 14:54, Dr. David Alan Gilbert (git)
<dgilbert@redhat.com> wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> The 'vmstate_smmuv3_queue' is missing the end-of-list marker.
>
> Fixes: 10a83cb9887
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  hw/arm/smmuv3.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index 39fbcbf577..40a86c1895 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -1414,6 +1414,8 @@ static const VMStateDescription vmstate_smmuv3_queue = {
>          VMSTATE_UINT32(prod, SMMUQueue),
>          VMSTATE_UINT32(cons, SMMUQueue),
>          VMSTATE_UINT8(log2size, SMMUQueue),
> +
> +        VMSTATE_END_OF_LIST(),
>      },
>  };

Thanks, applied to target-arm.next for 3.0. (I dropped the extra
blank line.)

-- PMM
