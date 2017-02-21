Received: from eggs.gnu.org ([2001:4830:134:3::10]:45319)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cgEYl-0002Pw-7t
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 12:49:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cgEYk-0003vF-HX
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 12:49:07 -0500
Received: from mail-wr0-x236.google.com ([2a00:1450:400c:c0c::236]:33595)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cgEYk-0003v2-A6
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 12:49:06 -0500
Received: by mail-wr0-x236.google.com with SMTP id 97so8262617wrb.0
	for <qemu-devel@nongnu.org>; Tue, 21 Feb 2017 09:49:06 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170221155856.GD2778@thinpad.lan.raisama.net>
References: <1486996099-15820-1-git-send-email-peter.maydell@linaro.org>
	<CAFEAcA98V-3EMDS+o9HnAdY14JDoY4i8yYyFP=OiK8QXMSWvmA@mail.gmail.com>
	<20170221155856.GD2778@thinpad.lan.raisama.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 21 Feb 2017 17:48:44 +0000
Message-ID: <CAFEAcA9762NB0ghnvdST2AGFn_y_i5f_KxT0sdiVbZgzA=fk8A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 0/4] cpu: Implement
 cpu_generic_new()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>

On 21 February 2017 at 15:58, Eduardo Habkost <ehabkost@redhat.com> wrote:
> On Thu, Feb 16, 2017 at 04:40:43PM +0000, Peter Maydell wrote:
>> I know it's only been a few days, but I just wanted to
>> say that I'd appreciate it if we could manage relatively
>> quick review on this one, since I have a set of patches
>> pending that depend on this and which it would be nice
>> to get into 2.9 (softfreeze approaching rapidly).
>
> I was away from work for the past 3 weeks and I am catching up on
> e-mail, right now. Is this proposal still up, or is this series
> obsoleted by something else?

Given Igor's view that this isn't the way we want to go, I have
decoupled the other patches I mention above from this patchset
(making them do an in-line call to parse_features etc like
the virt.c code etc etc do at the moment). So there's no rush
and we can take the time to decide what the right approach is
(which we can then implement for QEMU 2.10, I expect).

thanks
-- PMM
