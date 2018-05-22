Received: from eggs.gnu.org ([2001:4830:134:3::10]:38705)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1fLBSx-0001ID-Fs
	for qemu-devel@nongnu.org; Tue, 22 May 2018 13:52:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1fLBSs-0002qm-Gk
	for qemu-devel@nongnu.org; Tue, 22 May 2018 13:52:55 -0400
Sender: Richard Henderson <rth7680@gmail.com>
References: <20180521140402.23318-1-peter.maydell@linaro.org>
	<20180521140402.23318-15-peter.maydell@linaro.org>
	<5655dec4-6d82-a02c-2155-300c4baf1adf@twiddle.net>
	<CAFEAcA-Cb2sLTz1RNiiPLm=+92poENNF9WHuJrgLe1VGHnPV8A@mail.gmail.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <7c4c3d1f-d83f-cac4-adb7-a677a60dff07@twiddle.net>
Date: Tue, 22 May 2018 10:52:47 -0700
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-Cb2sLTz1RNiiPLm=+92poENNF9WHuJrgLe1VGHnPV8A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 14/27] iommu: Add IOMMU index concept to
 IOMMU API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 05/22/2018 10:51 AM, Peter Maydell wrote:
> That wouldn't allow for multiple instances of the same class where the
> answer is different (eg "my_iommu->has_trustzone_support ? 2 : 1" where
> the answer depends on how the instance is configured via QOM properties).

Ah.  I had somehow been assuming those would be different classes.
Ok then,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
