Received: from eggs.gnu.org ([2001:4830:134:3::10]:54704)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <bp@suse.de>)
	id 1elciy-0003Yb-LV
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 10:42:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bp@suse.de>) id 1elciu-0004l1-Da
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 10:42:28 -0500
Received: from mx2.suse.de ([195.135.220.15]:49162)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bp@suse.de>) id 1elciu-0004ke-6f
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 10:42:24 -0500
Date: Tue, 13 Feb 2018 16:41:51 +0100
From: Borislav Petkov <bp@suse.de>
Message-ID: <20180213154151.GC12578@pd.tnic>
References: <20180212153715.87555-1-brijesh.singh@amd.com>
	<20180212153715.87555-6-brijesh.singh@amd.com>
	<20180212183803.GR13981@localhost.localdomain>
	<4a1f22d9-da2e-618b-1423-629817389948@amd.com>
	<20180212211948.GK14422@pd.tnic>
	<CA+HCGMYvh081neh=aF45qG0WF2vpJwkZ4unnLPLwhEkDNPWZsQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+HCGMYvh081neh=aF45qG0WF2vpJwkZ4unnLPLwhEkDNPWZsQ@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v8 05/28] target/i386: add memory
 encryption feature cpuid support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Brijesh Singh <brijesh.ksingh@gmail.com>
Cc: Brijesh Singh <brijesh.singh@amd.com>, Eduardo Habkost <ehabkost@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Markus Armbruster <armbru@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Stefan Hajnoczi <stefanha@gmail.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Lendacky <Thomas.Lendacky@amd.com>, Alistair Francis <alistair.francis@xilinx.com>, Bruce Rogers <brogers@suse.com>, Richard Henderson <rth@twiddle.net>

On Tue, Feb 13, 2018 at 09:39:01AM -0600, Brijesh Singh wrote:
> Yes, I think we should be able to avoid creating new CPU model to
> handle this case. I am leaning towards dropping this patch and
> implement logic to populate the CPUID 0x8000_001F only when SEV is
> enabled. This should not require any changes in existing CPU model
> feature flag and live migration of existing guest should work fine.

That sounds even nicer.

Thx.

--=20
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imend=C3=B6rffer, Jane Smithard, Graham Norton=
, HRB 21284 (AG N=C3=BCrnberg)
--=20
