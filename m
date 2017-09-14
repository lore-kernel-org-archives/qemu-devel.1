Received: from eggs.gnu.org ([2001:4830:134:3::10]:39591)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dsWdh-0001Fy-25
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 12:05:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dsWdd-0005b5-2l
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 12:05:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58324)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dsWdc-0005aF-Ss
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 12:05:13 -0400
Date: Thu, 14 Sep 2017 17:05:00 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170914160500.GF7370@stefanha-x1.localdomain>
References: <20170913135418.GA14243@stefanha-x1.localdomain>
	<dbd4caa3-71e2-5ea0-c7b1-8aee774eec30@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dbd4caa3-71e2-5ea0-c7b1-8aee774eec30@redhat.com>
Subject: Re: [Qemu-devel] [libvirt] QEMU -M nvdimm=on and hotplug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michal Privoznik <mprivozn@redhat.com>
Cc: libvir-list@redhat.com, Haozhong Zhang <haozhong.zhang@intel.com>, qemu-devel@nongnu.org

On Wed, Sep 13, 2017 at 05:28:56PM +0200, Michal Privoznik wrote:
> On 09/13/2017 03:54 PM, Stefan Hajnoczi wrote:
> > 2. Only allow NVDIMM hotplug if the domain was started with -M
> >    nvdimm=on.
> > 
> > I think QEMU will not add -M nvdimm=on to the "pc" machine type by
> > default since it adds the NVDIMM DSM hardware interface that increases
> > the security attack surface.
> 
> So this is the downside. Well, I think all that we are left with is
> option 2 then. Or, we can expose nvdimm=on the domain XML (and enable it
> by default for any domain that already has a nvdimm device configured).

There probably needs to be an explicit nvdimm=on XML element so that
domains can be created without NVDIMMs at boot but the ability to
hotplug NVDIMMs later.

Stefan
