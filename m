Received: from eggs.gnu.org ([2001:4830:134:3::10]:45432)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fOJIX-0005qI-Mi
	for qemu-devel@nongnu.org; Thu, 31 May 2018 04:51:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fOJIU-0003DC-KM
	for qemu-devel@nongnu.org; Thu, 31 May 2018 04:51:05 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:40616)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1fOJIU-0003CR-CL
	for qemu-devel@nongnu.org; Thu, 31 May 2018 04:51:02 -0400
Received: by mail-wm0-x244.google.com with SMTP id x2-v6so45092717wmh.5
	for <qemu-devel@nongnu.org>; Thu, 31 May 2018 01:51:02 -0700 (PDT)
Date: Thu, 31 May 2018 09:50:57 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180531085057.GG26429@stefanha-x1.localdomain>
References: <CAJGDS+HNBG6PSvG7Cc7bN4rMadgm5W+1aQUAeizN9CGjSOCP5w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7lMq7vMTJT4tNk0a"
Content-Disposition: inline
In-Reply-To: <CAJGDS+HNBG6PSvG7Cc7bN4rMadgm5W+1aQUAeizN9CGjSOCP5w@mail.gmail.com>
Subject: Re: [Qemu-devel] Recording I/O activity after KVM does a VMEXIT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Arnabjyoti Kalita <akalita@cs.stonybrook.edu>
Cc: qemu-devel@nongnu.org, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>


--7lMq7vMTJT4tNk0a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 30, 2018 at 11:19:13PM -0400, Arnabjyoti Kalita wrote:
> I am trying to implement a 'minimal' record-replay mechanism for KVM, whi=
ch
> is similar to the one existing for TCG via -icount. I am trying to record
> I/O events only (specifically disk and network events) when KVM does a
> VMEXIT. This has led me to the function kvm_cpu_exec where I can clearly
> see the different ways of handling all of the possible VMExit cases (like
> PIO, MMIO etc.). To record network packets, I am working with the e1000
> hardware device.
>=20
> Can I make sure that all of the network I/O, atleast for the e1000 device
> happens through the KVM_EXIT_MMIO case and subsequent use of the
> address_space_rw() function ? Do I also need to look at other functions as
> well ? Also for recording disk activity, can I make sure that looking out
> for the KVM_EXIT_MMIO and/or KVM_EXIT_PIO cases in the vmexit mechanism,
> will be enough ?
>=20
> Let me know if there are other details that I need to take care of. I am
> using QEMU 2.11 on a x86-64 CPU and the guest runs a Linux Kernel 4.4 with
> Ubuntu 16.04.

I have CCed Pavel Dovgalyuk, the record/replay maintainer.

Stefan

--7lMq7vMTJT4tNk0a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbD7dxAAoJEJykq7OBq3PIWwMIAJKVqxgYV8jMLTOfy4CaRv3a
UyQd/cckjM/C6+mv2Vt1AUyRPVv3z6x+FJ9wVYFZMi7nnYa6GF53cdt0c+VkP8Kn
2YTDgqcGHgbI7PJMeAWlf5UndViynYzdTv+q6eO+5ZqpdrV0iAf0Nvu0YSbPWEdi
Lk3dGHBWnuCPovjZ2kBINz43gNrETT2v6JVUItZAoMGw71K2iH8zfNFGCx2kq2Xf
+xgTyhFGXdOQVt549nGMWgGaPNdLK3VnLmcIN0iPVOzImAByM+hw9w8lpmCciN6x
0Xlx6S+pRCPqNWjwKTiSHeUPwU3+c03+j9qmxs8DgU6rZ8/Vdt2L3LgPT9Lc1G0=
=Uex+
-----END PGP SIGNATURE-----

--7lMq7vMTJT4tNk0a--
