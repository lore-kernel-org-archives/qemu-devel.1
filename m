Received: from eggs.gnu.org ([2001:4830:134:3::10]:51812)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eZt4K-000112-8u
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 01:44:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eZt4H-0001B7-6V
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 01:44:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33714)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1eZt4G-0001AM-Vc
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 01:43:57 -0500
Date: Fri, 12 Jan 2018 14:43:54 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180112064354.GF29151@lemon.usersys.redhat.com>
References: <151570326218.441.13378298987831799927@5adcb62bf0d6>
	<ba4c016b-703f-906d-ad16-22ae1aa05b25@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba4c016b-703f-906d-ad16-22ae1aa05b25@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] net: Allow netdevs to be used with
 'hostfwd_add' and 'hostfwd_remove'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, jasowang@redhat.com, samuel.thibault@ens-lyon.org, dgilbert@redhat.com

On Fri, 01/12 07:23, Thomas Huth wrote:
> On 11.01.2018 21:41, no-reply@patchew.org wrote:
> > Hi,
> > 
> > This series failed build test on ppc host. Please find the details below.
> [...]
> > Updating 3c8cf5a9c21ff8782164d1def7f44bd888713384
> > Submodule 'dtc' (git://git.qemu-project.org/dtc.git) registered for path 'dtc'
> > Submodule 'pixman' (git://anongit.freedesktop.org/pixman) registered for path 'pixman'
> > Submodule 'roms/SLOF' (git://git.qemu-project.org/SLOF.git) registered for path 'roms/SLOF'
> > Submodule 'roms/ipxe' (git://git.qemu-project.org/ipxe.git) registered for path 'roms/ipxe'
> > Submodule 'roms/openbios' (git://git.qemu-project.org/openbios.git) registered for path 'roms/openbios'
> > Submodule 'roms/openhackware' (git://git.qemu-project.org/openhackware.git) registered for path 'roms/openhackware'
> > Submodule 'roms/qemu-palcode' (git://github.com/rth7680/qemu-palcode.git) registered for path 'roms/qemu-palcode'
> > Submodule 'roms/seabios' (git://git.qemu-project.org/seabios.git/) registered for path 'roms/seabios'
> > Submodule 'roms/sgabios' (git://git.qemu-project.org/sgabios.git) registered for path 'roms/sgabios'
> > Submodule 'roms/u-boot' (git://git.qemu-project.org/u-boot.git) registered for path 'roms/u-boot'
> > Submodule 'roms/vgabios' (git://git.qemu-project.org/vgabios.git/) registered for path 'roms/vgabios'
> > Cloning into 'dtc'...
> > Submodule path 'dtc': checked out '65cc4d2748a2c2e6f27f1cf39e07a5dbabd80ebf'
> > fatal: remote error: access denied or repository not exported: /pixman
> > Cloning into 'pixman'...
> > Clone of 'git://anongit.freedesktop.org/pixman' into submodule path 'pixman' failed
> 
>  Hi Fam,
> 
> why is patchew still trying to clone pixman? I thought we only use the
> system pixman library nowadays?

There is a bug in patchew tester that the git cache repo is not updated, so
every time it starts from a very old commit. Will fix it soon.

Fam
