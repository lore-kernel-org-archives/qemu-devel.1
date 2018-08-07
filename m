Received: from eggs.gnu.org ([2001:4830:134:3::10]:58607)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fn3cm-0002mW-6m
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 11:10:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fn3cl-0004Jl-3k
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 11:10:16 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:42195)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fn3ck-0004JV-PL
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 11:10:14 -0400
Received: by mail-oi0-x244.google.com with SMTP id b16-v6so15651204oic.9
	for <qemu-devel@nongnu.org>; Tue, 07 Aug 2018 08:10:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87o9ee1aka.fsf@trasno.org>
References: <20180807130355.29780-1-peter.maydell@linaro.org>
	<87muty2u57.fsf@trasno.org>
	<CAFEAcA_m+81aDQR=n=8gXhcifYp0L6n9KZA5COQsRejeqZe2FQ@mail.gmail.com>
	<87in4m2qni.fsf@trasno.org>
	<CAFEAcA81Xr6_eUV5247JtZRnN9Ms7fau1iwhHkmW-gnwH9y8JA@mail.gmail.com>
	<87wot21bbt.fsf@trasno.org>
	<CAFEAcA_y1qKsC8kSDee+FEpqZstz9UHTeyP6ABuGfXf_aDMRHw@mail.gmail.com>
	<87o9ee1aka.fsf@trasno.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 7 Aug 2018 16:09:53 +0100
Message-ID: <CAFEAcA_XJGWPioUDUR0+9v16Xj_osDwk7OYEK3vkqdg_SacMXA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] migration: Correctly handle subsections
 with no 'needed' function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On 7 August 2018 at 16:05, Juan Quintela <quintela@redhat.com> wrote:
> Peter Maydell <peter.maydell@linaro.org> wrote:
>> So it's better to use a needed-always subsection, which will give
>> the desired behaviour:
>>  * new QEMU -> new QEMU: state is always migrated
>>  * old QEMU -> new QEMU: migration doesn't fail, and guest
>>    will work assuming it didn't care about this corner of the
>>    device's functionality (the device will end up with state
>>    as it was at reset, or possibly special-cased via
>>    pre_load/post_load hooks for the "section not present" case)
>
> we break by definiton new QEMU -M <old machine type> into old QEMU.

Is that supposed to work? I always thought that we never
supported migration back to an older QEMU version like that.

In any case, for all the devices here the machine types are
not versioned.

thanks
-- PMM
