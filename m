Received: from eggs.gnu.org ([2001:4830:134:3::10]:53973)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1eoG9Z-0008Pi-QK
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 17:12:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1eoG9U-0008Iy-UD
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 17:12:49 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:53355)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1eoG9U-0008IU-Mz
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 17:12:44 -0500
Date: Tue, 20 Feb 2018 23:12:42 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <58983aec-d7c4-c10d-e2b0-dfc6c0fe3fbf@redhat.com>
Message-ID: <alpine.BSF.2.21.1802202302440.89213@zero.eik.bme.hu>
References: <CAFEAcA887ukS-r6ECRG7rrCMzXO8PpJqjevR=sELc_LNfRazLA@mail.gmail.com>
	<alpine.BSF.2.21.1802202225190.89213@zero.eik.bme.hu>
	<58983aec-d7c4-c10d-e2b0-dfc6c0fe3fbf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: Re: [Qemu-devel] Moving seabios-hppa git submodule to use a
 qemu.org mirror
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Jeff Cody <jcody@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Richard Henderson <rth@twiddle.net>

On Tue, 20 Feb 2018, Paolo Bonzini wrote:
>> I don't mind either way and don't expect to change this u-boot source
>> too much in the future so if you just copy it to the qemu repo without
>> mirroring my repo that's fine as well. (If any change will be needed I
>> can submit patches for it like for other QEMU parts but this should not
>> be needed too frequently as this firmware is not developed any further
>> by upstream so only changes may be bugfixes from QEMU contributors.) But
>> I can't do that myself so I need help with that. All I could do is to
>> provide my own repo and refer to that for all else I need your help.
>
> Out of curiosity, why is it not upstream?

See this thread:
http://lists.nongnu.org/archive/html/qemu-devel/2018-02/msg05221.html
(and those that it refers to; this seems to be everyone's first question, 
maybe I should add a FAQ in the commit message :-) )

I don't know the details but I guess the hardware vendor who created this 
fork never bothered to upstream their changes and then u-boot has changed 
so it's now not even simple to do so any more so this u-boot variant is at 
a dead end and only needed for this board because guests running on it 
(some of which are closed source thus cannot be changed) use the services 
provided by this u-boot version.

Regards,
BALATON Zoltan
