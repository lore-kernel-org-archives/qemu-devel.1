Received: from eggs.gnu.org ([2001:4830:134:3::10]:42765)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fWRZi-0003yM-V7
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 15:18:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fWRZe-0002A1-W0
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 15:18:26 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48550 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fWRZe-000297-QG
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 15:18:22 -0400
Date: Fri, 22 Jun 2018 22:18:21 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180622221313-mutt-send-email-mst@kernel.org>
References: <20180612184616.90838-1-mst@redhat.com>
	<20180614081800.GH6355@redhat.com> <20180622130659.GA11827@paraplu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180622130659.GA11827@paraplu>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 0/2] kvm: x86 CPU power management
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kashyap Chamarthy <kchamart@redhat.com>
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org, Richard Henderson <rth@twiddle.net>, huth@tuxfamily.org

On Fri, Jun 22, 2018 at 03:06:59PM +0200, Kashyap Chamarthy wrote:
> (Cc: Thomas Huth)
>=20
> On Thu, Jun 14, 2018 at 09:18:00AM +0100, Daniel P. Berrang=E9 wrote:
>=20
> [...]
>=20
> > IMHO this really shouldn't be under the -realtime flag. I don't think
> > the -realtime flag should ever have been introduced, and we certainly
> > shouldn't add more stuff under it.
> >=20
> > "-realtime" is referring to a very specific use case, while the
> > properties listed under it are all general purpose features. Real
> > time guests just happen to be one possible use case, but it is
> > valid to use them for non-real time guests.
>=20
> Given what you say above, then it sounds like the "-realtime" QEMU
> option should be deprecated, and removed in a future release.
>=20
> [...]
>=20

As a patch on top,  sure.

> --=20
> /kashyap
