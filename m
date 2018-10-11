Received: from eggs.gnu.org ([2001:4830:134:3::10]:60846)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gAbI9-0004Qh-Ge
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 09:46:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gAbI3-0001Y7-Vw
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 09:46:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:24438)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gAbHs-0001QH-HA
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 09:46:11 -0400
Date: Thu, 11 Oct 2018 15:45:58 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20181011134558.ygc76323ikj4huvt@sirius.home.kraxel.org>
References: <20181009131052.18500-1-lhrazky@redhat.com>
	<20181009131052.18500-2-lhrazky@redhat.com>
	<1539113618.12871.122.camel@redhat.com>
	<20181010103704.jqgfp3kiaiqu4hzt@sirius.home.kraxel.org>
	<1539262539.16655.99.camel@redhat.com>
	<20181011132047.3zef5j5puh4lt43c@sirius.home.kraxel.org>
	<1539264705.16655.121.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1539264705.16655.121.camel@redhat.com>
Subject: Re: [Qemu-devel] [Spice-devel] [RFC PATCH spice 1/2] QXL interface:
 add functions to identify monitors in the guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?B?THVrw6HFoSBIcsOhemvDvQ==?= <lhrazky@redhat.com>
Cc: Jonathon Jongsma <jjongsma@redhat.com>, spice-devel@lists.freedesktop.org, qemu-devel@nongnu.org

> > So, do we need this add display_id function at all?
> 
> You mean the addition of IDs in display_id = channel_id + monitor_id?

No, I mean spice_qxl_set_path() is enough, the other function is not
needed.

cheers,
  Gerd
