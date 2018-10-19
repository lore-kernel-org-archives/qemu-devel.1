Received: from eggs.gnu.org ([2001:4830:134:3::10]:43826)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gDOlo-0003Cv-Nf
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 03:00:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gDOlZ-0006jo-Rr
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 03:00:19 -0400
References: <20181019010625.25294-1-cota@braap.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f7067d72-3b2a-9e6e-4636-f18ac1cf5202@redhat.com>
Date: Fri, 19 Oct 2018 08:59:24 +0200
MIME-Version: 1.0
In-Reply-To: <20181019010625.25294-1-cota@braap.org>
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
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: Aleksandar Markovic <amarkovic@wavecomp.com>, Alexander Graf <agraf@suse.de>, Alistair Francis <alistair23@gmail.com>, Andrzej Zaborowski <balrogg@gmail.com>, Anthony Green <green@moxielogic.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Christian Borntraeger <borntraeger@de.ibm.com>, Chris Wulff <crwulff@gmail.com>, Cornelia Huck <cohuck@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, David Hildenbrand <david@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, Fabien Chouteau <chouteau@adacore.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, James Hogan <jhogan@kernel.org>, Laurent Vivier <laurent@vivier.eu>, Marek Vasut <marex@denx.de>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Max Filippov <jcmvbkbc@gmail.com>, Michael Clark <mjc@sifive.com>, Michael Walle <michael@walle.cc>, Palmer Dabbelt <palmer@sifive.com>, Pavel Dovgalyuk <dovgaluk@ispras.ru>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, Richard Henderson <rth@twiddle.net>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Stafford Horne <shorne@gmail.com>

On 19/10/2018 03:05, Emilio G. Cota wrote:
> I'm calling this series a v3 because it supersedes the two series
> I previously sent about using atomics for interrupt_request:
>   https://lists.gnu.org/archive/html/qemu-devel/2018-09/msg02013.html
> The approach in that series cannot work reliably; using (locked) atomics
> to set interrupt_request but not using (locked) atomics to read it
> can lead to missed updates.

The idea here was that changes to protected fields are all followed by
kick.  That may not have been the case, granted, but I wonder if the
plan is unworkable.

Paolo
