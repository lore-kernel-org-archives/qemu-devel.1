Received: from eggs.gnu.org ([2001:4830:134:3::10]:36665)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dqCfw-0006rv-Gy
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 02:22:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dqCfr-00057p-Of
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 02:22:00 -0400
Received: from mail-io0-x22c.google.com ([2607:f8b0:4001:c06::22c]:38900)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1dqCfr-00057P-IL
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 02:21:55 -0400
Received: by mail-io0-x22c.google.com with SMTP id n69so2512562ioi.5
	for <qemu-devel@nongnu.org>; Thu, 07 Sep 2017 23:21:55 -0700 (PDT)
References: <20170907092010.3605-1-aik@ozlabs.ru>
	<20170907092010.3605-2-aik@ozlabs.ru>
	<CAFEAcA-s026tJqgfa+kNsLtY2fEKpFs7ZT6zOk8CMg7ZX84CQA@mail.gmail.com>
	<2e429b41-8ffd-8bf7-56c7-32461033776e@ozlabs.ru>
	<CAFEAcA-Px28x1KcyRgQ6P68RUstWuOhHO17Z3wdG_6QL76+9xQ@mail.gmail.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <f445168a-10fc-2139-4bed-ceec1f1039a8@ozlabs.ru>
Date: Fri, 8 Sep 2017 16:21:48 +1000
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-Px28x1KcyRgQ6P68RUstWuOhHO17Z3wdG_6QL76+9xQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH qemu 1/4] memory: Postpone flatview and
 dispatch tree building till all devices are added
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, David Gibson <david@gibson.dropbear.id.au>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>

On 08/09/17 00:30, Peter Maydell wrote:
> On 7 September 2017 at 15:27, Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
>> On 07/09/17 19:30, Peter Maydell wrote:
>>> What happens if something in a device realize function tries
>>> to do a read from an AddressSpace?
>>
>>
>> address_space_memory is created before that loop but yes, address spaces
>> for devices are not rendered and QEMU crashes, needs fixing.
> 
> I'd be OK if we defined this to be not permitted, as long as
> we're reasonably happy that we don't currently do it anywhere
> and the error if it does happen is fairly clear about what's
> gone wrong.


QEMU actually only crashes with 2/4 + 3/4, with just 1/4 QEMU gets to
unassigned_mem_accepts() silently. Not sure how to convert this to a clear
error message.



-- 
Alexey
