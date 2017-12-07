Received: from eggs.gnu.org ([2001:4830:134:3::10]:33736)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eN1zW-0001kp-0P
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 14:37:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eN1zV-0005ks-8o
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 14:37:54 -0500
Received: from mail-oi0-x22f.google.com ([2607:f8b0:4003:c06::22f]:45994)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eN1zV-0005jM-1Z
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 14:37:53 -0500
Received: by mail-oi0-x22f.google.com with SMTP id x20so5695196oix.12
	for <qemu-devel@nongnu.org>; Thu, 07 Dec 2017 11:37:52 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1512670493-18114-1-git-send-email-peter.maydell@linaro.org>
References: <1512670493-18114-1-git-send-email-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 7 Dec 2017 19:37:31 +0000
Message-ID: <CAFEAcA-UO5Y_ACSZ2EEQEzgy30wdfEm3u8wUrBrXWaQaE_v+Kw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 0/6] arm: support -cpu max (and
 gic-version=max)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Cc: "Richard W . M . Jones" <rjones@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, "patches@linaro.org" <patches@linaro.org>

On 7 December 2017 at 18:14, Peter Maydell <peter.maydell@linaro.org> wrote:
> This patchset adds support for '-cpu max' to Arm, along the lines
> of the existing support we have for x86 targets:
>
>  * under KVM, -cpu max is the same as -cpu host
>  * under TCG, -cpu max means "emulate with as many features as
>    possible"

Forgot to mention: -cpu max for qemu-system-aarch64 will
be a 64-bit cpu, and for qemu-system-arm it will be a 32-bit
cpu. (This differs from all the other TCG CPU types, which
behave the same for the 32-bit and 64-bit binaries. I think
it is the same way that x86 -cpu max works, though.)

thanks
-- PMM
