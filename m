Received: from eggs.gnu.org ([2001:4830:134:3::10]:54519)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fONTs-0007Js-Ki
	for qemu-devel@nongnu.org; Thu, 31 May 2018 09:19:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fONTp-0001q0-BL
	for qemu-devel@nongnu.org; Thu, 31 May 2018 09:19:04 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:41663)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1fONTp-0001pZ-3I
	for qemu-devel@nongnu.org; Thu, 31 May 2018 09:19:01 -0400
Received: by mail-wr0-x244.google.com with SMTP id u12-v6so32960011wrn.8
	for <qemu-devel@nongnu.org>; Thu, 31 May 2018 06:19:01 -0700 (PDT)
Date: Thu, 31 May 2018 14:18:58 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180531131858.GL27838@stefanha-x1.localdomain>
References: <1525918138-6189-1-git-send-email-junyan.he@gmx.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nrM5Z5VIJgwP9LWp"
Content-Disposition: inline
In-Reply-To: <1525918138-6189-1-git-send-email-junyan.he@gmx.com>
Subject: Re: [Qemu-devel] [PATCH V5 0/9] nvdimm: guarantee persistence of
 QEMU writes to persistent memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: junyan.he@gmx.com
Cc: qemu-devel@nongnu.org, Haozhong Zhang <haozhong.zhang@intel.com>, xiaoguangrong.eric@gmail.com, crosthwaite.peter@gmail.com, mst@redhat.com, dgilbert@redhat.com, ehabkost@redhat.com, quintela@redhat.com, Junyan He <junyan.he@intel.com>, stefanha@redhat.com, pbonzini@redhat.com, imammedo@redhat.com, rth@twiddle.net


--nrM5Z5VIJgwP9LWp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

David Gilbert previously suggested a memory access interface.  I guess
it would look something like this:

  typedef struct {
      void (*memset)(void *s, int c, size_t n);
      void (*memcpy)(void *dest, const void *src, size_t n);
  } MemoryOperations;

That way code doesn't need if (pmem) A else B.  It can just do
mem_ops->foo().  Have you looked into this idea?

Also, there was a discussion about leaving the code unchanged but adding
an nvdimm_flush() call at the very end of migration.  I think someone
benchmarked it but can't find the email.  Please post a link or
summarize the results, because that approach would be much less
invasive.  Thanks!

Stefan

--nrM5Z5VIJgwP9LWp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbD/ZCAAoJEJykq7OBq3PIL5EIAKYEruBujBRbsNbEcZrlsQ3g
AKp65RSjVgnFjj6mj7q4EY3aO7GLqBUWkI0nxt37/xNM2ot+8Q1jHr33++e2gk8m
Pa0XdeSP3urL8vANaPMph0sZ5IOVV6yG5Zu0WOQEVu0VzhQgtSr+A5WVHSlfsirl
wz0YB0LWC1FWtjgQMX7dRT9dinqu0l8bhBAhO1wbOvb814OpcCtJqowSfUcWD0ZX
ItdEovem7/4iZGss6REfINDdEoWoqC66FCTjhJEdOlt3uT71qOlgFitM7MdUDoxt
bNMnSvDv8F99vqW2bp9oHphsEY9BYnGc+0P3Lsq4YlWdM5yzJ/FLWdy/iFMek4Y=
=cNqJ
-----END PGP SIGNATURE-----

--nrM5Z5VIJgwP9LWp--
