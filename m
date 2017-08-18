Received: from eggs.gnu.org ([2001:4830:134:3::10]:34097)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dikIa-000637-PR
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 12:39:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dikIV-0004nV-TD
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 12:39:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51822)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dikIV-0004nA-Mi
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 12:38:59 -0400
Date: Fri, 18 Aug 2017 13:38:54 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170818163854.GY3108@localhost.localdomain>
References: <1502842933-8323-1-git-send-email-tianyu.lan@intel.com>
	<34042934-782b-6bcc-b9b2-de7a1816cfb7@redhat.com>
	<3ababa62-f055-5bbb-b9b9-c55ada8368dd@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3ababa62-f055-5bbb-b9b9-c55ada8368dd@intel.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] x86: Skip check apic_id_limit for Xen
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Lan Tianyu <tianyu.lan@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, mst@redhat.com, rth@twiddle.net, anthony.perard@citrix.com, xen-devel@lists.xenproject.org

On Thu, Aug 17, 2017 at 09:37:10AM +0800, Lan Tianyu wrote:
> On 2017=E5=B9=B408=E6=9C=8816=E6=97=A5 19:21, Paolo Bonzini wrote:
> > On 16/08/2017 02:22, Lan Tianyu wrote:
> >> Xen vIOMMU device model will be in Xen hypervisor. Skip vIOMMU
> >> check for Xen here when vcpu number is more than 255.
> >=20
> > I think you still need to do a check for vIOMMU being enabled.
>=20
> Yes, this will be done in the Xen tool stack and Qemu doesn't have such
> knowledge. Operations of create, destroy Xen vIOMMU will be done in the
> Xen tool stack.

Shouldn't we make QEMU have knowledge of the vIOMMU device, then?
Won't QEMU need to know about it eventually?

--=20
Eduardo
