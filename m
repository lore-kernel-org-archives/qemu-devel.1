Received: from eggs.gnu.org ([2001:4830:134:3::10]:59486)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ffQiF-00050p-Pc
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 10:12:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ffQiE-0000xj-P9
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 10:12:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44504 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1ffQiE-0000xU-Jx
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 10:12:22 -0400
Date: Tue, 17 Jul 2018 16:12:14 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180717161214.42bb4c26.cohuck@redhat.com>
In-Reply-To: <20180717022924.25428-1-f4bug@amsat.org>
References: <20180717022924.25428-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/4] docker: Improve 'host-cross' image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>
Cc: Alex =?UTF-8?B?QmVubsOpZQ==?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, David Hildenbrand <david@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Thomas Huth <huth@tuxfamily.org>

On Mon, 16 Jul 2018 23:29:20 -0300
Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrote:

> Sorry I don't have a better name for this image,
> it is meant to cross-build for the same architecture
> than the host.
>=20
> Due to the bad name, explicitely tagged the last 2
> patches as 'RFC'.
>=20
> Tested on x86_64 and aarch64, should also work on
> s390x and ppc64le (per the Docker doc).
>=20
> If they are volunteers for test, the command is as simple as:
>=20
>   $ make docker-test-quick@debian-host-cross [V=3D1]

On s390x, all looks reasonable until it tries to install libxen-dev:

Step 4/14 : RUN DEBIAN_FRONTEND=3Dnoninteractive eatmydata     apt-get inst=
all -y --no-install-recommends         libaio-dev         libasound2-dev   =
      libattr1-dev         libbluetooth-dev         libbrlapi-dev         l=
ibbz2-dev         libcacard-dev         libcap-dev         libcap-ng-dev   =
      libcapstone-dev         libcurl4-gnutls-dev         libepoxy-dev     =
    libfdt-dev         libibverbs-dev         libiscsi-dev         libjemal=
loc-dev         libjpeg-dev         liblttng-ust-dev         liblzo2-dev   =
      libncursesw5-dev         libnfs-dev         libnss3-dev         libpi=
xman-1-dev         libpulse-dev         librados-dev         librbd-dev    =
     librdmacm-dev         libseccomp-dev         libsnappy-dev         lib=
spice-protocol-dev         libssh2-1-dev         liburcu-dev         libusb=
-1.0-0-dev         libusbredirhost-dev         libusbredirparser-dev       =
  libvdeplug-dev         libvte-dev         libxen-dev         uuid-dev    =
     xfslibs-dev
 ---> Running in a7f6ae892a05
Reading package lists...
Building dependency tree...
Reading state information...
E: Unable to locate package libxen-dev
