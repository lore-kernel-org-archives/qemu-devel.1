Received: from eggs.gnu.org ([2001:4830:134:3::10]:56048)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1f5num-0007jd-Kw
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 03:42:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1f5nui-0001qa-OQ
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 03:42:04 -0400
Message-ID: <1523346093.16671.23.camel@redhat.com>
From: Andrea Bolognani <abologna@redhat.com>
Date: Tue, 10 Apr 2018 09:41:33 +0200
In-Reply-To: <6bb12858-3b4e-e92f-93ea-b8708c8be870@redhat.com>
References: <20180409154921.29906-1-wei@redhat.com>
	<20180409155634.GO18283@redhat.com>
	<6bb12858-3b4e-e92f-93ea-b8708c8be870@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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
To: Wei Huang <wei@redhat.com>, "Daniel P. =?ISO-8859-1?Q?Berrang=E9?=" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, drjones@redhat.com, qemu-arm@nongnu.org

On Mon, 2018-04-09 at 11:29 -0500, Wei Huang wrote:
> > > Running mach-virt machine types (i.e. "-M virt") on different systems can
> > > result in various misleading warnings if -cpu and/or gic-version not specified.
> > > For KVM, this can be solved mostly by using "host" type. But the "host" type
> > > doesn't work for TCG. Compared with "host", the "max" type not only supports
> > > auto detection under KVM mode, but also works with TCG. So this patch set
> > > "max" as the default types for both -cpu and gic-version.
> > 
> > Hmm, generally we aim for the config provided by a machine type to be stable
> > across QEMU versions.
> 
> I understand this principle. But in reality, under KVM mode, the default
> config most time doesn't work. If end users specify cpu type manually,
> it still doesn't work because the host CPU is vendor-specific design
> (e.g. "cortex-a57" doesn't work on QCOM's machine). So we end up with
> using "-cpu host" all the time. My argument for this patch is that "-cpu
> max" isn't worse than "-cpu host".

I figure the people not explicitly specifying a CPU model on the
command line will probably also use '-M virt' instead of versioned
machine types, which means they will get a different guest behavior
after upgrading QEMU regardless.

Defaulting to 'max' for '-cpu' and 'gic-version' makes it convenient
to quickly and concisely start a guest; if you care about guest ABI
at all, then you are already specifying everything explicitly on the
command line instead of relying on defaults - or using libvirt ;)

-- 
Andrea Bolognani / Red Hat / Virtualization
