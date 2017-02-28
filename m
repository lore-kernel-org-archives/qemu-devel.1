Received: from eggs.gnu.org ([2001:4830:134:3::10]:52229)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cilry-0002Ro-0v
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 12:47:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cilrw-0001Ks-Vw
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 12:47:25 -0500
Received: from mail-wr0-x22c.google.com ([2a00:1450:400c:c0c::22c]:34830)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cilrw-0001Ke-Pr
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 12:47:24 -0500
Received: by mail-wr0-x22c.google.com with SMTP id g10so13937180wrg.2
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 09:47:24 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <619a06f3-1b9a-ba3e-2469-76e57bf838f0@vivier.eu>
References: <1487957728-8354-1-git-send-email-peter.maydell@linaro.org>
	<619a06f3-1b9a-ba3e-2469-76e57bf838f0@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Feb 2017 17:47:03 +0000
Message-ID: <CAFEAcA-TSUK3vvB3GQ-9keeNcTPyus9MEm51NcO3AYh84LOWsA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH risu 0/9] risu: refactor and reduce
 CPU-specific code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>

On 24 February 2017 at 18:15, Laurent Vivier <laurent@vivier.eu> wrote:
> Le 24/02/2017 =C3=A0 18:35, Peter Maydell a =C3=A9crit :
>> This patchset refactors the risu C code to reduce the significant
>> amount of duplicated and duplicated-but-not-quite-the-same code
>> in the per-CPU files.
>>
>> I've compile tested this for all architectures, but I'm not in a
>> position to do runtime tests for non-ARM (my attempt to use the
>> ppc64le risu under QEMU gives mismatch errors even without these
>> patches, and the m68k risu makes QEMU crash, presumably because our
>> m68k support isn't complete yet).  So I wasn't quite prepared to just
>
> Yes, the FPU part is missing.
>
>> push it straight out to master the way I've done with previous
>> changes I've been making.
>>
>> Nikunj, Laurent: if you have time to test this patchset to confirm
>> that it hasn't broken anything for you that would be great.
>
> for m68k
> Tested-by: Laurent Vivier <laurent@vivier.eu>

Thanks; I've gone ahead and pushed this series to risu master.

-- PMM
