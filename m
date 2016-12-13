Received: from eggs.gnu.org ([2001:4830:134:3::10]:51153)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cGuiN-0008RP-Jy
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 16:34:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cGuiJ-00052i-LJ
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 16:34:23 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36548)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cGuiJ-00052c-Aw
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 16:34:19 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uBDLYF4s095588
	for <qemu-devel@nongnu.org>; Tue, 13 Dec 2016 16:34:17 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
	by mx0a-001b2d01.pphosted.com with ESMTP id 27akchyfqj-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 13 Dec 2016 16:34:16 -0500
Received: from localhost
	by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Tue, 13 Dec 2016 16:33:46 -0500
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <CAJSP0QUkFjfsQ21i3-qXQL5N3xJd6WnEmy1BewMV3z=VOpr7BQ@mail.gmail.com>
References: <CAJSP0QUn4OE3_9foGgktt5O_KzrEzV8uhB1mpoS1q5x4DsPTPQ@mail.gmail.com>
	<CAJSP0QV1S4mohikvxx9OgnsRgMRNmH+a9WjHCeC7gGaeBMyktQ@mail.gmail.com>
	<CAJSP0QUkFjfsQ21i3-qXQL5N3xJd6WnEmy1BewMV3z=VOpr7BQ@mail.gmail.com>
Date: Tue, 13 Dec 2016 15:33:40 -0600
Message-Id: <20161213213340.5009.90101@loki>
Subject: Re: [Qemu-devel] Any QEMU 2.8 release blockers?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel <qemu-devel@nongnu.org>
Cc: Peter Maydell <peter.maydell@linaro.org>

Quoting Stefan Hajnoczi (2016-12-13 15:04:24)
> On Tue, Dec 13, 2016 at 10:01 AM, Stefan Hajnoczi <stefanha@gmail.com> wr=
ote:
> > On Fri, Dec 9, 2016 at 3:34 PM, Stefan Hajnoczi <stefanha@gmail.com> wr=
ote:
> >> Hi folks,
> >> How is QEMU 2.8.0-rc3 holding up?
> >>
> >> I'm not aware of release blockers.  QEMU 2.8.0 will be released on
> >> Tuesday, December 13th if nothing comes up.  It will be the -rc3
> >> source tree.
> >
> > There have been no release blockers so I plan to tag QEMU 2.8.0 today
> > (December 13th at 19:00 UTC).
> >
> > If something critical turns up please notify me on IRC (stefanha on
> > #qemu irc.oftc.net).
> =

> Mike Roth discovered a migration compatibility bug introduced by
> commit d1b4259f1ab18af24e6a297edb6a8f71691f3256 ("virtio-bus: Plug
> devices after features are negotiated").  The release will be delayed
> until this is resolved.
> =

> Please check the mailing list for discussion.  Mike is sending out a
> mail summarizing the bug.

I've posted a summary in the original patch thread:

  https://lists.gnu.org/archive/html/qemu-devel/2016-12/msg01862.html

> =

> Stefan
>=20
