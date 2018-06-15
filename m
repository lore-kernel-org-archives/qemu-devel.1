Received: from eggs.gnu.org ([2001:4830:134:3::10]:43950)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fTtvK-0005iN-32
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 14:58:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fTtvF-0005HP-8F
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 14:58:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44356)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fTtvF-0005Fi-1n
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 14:58:09 -0400
Date: Fri, 15 Jun 2018 15:58:05 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180615185805.GE7451@localhost.localdomain>
References: <20180615141609.20749-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180615141609.20749-1-berrange@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] docs: add guidance on configuring CPU
 models for x86
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On Fri, Jun 15, 2018 at 03:16:09PM +0100, Daniel P. Berrang=E9 wrote:
> With the recent set of CPU hardware vulnerabilities on x86, it is
> increasingly difficult to understand which CPU configurations are
> good to use and what flaws they might be vulnerable to.
>=20
> This doc attempts to help management applications and administrators in
> picking sensible CPU configuration on x86 hosts. It outlines which of
> the named CPU models are good choices, and describes which extra CPU
> flags should be enabled to allow the guest to mitigate hardware flaws.
>=20
> Signed-off-by: Daniel P. Berrang=E9 <berrange@redhat.com>

Thank you very much.

I wonder how we could reference this from the man page and
qemu-doc.html without saying "look at the QEMU source tree".

(I'm not willing to rewrite this using texinfo to make that
happen.)


--=20
Eduardo
