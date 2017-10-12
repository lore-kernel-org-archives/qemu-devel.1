Received: from eggs.gnu.org ([2001:4830:134:3::10]:41359)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e2idb-0001WR-FM
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 14:55:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e2ida-0002C5-LW
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 14:55:19 -0400
Received: from mail-wm0-x233.google.com ([2a00:1450:400c:c09::233]:50972)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e2ida-0002BY-8S
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 14:55:18 -0400
Received: by mail-wm0-x233.google.com with SMTP id u138so15644843wmu.5
	for <qemu-devel@nongnu.org>; Thu, 12 Oct 2017 11:55:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <7c9386e1-b257-29bd-a344-d36574850b70@redhat.com>
References: <CAFEAcA-zUTfLOBkOeLc4e1Ok0dnKD=hWsdeR47125MhMnwV7UA@mail.gmail.com>
	<20171010161008.GM30015@redhat.com>
	<7c9386e1-b257-29bd-a344-d36574850b70@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Oct 2017 19:54:56 +0100
Message-ID: <CAFEAcA_z1ah8_KWKMTxt5v-76dcPSonGKYO3Mpj9V57kjX+9NQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] proposed schedule for 2.11 release
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>

On 10 October 2017 at 17:26, Paolo Bonzini <pbonzini@redhat.com> wrote:
> On 10/10/2017 18:10, Daniel P. Berrange wrote:
>> On Tue, Oct 10, 2017 at 03:07:26PM +0100, Peter Maydell wrote:
>>> OK, here's a strawman proposal for the 2.11 release cycle,
>>> based on aiming for a 5 Dec release date and working backwards
>>> with the same cadence as 2.10.
>>>
>>> 2017-10-31 Soft freeze -- all feature changes must already be in a
>>>            pull request that's been sent to the mailing list
>>> 2017-11-07 Hard freeze, tag rc0
>>> 2017-11-14 Tag rc1
>>> 2017-11-21 Tag rc2
>>> 2017-11-28 Tag rc3
>>> 2017-12-05 Release (or rc4 if we need it)
>>> 2017-12-12 Release if we needed an rc4
>>>
>>> That makes softfreeze in 3 weeks time. I'd rather not push
>>> the times back any further because we end up in serious
>>> risk of running into the christmas holiday period.
>>
>> Soft freeze date is not great from a KVM Forum timing POV - the 31st is
>> likely to be a travel day for most of the Red Hat devs.
>
> Might as well have soft freeze on Oct 24 (and keep hard freeze on Nov
> 7)...  Non-maintainers posting patches on the Oct 24-31 week probably
> wouldn't have them included in 2.11 anyway.

Hmm, I'd forgotten that KVM Forum dates would mess this up.
I'm going to be travelling/at the conference for the 23-27th
week, so I can't guarantee that I'll be able to apply any pull
requests then. But I will be back for the 30th, so I'd
rather not officially set the soft freeze date to the 24th.
Maintainers who are going to be away then will just, as
Daniel suggests, want to plan ahead to have got their
pull requests on list.

thanks
-- PMM
