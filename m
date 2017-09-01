Received: from eggs.gnu.org ([2001:4830:134:3::10]:59473)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dnmfq-0001V3-EI
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 10:12:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dnmfk-000410-Nl
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 10:11:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38844)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dnmfk-0003zT-IO
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 10:11:48 -0400
Message-ID: <1504275104.10150.19.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 01 Sep 2017 16:11:44 +0200
In-Reply-To: <1504254677.10150.3.camel@redhat.com>
References: <20170831122925.GJ17315@redhat.com>
	<CAFEAcA_pZn5evv_Z00EKevr1PrV+vNrs4bzEv9FaYLU_cisqyw@mail.gmail.com>
	<1504254677.10150.3.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] RFC: changing ROM bundling in tar dists for
 releases
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, "Daniel P. Berrange" <berrange@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

  Hi,

> I think it makes sense to create a separate project for the firmware
> blobs.=C2=A0=C2=A0Move over the firmware binaries and source submodules=
 to the
> new project.=C2=A0=C2=A0This way updating both firmware sources and bin=
aries
> can
> be done with a single commit, like we handle this today, just in the
> new firmware repo instead of the main qemu repo.

i.e. something like this:

https://www.kraxel.org/cgit/qemu-firmware/

(only seabios is there for now)

cheers,
  Gerd
