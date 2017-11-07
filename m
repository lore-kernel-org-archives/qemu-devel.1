Received: from eggs.gnu.org ([2001:4830:134:3::10]:39611)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <patrick.ohly@intel.com>) id 1eC0Kl-0007Cu-IS
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 04:38:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <patrick.ohly@intel.com>) id 1eC0Ki-0003w4-BE
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 04:38:15 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:52419)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <patrick.ohly@intel.com>)
	id 1eC0Ki-0003vb-3H
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 04:38:12 -0500
Received: by mail-wm0-x242.google.com with SMTP id t139so2384122wmt.1
	for <qemu-devel@nongnu.org>; Tue, 07 Nov 2017 01:38:11 -0800 (PST)
Message-ID: <1510047488.22094.17.camel@intel.com>
From: Patrick Ohly <patrick.ohly@intel.com>
Date: Tue, 07 Nov 2017 10:38:08 +0100
In-Reply-To: <20171107092322.GE14232@redhat.com>
References: <1509988303.22094.8.camel@intel.com>
	<20171106172646.GO23361@redhat.com>
	<1510002125.22094.10.camel@intel.com>
	<20171107092322.GE14232@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] RFC: connecting chardev to a command forked by qemu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Amarnath Valluri <amarnath.valluri@intel.com>

On Tue, 2017-11-07 at 09:23 +0000, Daniel P. Berrange wrote:
> On Mon, Nov 06, 2017 at 10:02:05PM +0100, Patrick Ohly wrote:
> > On Mon, 2017-11-06 at 17:26 +0000, Daniel P. Berrange wrote:
> > > I can see the argument about it making QEMU easier to use, and
> > > those
> > > who care about security aren't forced to use this new feature. It
> > > none the less has a cost on maintainers and existance of these
> > > features does reflect on QEMU's security reputation even if many
> > > don't use it.
> > 
> > With Yocto we really don't have much choice: we need a patch like
> > this
> > because the alternative (introducing support for spawning and
> > stopping
> > swtpm and then passing the right parameters to QEMU) is way more
> > complex. So if this patch isn't acceptable to QEMU upstream, then I
> > will keep it as simple as possible and propose it as a local patch
> > in
> > Yocto.
> 
> I don't really buy this argument. Any distro's core job is the
> ability to start/stop/manage processes. Saying yocto is unable to
> manage runing of swtpm is really dubious - it is simply a choice to
> declare that it is QEMU's job. 

Yocto isn't really a distro. It's mostly a build system and meta data
that can be used to build custom distros.

The use of qemu+swtpm is during testing on whatever distro the
developer has chosen for his build machine. Yocto could build libvirt
for that host to manage QEMU, but given the choice between that or
enhancing the Yocto QEMU support code and patching QEMU, patching IMHO
is the easier and cleaner solution - for Yocto, at least.

I'll proceed with proposing the patch as a Yocto-specific modification
for QEMU.

-- 
Best Regards, Patrick Ohly

The content of this message is my personal opinion only and although
I am an employee of Intel, the statements I make here in no way
represent Intel's position on the issue, nor am I authorized to speak
on behalf of Intel on this matter.
