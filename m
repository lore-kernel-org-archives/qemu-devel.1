Received: from eggs.gnu.org ([2001:4830:134:3::10]:41722)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gEcAJ-0005JX-1O
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 11:30:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gEcAE-0001Um-Iv
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 11:30:46 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38503)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gEcAE-0001SA-6j
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 11:30:42 -0400
Received: by mail-wr1-f65.google.com with SMTP id d10-v6so5862284wrs.5
	for <qemu-devel@nongnu.org>; Mon, 22 Oct 2018 08:30:41 -0700 (PDT)
References: <20181019010625.25294-1-cota@braap.org>
	<f7067d72-3b2a-9e6e-4636-f18ac1cf5202@redhat.com>
	<20181019145018.GB7279@flamenco>
	<6190036c-cd1f-4549-9b7e-9e7913c972d4@redhat.com>
	<20181019192932.GA17761@flamenco> <20181019234608.GA32420@flamenco>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <74e14727-1174-0b91-94ae-6f07475e583d@redhat.com>
Date: Mon, 22 Oct 2018 17:30:37 +0200
MIME-Version: 1.0
In-Reply-To: <20181019234608.GA32420@flamenco>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v3 0/56] per-CPU locks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Aleksandar Markovic <amarkovic@wavecomp.com>, Alexander Graf <agraf@suse.de>, Alistair Francis <alistair23@gmail.com>, Andrzej Zaborowski <balrogg@gmail.com>, Anthony Green <green@moxielogic.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Christian Borntraeger <borntraeger@de.ibm.com>, Chris Wulff <crwulff@gmail.com>, Cornelia Huck <cohuck@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, David Hildenbrand <david@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, Fabien Chouteau <chouteau@adacore.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, James Hogan <jhogan@kernel.org>, Laurent Vivier <laurent@vivier.eu>, Marek Vasut <marex@denx.de>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Max Filippov <jcmvbkbc@gmail.com>, Michael Clark <mjc@sifive.com>, Michael Walle <michael@walle.cc>, Palmer Dabbelt <palmer@sifive.com>, Pavel Dovgalyuk <dovgaluk@ispras.ru>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, Richard Henderson <rth@twiddle.net>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Stafford Horne <shorne@gmail.com>

On 20/10/2018 01:46, Emilio G. Cota wrote:
>> So it is possible that it was my implementation, and not the approach,
>> what was at fault :-)
> I've just observed a similar hang after adding the "BQL
> pushdown" patches on top of this series. So it's likely that the
> hangs come from those patches, and not from the work on
> cpu->interrupt_request. I just confirmed with the prior
> series, and removing the pushdown patches fixes the hangs there
> as well.

Oh well, not a big deal.  You already wrote these patches and I don't
have much time for MTTCG anyway, so I am okay with sticking with them.
Thanks!

Paolo
