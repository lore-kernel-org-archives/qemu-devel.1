Received: from eggs.gnu.org ([209.51.188.92]:41845)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1h08Z3-0002wd-HY
	for qemu-devel@nongnu.org; Sat, 02 Mar 2019 12:36:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1h08Z2-00005e-NS
	for qemu-devel@nongnu.org; Sat, 02 Mar 2019 12:36:45 -0500
Received: from hera.aquilenet.fr ([185.233.100.1]:54044)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1h08Z2-0008Ru-E0
	for qemu-devel@nongnu.org; Sat, 02 Mar 2019 12:36:44 -0500
Date: Sat, 2 Mar 2019 09:36:29 -0800
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20190302173629.3tfpiems2plii6gc@function>
References: <20190302022518.18719-1-samuel.thibault@ens-lyon.org>
	<5b0be3f1-85c1-bb1a-2692-e0f2650bcb4f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5b0be3f1-85c1-bb1a-2692-e0f2650bcb4f@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] slirp: fix big/little endian conversion in
 ident protocol
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Cc: qemu-devel@nongnu.org, will@wbowling.info, stefanha@redhat.com, jan.kiszka@siemens.com

Philippe Mathieu-Daud=C3=A9, le sam. 02 mars 2019 18:31:56 +0100, a ecrit=
:
> On 3/2/19 3:25 AM, Samuel Thibault wrote:
> > Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
> > ---
>=20
> I got:
>=20
> Applying: slirp: fix big/little endian conversion in ident protocol
> error: patch failed: slirp/tcp_subr.c:660
> error: slirp/tcp_subr.c: patch does not apply
>=20
> Then noticed another slirp patch, applied first then this one succeed,
> so you missed:
>=20
> Based-on: <1551476756-25749-1-git-send-email-will@wbowling.info>

Oh, I didn't know about that one.

> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Thanks!

Samuel
