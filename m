Received: from eggs.gnu.org ([2001:4830:134:3::10]:44369)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1clZdA-0003Md-Sc
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 06:19:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1clZd5-0002HT-Rw
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 06:19:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49952)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1clZd5-0002HH-Lz
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 06:19:39 -0500
Message-ID: <1488971976.6514.54.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 08 Mar 2017 12:19:36 +0100
In-Reply-To: <20170308102009.GF7470@redhat.com>
References: <3d1c16a1-ec05-0367-e569-64a63b34f2e3@redhat.com>
	<20170308102009.GF7470@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel] What's the next QEMU version after 2.9 ? (or: when
 is a good point in time to get rid of old interfaces)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>

  Hi,

> libvirt suffered similar lack of clarity around when to bump major versio=
n
> number as opposed to minor version. To address this we recently adopted t=
he
> rule[1] that major version number changes have no relation to features. T=
he
> major number is simply incremented at the start of each calendar year.

I like the idea of time-based version numbering.  Changing the plan for
2.9 still is probably a bad idea given we have a 2.9 machine type
already etc.

But we can start changing things afterwards.  So we could start with 3.x
after 2.9, and bump the major for the first release each year
(libvirt-style).  Or we could use the year as major number and jump
straight to 17.x (mesa-style).

> From the POV of libvirt, I don't think saying that .0 releases have
> incompatible changes is particularly useful in itself. What *is* useful
> is to have a clear rule around a deprecation cycle. ie, a rule that says
> a feature will be marked deprecated for 3 releases or 12 months, before i=
t
> is permitted to be removed/changed. If that were followed, there is no
> need to batch up such changes in a .0 release IMHO.

Yes, it's probably a good idea to deprecate things first.  When going
with the 12 months rule it could be useful to batch things and do a
yearly "spring cleaning" when the major is bumped.

We could also create new machine types for major versions only, to keep
the number somewhat under control.  Not sure how well that would work in
practice.  We'd probably need a ${type}-next machine type then (future
${type}-4 machine type, for development, incompatible changes allowed)
and make ${type}-3 the default machine type.

cheers,=20
  Gerd
