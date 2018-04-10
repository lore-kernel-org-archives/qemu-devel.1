Received: from eggs.gnu.org ([2001:4830:134:3::10]:41707)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1f5p0y-0007wm-Sj
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 04:52:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1f5p0u-0002yz-UZ
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 04:52:32 -0400
Date: Tue, 10 Apr 2018 09:52:00 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180410085200.GD5155@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180409154921.29906-1-wei@redhat.com>
	<20180409155634.GO18283@redhat.com>
	<6bb12858-3b4e-e92f-93ea-b8708c8be870@redhat.com>
	<1523346093.16671.23.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1523346093.16671.23.camel@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/1] mach-virt: Change default cpu and
 gic-version setting to "max"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrea Bolognani <abologna@redhat.com>
Cc: Wei Huang <wei@redhat.com>, qemu-devel@nongnu.org, peter.maydell@linaro.org, drjones@redhat.com, qemu-arm@nongnu.org

On Tue, Apr 10, 2018 at 09:41:33AM +0200, Andrea Bolognani wrote:
> On Mon, 2018-04-09 at 11:29 -0500, Wei Huang wrote:
> > > > Running mach-virt machine types (i.e. "-M virt") on different systems can
> > > > result in various misleading warnings if -cpu and/or gic-version not specified.
> > > > For KVM, this can be solved mostly by using "host" type. But the "host" type
> > > > doesn't work for TCG. Compared with "host", the "max" type not only supports
> > > > auto detection under KVM mode, but also works with TCG. So this patch set
> > > > "max" as the default types for both -cpu and gic-version.
> > > 
> > > Hmm, generally we aim for the config provided by a machine type to be stable
> > > across QEMU versions.
> > 
> > I understand this principle. But in reality, under KVM mode, the default
> > config most time doesn't work. If end users specify cpu type manually,
> > it still doesn't work because the host CPU is vendor-specific design
> > (e.g. "cortex-a57" doesn't work on QCOM's machine). So we end up with
> > using "-cpu host" all the time. My argument for this patch is that "-cpu
> > max" isn't worse than "-cpu host".
> 
> I figure the people not explicitly specifying a CPU model on the
> command line will probably also use '-M virt' instead of versioned
> machine types, which means they will get a different guest behavior
> after upgrading QEMU regardless.

Libvirt uses versioned machine types and does not specify -cpu unless the
user has added <cpu> to their XML. IOW libvirt assumes the default CPU
model is stable because that's what QEMU has promised in the past.

> Defaulting to 'max' for '-cpu' and 'gic-version' makes it convenient
> to quickly and concisely start a guest; if you care about guest ABI
> at all, then you are already specifying everything explicitly on the
> command line instead of relying on defaults - or using libvirt ;)

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
