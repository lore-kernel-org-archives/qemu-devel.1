Received: from eggs.gnu.org ([2001:4830:134:3::10]:36602)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fETHi-0005a8-Ip
	for qemu-devel@nongnu.org; Fri, 04 May 2018 01:29:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fETHf-000257-Ej
	for qemu-devel@nongnu.org; Fri, 04 May 2018 01:29:34 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52628 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fETHf-00024X-A7
	for qemu-devel@nongnu.org; Fri, 04 May 2018 01:29:31 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <CAFEAcA-hha7jMSfPTdNEVKhuJr4nwAx4wKmEk5E9+j-JS4U14w@mail.gmail.com>
	<d50e3a40-d7f3-4c9b-e930-4c2f4d6c8a53@redhat.com>
	<CAFEAcA8wJuJ9464LadgjJOo-7ttdGYcfDQWALbkxBRJCr_knkg@mail.gmail.com>
	<062deb2a-35fc-319f-b159-3b58cbf910df@redhat.com>
	<20180502115844.GO3308@redhat.com>
	<CAFEAcA-e_=08658O8E3CAmYXvBbNWmznnhfMLUW+MXnxb_vKfQ@mail.gmail.com>
	<20180503093329.GF11382@redhat.com>
	<8af696b5-3985-ffd6-43fb-2bcbfe0d0493@redhat.com>
	<222ee475-9eb5-8887-819a-7b093fc269b1@kaod.org>
	<20180503180240.GC13789@stefanha-x1.localdomain>
Date: Fri, 04 May 2018 07:29:20 +0200
In-Reply-To: <20180503180240.GC13789@stefanha-x1.localdomain> (Stefan
	Hajnoczi's message of "Thu, 3 May 2018 19:02:40 +0100")
Message-ID: <87in84c7kf.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] release retrospective, next release timing,
 numbering
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Greg Kurz <groug@kaod.org>, QEMU Developers <qemu-devel@nongnu.org>

Stefan Hajnoczi <stefanha@redhat.com> writes:

[...]
> So to clarify, three separate steps:
>
> 1. Get rid of target-specific #ifdefs

... and compile just once instead of per target, speeding up the build

> 2a. Modular QEMU, single binary
> 2b. Heterogenous QEMU
>
> 2a and 2b are independent but both depend on 1.

1. can be incremental.  Something for
<https://wiki.qemu.org/Contribute/BiteSizedTasks>?
