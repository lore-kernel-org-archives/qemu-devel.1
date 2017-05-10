Received: from eggs.gnu.org ([2001:4830:134:3::10]:44683)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d8Llq-0002Cp-0o
	for qemu-devel@nongnu.org; Wed, 10 May 2017 03:10:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d8Llo-0002Xe-VY
	for qemu-devel@nongnu.org; Wed, 10 May 2017 03:10:49 -0400
Date: Wed, 10 May 2017 17:10:05 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170510071005.GW25748@umbus.fritz.box>
References: <1494389972-26471-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6B5oiwbC31sfIr4n"
Content-Disposition: inline
In-Reply-To: <1494389972-26471-1-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] target/ppc: Avoid printing wrong
 aliases in CPU help text
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>


--6B5oiwbC31sfIr4n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 10, 2017 at 06:19:32AM +0200, Thomas Huth wrote:
> When running with KVM, we update the "family" CPU alias to point
> to the right host CPU type, so that it for example possible to
> use "-cpu POWER8" on a POWER8NVL host. However, the function for
> printing the list of available CPU models is called earlier than
> the KVM setup code, so the output of "-cpu help" is wrong in that
> case. Since it would be somewhat ugly anyway to have different
> help texts depending on whether "-enable-kvm" has been specified
> or not, we should better always print the same text, so fix this
> issue by printing "alias for preferred XXX CPU" instead.
>=20
> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Applied to ppc-for-2.10, thanks.

Just after today's pull request, I'm afraid, but I really wanted to
get that out because it has some vital POWER9 fixes.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--6B5oiwbC31sfIr4n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZErzNAAoJEGw4ysog2bOSAHAP/jZxehXzi8WAy3YyT1Ryh5MH
67zRJAOEdXQSOuZCQJ+T/mF0b6p3kqBCYQLrcgSPJLvCFcxMFRh5ly7QJF2gvyw0
F1e+DLH8XnaZxYBSHdyd96yZDjYnC2NEIkkL+tVqIZKdbzN4FpV0v7x84D3fry0P
xK2GPNMHaItDhtkcl/OcmAOaI2Cd5iA8Bh+qKmn3SPHC1kNHpJC0s9ON2T5a/t/b
c3ozCXpOu3UYpGTT0i9VrXEj6nQfuOjdLYDFCypeewuxlmcY3fsDoa8N344GbAgn
fqm44kTwBM70B0avvFW5JrA3CH6uTGd3PA+RkRtiRtv05K3Hl+yGXRvNnyDVav+k
EC6h+QFfgrLIcWT7sG9u7HDBDs/1XA5peqh9xkH736mJAz4IOAJwgxQ02ArQWi8x
5MV9FauunePR2oJsqHYQZd8J1i6CZTRWcS9RHOvxjhSArFmwZTSSeJ3u6f5X0WnG
nHPKegWd6VW/GFNolHwvcLe2lni/DMzweN/h83AiIB+EbS9d7Yh7F32Kba4iBHTf
OV5us5zbd8CuUB0HNithiyInQMRQs9uc4TEXGiGwj95MFqr7C+fX87wndFKjD6+p
WWIYp19dDB43gbvixPdAaOdjJDry/dIcInId3BAgUpC2ybAHuSIAIltFhpG8430L
wcYDCzsG2iXtURobz2v7
=ngGi
-----END PGP SIGNATURE-----

--6B5oiwbC31sfIr4n--
