Received: from eggs.gnu.org ([2001:4830:134:3::10]:36281)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dAY8b-0005RQ-UX
	for qemu-devel@nongnu.org; Tue, 16 May 2017 04:47:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dAY8Y-0002Sy-3o
	for qemu-devel@nongnu.org; Tue, 16 May 2017 04:47:26 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170515214114.15442-1-eblake@redhat.com>
	<20170515214114.15442-5-eblake@redhat.com>
Date: Tue, 16 May 2017 10:46:57 +0200
In-Reply-To: <20170515214114.15442-5-eblake@redhat.com> (Eric Blake's message
	of "Mon, 15 May 2017 16:41:13 -0500")
Message-ID: <87y3txfata.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v9 4/5] shutdown: Add source information to
 SHUTDOWN and RESET
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, "open list:Overall" <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Alexander Graf <agraf@suse.de>, Yongbok Kim <yongbok.kim@imgtec.com>, Gerd Hoffmann <kraxel@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Rob Herring <robh@kernel.org>, Stefano Stabellini <sstabellini@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Anthony Perard <anthony.perard@citrix.com>, "open list:X86" <xen-devel@lists.xenproject.org>, Richard Henderson <rth@twiddle.net>, Artyom Tarasenko <atar4qemu@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, Stefan Weil <sw@weilnetz.de>, alistair.francis@xilinx.com, "open list:Calxeda Highbank" <qemu-arm@nongnu.org>, Jan Kiszka <jan.kiszka@web.de>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Igor Mammedov <imammedo@redhat.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, David Gibson <david@gibson.dropbear.id.au>, Paul Burton <paul.burton@imgtec.com>, Max Filippov <jcmvbkbc@gmail.com>, Marcelo Tosatti <mtosatti@redhat.com>, Michael Walle <michael@walle.cc>, "open list:Old World" <qemu-ppc@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>

Eric Blake <eblake@redhat.com> writes:

> Time to wire up all the call sites that request a shutdown or
> reset to use the enum added in the previous patch.
>
> It would have been less churn to keep the common case with no
> arguments as meaning guest-triggered, and only modified the
> host-triggered code paths, via a wrapper function, but then we'd
> still have to audit that I didn't miss any host-triggered spots;
> changing the signature forces us to double-check that I correctly
> categorized all callers.
>
> Since command line options can change whether a guest reset request
> causes an actual reset vs. a shutdown, it's easy to also add the
> information to reset requests.
>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> Acked-by: David Gibson <david@gibson.dropbear.id.au> [ppc parts]
> Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk> [SPARC part]
> Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com> [s390x parts]
>
> ---
> v8: rebase later in series

That turned out nicely.  Thanks!

Reviewed-by: Markus Armbruster <armbru@redhat.com>
