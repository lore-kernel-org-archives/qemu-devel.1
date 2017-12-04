Received: from eggs.gnu.org ([2001:4830:134:3::10]:35390)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eLruf-0004ez-1W
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 09:40:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eLrue-0000M2-3k
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 09:40:05 -0500
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:34493)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eLrud-0000LF-Um
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 09:40:04 -0500
Received: by mail-oi0-x243.google.com with SMTP id u193so11833320oie.1
	for <qemu-devel@nongnu.org>; Mon, 04 Dec 2017 06:40:03 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-DSVi1u9sQr5ZvCovtt+qTKoxPW2UiJxQt2YkLOWAuAQ@mail.gmail.com>
References: <20171204034802.7336-1-david@gibson.dropbear.id.au>
	<CAFEAcA-DSVi1u9sQr5ZvCovtt+qTKoxPW2UiJxQt2YkLOWAuAQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 4 Dec 2017 14:39:42 +0000
Message-ID: <CAFEAcA9jp_gz25ZNvn1=y5qK+LHnqMUJfqKDtKcnNZnBRFRiMg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/3] ppc-for-2.11 queue 20171204
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Alexander Graf <agraf@suse.de>, Greg Kurz <groug@kaod.org>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 4 December 2017 at 10:17, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 4 December 2017 at 03:47, David Gibson <david@gibson.dropbear.id.au> wrote:
>> The following changes since commit c11d61271b9e6e7a1f0479ef1ca8fb55fa457a62:
>>
>>   Update version for v2.11.0-rc3 release (2017-11-29 17:59:34 +0000)
>>
>> are available in the Git repository at:
>>
>>   git://github.com/dgibson/qemu.git tags/ppc-for-2.11-20171204
>>
>> for you to fetch changes up to 768a20f3a491ed4afce73ebb65347d55251c0ebd:
>>
>>   spapr: Include "pre-plugged" DIMMS in ram size calculation at reset (2017-12-04 11:31:22 +1100)
>>
>> ----------------------------------------------------------------
>> ppc patch queue 2017-12-04
>>
>> We are, alas, not yet to the bottom of ppc bugs.  This pull request
>> fixes several more.  I believe they're important enough to include in
>> 2.11. despite the late date.
>>
>> ----------------------------------------------------------------
>> David Gibson (1):
>>       spapr: Include "pre-plugged" DIMMS in ram size calculation at reset
>>
>> Kurban Mallachiev (1):
>>       target-ppc: Don't invalidate non-supported msr bits
>>
>> Laurent Vivier (1):
>>       pseries: fix TCG migration
>
> So my question here is about the same as to mst: are these fixes all
> really vital? Were any of the bugs they fix present in 2.10 ?
>
> (A +7-4 diffstat is not too difficult to justify though.)

...so I looked at the patches and agreed they made sense for rc4.

Applied, thanks.
-- PMM
