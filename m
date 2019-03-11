Received: from eggs.gnu.org ([209.51.188.92]:41316)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1h3Kon-0003hA-2T
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 09:18:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1h3KbY-0002L5-1n
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 09:04:33 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:41380)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1h3KbX-0002KK-QK
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 09:04:31 -0400
Received: by mail-qt1-f195.google.com with SMTP id v10so4852473qtp.8
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 06:04:31 -0700 (PDT)
Date: Mon, 11 Mar 2019 09:04:22 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190311090135-mutt-send-email-mst@kernel.org>
References: <20190309004826.9027-1-lersek@redhat.com>
	<bf1a5775-17d9-c5bd-4e08-451585d3015e@redhat.com>
	<20190311102801.GM12393@redhat.com>
	<20190311085449-mutt-send-email-mst@kernel.org>
	<20190311130000.GW12393@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190311130000.GW12393@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 00/10] bundle edk2 platform firmware with
 QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>, Laszlo Ersek <lersek@redhat.com>, imammedo@redhat.com, kraxel@redhat.com, qemu-devel@nongnu.org

On Mon, Mar 11, 2019 at 01:00:00PM +0000, Daniel P. Berrangé wrote:
> On Mon, Mar 11, 2019 at 08:57:04AM -0400, Michael S. Tsirkin wrote:
> > On Mon, Mar 11, 2019 at 10:28:01AM +0000, Daniel P. Berrangé wrote:
> > > On Sat, Mar 09, 2019 at 02:20:06AM +0100, Philippe Mathieu-Daudé wrote:
> > > > On 3/9/19 1:48 AM, Laszlo Ersek wrote:
> > > > > Repo:   https://github.com/lersek/qemu.git
> > > > > Branch: edk2_build
> > > > > 
> > > > > This series advances the roms/edk2 submodule to the "edk2-stable201903"
> > > > > release, and builds and captures platform firmware binaries from that
> > > > > release. At this point they are meant to be used by both end-users and
> > > > > by Igor's ACPI unit tests in qtest ("make check").
> > > > > 
> > > > > Previous discussion:
> > > > > 
> > > > >   [Qemu-devel] bundling edk2 platform firmware images with QEMU
> > > > >   http://mid.mail-archive.com/80f0bae3-e79a-bb68-04c4-1c9c684d95b8@redhat.com
> > > > >   https://lists.gnu.org/archive/html/qemu-devel/2019-03/msg02601.html
> > > > > 
> > > > > Note that the series was formatted with "--no-binary" (affecting patch
> > > > > #8), therefore it cannot be applied with "git-am". See the remote
> > > > > repo/branch reference near the top instead.
> > > > > 
> > > > > Thanks,
> > > > > Laszlo
> > > > > 
> > > > > Laszlo Ersek (10):
> > > > >   roms: lift "edk2-funcs.sh" from "tests/uefi-test-tools/build.sh"
> > > > >   roms/edk2-funcs.sh: require gcc-4.8+ for building i386 and x86_64
> > > > >   tests/uefi-test-tools/build.sh: work around TianoCore#1607
> > > > >   roms/edk2: advance to tag edk2-stable201903
> > > > >   roms/edk2-funcs.sh: add the qemu_edk2_get_thread_count() function
> > > > >   roms/Makefile: replace the $(EFIROM) target with "edk2-basetools"
> > > > >   roms: build edk2 firmware binaries and variable store templates
> > > > >   pc-bios: add edk2 firmware binaries and variable store templates
> > > > >   pc-bios: document the edk2 firmware images; add firmware descriptors
> > > > >   Makefile: install the edk2 firmware images and their descriptors
> > > > > 
> > > > >  Makefile                                       |  17 +-
> > > > >  pc-bios/README                                 |  11 +
> > > > >  pc-bios/descriptors/50-edk2-i386-secure.json   |  34 +++
> > > > >  pc-bios/descriptors/50-edk2-x86_64-secure.json |  35 +++
> > > > >  pc-bios/descriptors/60-edk2-aarch64.json       |  31 +++
> > > > >  pc-bios/descriptors/60-edk2-arm.json           |  31 +++
> > > > >  pc-bios/descriptors/60-edk2-i386.json          |  33 +++
> > > > >  pc-bios/descriptors/60-edk2-x86_64.json        |  34 +++
> > > > >  pc-bios/edk2-aarch64-code.fd                   | Bin 0 -> 67108864 bytes
> > > > >  pc-bios/edk2-arm-code.fd                       | Bin 0 -> 67108864 bytes
> > > > >  pc-bios/edk2-arm-vars.fd                       | Bin 0 -> 67108864 bytes
> > > > 
> > > > GitHub moans here:
> > > > 
> > > > remote: warning: GH001: Large files detected. You may want to try Git
> > > > Large File Storage - https://git-lfs.github.com.
> > > > remote: warning: See http://git.io/iEPt8g for more information.
> > > > remote: warning: File pc-bios/edk2-arm-vars.fd is 64.00 MB; this is
> > > > larger than GitHub's recommended maximum file size of 50.00 MB
> > > > remote: warning: File pc-bios/edk2-arm-code.fd is 64.00 MB; this is
> > > > larger than GitHub's recommended maximum file size of 50.00 MB
> > > > remote: warning: File pc-bios/edk2-aarch64-code.fd is 64.00 MB; this is
> > > > larger than GitHub's recommended maximum file size of 50.00 MB
> > > 
> > > I wonder if this is a such that github isn't handling sparse files
> > > well, or if they just blindly do this check before they look at the
> > > actual required storage for the files.
> > > 
> > > Regards,
> > > Daniel
> > 
> > 
> > Right. But really: can we keep these around compressed?
> 
> I think it is viable for us to xz compress the images that we store in
> git & just let make "build"  the uncompressed images when needed.
> 
> Regards,
> Daniel

Right that's the simplest approach. OTOH we do link with zlib already,
so we could support actual compressed firmware too. Not sure it's worth
it.


> -- 
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
