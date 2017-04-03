Received: from eggs.gnu.org ([2001:4830:134:3::10]:50949)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cv5SD-0006gQ-H4
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 13:07:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cv5SA-0006YL-Qc
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 13:07:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33740)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cv5SA-0006Xz-La
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 13:07:42 -0400
Date: Mon, 3 Apr 2017 18:07:38 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170403170738.GC2768@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1490965817-16913-1-git-send-email-amarnath.valluri@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1490965817-16913-1-git-send-email-amarnath.valluri@intel.com>
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
To: Amarnath Valluri <amarnath.valluri@intel.com>
Cc: qemu-devel@nongnu.org, patrick.ohly@intel.com, stefanb@linux.vnet.ibm.com

On Fri, Mar 31, 2017 at 04:10:09PM +0300, Amarnath Valluri wrote:
> Briefly, Theses set of patches introduces:
>  - new TPM backend driver to support software TPM emulators(swtpm(1)).
>  - and few supported fixes/enhancements/cleanup to existing tpm backend code.
> 
> The similar idea was initiated earliar(2) by Stefan Berger(CCed) with slightly
> different approach, using CUSE. As swtpm has excellent support for unix domain
> sockets, hence this implementation uses unix domain sockets to communicate with
> swtpm.
> 
> When Qemu is configured with 'emulator' tpm backend, it spawns 'swtpm' and
> communicates its via Unix domain sockets.

I'm not convinced that having QEMU spawning swtpm itself is a desirable
approach, as it means QEMU needs to have all the privileges that swtpm
will need, so that swtpm can inherit them. At the very least I think we
need to have a way to disable this spawning, so it can connect to a
pre-existing swtpm process that's been spawned ahead of time. This will
let us have stricter privilege separation.

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
