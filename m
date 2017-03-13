Received: from eggs.gnu.org ([2001:4830:134:3::10]:53710)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cnQnD-0007QD-32
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 10:17:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cnQnC-0003K4-8n
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 10:17:47 -0400
Received: from mail-wm0-x234.google.com ([2a00:1450:400c:c09::234]:37849)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cnQnC-0003Jq-27
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 10:17:46 -0400
Received: by mail-wm0-x234.google.com with SMTP id n11so41126636wma.0
	for <qemu-devel@nongnu.org>; Mon, 13 Mar 2017 07:17:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <871su1w9jc.fsf@secure.mitica>
References: <87tw6y8bs8.fsf@secure.mitica>
	<CAFEAcA978SJemCfYJPa8jwtuhhi6JGh9pEDGYNJ1npJA3nvEQA@mail.gmail.com>
	<871su1w9jc.fsf@secure.mitica>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 13 Mar 2017 15:17:24 +0100
Message-ID: <CAFEAcA8oAFqQrTE5bq_yZvoLkQhm4HqAiA16Kdzo6mSVjPg7eQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] KVM call for 2017-03-14
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: KVM devel mailing list <kvm@vger.kernel.org>, QEMU Developer <qemu-devel@nongnu.org>

On 13 March 2017 at 15:12, Juan Quintela <quintela@redhat.com> wrote:
> Peter Maydell <peter.maydell@linaro.org> wrote:
>>     [Making QEMU more modular would help with defeating the legacy
>>     and back-compat dragons, though]
>
> That would be ideal, but where to start?  Think of something as "simple"
> asd adding a struct of operations that implement the differences for
> TCG, xen and kvm.  And you see that you get into having to rewrite lot
> of code after moving to that abstraction just the more simple
> operations.

Oh, indeed, it's a huge and painful amount of work that
doesn't actually produce a product with more features when
you've done it. But if it was simple and easy we'd have
already done it and it wouldn't merit listing on a
"big problems we need to solve somehow" list :-)

thanks
-- PMM
