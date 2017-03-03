Received: from eggs.gnu.org ([2001:4830:134:3::10]:57290)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jhanley@dgtlrift.com>) id 1cjt9B-0005Dt-OI
	for Qemu-devel@nongnu.org; Fri, 03 Mar 2017 14:45:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jhanley@dgtlrift.com>) id 1cjt99-0001YQ-QM
	for Qemu-devel@nongnu.org; Fri, 03 Mar 2017 14:45:49 -0500
Received: from mail-ua0-x22f.google.com ([2607:f8b0:400c:c08::22f]:33251)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jhanley@dgtlrift.com>)
	id 1cjt99-0001X3-Dg
	for Qemu-devel@nongnu.org; Fri, 03 Mar 2017 14:45:47 -0500
Received: by mail-ua0-x22f.google.com with SMTP id c11so75569095uaa.0
	for <Qemu-devel@nongnu.org>; Fri, 03 Mar 2017 11:45:45 -0800 (PST)
MIME-Version: 1.0
From: James Hanley <jhanley@dgtlrift.com>
Date: Fri, 3 Mar 2017 14:45:44 -0500
Message-ID: <CAF++6APFk2KY-7yFYtsgcTwn31RCf_Wxucp3eTLbB2e1c5QAyg@mail.gmail.com>
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
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel <Qemu-devel@nongnu.org>

I'm trying to clone clean and I'm getting the following when initing the
submodules updated:

jim@jim-VirtualBox:~/project/lg_4k_test/qemu_pristine$ ( git submodule
sync; git submodule update --init --recursive )
Submodule 'dtc' (http://git.qemu-project.org/git/dtc.git) registered for
path 'dtc'
Submodule 'pixman' (https://anongit.freedesktop.org/git/pixman.git)
registered for path 'pixman'
Submodule 'roms/SLOF' (http://git.qemu-project.org/git/SLOF.git) registered
for path 'roms/SLOF'
Submodule 'roms/ipxe' (http://git.qemu-project.org/git/ipxe.git) registered
for path 'roms/ipxe'
Submodule 'roms/openbios' (http://git.qemu-project.org/git/openbios.git)
registered for path 'roms/openbios'
Submodule 'roms/openhackware' (
http://git.qemu-project.org/git/openhackware.git) registered for path
'roms/openhackware'
Submodule 'roms/qemu-palcode' (https://github.com/rth7680/qemu-palcode.git)
registered for path 'roms/qemu-palcode'
Submodule 'roms/seabios' (http://git.qemu-project.org/git/seabios.git)
registered for path 'roms/seabios'
Submodule 'roms/sgabios' (http://git.qemu-project.org/git/sgabios.git)
registered for path 'roms/sgabios'
Submodule 'roms/skiboot' (http://git.qemu-project.org/git/skiboot.git)
registered for path 'roms/skiboot'
Submodule 'roms/u-boot' (http://git.qemu-project.org/git/u-boot.git)
registered for path 'roms/u-boot'
Submodule 'roms/vgabios' (http://git.qemu-project.org/git/vgabios.git)
registered for path 'roms/vgabios'
Cloning into 'dtc'...
Checking connectivity... done.
fatal: reference is not a tree: fa8bc7f928ac25f23532afc8beb2073efc8fb063
Cloning into 'pixman'...
remote: Counting objects: 11541, done.
remote: Compressing objects: 100% (2702/2702), done.
remote: Total 11541 (delta 8882), reused 11467 (delta 8837)
Receiving objects: 100% (11541/11541), 2.64 MiB | 1.77 MiB/s, done.
Resolving deltas: 100% (8882/8882), done.
Checking connectivity... done.
Submodule path 'pixman': checked out
'87eea99e443b389c978cf37efc52788bf03a0ee0'
Cloning into 'roms/SLOF'...
Checking connectivity... done.
fatal: reference is not a tree: 66d250ef0fd06bb88b7399b9563b5008201f2d63
Cloning into 'roms/ipxe'...
Checking connectivity... done.
Submodule path 'roms/ipxe': checked out
'b991c67c1d91574ef22336cc3a5944d1e63230c9'
Cloning into 'roms/openbios'...
Checking connectivity... done.
Submodule path 'roms/openbios': checked out
'0cd97cc904e71fbb461112f6756934ec6af890b8'
Cloning into 'roms/openhackware'...
Checking connectivity... done.
Submodule path 'roms/openhackware': checked out
'c559da7c8eec5e45ef1f67978827af6f0b9546f5'
Cloning into 'roms/qemu-palcode'...
remote: Counting objects: 279, done.
remote: Total 279 (delta 0), reused 0 (delta 0), pack-reused 279
Receiving objects: 100% (279/279), 143.11 KiB | 0 bytes/s, done.
Resolving deltas: 100% (171/171), done.
Checking connectivity... done.
Submodule path 'roms/qemu-palcode': checked out
'f3c7e44c70254975df2a00af39701eafbac4d471'
Cloning into 'roms/seabios'...
Checking connectivity... done.
fatal: reference is not a tree: 5f4c7b13cdf9c450eb55645f4362ea58fa61b79b
Cloning into 'roms/sgabios'...
Checking connectivity... done.
Submodule path 'roms/sgabios': checked out
'23d474943dcd55d0550a3d20b3d30e9040a4f15b'
Cloning into 'roms/skiboot'...
Checking connectivity... done.
Submodule path 'roms/skiboot': checked out
'762d0082f18e4fb921a2d44a1051b02d8b0f6381'
Cloning into 'roms/u-boot'...
Checking connectivity... done.
Submodule path 'roms/u-boot': checked out
'2072e7262965bb48d7fffb1e283101e6ed8b21a8'
Cloning into 'roms/vgabios'...
Checking connectivity... done.
Submodule path 'roms/vgabios': checked out
'19ea12c230ded95928ecaef0db47a82231c2e485'
Unable to checkout 'fa8bc7f928ac25f23532afc8beb2073efc8fb063' in submodule
path 'dtc'
Unable to checkout '66d250ef0fd06bb88b7399b9563b5008201f2d63' in submodule
path 'roms/SLOF'
Unable to checkout '5f4c7b13cdf9c450eb55645f4362ea58fa61b79b' in submodule
path 'roms/seabios'
jim@jim-VirtualBox:~/project/lg_4k_test/qemu_pristine$


It's unclear to me what should be done for a pristine clone - is there a
step missing from pulling those submodules?

-Jim
