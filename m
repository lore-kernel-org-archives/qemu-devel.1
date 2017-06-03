Received: from eggs.gnu.org ([2001:4830:134:3::10]:53327)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dHIHw-0003hT-Rf
	for qemu-devel@nongnu.org; Sat, 03 Jun 2017 19:17:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dHIHt-0002F4-OX
	for qemu-devel@nongnu.org; Sat, 03 Jun 2017 19:16:56 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38334)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1dHIHt-0002En-Fi
	for qemu-devel@nongnu.org; Sat, 03 Jun 2017 19:16:53 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v53NDn0v145854
	for <qemu-devel@nongnu.org>; Sat, 3 Jun 2017 19:16:52 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2av16jyhwp-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Sat, 03 Jun 2017 19:16:52 -0400
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Sat, 3 Jun 2017 17:16:51 -0600
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <87a85t0xf7.fsf@dusky.pond.sub.org>
References: <1481822644-617-1-git-send-email-mdroth@linux.vnet.ibm.com>
	<1481822644-617-2-git-send-email-mdroth@linux.vnet.ibm.com>
	<20170512102204.GG2069@work-vm> <87y3ty383w.fsf@dusky.pond.sub.org>
	<87a85t0xf7.fsf@dusky.pond.sub.org>
Date: Sat, 03 Jun 2017 18:16:39 -0500
Message-Id: <149653179997.4029.17549990739392588649@loki>
Subject: Re: [Qemu-devel] [PATCH 1/2] tests: check-qom-proplist: add checks
 for cmdline-created objects
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, =?utf-8?q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, qemu-stable@nongnu.org

Quoting Markus Armbruster (2017-05-31 12:05:16)
> Markus Armbruster <armbru@redhat.com> writes:
> =

> > "Dr. David Alan Gilbert" <dgilbert@redhat.com> writes:
> >
> >> I notice this pair of patches doesn't seem to have gone anywhere.
> >> WHile it's labelled as a monitor fix, it's all QOM stuff, so I don't
> >> think it should be going via me.
> >
> > It's somewhere between QOM and QemuOpts.  Andreas, please have a look.
> > Feel free to ask me to take the patch through my tree.
> =

> I considered applying the series to qapi-next, and realized I'm not sure
> what the latest version is.  I could peruse the archives, but that's
> work.  Mike, would you mind resending your latest version?

This version (v4) is the latest, but I've rebased/re-tested on master
and re-submitted those as v5. Thanks!
