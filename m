Received: from eggs.gnu.org ([2001:4830:134:3::10]:47207)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eZskP-0003Z0-Kn
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 01:23:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eZskL-0007St-St
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 01:23:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42094)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1eZskL-0007Rh-MU
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 01:23:21 -0500
References: <151570326218.441.13378298987831799927@5adcb62bf0d6>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <ba4c016b-703f-906d-ad16-22ae1aa05b25@redhat.com>
Date: Fri, 12 Jan 2018 07:23:13 +0100
MIME-Version: 1.0
In-Reply-To: <151570326218.441.13378298987831799927@5adcb62bf0d6>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: qemu-devel@nongnu.org, famz@redhat.com
Cc: jasowang@redhat.com, samuel.thibault@ens-lyon.org, dgilbert@redhat.com

On 11.01.2018 21:41, no-reply@patchew.org wrote:
> Hi,
> 
> This series failed build test on ppc host. Please find the details below.
[...]
> Updating 3c8cf5a9c21ff8782164d1def7f44bd888713384
> Submodule 'dtc' (git://git.qemu-project.org/dtc.git) registered for path 'dtc'
> Submodule 'pixman' (git://anongit.freedesktop.org/pixman) registered for path 'pixman'
> Submodule 'roms/SLOF' (git://git.qemu-project.org/SLOF.git) registered for path 'roms/SLOF'
> Submodule 'roms/ipxe' (git://git.qemu-project.org/ipxe.git) registered for path 'roms/ipxe'
> Submodule 'roms/openbios' (git://git.qemu-project.org/openbios.git) registered for path 'roms/openbios'
> Submodule 'roms/openhackware' (git://git.qemu-project.org/openhackware.git) registered for path 'roms/openhackware'
> Submodule 'roms/qemu-palcode' (git://github.com/rth7680/qemu-palcode.git) registered for path 'roms/qemu-palcode'
> Submodule 'roms/seabios' (git://git.qemu-project.org/seabios.git/) registered for path 'roms/seabios'
> Submodule 'roms/sgabios' (git://git.qemu-project.org/sgabios.git) registered for path 'roms/sgabios'
> Submodule 'roms/u-boot' (git://git.qemu-project.org/u-boot.git) registered for path 'roms/u-boot'
> Submodule 'roms/vgabios' (git://git.qemu-project.org/vgabios.git/) registered for path 'roms/vgabios'
> Cloning into 'dtc'...
> Submodule path 'dtc': checked out '65cc4d2748a2c2e6f27f1cf39e07a5dbabd80ebf'
> fatal: remote error: access denied or repository not exported: /pixman
> Cloning into 'pixman'...
> Clone of 'git://anongit.freedesktop.org/pixman' into submodule path 'pixman' failed

 Hi Fam,

why is patchew still trying to clone pixman? I thought we only use the
system pixman library nowadays?

 Thomas
