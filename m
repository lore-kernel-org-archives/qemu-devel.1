Received: from eggs.gnu.org ([2001:4830:134:3::10]:50541)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ctIQV-0005xX-1n
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 14:34:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ctIQU-0007AH-1d
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 14:34:35 -0400
Received: from mail-wr0-x234.google.com ([2a00:1450:400c:c0c::234]:33838)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ctIQT-00079m-RR
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 14:34:33 -0400
Received: by mail-wr0-x234.google.com with SMTP id l43so28240374wre.1
	for <qemu-devel@nongnu.org>; Wed, 29 Mar 2017 11:34:32 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAC8NTUWHysUbj_MuL5DG4oxAe4W=qDQ65o4bQ5TN2W+YqX8aRA@mail.gmail.com>
References: <CAC8NTUUWuH4k7SZSus_hz6a6V+OLGYUFcSOUwVbji2YDAZbVdQ@mail.gmail.com>
	<20170328201623.GD20211@cbox>
	<CAC8NTUVPoH=ZiJ51EoOLPKhsyGKo5iszkhHzb5K8Heax3n2KuA@mail.gmail.com>
	<CAC8NTUWHysUbj_MuL5DG4oxAe4W=qDQ65o4bQ5TN2W+YqX8aRA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 29 Mar 2017 19:34:11 +0100
Message-ID: <CAFEAcA-9nVNUMiSDDNsoMHTdJggJpL=3-7bK+jVoT7MSC3J_CA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] host stalls when qemu-system-aarch64 with kvm and
 pflash
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Radha Mohan <mohun106@gmail.com>
Cc: Christoffer Dall <cdall@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>

On 29 March 2017 at 19:17, Radha Mohan <mohun106@gmail.com> wrote:
>> I will also try with qemu 2.8 and see.
>
> Same issue with 2.8.0 and 2.7.1 qemu version.

Thanks for checking -- good to know it's not a regression
on the QEMU side. (If you can soft-lockup the host it's
clearly a host kernel bug, but it might have been that
we changed something recently to provoke it.)

thanks
-- PMM
