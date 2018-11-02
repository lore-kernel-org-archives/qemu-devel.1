Received: from eggs.gnu.org ([2001:4830:134:3::10]:34468)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gIbDe-0003nG-LB
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 11:18:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gIbDb-0005za-0c
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 11:18:40 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:39270)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gIbDZ-0005z9-PY
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 11:18:38 -0400
Received: by mail-ot1-x344.google.com with SMTP id g27so1992960oth.6
	for <qemu-devel@nongnu.org>; Fri, 02 Nov 2018 08:18:37 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <BN6PR2201MB12515D71ED36B637045DA6D2C6CF0@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <BN6PR2201MB125116B5479010DB326DCCFCC6CE0@BN6PR2201MB1251.namprd22.prod.outlook.com>
	<51a26700-5da5-0a15-0e0e-6405ce5e65d4@redhat.com>
	<20181101172353.GA2316@sx9>
	<BN6PR2201MB12512B92322BFB8965848215C6CF0@BN6PR2201MB1251.namprd22.prod.outlook.com>
	<20181102143119.GA2274@sx9>
	<BN6PR2201MB12515D71ED36B637045DA6D2C6CF0@BN6PR2201MB1251.namprd22.prod.outlook.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 2 Nov 2018 15:18:15 +0000
Message-ID: <CAFEAcA9KJn++ASQ+xzEAs+pi0xkZG7i3aPUZEQZXwRfYJy6jbw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Correction needed for R5900 instruction decoding
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <amarkovic@wavecomp.com>
Cc: Fredrik Noring <noring@nocrew.org>, Stefan Markovic <smarkovic@wavecomp.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Aleksandar Rikalo <arikalo@wavecomp.com>, "Emilio G. Cota" <cota@braap.org>, "Maciej W. Rozycki" <macro@linux-mips.org>, =?UTF-8?Q?J=C3=BCrgen_Urban?= <JuergenUrban@gmx.de>, Petar Jovanovic <pjovanovic@wavecomp.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>

On 2 November 2018 at 15:03, Aleksandar Markovic <amarkovic@wavecomp.com> wrote:
> Hi, Fredrik.
>
>> From: Fredrik Noring <noring@nocrew.org>
>> Subject: Re: [Qemu-devel] Correction needed for R5900 instruction decoding
>>
>> Hi Aleksandar,
>>
>> > It is now code freeze before 3.1, the code base is being stabilized, and
>> > only important fixes are allowed to be integrated - so, in that light, a
>> > separate patch, or a small series, that addresses only concerns from the
>> > original mail of this thread is needed. Such series should not contain any
>> > additional features (like your v2 of the series "Amend..." does), and its
>> > patch titles should look like "Fix decoding mechanism of ..." or such.
>> >
>> > Could you please provide those appropriate changes in that format?
>>
>> I certainly could, but why not simply apply patch 1 and 2 in the posted
>> v2 series and leave the rest for later?
>
> How do you know patches 1 and 2 will and should be applied? You jump
> to conclusions. Also, a basic rule while analyzing problems and their
> solutions is to avoid and omit irrelevant parts.

Hey guys, can we try to keep the tone of the conversation friendly here?

I think what Fred is suggesting is that the minimal set of fixing
patches would be just patch 1 and 2 from that set, and so you could
if you wanted apply those two patches to get the desired effect.

>From the other side of things, as a submaintainer around release
time there's often a lot of work to do and it's easy to confuse
different patchsets or forget the status of them, so it's useful
to have a patch series which is exactly the set of patches that
the submitter thinks are suitable to go into the release, and it's
less work to apply those than to fish out a subset of patches
from a series.

So overall, I think my suggestion would be that the best move
from here would be for Fred to send a patchset with the changes
for 3.1 and only those changes. Could you do that, please?

thanks
-- PMM
