Received: from eggs.gnu.org ([2001:4830:134:3::10]:37501)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cqimb-0007Ea-WD
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 12:06:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cqimX-0002IN-Rc
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 12:06:45 -0400
Received: from mail-wm0-x22e.google.com ([2a00:1450:400c:c09::22e]:37905)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cqimX-0002Hk-Lr
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 12:06:41 -0400
Received: by mail-wm0-x22e.google.com with SMTP id t189so42334983wmt.1
	for <qemu-devel@nongnu.org>; Wed, 22 Mar 2017 09:06:41 -0700 (PDT)
Date: Wed, 22 Mar 2017 16:06:37 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170322160637.GB16717@stefanha-x1.localdomain>
References: <908ba384-d589-5755-efb2-f4d2fb14ce1e@kamp.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+pHx0qQiF2pBVqBT"
Content-Disposition: inline
In-Reply-To: <908ba384-d589-5755-efb2-f4d2fb14ce1e@kamp.de>
Subject: Re: [Qemu-devel] Qemu and CPU wait time
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Lieven <pl@kamp.de>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>


--+pHx0qQiF2pBVqBT
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 06, 2017 at 03:32:49PM +0100, Peter Lieven wrote:
> is there something equivalent to "CPU ready" in VMWare or =E2=80=9EHyper-=
V Hypervisor Virtual Processor\CPU Wait Time Per Dispatch=E2=80=9C in Hyper=
-V in
> KVM/Qemu?

I think you can get this information from "perf sched latency" (see man
perf-sched).  Restrict it to the vcpu threads and it shows how long a
runnable vcpu has to wait (average and maximum).

Here is an example from https://lwn.net/Articles/353295/:

  perf sched record sleep 10     # record full system activity for 10 secon=
ds
  perf sched latency --sort max  # report latencies sorted by max

  -------------------------------------------------------------------------=
----------------
   Task                  |   Runtime ms  | Switches | Average delay ms | Ma=
ximum delay ms |
  -------------------------------------------------------------------------=
----------------
   python:14049          |    114.694 ms |      125 | avg:    0.120 ms | ma=
x:    5.343 ms |
  ...
  -------------------------------------------------------------------------=
----------------
   TOTAL:                |   3144.817 ms |    11654 |
  ---------------------------------------------------

More info: http://www.brendangregg.com/blog/2017-03-16/perf-sched.html

Stefan

--+pHx0qQiF2pBVqBT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY0qENAAoJEJykq7OBq3PIBpMH/RdKuLJtMfIdkEKS6ksRSzKM
bbI4uBa1CAdXyv180PmQzh695MBmna3KTaPUMP4ClplV4p+R63bns5pMtJxhcb9c
Q5mQv+03P62BK3a9MGgu+9faDXipv02hNRfnwoyS/CK1ouyHn92rNvGZHsRb8lF3
uhOoFXS1KccrYcxjoHgnCQav6AltpAkhsNQjlAh3lf3mZQw32NnSxNbbaqClz9Bc
F5smw2aK8l2YV6i2BgA/9oymSc7OLOd6Msho/nTWixbiG2e5/QmF3ppKnmqOw/Ge
5xeMnypOJ0L/baf/rdJupL24TcKhjiAZlFytIRMkrswyW08jx4ECGavedH9NIKM=
=Mczi
-----END PGP SIGNATURE-----

--+pHx0qQiF2pBVqBT--
