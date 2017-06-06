Received: from eggs.gnu.org ([2001:4830:134:3::10]:56723)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dII44-000209-8l
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 13:14:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dII43-0005KB-DY
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 13:14:44 -0400
Received: from mail-wm0-x232.google.com ([2a00:1450:400c:c09::232]:33359)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dII43-0005Jw-79
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 13:14:43 -0400
Received: by mail-wm0-x232.google.com with SMTP id m7so29465486wmg.0
	for <qemu-devel@nongnu.org>; Tue, 06 Jun 2017 10:14:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170602162857.6065-1-krzk@kernel.org>
References: <20170602162857.6065-1-krzk@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 6 Jun 2017 18:14:21 +0100
Message-ID: <CAFEAcA8MnUERMj4_KTu6RAw3bJBT63YkrAJj7eKU=oRxK2=mLw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v4 0/9] hw: arm: exynos: Improvements and
 cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Igor Mitsyanko <i.mitsyanko@gmail.com>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Eric Blake <eblake@redhat.com>

On 2 June 2017 at 17:28, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> Hi,
>
> I split non-intrusive changes from my previous attempts [1].
>
> This patchset contains only cleanups, minor improvements and support for
> power off. Power off itself will not happen because kernel will hang
> before trying it, on syncing IRQ works (fix for this is [2], but this will
> be separate).
>
> Changes since v3:
> 1. Rebase on current master (API for shutdown changed).
> 2. Apply Peter's reviewed-by tag.

Thanks for splitting these out.
Applied to target-arm.next, thanks.

-- PMM
