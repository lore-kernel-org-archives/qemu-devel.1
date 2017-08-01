Received: from eggs.gnu.org ([2001:4830:134:3::10]:40563)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dcTgO-0004e8-Ug
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 05:41:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dcTgO-0008P3-4s
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 05:41:44 -0400
Received: from mail-wr0-x231.google.com ([2a00:1450:400c:c0c::231]:36976)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dcTgN-0008OW-TD
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 05:41:44 -0400
Received: by mail-wr0-x231.google.com with SMTP id 33so4416625wrz.4
	for <qemu-devel@nongnu.org>; Tue, 01 Aug 2017 02:41:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <48d4b55f-6463-48a8-8ed3-b72110005377@adacore.com>
References: <1501575048-13485-1-git-send-email-frederic.konrad@adacore.com>
	<1501575048-13485-3-git-send-email-frederic.konrad@adacore.com>
	<CAFEAcA__hzcs_wvtYA35F4wAPhgHX0=-z8TJ8uwTSom6zxjN=A@mail.gmail.com>
	<086e70d6-d5c1-2879-874f-ea1804c6ab38@adacore.com>
	<20170801093015.GA4859@toto>
	<48d4b55f-6463-48a8-8ed3-b72110005377@adacore.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 1 Aug 2017 10:41:22 +0100
Message-ID: <CAFEAcA_eWCEmXBGNJXAfUjgXwYX10FwxRwd_YNcdtMYXNLAROg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for-2.10 2/2] xilinx-spips: add a migration
 blocker when using mmio_execution
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: KONRAD Frederic <frederic.konrad@adacore.com>
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, Alistair Francis <alistair.francis@xilinx.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>

On 1 August 2017 at 10:35, KONRAD Frederic <frederic.konrad@adacore.com> wrote:
>
>
> On 08/01/2017 11:30 AM, Edgar E. Iglesias wrote:
>> At this stage, perhaps we should just register the blocker when this dev
>> realizes.
>>
>> If a request_ptr comes in during migration, the VM will fail either way...

> Yes but this will breaks migration for the spips device everytime
> and not only when mmio-execution is used?

This line of thought is why I ended up suggesting just disabling
the exec-in-place feature -- that way we just don't introduce
what would be a new-in-2.10 feature, rather than breaking something
that used to work in 2.9.

thanks
-- PMM
