Received: from eggs.gnu.org ([209.51.188.92]:54830)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gqazZ-0003j7-JA
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 04:56:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gqazY-00035i-Se
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 04:56:41 -0500
Date: Mon, 4 Feb 2019 10:56:28 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190204095628.GC5855@linux.fritz.box>
References: <20190125174653.4604-1-kwolf@redhat.com>
	<20190125174653.4604-4-kwolf@redhat.com>
	<20190129155832.GJ30796@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190129155832.GJ30796@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/3] scsi-disk: Deprecate device_id
 fallback to BlockBackend name
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-block@nongnu.org, armbru@redhat.com, pbonzini@redhat.com, pkrempa@redhat.com, eblake@redhat.com, libvir-list@redhat.com, qemu-devel@nongnu.org

Am 29.01.2019 um 16:58 hat Daniel P. Berrang=E9 geschrieben:
> On Fri, Jan 25, 2019 at 06:46:53PM +0100, Kevin Wolf wrote:
> > We should never have exposed BlockBackend names to the guest, it's a
> > host detail. Deprecate this behaviour. Users who need to maintain the
> > guest ABI can explicitly set the value with the device_id property.
>=20
> I don't think we've deprecated things in the past which would cause
> a guest ABI change when finally deleted.
>=20
> Shouldn't we be instead setting using machine type versioning here,
> so that existing machine types keep using the blk_name() fallback
> forever, while QEMU 4.0+ machine types avoid blk_name() fallback
> immediately.

I was going to implement this, but then I wondered if that's actually
worthwhile. With -blockdev, you don't get the bad behaviour anyway, and
tools that would select new machine types will hopefully also use new
backend options.

So if we need to keep the bad behaviour around anyway instead of
completely removing it as I intended originally, maybe -drive vs.
-blockdev is enough to make the difference and we shouldn't change
anything at the device model level at all.

Kevin
