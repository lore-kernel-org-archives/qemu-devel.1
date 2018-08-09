Received: from eggs.gnu.org ([2001:4830:134:3::10]:36972)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fnoLv-0002pC-Mj
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 13:04:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fnoLu-0004S2-Fw
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 13:03:59 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:36246)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fnoLu-0004Rm-9b
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 13:03:58 -0400
Received: by mail-oi0-x242.google.com with SMTP id n21-v6so11072331oig.3
	for <qemu-devel@nongnu.org>; Thu, 09 Aug 2018 10:03:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <19a9c0c6-03eb-d368-d8c8-fb62102556a4@redhat.com>
References: <20180809160011.17225-1-peter.maydell@linaro.org>
	<19a9c0c6-03eb-d368-d8c8-fb62102556a4@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 9 Aug 2018 18:03:36 +0100
Message-ID: <CAFEAcA_rRW7qbtiM4c-sBVmQhFMSuKnVqU6+oXsdXPwJ3GKv6A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] scripts/checkpatch.pl: Enforce multiline
 comment syntax
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, Thomas Huth <thuth@redhat.com>

On 9 August 2018 at 17:43, Paolo Bonzini <pbonzini@redhat.com> wrote:
> On 09/08/2018 18:00, Peter Maydell wrote:
>> The kernel's checkpatch does not enforce "leading /* on
>> a line of its own, so that part is unique to QEMU's checkpatch.
>
> Yeah, that's because for some reason the Linux network subsystem uses
> the style without the lone leading "/*".

Yes. Linux checkpatch warns if you use lone-leading-/* in the
network subsystem. What it doesn't do but should is warn you
if you *don't* use lone-leading-/* anywhere else. (I've had
kernel patches nitpicked for getting this wrong before.)
If I'm feeling enthusiastic enough I might submit a patch
to Linux checkpatch to do

   if (networking subsystem) {
        warn if lone leading opener used;
   } else {
        warn if lone leading opener not used;
   }

> Which is actually what QEMU is
> using in most of the code, I think, so...
>
>> I'm still not used to the leeading-/*-on-it's-own style,
>> so having checkpatch catch my lapses is handy...
>
> ... if it's not what we are using, why enforce it?

See the enormous long threads on the recent changes to CODING_STYLE:
https://lists.gnu.org/archive/html/qemu-devel/2018-06/msg00696.html
https://lists.gnu.org/archive/html/qemu-devel/2018-06/msg02717.html

Basically, I wanted to rule out things like

  /* this
     weirdness */

and lots of other people wanted (a) to not have

  /* this thing
   * which I think is fine
   */

and (b) to consistently define only one format as OK.

So I accepted having my personal preferred format not being
permitted in order to get consensus on getting rid of the
formats I think are really ugly :-)

thanks
-- PMM
