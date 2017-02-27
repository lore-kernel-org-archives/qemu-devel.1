Received: from eggs.gnu.org ([2001:4830:134:3::10]:49873)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ciOR6-0001AW-EL
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 11:46:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ciOR5-000588-H9
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 11:46:08 -0500
Date: Mon, 27 Feb 2017 16:46:00 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170227164600.GH10201@stefanha-x1.localdomain>
References: <1484884080-28836-1-git-send-email-zhang.zhanghailiang@huawei.com>
	<1484884080-28836-2-git-send-email-zhang.zhanghailiang@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Dx9iWuMxHO1cCoFc"
Content-Disposition: inline
In-Reply-To: <1484884080-28836-2-git-send-email-zhang.zhanghailiang@huawei.com>
Subject: Re: [Qemu-devel] [PATCH v3 1/6] docs/block-replication: Add
 description for shared-disk case
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: zhanghailiang <zhang.zhanghailiang@huawei.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, xiecl.fnst@cn.fujitsu.com, zhangchen.fnst@cn.fujitsu.com, xuquan8@huawei.com, Wen Congyang <wency@cn.fujitsu.com>


--Dx9iWuMxHO1cCoFc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 20, 2017 at 11:47:55AM +0800, zhanghailiang wrote:
> +Secondary:
> + -drive if=none,driver=qcow2,file.filename=/mnt/ramfs/hidden_disk.img,id=hidden_disk0,\
> +        backing.driver=raw,backing.file.filename=1.raw \
> + -drive if=virtio,id=active-disk0,driver=replication,mode=secondary,\
> +        file.driver=qcow2,top-id=active-disk0,\
> +        file.file.filename=/mnt/ramfs/active_disk.img,\
> +        file.backing=hidden_disk0,shared-disk=on

I don't see where this patch series adds a -drive shared-disk=on option.
Did I miss it?

--Dx9iWuMxHO1cCoFc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYtFfIAAoJEJykq7OBq3PIKrIH/ialgrMfXlXuHl/5CeikQA+9
enwwIiS7y1GDqMka6XrWxlU3Y+Lkh4hZ6RvF0YotkFc/F5ljfZBWZz4E1Sudxz2+
vhNlKu3GEVeaDqEdfyNbh/gtxOlD8kbxeOTzYGJIn+DTe/u7VUvpntYReygjDObL
24K064NN60qrM8dSPaDtTc8r4OtUrHP4s1nz7WpcRELv/fheFjsKir8YUNDdhtCg
IaQLQ7gy86GmqrjlsgS52SxBUHdBQ0c+o5aWMVgq9aS+FrXeW49+wF8ya/89WBNu
RNWauWsWNLFA91xZVd9RQNF1fhz4gA7gPZqPyBFzBv6YR8iCrQxfWVbME8a3xC4=
=k2TY
-----END PGP SIGNATURE-----

--Dx9iWuMxHO1cCoFc--
