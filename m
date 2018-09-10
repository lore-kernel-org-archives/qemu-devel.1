Received: from eggs.gnu.org ([2001:4830:134:3::10]:42703)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fzKih-0000NX-3l
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 07:51:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fzKib-0006Ba-3t
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 07:51:06 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57466 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fzKiZ-0006AZ-5W
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 07:51:00 -0400
References: <f38111ad-3fbb-210e-e7ec-49ae675ea65e@eagerm.com>
	<a57fdd27-7a86-3f31-341c-e98101d17b9a@eagerm.com>
	<61c2239b-f8db-6648-ba1b-203309d876eb@eagerm.com>
	<f741c912-c37b-34a6-89a3-96577d186adc@eagerm.com>
	<CAFEAcA-8fF1F6A64Yv5G0LB9T4mBRvSSqi8oe3kENxSOGc982Q@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <31902dac-e381-412f-5ec4-e8d39fe63961@redhat.com>
Date: Mon, 10 Sep 2018 13:50:56 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-8fF1F6A64Yv5G0LB9T4mBRvSSqi8oe3kENxSOGc982Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] RISC-V - Dynamic parameterization of
 RISC-V memory map
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Michael Eager <eager@eagerm.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 06/09/2018 17:44, Peter Maydell wrote:
> On 6 September 2018 at 16:07, Michael Eager <eager@eagerm.com> wrote:
>> Any comments?
> I'd quite like to hear from somebody more familiar with the
> readconfig/writeconfig stuff than me about whether this
> very riscv-centric approach makes sense and fits with how
> the config file is used by other parts of QEMU.
> 
> I'm not sure who would be best to do that review, though. Paolo,
> any suggestions for who knows that bit of the code?

I'm not sure why you need a readconfig-specific section and you cannot
just use -machine (adding properties to the RISC-V machine classes).
That would be usable through either command line or -readconfig.

Paolo
