Received: from eggs.gnu.org ([2001:4830:134:3::10]:56217)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dpxpG-0000De-Gq
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 10:30:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dpxp7-0004F0-7l
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 10:30:38 -0400
Received: from mail-wm0-x231.google.com ([2a00:1450:400c:c09::231]:36229)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dpxp7-0004EI-12
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 10:30:29 -0400
Received: by mail-wm0-x231.google.com with SMTP id r10so70870wmf.1
	for <qemu-devel@nongnu.org>; Thu, 07 Sep 2017 07:30:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <2e429b41-8ffd-8bf7-56c7-32461033776e@ozlabs.ru>
References: <20170907092010.3605-1-aik@ozlabs.ru>
	<20170907092010.3605-2-aik@ozlabs.ru>
	<CAFEAcA-s026tJqgfa+kNsLtY2fEKpFs7ZT6zOk8CMg7ZX84CQA@mail.gmail.com>
	<2e429b41-8ffd-8bf7-56c7-32461033776e@ozlabs.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 7 Sep 2017 15:30:07 +0100
Message-ID: <CAFEAcA-Px28x1KcyRgQ6P68RUstWuOhHO17Z3wdG_6QL76+9xQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: QEMU Developers <qemu-devel@nongnu.org>, David Gibson <david@gibson.dropbear.id.au>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>

On 7 September 2017 at 15:27, Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
> On 07/09/17 19:30, Peter Maydell wrote:
>> What happens if something in a device realize function tries
>> to do a read from an AddressSpace?
>
>
> address_space_memory is created before that loop but yes, address spaces
> for devices are not rendered and QEMU crashes, needs fixing.

I'd be OK if we defined this to be not permitted, as long as
we're reasonably happy that we don't currently do it anywhere
and the error if it does happen is fairly clear about what's
gone wrong.

thanks
-- PMM
