Received: from eggs.gnu.org ([2001:4830:134:3::10]:44600)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fddsH-0002Bp-9a
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 11:51:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fddsG-0007gD-IX
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 11:51:21 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:32948)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fddsG-0007fo-Cq
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 11:51:20 -0400
Received: by mail-oi0-x244.google.com with SMTP id l10-v6so9975952oii.0
	for <qemu-devel@nongnu.org>; Thu, 12 Jul 2018 08:51:20 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA82ZxENfCU8C9jnOLJx+WOw6QcR1LYYfG7KVB_7Fv7w_w@mail.gmail.com>
References: <20180709150235.7573-1-programmingkidx@gmail.com>
	<CAFEAcA82ZxENfCU8C9jnOLJx+WOw6QcR1LYYfG7KVB_7Fv7w_w@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Jul 2018 16:50:59 +0100
Message-ID: <CAFEAcA8mb4u74LbXQg7o5=XqV+wv=Wuw8WZputNQ5r87baEmug@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3] ui/cocoa.m: replace scrollingDeltaY
 with deltaY
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Arbuckle <programmingkidx@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 11 July 2018 at 22:18, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 9 July 2018 at 16:02, John Arbuckle <programmingkidx@gmail.com> wrote:
>> The NSEvent class method scrollingDeltaY is available
>> for Mac OS 10.7 and newer. Since QEMU supports Mac OS
>> 10.5 and up, we need to be using a method that is
>> available on these version of Mac OS X. The deltaY
>> method is a method that does the same thing as
>> scrollingDeltaY and is available on Mac OS 10.5 and
>> up. So we replace scrollingDeltaY with deltaY.
>>
>> We only check deltaY's value if it is not zero
>> because zero means no scrolling took place.

> I'll tweak the comments and put this in for 3.0 rc1.

Now applied to master, thanks.

-- PMM
