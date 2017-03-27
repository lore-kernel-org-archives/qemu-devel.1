Received: from eggs.gnu.org ([2001:4830:134:3::10]:36685)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1csXZn-0000PG-7q
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 12:33:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1csXZm-0007ah-En
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 12:33:03 -0400
Received: from mail-wr0-x22d.google.com ([2a00:1450:400c:c0c::22d]:34303)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1csXZm-0007a5-9X
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 12:33:02 -0400
Received: by mail-wr0-x22d.google.com with SMTP id l43so64639508wre.1
	for <qemu-devel@nongnu.org>; Mon, 27 Mar 2017 09:33:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1490519798.11328.113.camel@oracle.com>
References: <CAFEAcA9pqDoCWrPAJ+KVxLC_eRy-xRg36oYuARYg2YP8VpGpBg@mail.gmail.com>
	<1490474958.11328.86.camel@oracle.com>
	<CAFEAcA-BaDtJyNk0pB7AwyJNXtZ8V9LgJzcuAfPbN65b7OFsSw@mail.gmail.com>
	<1490519798.11328.113.camel@oracle.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Mar 2017 17:32:40 +0100
Message-ID: <CAFEAcA8uZK3tX_XKhL9S6Wt00Ei_dJw52K+f8yX5vqRygYwP-g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] Proposal for deprecating unsupported host OSes &
 architecutures
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Knut Omang <knut.omang@oracle.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 26 March 2017 at 10:16, Knut Omang <knut.omang@oracle.com> wrote:
> On Sat, 2017-03-25 at 21:15 +0000, Peter Maydell wrote:
>> On 25 March 2017 at 20:49, Knut Omang <knut.omang@oracle.com> wrote:
>> >
>> > Can we please keep the Sparc support in for a while still?
>>
>> Yes, John Paul Adrian Glaubitz and the Debian Project have
>> kindly provided me with access to a Sparc box. I'm planning
>> to send a patch that puts sparc into the 'supported'
>> category before 2.9 release.
>
> good to hear!

It occurred to me that it might be helpful to point out that
support of Solaris as a host OS is a separate thing and is
still in the 'unsupported' category. (It's also quite high
on the list of stuff to drop because I suspect it's broken
and it's one of the things making a mess of our configure code.)

thanks
-- PMM
