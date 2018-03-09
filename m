Received: from eggs.gnu.org ([2001:4830:134:3::10]:59201)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1euErc-0001kY-V8
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 05:03:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1euErX-0007eO-Qv
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 05:03:00 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47228 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kchamart@redhat.com>) id 1euErX-0007d7-Li
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 05:02:55 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F1B13EAEA8
	for <qemu-devel@nongnu.org>; Fri,  9 Mar 2018 10:02:50 +0000 (UTC)
Date: Fri, 9 Mar 2018 11:02:43 +0100
From: Kashyap Chamarthy <kchamart@redhat.com>
Message-ID: <20180309100243.t6gltzqrgnjtmigy@eukaryote>
References: <20180307144951.d75lo5rgzi2vf27z@eukaryote>
	<20180307151836.GK20201@redhat.com>
	<20180308075245.lgzredyhn2paawg4@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180308075245.lgzredyhn2paawg4@sirius.home.kraxel.org>
Subject: Re: [Qemu-devel] [RFC] Defining firmware (OVMF,
 et al) metadata format & file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>, qemu-devel@nongnu.org, libvir-list@redhat.com, lersek@redhat.com

On Thu, Mar 08, 2018 at 08:52:45AM +0100, Gerd Hoffmann wrote:
>   Hi,
> 
> > > [*] Open question: Who, between QEMU and libvirt, should define the said
> > > firmware metadata format and file?
> > 
> > IMHO QEMU should be defining the format, because the file will contain
> > info about certain QEMU features associated with the firmware (eg smm).
> > Also there are potentially other non-libvirt mgmt apps that spawn QEMU
> > which would like this info (eg libguestfs), so having libvirt define the
> > format is inappropriate.
> > 
> > I'd suggest we just need something in docs/specs/firmware-metadata.rst
> > for QEMU source tree.
> > 
> > Potentially QEMU could even use the metadata files itself for finding
> > the default firmeware images, instead of compiling this info into its
> > binaries. I wouldn't suggest we need todo that right away, but bear it
> > in mind as a potential use case.
> 
> With qemu using this itself in mind it probably makes sense to specify
> this as qapi schema.  That'll simplify parsing and using these files in
> qemu, and possibly simplifies things on the libvirt side too.

Yeah, FWIW, I too find using the QAPI schema for the metadata file
format more appealing (rather than a separate file format).  And
libvirt already has infrastructure to handle QAPI.

-- 
/kashyap
