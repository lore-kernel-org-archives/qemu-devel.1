Received: from eggs.gnu.org ([2001:4830:134:3::10]:53115)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dc9Y8-0006Tb-1x
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 08:11:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dc9Y7-0004jd-8O
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 08:11:52 -0400
Received: from mail-wm0-x230.google.com ([2a00:1450:400c:c09::230]:35903)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dc9Y7-0004io-1x
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 08:11:51 -0400
Received: by mail-wm0-x230.google.com with SMTP id t201so177469193wmt.1
	for <qemu-devel@nongnu.org>; Mon, 31 Jul 2017 05:11:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1501153150-19984-1-git-send-email-peter.maydell@linaro.org>
References: <1501153150-19984-1-git-send-email-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 31 Jul 2017 13:11:29 +0100
Message-ID: <CAFEAcA8yQ27yei8OMNwQGrVsp2_=mR4LPP5u2A6+LDFNtX++-Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH for-2.10 0/5] M profile MPU
 bugfixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Cc: "patches@linaro.org" <patches@linaro.org>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>

On 27 July 2017 at 11:59, Peter Maydell <peter.maydell@linaro.org> wrote:
> This patchset fixes some bugs in the M profile MPU code:
>  * the guest shouldn't be able to make system space executable
>  * PPB region accesses should not be subject to MPU lookups
>  * we were not resetting the PMSAv7 MPU state for M profile CPUs
>  * we weren't migrating the MPU_RNR state
>
> The renaming from cp15.c6_rgnr to pmsav7.rnr is not strictly
> necessary for 2.10, but it doesn't affect many places in the code
> and it restores the invariant that no mutable M profile CPU
> state is stored in env->cp15.something fields.

Applied to target-arm queue for 2.10, with the minor function
renames (s/is_/m_is_/) suggested by Philippe.

thanks
-- PMM
