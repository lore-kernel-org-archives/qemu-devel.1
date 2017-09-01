Received: from eggs.gnu.org ([2001:4830:134:3::10]:47814)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dnq0O-0007pR-7y
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 13:45:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dnq0M-0005EW-Ni
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 13:45:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42012)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dnq0M-0005EB-Ga
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 13:45:18 -0400
Message-ID: <1504287916.10150.21.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 01 Sep 2017 19:45:16 +0200
In-Reply-To: <20170901151340.GQ31680@redhat.com>
References: <20170831122925.GJ17315@redhat.com>
	<CAFEAcA_pZn5evv_Z00EKevr1PrV+vNrs4bzEv9FaYLU_cisqyw@mail.gmail.com>
	<1504254677.10150.3.camel@redhat.com>
	<1504275104.10150.19.camel@redhat.com>
	<20170901151340.GQ31680@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

  Hi,

> > i.e. something like this:
> > 
> > https://www.kraxel.org/cgit/qemu-firmware/
> > 
> > (only seabios is there for now)
> 
> So presumably we'd want a 'make install' target there too, to place
> the
> various ROMS in the location QEMU expects ?

Yes.

Or place them in $prefix/share/qemu-firmware, and add that directory to
the qemu default search path.

> So non-distro users would need to download & install the ROMs,
> and then download, build & install QEMU ?

Yes.

> How would you view ROM install working for devs working against GIT ?
> 
> eg when we update a ROM in the firmware directory, how do devs know
> to
> update their firmware.  Would the qemu-firmware.git be a submodule of
> qemu.git, so that a 'make install' would deploy roms for devs ?

Not sure yet how to handle that best.  I'd tend to not make it a
submodule.  Typically there are no lockstep updates for qemu and
firmware, in most cases new firmware is only required if you want use a
new feature which needs firmware support.  So I think we don't need a
tight coupling between qemu and firmware.  Just updating the firmware
checkout now and then (or even simply using the distro builds) should
work in the vast majority of cases.

cheers,
  Gerd
