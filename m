Received: from eggs.gnu.org ([2001:4830:134:3::10]:37544)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cQUit-0004Iv-Ix
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 02:50:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cQUio-00079v-Ki
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 02:50:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33488)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cQUio-00078S-FA
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 02:50:26 -0500
Message-ID: <1483948223.19018.24.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 09 Jan 2017 08:50:23 +0100
In-Reply-To: <c8a3c973-4e5b-05f4-ac3f-e117d353e374@redhat.com>
References: <1483692945-9866-1-git-send-email-kraxel@redhat.com>
	<1483692945-9866-9-git-send-email-kraxel@redhat.com>
	<c8a3c973-4e5b-05f4-ac3f-e117d353e374@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 08/17] wctablet: drop debug code from
 wctablet_handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, avg.tolik@gmail.com

On Fr, 2017-01-06 at 07:17 -0600, Eric Blake wrote:
> On 01/06/2017 02:55 AM, Gerd Hoffmann wrote:
> > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> > ---
> >  backends/wctablet.c | 6 ------
> >  1 file changed, 6 deletions(-)
>=20
> Why not just squash this into 1/17?

My intention is to keep the submission by Anatoli separate from the
cleanups and improvements I did.  Also in case I introduced any
regressions it is easier to figure which change broke things this way.

For the actual merge it probably makes sense to just squash the whole
series into a single patch.

cheers,
  Gerd
