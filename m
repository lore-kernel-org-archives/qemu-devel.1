Received: from eggs.gnu.org ([2001:4830:134:3::10]:58688)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cv5s0-0007Df-BA
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 13:34:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cv5rw-0003x8-TM
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 13:34:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57628)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cv5rw-0003wP-NH
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 13:34:20 -0400
Date: Mon, 3 Apr 2017 18:34:15 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170403173415.GC2112@work-vm>
References: <1490965817-16913-1-git-send-email-amarnath.valluri@intel.com>
	<20170403170738.GC2768@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170403170738.GC2768@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/7] Provide support for the software TPM
 emulator
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Amarnath Valluri <amarnath.valluri@intel.com>, patrick.ohly@intel.com, qemu-devel@nongnu.org, stefanb@linux.vnet.ibm.com

* Daniel P. Berrange (berrange@redhat.com) wrote:
> On Fri, Mar 31, 2017 at 04:10:09PM +0300, Amarnath Valluri wrote:
> > Briefly, Theses set of patches introduces:
> >  - new TPM backend driver to support software TPM emulators(swtpm(1)).
> >  - and few supported fixes/enhancements/cleanup to existing tpm backend code.
> > 
> > The similar idea was initiated earliar(2) by Stefan Berger(CCed) with slightly
> > different approach, using CUSE. As swtpm has excellent support for unix domain
> > sockets, hence this implementation uses unix domain sockets to communicate with
> > swtpm.
> > 
> > When Qemu is configured with 'emulator' tpm backend, it spawns 'swtpm' and
> > communicates its via Unix domain sockets.
> 
> I'm not convinced that having QEMU spawning swtpm itself is a desirable
> approach, as it means QEMU needs to have all the privileges that swtpm
> will need, so that swtpm can inherit them. At the very least I think we
> need to have a way to disable this spawning, so it can connect to a
> pre-existing swtpm process that's been spawned ahead of time. This will
> let us have stricter privilege separation.

I agree, just letting something external start the swtpm and using
a chardev to talk to it would seem to work wouldn't it?

However, generally I prefer this mechanism of avoiding CUSE.

Dave


> Regards,
> Daniel
> -- 
> |: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
> |: http://libvirt.org              -o-             http://virt-manager.org :|
> |: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
