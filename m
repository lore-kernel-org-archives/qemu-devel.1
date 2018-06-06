Received: from eggs.gnu.org ([2001:4830:134:3::10]:48387)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jl4312@columbia.edu>) id 1fQXfG-0006Cz-3v
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 08:35:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jl4312@columbia.edu>) id 1fQXfC-0002Ef-VU
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 08:35:46 -0400
Received: from outprodmail01.cc.columbia.edu ([128.59.72.39]:56490)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jl4312@columbia.edu>) id 1fQXfC-0002EA-Rr
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 08:35:42 -0400
Received: from hazelnut (hazelnut.cc.columbia.edu [128.59.213.250])
	by outprodmail01.cc.columbia.edu (8.14.4/8.14.4) with ESMTP id
	w56CZ2MS030633
	for <qemu-devel@nongnu.org>; Wed, 6 Jun 2018 08:35:41 -0400
Received: from hazelnut (localhost.localdomain [127.0.0.1])
	by hazelnut (Postfix) with ESMTP id E8BB380
	for <qemu-devel@nongnu.org>; Wed,  6 Jun 2018 08:35:41 -0400 (EDT)
Received: from sendprodmail03.cc.columbia.edu (sendprodmail03.cc.columbia.edu
	[128.59.72.15]) by hazelnut (Postfix) with ESMTP id B84E980
	for <qemu-devel@nongnu.org>; Wed,  6 Jun 2018 08:35:41 -0400 (EDT)
Received: from mail-wm0-f70.google.com (mail-wm0-f70.google.com [74.125.82.70])
	by sendprodmail03.cc.columbia.edu (8.14.4/8.14.4) with ESMTP id
	w56CZflU049365
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 6 Jun 2018 08:35:41 -0400
Received: by mail-wm0-f70.google.com with SMTP id l4-v6so2954272wmh.0
	for <qemu-devel@nongnu.org>; Wed, 06 Jun 2018 05:35:41 -0700 (PDT)
Received: from mail-wm0-f54.google.com (mail-wm0-f54.google.com.
	[74.125.82.54]) by smtp.gmail.com with ESMTPSA id
	c40-v6sm14484699edb.68.2018.06.06.05.35.38
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 06 Jun 2018 05:35:38 -0700 (PDT)
Received: by mail-wm0-f54.google.com with SMTP id j15-v6so11760287wme.0
	for <qemu-devel@nongnu.org>; Wed, 06 Jun 2018 05:35:38 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D1911F8B6B@SHSMSX101.ccr.corp.intel.com>
References: <CAHyh4xhckUtH=gfa5K+KVehz27hVznUg7UX-Ca-AcjCvtiAhHg@mail.gmail.com>
	<AADFC41AFE54684AB9EE6CBC0274A5D1911F3CAE@SHSMSX101.ccr.corp.intel.com>
	<CAHyh4xhbVROe3xUXwojOMBHKdTxNms7ZqRkhpm+1N0XZm3xBuA@mail.gmail.com>
	<AADFC41AFE54684AB9EE6CBC0274A5D1911F8B6B@SHSMSX101.ccr.corp.intel.com>
From: Jintack Lim <jintack@cs.columbia.edu>
Date: Wed, 6 Jun 2018 08:35:37 -0400
Message-ID: <CAHyh4xjO8uJ3bwRN2Zmk6vL5-mT7xEY=LBLLfaFnHB6qF_C-MQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] vIOMMU Posted-interrupt implementation - atomic
 operation?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: QEMU Devel Mailing List <qemu-devel@nongnu.org>, Peter Xu <peterx@redhat.com>

On Wed, Jun 6, 2018 at 2:56 AM, Tian, Kevin <kevin.tian@intel.com> wrote:
>> From: Jintack Lim [mailto:jintack@cs.columbia.edu]
>> Sent: Tuesday, June 5, 2018 8:57 PM
>>
>> Thanks, Kevin.
>>
>> On Tue, Jun 5, 2018 at 2:54 AM, Tian, Kevin <kevin.tian@intel.com> wrote:
>> >> From: Jintack Lim
>> >> Sent: Friday, June 1, 2018 11:47 AM
>> >>
>> >> Hi,
>> >>
>> >> I'm implementing Posted-interrupt functionality in vIOMMU. According
>> >> to Vt-d spec 5.2.3, IOMMU performs a coherent atomic read-modify-
>> write
>> >> operation of the posted-interrupt descriptor. I wonder how can we
>> >> achieve this considering the guest can modify the same
>> >> posted-interrupt descriptor anytime. Is there any existing mechanism
>> >> that I can use in QEMU?
>> >>
>> >
>> > I don't think it's possible to emulate such operation in software, unless
>> > you want to change guest to be cooperative. Actually it is not necessary.
>> > VT-d does so due to some hardware implementation consideration.
>>
>> Would you mind expanding this? I'm curious what it would be. Is it
>> because IOMMU can't do something like cmpxchg instructions?
>
> I don't have further information. Above is what I was told by hardware
> team.

Ah, I see. Thanks!

>
>>
>> > Since you are emulating on CPU, could just follow how CPU posted
>> > interrupt is conducted. If you look at SDM (29.6 Posted-Interrupt
>> > Processing):
>> >
>> >         "There is a requirement, however, that such modifications be
>> > done using locked read-modify-write instructions."
>> >
>> > [instructions] means you can do update multiple times when posting an
>> > interrupt, as long as each update is atomic.
>>
>> Ah, that's a good point. So the unit of atomic operation doesn't need
>> to be the whole PI descriptor, but it can be any subset (e.g. just one
>> bit) of the descriptor? By looking at Linux kernel code, that seems to
>> be the case.
>>
>
> Exactly. :-)

Cool. Thanks for the confirmation.

Thanks,
Jintack

>
> Thanks
> Kevin
