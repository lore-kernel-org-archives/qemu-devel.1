Received: from eggs.gnu.org ([2001:4830:134:3::10]:33030)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fVfAd-0005U1-SY
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 11:37:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fVfAc-0002i8-Tu
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 11:37:19 -0400
Received: from mail-ot0-x22d.google.com ([2607:f8b0:4003:c0f::22d]:33976)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fVfAc-0002hu-Mn
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 11:37:18 -0400
Received: by mail-ot0-x22d.google.com with SMTP id r18-v6so9618otk.1
	for <qemu-devel@nongnu.org>; Wed, 20 Jun 2018 08:37:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1528790908-23441-2-git-send-email-eric.auger@redhat.com>
References: <1528790908-23441-1-git-send-email-eric.auger@redhat.com>
	<1528790908-23441-2-git-send-email-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 20 Jun 2018 16:36:57 +0100
Message-ID: <CAFEAcA_YbwG=1OUxAutMwyYjQSV=QvcN2Us1EUUvVkCmRJn1ug@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 1/4] hw/arm/smmuv3: Fix translate error
 handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Auger <eric.auger@redhat.com>
Cc: Eric Auger <eric.auger.pro@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, jia.he@hxt-semitech.com, Jia He <hejianet@gmail.com>

On 12 June 2018 at 09:08, Eric Auger <eric.auger@redhat.com> wrote:
> From: Jia He <hejianet@gmail.com>
>
> In case the STE's config is "Bypass" we currently don't set the
> IOMMUTLBEntry perm flags and the access does not succeed. Also
> if the config is 0b0xx (Aborted/Reserved), decode_ste and
> smmuv3_decode_config currently returns -EINVAL and we don't enter
> the expected code path: we record an event whereas we should not.
>
> This patch fixes those bugs and simplifies the error handling.
> decode_ste and smmuv3_decode_config now return 0 if aborted or
> bypassed config was found. Only bad config info produces negative
> error values. In smmuv3_translate we more clearly differentiate
> errors, bypass/smmu disabled, aborted and success cases. Also
> trace points are differentiated.
>
> Fixes: 9bde7f0674fe ("hw/arm/smmuv3: Implement translate callback")
> Reported-by: jia.he@hxt-semitech.com
> Signed-off-by: jia.he@hxt-semitech.com
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
