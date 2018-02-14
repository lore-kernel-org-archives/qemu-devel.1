Received: from eggs.gnu.org ([2001:4830:134:3::10]:41794)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1elyUO-0002lW-OD
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 09:56:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1elyUL-00028v-M3
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 09:56:52 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42876)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1elyUL-00028W-Df
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 09:56:49 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w1EEsTmX141456
	for <qemu-devel@nongnu.org>; Wed, 14 Feb 2018 09:56:48 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2g4n6r6bwu-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 14 Feb 2018 09:56:47 -0500
Received: from localhost
	by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 14 Feb 2018 09:56:46 -0500
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <a2c5404e-7f1e-09c8-329f-1abb585070df@redhat.com>
References: <20180214001105.21508-1-mdroth@linux.vnet.ibm.com>
	<20180214085148.GD13644@redhat.com>
	<a2c5404e-7f1e-09c8-329f-1abb585070df@redhat.com>
Date: Wed, 14 Feb 2018 08:56:37 -0600
Message-Id: <151862019703.31987.7264096901853091526@sif>
Subject: Re: [Qemu-devel] [qemu-web PATCH] Add a blog post documenting
 Spectre/Meltdown options for QEMU 2.11.1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, Suraj Jitindar Singh <sjitindarsingh@gmail.com>, David Gibson <david@gibson.dropbear.id.au>

Quoting Paolo Bonzini (2018-02-14 04:33:29)
> On 14/02/2018 09:51, Daniel P. Berrang=C3=A9 wrote:
> >> +Please note that, as mentioned in the previous blog post, QEMU/KVM ge=
nerally
> >> +has the same requirements as other unpriviledged processes running on=
 the
> >> +host WRT Spectre/Meltdown mitigation.
> >
> > Is this actually still considered accurate wrt the host QEMU ? I was un=
der
> > the believe that life is more complicated for QEMU/KVM wrt Spectre and =
that
> > it will require more protection than other unpriv processes on the host=
 in
> > some cases.
> =

> The plan is for KVM to ensure that QEMU can be treated as yet another
> unprivileged process.  Anything else would require applying the same
> care to all of QEMU's dependencies.

Would the following re-wording be reasonable? The main goal of the
statement is to stress that additional patches pertaining to general
host-side security are still needed to secure a QEMU/KVM host, not
so much to suggest that there isn't anything needed beyond that.

-Please note that, as mentioned in the previous blog post, QEMU/KVM general=
ly
-has the same requirements as other unpriviledged processes running on the
-host WRT Spectre/Meltdown mitigation. What is being addressed here is
-enabling a guest operating system to enable the same (or similar) mitigati=
ons
-to protect itself from unpriviledged guest processes. Thus, the
-patches/requirements listed here are specific to that goal and should not =
be
-regarded as the full set of requirements to enable mitigations on the host
-side (though in some cases there is some overlap between the two WRT requi=
red
-patches/etc).

+Please note that QEMU/KVM has at least the same requirements as other
+unpriviledged processes running on the host WRT Spectre/Meltdown
+mitigation. What is being addressed here is enabling a guest operating sys=
tem
+to enable the same (or similar) mitigations to protect itself from
+unpriviledged guest processes. Thus, the patches/requirements listed here =
are
+specific to that goal and should not be regarded as the full set of
+requirements to enable mitigations on the host side (though in some cases
+there is some overlap between the two WRT required patches/etc).


> =

> Paolo
>=20
