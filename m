Received: from eggs.gnu.org ([2001:4830:134:3::10]:50558)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fzeei-0005RQ-GH
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 05:08:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fzeef-0005lN-CL
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 05:08:20 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38198 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1fzeed-0005ke-EP
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 05:08:17 -0400
Date: Tue, 11 Sep 2018 17:08:10 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180911090810.GP19292@lemon.usersys.redhat.com>
References: <20180906054340.28988-1-famz@redhat.com>
	<20180911090018.yjcnv45hyls2cqyc@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180911090018.yjcnv45hyls2cqyc@sirius.home.kraxel.org>
Subject: Re: [Qemu-devel] [PATCH v2 0/4] tests: VM build in OpenBSD 6.3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Thomas Huth <thuth@redhat.com>, Brad Smith <brad@comstyle.com>, Eric Blake <eblake@redhat.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>, Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>

On Tue, 09/11 11:00, Gerd Hoffmann wrote:
> On Thu, Sep 06, 2018 at 01:43:36PM +0800, Fam Zheng wrote:
> > In this new version:
> > 
> >     - Include the virtio fix by Paolo so that it's easier to test this series.
> >     - Improve the slirp patch on input validation and buffer overflow. [Thomas]
> >     - Use OpenBSD 6.3 image; Use guestfwd and tftp-server-name.
> > 
> > Thanks to the loose dependency, the three parts (patch 1; patches 2+3; patch 4)
> > can go to individual maintainers if desired.
> > 
> > Fam Zheng (3):
> >   slirp: Add sanity check for str option length
> >   slirp: Implement RFC2132 TFTP server name
> >   tests: vm: auto_install OpenBSD
> > 
> > Paolo Bonzini (1):
> >   virtio: update MemoryRegionCaches when guest negotiates features
> 
> Tested-by: Gerd Hoffmann <kraxel@redhat.com>
> 

Thanks. I think Michael has included the virtio patch in a pull already. I'll
pick up your tested-by tag and queue the OpenBSD patch, then leave the slirp
ones to Samuel (the test script will still depend on the new slirp options, of
course).

Fam
