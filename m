Received: from eggs.gnu.org ([2001:4830:134:3::10]:40082)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fPrKs-00056P-4S
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 11:23:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fPrKr-00084Z-A8
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 11:23:54 -0400
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:34595)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fPrKr-00084D-47
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 11:23:53 -0400
Received: by mail-ot0-x241.google.com with SMTP id i5-v6so38154665otf.1
	for <qemu-devel@nongnu.org>; Mon, 04 Jun 2018 08:23:53 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87k1red1w8.fsf@linaro.org>
References: <20180521140402.23318-1-peter.maydell@linaro.org>
	<20180521140402.23318-16-peter.maydell@linaro.org>
	<87603evivz.fsf@linaro.org>
	<CAFEAcA8xRj5CWkAMdUVvT_cZJWSL5ysvt8qb6fbypSp5ZJF1sg@mail.gmail.com>
	<87k1red1w8.fsf@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 4 Jun 2018 16:23:26 +0100
Message-ID: <CAFEAcA9+KRDi0PVLV-YZgYNF-Vr=Jy5AjThom_MSio1WWmHWjQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 15/27] iommu: Add IOMMU index argument to
 notifier APIs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On 4 June 2018 at 16:09, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
>
> Peter Maydell <peter.maydell@linaro.org> writes:
>
>> On 23 May 2018 at 10:08, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote=
:
>>> Its a minor thing but are we ever expecting iommu_idx to ever be
>>> negative?
>>
>> Coming back to this one -- no, we don't expect negative iommu_idxs.
>> But on the other hand we don't ever expect negative TCG mmu_indexes
>> either, and we use 'int' for those...
>
> That's a clean-up right there ;-)
>
> As I said it's a minor thing but I generally favour clearest type for
> the range you are going to see. That said the enum stuff on the older
> clangs did confuse me so there is that...

I prefer the "don't use unsigned unless you need the
unsigned-integer semantics" approach. (For instance most
loop indexes won't ever be negative, but "int i" is the
usual thing there.)

thanks
-- PMM
