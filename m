Received: from eggs.gnu.org ([2001:4830:134:3::10]:38977)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fWIxa-0004Ef-Kv
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 06:06:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fWIxZ-0000rj-PB
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 06:06:30 -0400
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:38173)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fWIxZ-0000qU-IM
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 06:06:29 -0400
Received: by mail-ot0-x244.google.com with SMTP id p95-v6so6910230ota.5
	for <qemu-devel@nongnu.org>; Fri, 22 Jun 2018 03:06:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180620132032.28865-1-peter.maydell@linaro.org>
References: <20180620132032.28865-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 22 Jun 2018 11:06:08 +0100
Message-ID: <CAFEAcA_UvmXS9xXpJ4hEs__XMtqY47cZpnvwmwUfP6qtkJCrvg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v3 0/8] arm: implement TZ MPC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Cc: Eric Auger <eric.auger@redhat.com>, "patches@linaro.org" <patches@linaro.org>

On 20 June 2018 at 14:20, Peter Maydell <peter.maydell@linaro.org> wrote:
> Hi; this is v3 of my iommu patchset. All the IOMMU stuff is now
> in master, so the remaining part is just implementing and using
> the Trustzone Memory Protection Controller in the mps2-an505.
>
> Changes from v2 to v3 (all fairly minor):
>  * add new variable to clarify sense of LUT bits
>  * only autoinc the IDX register if CTRL.AUTOINC is set
>  * NS accesses should see IDregs only
>    (The datasheet is unclear on the exact behaviour on an
>    NS access to a non-ID register, so I've made a best guess
>    and had them RAZ/WI. This behaviour is not reachable for
>    the mps2-an505 anyway, so it doesn't really matter.)



Applied to target-arm.next, thanks.

-- PMM
