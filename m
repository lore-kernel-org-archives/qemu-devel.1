Received: from eggs.gnu.org ([209.51.188.92]:50080)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gm189-0007jh-J1
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 13:50:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gm17z-0007c4-Tn
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 13:50:35 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:38665)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gm17n-0007W1-WB
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 13:50:21 -0500
Received: by mail-ot1-x341.google.com with SMTP id e12so24618130otl.5
	for <qemu-devel@nongnu.org>; Tue, 22 Jan 2019 10:50:15 -0800 (PST)
MIME-Version: 1.0
References: <20190110121736.23448-1-richard.henderson@linaro.org>
	<20190110121736.23448-9-richard.henderson@linaro.org>
	<CAFEAcA9+8XBXDqL8JfTpS8q05XwaZ+Ck1nqAhTLsyN_=WCjXNA@mail.gmail.com>
	<13b8c253-d3da-3bca-de83-ea9422d5f30f@linaro.org>
In-Reply-To: <13b8c253-d3da-3bca-de83-ea9422d5f30f@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 22 Jan 2019 16:57:49 +0000
Message-ID: <CAFEAcA8rzNDhgqrzei7L3X=WbnZV-1jVUcob50orPmw8twjjpg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 08/11] target/arm: Add guarded_pages cpu
 property for user-only
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Tue, 22 Jan 2019 at 15:42, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 1/22/19 7:29 AM, Peter Maydell wrote:
> > On Thu, 10 Jan 2019 at 12:18, Richard Henderson
> > <richard.henderson@linaro.org> wrote:
> >>
> >> While waiting for a proper userland ABI, allow static test
> >> cases to be written assuming that GP is set for all pages.
> >>
> >> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> >> ---
> >>  target/arm/cpu.h           |  4 ++++
> >>  target/arm/cpu64.c         | 18 ++++++++++++++++++
> >>  target/arm/translate-a64.c |  8 +++++++-
> >>  3 files changed, 29 insertions(+), 1 deletion(-)
> >
> > This is OK code-wise but I'm a bit wary of committing it
> > because then we're stuck with the property forever even
> > if it turns out to be irrelevant to whatever the userland
> > ABI eventually is.
>
> That's surely simply a matter of documentation.
> "Don't rely on this property: it will go away."

Convention is that those should be prefixed with "x-".

thanks
-- PMM
