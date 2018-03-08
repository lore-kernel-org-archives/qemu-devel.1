Received: from eggs.gnu.org ([2001:4830:134:3::10]:59630)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1etqMO-0006cw-Ax
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 02:53:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1etqMJ-0000eA-Ft
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 02:53:08 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48318 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1etqMJ-0000e1-AU
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 02:53:03 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C44594026794
	for <qemu-devel@nongnu.org>; Thu,  8 Mar 2018 07:52:52 +0000 (UTC)
Date: Thu, 8 Mar 2018 08:52:45 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180308075245.lgzredyhn2paawg4@sirius.home.kraxel.org>
References: <20180307144951.d75lo5rgzi2vf27z@eukaryote>
	<20180307151836.GK20201@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180307151836.GK20201@redhat.com>
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
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Kashyap Chamarthy <kchamart@redhat.com>, qemu-devel@nongnu.org, libvir-list@redhat.com, lersek@redhat.com

  Hi,

> > [*] Open question: Who, between QEMU and libvirt, should define the said
> > firmware metadata format and file?
> 
> IMHO QEMU should be defining the format, because the file will contain
> info about certain QEMU features associated with the firmware (eg smm).
> Also there are potentially other non-libvirt mgmt apps that spawn QEMU
> which would like this info (eg libguestfs), so having libvirt define the
> format is inappropriate.
> 
> I'd suggest we just need something in docs/specs/firmware-metadata.rst
> for QEMU source tree.
> 
> Potentially QEMU could even use the metadata files itself for finding
> the default firmeware images, instead of compiling this info into its
> binaries. I wouldn't suggest we need todo that right away, but bear it
> in mind as a potential use case.

With qemu using this itself in mind it probably makes sense to specify
this as qapi schema.  That'll simplify parsing and using these files in
qemu, and possibly simplifies things on the libvirt side too.

cheers,
  Gerd
