Received: from eggs.gnu.org ([2001:4830:134:3::10]:35257)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jhanley@dgtlrift.com>) id 1ckvpu-0005Tl-JJ
	for Qemu-devel@nongnu.org; Mon, 06 Mar 2017 11:50:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jhanley@dgtlrift.com>) id 1ckvps-0001OD-Gy
	for Qemu-devel@nongnu.org; Mon, 06 Mar 2017 11:50:14 -0500
Received: from mail-ua0-x242.google.com ([2607:f8b0:400c:c08::242]:36677)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jhanley@dgtlrift.com>)
	id 1ckvps-0001Mx-8g
	for Qemu-devel@nongnu.org; Mon, 06 Mar 2017 11:50:12 -0500
Received: by mail-ua0-x242.google.com with SMTP id y16so17613215uay.3
	for <Qemu-devel@nongnu.org>; Mon, 06 Mar 2017 08:50:10 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9NPoujRE47pyNEui-DwxwisNpmGNp0w4B_+_mwbuV_4Q@mail.gmail.com>
References: <CAF++6APFk2KY-7yFYtsgcTwn31RCf_Wxucp3eTLbB2e1c5QAyg@mail.gmail.com>
	<CAFEAcA9NPoujRE47pyNEui-DwxwisNpmGNp0w4B_+_mwbuV_4Q@mail.gmail.com>
From: James Hanley <jhanley@dgtlrift.com>
Date: Mon, 6 Mar 2017 11:50:08 -0500
Message-ID: <CAF++6AN8-pKhPKNQPDnCkXzQdqo4hPTH6eJetuzQXmsBkDXRNA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 0/2] submodule-update queue 20170303
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel <Qemu-devel@nongnu.org>

I'm still seeing the same error - the only change I have in my clone is the
following so that the submodules are accessible across our firewall -
should the http URLs be referencing the same backend repo as the git URLs?:
jim@jim-VirtualBox:~/project/test_qemu_repo/qemu$ git diff -v
6865190577f240d0c0f15d6537a893d771596404^
6865190577f240d0c0f15d6537a893d771596404
diff --git a/.gitmodules b/.gitmodules
index ca323b4..0156c06 100644
--- a/.gitmodules
+++ b/.gitmodules
@@ -1,36 +1,36 @@
 [submodule "roms/vgabios"]
        path = roms/vgabios
-       url = git://git.qemu-project.org/vgabios.git/
+       url = http://git.qemu-project.org/git/vgabios.git
 [submodule "roms/seabios"]
        path = roms/seabios
-       url = git://git.qemu-project.org/seabios.git/
+       url = http://git.qemu-project.org/git/seabios.git
 [submodule "roms/SLOF"]
        path = roms/SLOF
-       url = git://git.qemu-project.org/SLOF.git
+       url = http://git.qemu-project.org/git/SLOF.git
 [submodule "roms/ipxe"]
        path = roms/ipxe
-       url = git://git.qemu-project.org/ipxe.git
+       url = http://git.qemu-project.org/git/ipxe.git
 [submodule "roms/openbios"]
        path = roms/openbios
-       url = git://git.qemu-project.org/openbios.git
+       url = http://git.qemu-project.org/git/openbios.git
 [submodule "roms/openhackware"]
        path = roms/openhackware
-       url = git://git.qemu-project.org/openhackware.git
+       url = http://git.qemu-project.org/git/openhackware.git
 [submodule "roms/qemu-palcode"]
        path = roms/qemu-palcode
-       url = git://github.com/rth7680/qemu-palcode.git
+       url = https://github.com/rth7680/qemu-palcode.git
 [submodule "roms/sgabios"]
        path = roms/sgabios
-       url = git://git.qemu-project.org/sgabios.git
+       url = http://git.qemu-project.org/git/sgabios.git
 [submodule "pixman"]
        path = pixman
-       url = git://anongit.freedesktop.org/pixman
+       url = https://anongit.freedesktop.org/git/pixman.git
 [submodule "dtc"]
        path = dtc
-       url = git://git.qemu-project.org/dtc.git
+       url = http://git.qemu-project.org/git/dtc.git
 [submodule "roms/u-boot"]
        path = roms/u-boot
-       url = git://git.qemu-project.org/u-boot.git
+       url = http://git.qemu-project.org/git/u-boot.git
 [submodule "roms/skiboot"]
        path = roms/skiboot
-       url = git://git.qemu.org/skiboot.git
+       url = http://git.qemu-project.org/git/skiboot.git


On Sat, Mar 4, 2017 at 7:47 AM, Peter Maydell <peter.maydell@linaro.org>
wrote:

> On 3 March 2017 at 19:45, James Hanley <jhanley@dgtlrift.com> wrote:
> > I'm trying to clone clean and I'm getting the following when initing the
> > submodules updated:
>
> > It's unclear to me what should be done for a pristine clone - is there a
> > step missing from pulling those submodules?
>
> I just did:
>  git clone git://git.qemu-project.org/qemu.git
>  cd qemu
>  git submodule init
>  git submodule update
>
> and that worked for me.
>
> (We do occasionally accidentally introduce an error where we
> update the submodule but the qemu-project.org mirror of a
> git repo hasn't yet moved forward to include the reference.
> But it seems to all be OK at the moment.)
>
> As an aside you typically don't need all the submodules if
> you're just interested in building QEMU. (You might need
> the dtc module but configure will tell you if you do and
> also what command to ues to just get the dtc submodule
> and not anything else.)
>
> thanks
> -- PMM
>
