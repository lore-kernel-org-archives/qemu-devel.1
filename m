Received: from eggs.gnu.org ([2001:4830:134:3::10]:39671)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fpdGS-00081S-50
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 13:38:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fpdGC-0004ef-V1
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 13:37:52 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48538 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fpdGC-0004dh-OI
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 13:37:36 -0400
References: <20180808210750.3915-1-jusual@mail.ru>
	<20180808210750.3915-2-jusual@mail.ru>
	<CAJSP0QUZERaC=YVe_eWJjtVdMt24Ngi7H5yU6a9anf59n+Zwfw@mail.gmail.com>
	<5a087618-751c-c562-6d41-630a9ced03f4@mail.ru>
	<CAJSP0QWxBtpeTt=4wBjemdTjQy_12DS+1PHZUvP2S48LcxWv7g@mail.gmail.com>
	<CAFEAcA8wJtLxZcyCSjcN6uxBAHz7LywVEGgFs-5=NjGb7pTTDQ@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b8139632-bc0b-3a37-26ed-74c812912aac@redhat.com>
Date: Tue, 14 Aug 2018 19:37:30 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8wJtLxZcyCSjcN6uxBAHz7LywVEGgFs-5=NjGb7pTTDQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/4] hw/char: Implement nRF51 SoC UART
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>
Cc: Julia Suvorova <jusual@mail.ru>, qemu-devel <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, =?UTF-8?Q?Steffen_G=c3=b6rtz?= <mail@steffen-goertz.de>

On 14/08/2018 12:02, Peter Maydell wrote:
> On 13 August 2018 at 10:47, Stefan Hajnoczi <stefanha@gmail.com> wrote:
>> It's an assumption that on-board devices cannot be hot unplugged and
>> that the machine type stays alive until QEMU terminates.
>>
>> Making this assumption saves 1 call to qemu_chr_fe_set_handlers().
>> The cost is that we cannot safely stop the system-on-chip because its
>> devices don't clean up properly.
>>
>> Since cleanup is so trivial here I think it's worthwhile.
> I would be more in favour of adding an unrealize function to
> random always-present-never-unpluggable devices if we had
> better documentation of exactly what the QOM lifecycle is
> and what needs to be done in init/realize/unrealize/etc.
> As it is, I don't know myself and therefore can't review
> whether devices with unrealize methods get it right. And
> obviously the code is completely untestable because it can
> never run...

I agree.  Don't bother with unrealize unless the device hot-unpluggable.
 What matters is that init/finalize are done right but that is tested by
device-introspection-test.

Paolo
