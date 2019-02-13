Received: from eggs.gnu.org ([209.51.188.92]:43387)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gtvsm-00039U-LH
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 09:51:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gtvoN-0008Qd-Gr
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 09:47:00 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:56090)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1gtvoN-0007Z2-6I
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 09:46:55 -0500
Date: Wed, 13 Feb 2019 16:46:30 +0200
From: Yuval Shaia <yuval.shaia@oracle.com>
Message-ID: <20190213144629.GA10728@lap1>
References: <20190213065357.16076-1-yuval.shaia@oracle.com>
	<20190213065357.16076-9-yuval.shaia@oracle.com>
	<d460be76-ceb9-16ba-6cc7-56541a420753@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <d460be76-ceb9-16ba-6cc7-56541a420753@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 7/9] hw/pvrdma: Delete unneeded function
 argument
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, dgilbert@redhat.com, armbru@redhat.com

On Wed, Feb 13, 2019 at 01:40:34PM +0100, Philippe Mathieu-Daud=E9 wrote:
> On 2/13/19 7:53 AM, Yuval Shaia wrote:
> > The function argument rdma_dev_res is not needed as it is stored in t=
he
> > backend_dev object at init.
> >=20
> > Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
> > Reviewed-by: Marcel Apfelbaum<marcel.apfelbaum@gmail.com>
>=20
> Should we teach checkpatch.pl to check name/space/email?

Nice idea :)

Marcel, i copied it from your signature so you may want to check it.
Anyway, is re-spin needed or you can fix it for the PR?

Yuval
