Received: from eggs.gnu.org ([2001:4830:134:3::10]:50828)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eoFtK-0000ii-46
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 16:56:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eoFtG-00065q-VP
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 16:56:02 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:35123)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eoFtG-000654-Nt
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 16:55:58 -0500
Received: by mail-wr0-f195.google.com with SMTP id l43so18613176wrc.2
	for <qemu-devel@nongnu.org>; Tue, 20 Feb 2018 13:55:58 -0800 (PST)
References: <CAFEAcA887ukS-r6ECRG7rrCMzXO8PpJqjevR=sELc_LNfRazLA@mail.gmail.com>
	<alpine.BSF.2.21.1802202225190.89213@zero.eik.bme.hu>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <58983aec-d7c4-c10d-e2b0-dfc6c0fe3fbf@redhat.com>
Date: Tue, 20 Feb 2018 22:55:55 +0100
MIME-Version: 1.0
In-Reply-To: <alpine.BSF.2.21.1802202225190.89213@zero.eik.bme.hu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
To: BALATON Zoltan <balaton@eik.bme.hu>, Peter Maydell <peter.maydell@linaro.org>
Cc: Jeff Cody <jcody@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Richard Henderson <rth@twiddle.net>

On 20/02/2018 22:41, BALATON Zoltan wrote:
> On Tue, 20 Feb 2018, Peter Maydell wrote:
>> I just noticed that we seem to have acquired another git
>> submodule that isn't pointing to a qemu.org git url:
>>
>> [submodule "roms/seabios-hppa"]
>>        path = roms/seabios-hppa
>>        url = git://github.com/hdeller/seabios-hppa.git
> 
> And there's also
> 
> [submodule "roms/qemu-palcode"]
>         path = roms/qemu-palcode
>         url = git://github.com/rth7680/qemu-palcode.git
> 
> if that matters.

That already exists at https://github.com/qemu/qemu-palcode, it's just
not pointed to by .gitmodules.

> I don't mind either way and don't expect to change this u-boot source
> too much in the future so if you just copy it to the qemu repo without
> mirroring my repo that's fine as well. (If any change will be needed I
> can submit patches for it like for other QEMU parts but this should not
> be needed too frequently as this firmware is not developed any further
> by upstream so only changes may be bugfixes from QEMU contributors.) But
> I can't do that myself so I need help with that. All I could do is to
> provide my own repo and refer to that for all else I need your help.

Out of curiosity, why is it not upstream?

Paolo
