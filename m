Received: from eggs.gnu.org ([2001:4830:134:3::10]:32834)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dAe60-0007sm-TJ
	for qemu-devel@nongnu.org; Tue, 16 May 2017 11:09:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dAe60-0001p9-6I
	for qemu-devel@nongnu.org; Tue, 16 May 2017 11:09:08 -0400
Date: Tue, 16 May 2017 16:08:37 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170516150837.GP8498@stefanha-x1.localdomain>
References: <20170511144208.24075-1-pbonzini@redhat.com>
	<20170511144208.24075-19-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xXygN3QAmJYWdGtb"
Content-Disposition: inline
In-Reply-To: <20170511144208.24075-19-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 18/18] block: make accounting thread-safe
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, famz@redhat.com, qemu-block@nongnu.org


--xXygN3QAmJYWdGtb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 11, 2017 at 04:42:08PM +0200, Paolo Bonzini wrote:
> diff --git a/block/accounting.c b/block/accounting.c
> index 0429e31c9f..85890e4fe5 100644
> --- a/block/accounting.c
> +++ b/block/accounting.c
> @@ -35,6 +35,7 @@ static const int qtest_latency_ns = NANOSECONDS_PER_SECOND / 1000;
>  void block_acct_init(BlockAcctStats *stats, bool account_invalid,
>                       bool account_failed)
>  {
> +    qemu_mutex_init(&stats->spin);

Only if you respin this series:

s/spin/lock/

(It's no longer a spinlock.)

--xXygN3QAmJYWdGtb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZGxX1AAoJEJykq7OBq3PIgygIAIrdvvdEBprTa81VVoWC3xgr
QoustpXVer7flYoe9idcst2nvfxM9L/cSXZmtx5LGRbA8CyL2AYJkYmtiENLY9a9
05KtWHUWsNpDr42p9AInCJLWpELiiEE7yHUQrg3ixgOia6a4Pcbw4n8kikptI3TU
MlEaVkqA6wh3pMGdi/XGL+N5uQNN8k++4r7/txyPv22X0YypN8uqDtLdIUSsE02H
6l6Des5sNcOtua4og5p8pjnQeaMM0Bk0oLBDXB6HxXHO2/fId22WbuUWQ7k+o/Yu
+aAjGEONJsDWKgTeB7tRjXvj8GpbxiO7UogLoiNWqY/niOvPSDU8uIwPqu2eK5I=
=PdHo
-----END PGP SIGNATURE-----

--xXygN3QAmJYWdGtb--
