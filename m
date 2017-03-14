Received: from eggs.gnu.org ([2001:4830:134:3::10]:34352)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cnjlF-0002Z5-Fk
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 06:33:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cnjlC-0006RG-ER
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 06:32:59 -0400
Received: from mail-wr0-x235.google.com ([2a00:1450:400c:c0c::235]:33666)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cnjlC-0006Qr-7a
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 06:32:58 -0400
Received: by mail-wr0-x235.google.com with SMTP id u48so121017732wrc.0
	for <qemu-devel@nongnu.org>; Tue, 14 Mar 2017 03:32:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <6559d50e-b8d5-eaa2-4a14-48608644ad29@redhat.com>
References: <87tw6y8bs8.fsf@secure.mitica>
	<CAFEAcA978SJemCfYJPa8jwtuhhi6JGh9pEDGYNJ1npJA3nvEQA@mail.gmail.com>
	<6559d50e-b8d5-eaa2-4a14-48608644ad29@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 14 Mar 2017 11:32:34 +0100
Message-ID: <CAFEAcA8MW1cWDu6bOXC-CeKD-hPo3eiZ4Kpc-_==fdoM=QKXUw@mail.gmail.com>
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
To: Thomas Huth <thuth@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>, QEMU Developer <qemu-devel@nongnu.org>, KVM devel mailing list <kvm@vger.kernel.org>

On 14 March 2017 at 10:24, Thomas Huth <thuth@redhat.com> wrote:
> On 13.03.2017 11:02, Peter Maydell wrote:
>> Are we trying to be:
>>     . a dev platform before easy h/w availability?
>>       [not easy for QEMU for several reasons]
>
> What reasons exactly do you mean here?

The main ones I had in mind are:
 * to do this you need really to have access to the specs for
   new hardware features early. If you wait for publication
   of official specs to start implementation then you won't
   be done until most of the "window" before h/w is available
   has already closed
 * you need to actually implement new features, which requires
   more work than we're currently putting in -- for instance
   for ARM we still haven't finished implementing virtualization
   emulation, and we haven't even started with v8.1 features yet
 * you need to do better testing than just "does it boot
   Linux?" if you're trying to provide a dev platform for
   people to use for developing Linux...

thanks
-- PMM
