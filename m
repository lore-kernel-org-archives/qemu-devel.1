Received: from eggs.gnu.org ([2001:4830:134:3::10]:49500)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cxUua-0001P6-TI
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 04:43:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cxUua-00039W-3e
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 04:43:00 -0400
Date: Mon, 10 Apr 2017 10:42:50 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170410084250.GC4883@noname.redhat.com>
References: <20170406150148.zwjpozqtale44jfh@perseus.local>
	<d60ea1f9-ae2c-6625-90de-944cbb490f85@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SLDf9lqlvOQaIe6s"
Content-Disposition: inline
In-Reply-To: <d60ea1f9-ae2c-6625-90de-944cbb490f85@redhat.com>
Subject: Re: [Qemu-devel] [RFC] Proposed qcow2 extension: subcluster
 allocation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>


--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Am 07.04.2017 um 19:10 hat Max Reitz geschrieben:
> One case I'd be especially interested in are of course 4 kB subclusters
> for 64 kB clusters (because 4 kB is a usual page size and can be
> configured to be the block size of a guest device; and because 64 kB
> simply is the standard cluster size of qcow2 images nowadays[1]...).

Why should the current default cluster size be an argument for anything?
64k is a tradeoff between small COW size and large allocation
granularity that seemed to work well (and it used to be the maximum
cluster size originally, so it seemed safer than 128k).

With subclusters, we have a completely different situation and need to
find a new default that works best. I'm relatively sure that 64k are too
small under the new conditions.

Also, undefined reference: [1] (I was hoping to find a better argument
there...)

Kevin

--SLDf9lqlvOQaIe6s
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJY60WKAAoJEH8JsnLIjy/WLpcQAJZh7SaLlh98FTPKons1V3OK
9WiwW+iA3TK8UDOuGmYotNQlf+MmnX5E4MOMvdFV0sIzAtMK3NsIv/RLdVT5L91T
nCA96z3qi6RQCFPJKzt2VHjCk9KX8+vJXAGicG8CsWobAKMi9CXkOEhhrw17+5HB
G4apWk0/EMutji8u/q4yX2m0ZwpPNy8tPCpDvvID7EIZv1kpPKBewk5zkkdQv+K0
XeCKQ0V3ZH44TMVY2iFOBeKGUl8/CcdImK3sFTMTYs0UMjZVkGY7P/t5RLf+4O4a
F7P3y8OGVLnOd+N8rXzoVeBVFRIZJwef0yGpnGBCmymOrNALf5Gm0IiOfEOlkcCZ
nDAZ8D2kC1hq3xfV3fidJ8avNBnzpXdz0sWD4QS4FOYr2bAkCSpf22eUr7vrMmOG
2YkuxzoGc96MpXaTYaXjliJvO1UpSTVoIH6FC2Mr3UeXPks4LMtbDOn5P9taHhM2
u7P+tcrPXBEFFFI6TYPBloYBeBeFvc/VdNs9yN3ZSExyIp42KnhrreekCWzsR2VD
xz27J1oElqcKCdydC+WLPuc6hqz0DFLYLQ2xKM/z6fQURM8QZhyLFtUhLAcCUaiZ
T2k/PPCis8BxQVyGzXF8QHdZKcLKdQ/aON5RdO9+uWzhMK1TkX2oNhK42SfmYrPi
FqVm6Os5r6Mblu5INefQ
=iWEy
-----END PGP SIGNATURE-----

--SLDf9lqlvOQaIe6s--
