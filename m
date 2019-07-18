Return-Path: <SRS0=9jkQ=VP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C86B6C76191
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 06:21:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7393021019
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 06:21:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7393021019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34684 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnzmx-0005r4-KO
	for qemu-devel@archiver.kernel.org; Thu, 18 Jul 2019 02:21:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46206)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hnzmS-0005NM-CT
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 02:20:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hnzm8-0006Nq-QG
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 02:20:40 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41889)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hnzm8-0006MY-HH
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 02:20:20 -0400
Received: by mail-wr1-f67.google.com with SMTP id c2so24065586wrm.8
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2019 23:20:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=8UqYDtzzabCPcpiSnK3xtEjlUjUsBYMO/m8ueY1zMZo=;
 b=KyEkWc24sjpamsXJcckXx0A19hw9Ufc5Q0yK4cr8wjHW8qIH8a7HyCqCmTDts8J0eT
 s2Aa6dOzK/Aq/ReppSMLrcyPecUNt/IGaVBsjN1Ft+V5QBWeUjq+lEoV+IF9ye8lq4Mv
 PXHGPNsfoUN5BYuZWUJbBykhJ6KptLckENqA6MToPh7kUVM1VZK1GSYsr4tRxLQJCr3P
 CpJcAPvmgU4iX5nJMk1oHbfdw49sIWUGflXpSwJyadtbrXEXKmFtfMINNYLYC06m87F1
 4c/uNwjgDSHAI8/PtK479QcyAkKu46hxOamXLMdNpQbuch+CUcd9vuh/jbZeAbti00dK
 jXgg==
X-Gm-Message-State: APjAAAXX/2YPBpckqiT4DjDDIO6E7tMVe02JNcCcFVP/XX8ldJadu4P8
 Tqtb1dw4RObMf79rnjE6RLyWRVVqeIg=
X-Google-Smtp-Source: APXvYqwrszMqn6GGf3KyZr+hKX5yiHuvEyJZKft+t1LQBGg8YvYu7RbaifFtIqD61GcO65szjGhn1g==
X-Received: by 2002:adf:b1d1:: with SMTP id r17mr47535736wra.273.1563430818354; 
 Wed, 17 Jul 2019 23:20:18 -0700 (PDT)
Received: from [192.168.1.37] (62.red-83-42-61.dynamicip.rima-tde.net.
 [83.42.61.62])
 by smtp.gmail.com with ESMTPSA id d10sm31250554wro.18.2019.07.17.23.20.17
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Wed, 17 Jul 2019 23:20:17 -0700 (PDT)
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
 Thomas Huth <thuth@redhat.com>
References: <CAL1e-=jiySpoypabXMkUsO=2pqgUrRxUhac=JM_V=2sn2LPhWA@mail.gmail.com>
 <054d5b29-6482-1d71-3866-057dd00cb021@redhat.com>
 <CAL1e-=ikCpJO1bn=AKYSLWb8QNYkf6062ojxn+UN3svXCEQvFA@mail.gmail.com>
 <ff1c3cea-0de0-1717-44f2-f57b2c30a359@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <fe175e72-48f3-1a20-f9f0-34fbbadcf4a4@redhat.com>
Date: Thu, 18 Jul 2019 08:20:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <ff1c3cea-0de0-1717-44f2-f57b2c30a359@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.67
Subject: Re: [Qemu-devel] [QUESTION] SDL 1.2 support
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "berrange@redhat.com" <berrange@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/16/19 8:20 PM, Philippe Mathieu-Daudé wrote:
> Hi Aleksandar,
> 
> On 7/16/19 7:09 PM, Aleksandar Markovic wrote:
>> On Tue, Jul 16, 2019 at 1:54 PM Thomas Huth <thuth@redhat.com> wrote:
>>>
>>> On 16/07/2019 13.17, Aleksandar Markovic wrote:
>>>> Hello, Gerd, Daniel, and others involved.
>>>>
>>>> I have multiple reports from end users that say that transition from
>>>> SDL 1.2 to SDL 2.0 was difficult, or even impossible for their hosts.
>>>> In that light, they don't appreciate removing SDL 1.2 support from
>>>> QEMU. The most notable example is Ubutnu 16.04, where it looks there
>>>> is no way of installing SDL 2.0 that does not involve complete OS
>>>> upgrade, which, for various reasons, many are not willing to do.
>>>
>>> What's the problem here? According to
>>> https://packages.ubuntu.com/xenial/libsdl2-2.0-0 the library should be
>>> available there.
>>>
>>
>> Yes, we, as developers, are good at upgrading, we like flexibility in
>> our development systems, and naturally want to try latest and greatest
>> tools and libraries.
>>
>> However, in QA / build / test environments, the things seem to look
>> different. Their main concern is stability and repeatibility of their
>> systems. They don't like updates and upgrades. If a new of library
>> is available for an OS, this does not mean it will be installed, or it
>> will be desired to be installed.
>>
>> It appears that Ubuntu 16.04 came originally with SDL 1.2, and
>> SDL 2.0 was made available later on.
> 
> I am a bit confused, I checked the older Xenial image I can find is a
> pre-release:
> 
> 16.04.20151218.1-xenial-baseline
> 
> # lsb_release -a
> LSB Version:
> core-9.20160110ubuntu0.2-amd64:core-9.20160110ubuntu0.2-noarch:security-9.20160110ubuntu0.2-amd64:security-9.20160110ubuntu0.2-noarch
> Distributor ID: Ubuntu
> Description:    Ubuntu Xenial Xerus (development branch)
> Release:        16.04
> Codename:       xenial
> 
> # apt-cache search libsdl
> libsdl1.2-dbg - Simple DirectMedia Layer debug files
> libsdl1.2-dev - Simple DirectMedia Layer development files
> libsdl1.2debian - Simple DirectMedia Layer
> 
> # apt-cache search libsdl2
> 
> # apt-get update
> 
> # apt-cache search libsdl2
> libsdl2-2.0-0 - Simple DirectMedia Layer
> libsdl2-dbg - Simple DirectMedia Layer debug files
> libsdl2-dev - Simple DirectMedia Layer development files
> libsdl2-doc - Reference manual for libsdl2
> libsdl2-gfx-1.0-0 - drawing and graphical effects extension for SDL2
> libsdl2-gfx-dbg - debugging symbols for SDL2_gfx
> libsdl2-gfx-dev - development files for SDL2_gfx
> libsdl2-gfx-doc - documentation files for SDL2_gfx
> libsdl2-image-2.0-0 - Image loading library for Simple DirectMedia Layer
> 2, libraries
> libsdl2-image-dbg - Image loading library for Simple DirectMedia Layer
> 2, debugging symbols
> libsdl2-image-dev - Image loading library for Simple DirectMedia Layer
> 2, development files
> libsdl2-mixer-2.0-0 - Mixer library for Simple DirectMedia Layer 2,
> libraries
> libsdl2-mixer-dbg - Mixer library for Simple DirectMedia Layer 2, debugging
> libsdl2-mixer-dev - Mixer library for Simple DirectMedia Layer 2,
> development files
> libsdl2-net-2.0-0 - Network library for Simple DirectMedia Layer 2,
> libraries
> libsdl2-net-dbg - Network library for Simple DirectMedia Layer 2, debugging
> libsdl2-net-dev - Network library for Simple DirectMedia Layer 2,
> development files
> libsdl2-ttf-2.0-0 - TrueType Font library for Simple DirectMedia Layer
> 2, libraries
> libsdl2-ttf-dbg - TrueType Font library for Simple DirectMedia Layer 2,
> debugging
> libsdl2-ttf-dev - TrueType Font library for Simple DirectMedia Layer 2,
> development files
> 
> # apt-cache show libsdl2-dev
> Package: libsdl2-dev
> Architecture: amd64
> Version: 2.0.4+dfsg1-2ubuntu2.16.04.1
> Priority: optional
> Section: universe/libdevel
> Source: libsdl2
> Origin: Ubuntu
> Maintainer: Ubuntu Developers <ubuntu-devel-discuss@lists.ubuntu.com>
> Original-Maintainer: Debian SDL packages maintainers
> <pkg-sdl-maintainers@lists.alioth.debian.org>
> Bugs: https://bugs.launchpad.net/ubuntu/+filebug
> Installed-Size: 3803
> Depends: libasound2-dev, libdbus-1-dev, libegl1-mesa-dev,
> libgl1-mesa-dev, libgles2-mesa-dev, libglu1-mesa-dev, libmirclient-dev,
> libpulse-dev, libsdl2-2.0-0 (= 2.0.4+dfsg1-2ubuntu2.16.04.1),
> libsndio-dev, libudev-dev, libwayland-dev, libx11-dev, libxcursor-dev,
> libxext-dev, libxi-dev, libxinerama-dev, libxkbcommon-dev,
> libxrandr-dev, libxss-dev, libxt-dev, libxv-dev, libxxf86vm-dev
> Conflicts: libsdl-1.3-dev
> Replaces: libsdl-1.3-dev
> Filename:
> pool/universe/libs/libsdl2/libsdl2-dev_2.0.4+dfsg1-2ubuntu2.16.04.1_amd64.deb
> Size: 612948
> MD5sum: 75ff5bbc4c5ec0c9b81052b3695aa642
> SHA1: 7d9ddbb5217343400128149ceea497d29a188a5e
> SHA256: 1b79ee19be271d26e28de1a83f8181afa36a7fdc5479faa9f5dfe07ba4c4c272
> Homepage: http://www.libsdl.org/
> Description: Simple DirectMedia Layer development files
> Description-md5: 9a82f59c5790721baad7ffc5f181d3d6
> Supported: 5y
> 
> Package: libsdl2-dev
> Priority: optional
> Section: universe/libdevel
> Installed-Size: 3802
> Maintainer: Ubuntu Developers <ubuntu-devel-discuss@lists.ubuntu.com>
> Original-Maintainer: Debian SDL packages maintainers
> <pkg-sdl-maintainers@lists.alioth.debian.org>
> Architecture: amd64
> Source: libsdl2
> Version: 2.0.4+dfsg1-2ubuntu2
> Replaces: libsdl-1.3-dev
> Depends: libasound2-dev, libdbus-1-dev, libegl1-mesa-dev,
> libgl1-mesa-dev, libgles2-mesa-dev, libglu1-mesa-dev, libmirclient-dev,
> libpulse-dev, libsdl2-2.0-0 (= 2.0.4+dfsg1-2ubuntu2), libsndio-dev,
> libudev-dev, libwayland-dev, libx11-dev, libxcursor-dev, libxext-dev,
> libxi-dev, libxinerama-dev, libxkbcommon-dev, libxrandr-dev, libxss-dev,
> libxt-dev, libxv-dev, libxxf86vm-dev
> Conflicts: libsdl-1.3-dev
> Filename:
> pool/universe/libs/libsdl2/libsdl2-dev_2.0.4+dfsg1-2ubuntu2_amd64.deb
> Size: 613746
> MD5sum: 470e753ffa16fec00c29215e0c94efc9
> SHA1: db99050370630d36105131d60bad9daa95c530d8
> SHA256: 461dc89140f2716f05e20cf35c2cf3f46b0ae6e32c5bed16136df08d28b2fde0
> Description: Simple DirectMedia Layer development files
> Description-md5: 9a82f59c5790721baad7ffc5f181d3d6
> Homepage: http://www.libsdl.org/
> Bugs: https://bugs.launchpad.net/ubuntu/+filebug
> Origin: Ubuntu
> Supported: 9m
> 
> # curl -v
> http://archive.ubuntu.com/ubuntu/pool/universe/libs/libsdl2/libsdl2_2.0.4+dfsg1-2ubuntu2.dsc
> 2>&1 | fgrep Last-Modified
> < Last-Modified: Thu, 10 Mar 2016 22:03:45 GMT
> 
> This package was available before the Xenial official release.
> 
> I am supposing your host does not have Internet access to run apt-update
> then?

Spending more time on this issue, assuming your customer has Ubuntu
16.04 installed from default cdrom image, with not network connectivity,
but can copy packages on a USB drive.

So since the default install comes without git, I had to shutdown the
guest, mount the disk image, copy from a cloned repository, reboot the
guest.

$ ./configure

ERROR: pkg-config binary 'pkg-config' not found

pkg-config depends of the following 11 packages:
- bzip2
- dpkg-dev
- libdpkg-perl
- libgdbm3
- libglib2.0-0
- libperl5.22
- make
- patch
- perl
- perl-modules-5.22
- xz-utils

Since it starts to be painful and time consuming to shutdown guest/mount
image/copy files/umount image/restart guest, and since I have network
access to it, I'll install openssh-server, but will not run "apt-get
update" in my guest.

So openssh-server requires:
- init-system-helpers
- libbsd0
- libedit2
- libgssapi-krb5-2
- libk5crypto3
- libkeyutils1
- libkrb5-3
- libkrb5support0
- libwrap0
- openssh-client
- openssh-server
- openssh-sftp-server

Now I manually download all the .deb packages from
http://archive.ubuntu.com/ubuntu and copy them to the guest.
Restart guest, install packages.

$ ./configure

ERROR: glib-2.40 gthread-2.0 is required to compile QEMU

Ok, this is a hard dependency.

New packages to install:
- libelf1
- libglib2.0-bin
- libglib2.0-data
- libglib2.0-dev
- libpcre16-3
- libpcre3-dev
- libpcre32-3
- libpcrecpp0v5
- zlib1g-dev

$ ./configure

ERROR: pixman >= 0.21.8 not present.
       Please install the pixman devel package.

Installing:
- libpixman-1-0
- libpixman-1-dev

$ ./configure
No C++ compiler available; disabling C++ specific optional code
Install prefix    /usr/local
BIOS directory    /usr/local/share/qemu
firmware path     /usr/local/share/qemu-firmware
binary directory  /usr/local/bin
library directory /usr/local/lib
module directory  /usr/local/lib/qemu
libexec directory /usr/local/libexec
include directory /usr/local/include
config directory  /usr/local/etc
local state directory   /usr/local/var
Manual directory  /usr/local/share/man
ELF interp prefix /usr/gnemul/qemu-%M
Source path       /tmp/qemu
GIT binary        git
GIT submodules    ui/keycodemapdb tests/fp/berkeley-testfloat-3
tests/fp/berkeley-softfloat-3 dtc capstone slirp
C compiler        cc
Host C compiler   cc
C++ compiler
Objective-C compiler cc
ARFLAGS           rv
CFLAGS            -O2 -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=2 -g
QEMU_CFLAGS       -I/usr/include/pixman-1 -I$(SRC_PATH)/dtc/libfdt
-Werror  -pthread -I/usr/include/glib-2.0
-I/usr/lib/x86_64-linux-gnu/glib-2.0/include -fPIE -DPIE -m64 -mcx16
-D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE
-Wstrict-prototypes -Wredundant-decls -Wall -Wundef -Wwrite-strings
-Wmissing-prototypes -fno-strict-aliasing -fno-common -fwrapv -std=gnu99
 -Wendif-labels -Wno-missing-include-dirs -Wempty-body -Wnested-externs
-Wformat-security -Wformat-y2k -Winit-self -Wignored-qualifiers
-Wold-style-declaration -Wold-style-definition -Wtype-limits
-fstack-protector-strong -I$(SRC_PATH)/capstone/include
LDFLAGS           -Wl,--warn-common -Wl,-z,relro -Wl,-z,now -pie -m64 -g
QEMU_LDFLAGS      -L$(BUILD_DIR)/dtc/libfdt
make              make
install           install
python            python -B (2.7.12)
slirp support     git
smbd              /usr/sbin/smbd
module support    no
host CPU          x86_64
host big endian   no
target list       aarch64-softmmu alpha-softmmu arm-softmmu cris-softmmu
hppa-softmmu i386-softmmu lm32-softmmu m68k-softmmu microblaze-softmmu
microblazeel-softmmu mips-softmmu mips64-softmmu mips64el-softmmu
mipsel-softmmu moxie-softmmu nios2-softmmu or1k-softmmu ppc-softmmu
ppc64-softmmu riscv32-softmmu riscv64-softmmu s390x-softmmu sh4-softmmu
sh4eb-softmmu sparc-softmmu sparc64-softmmu tricore-softmmu
unicore32-softmmu x86_64-softmmu xtensa-softmmu xtensaeb-softmmu
aarch64-linux-user aarch64_be-linux-user alpha-linux-user arm-linux-user
armeb-linux-user cris-linux-user hppa-linux-user i386-linux-user
m68k-linux-user microblaze-linux-user microblazeel-linux-user
mips-linux-user mips64-linux-user mips64el-linux-user mipsel-linux-user
mipsn32-linux-user mipsn32el-linux-user nios2-linux-user or1k-linux-user
ppc-linux-user ppc64-linux-user ppc64abi32-linux-user ppc64le-linux-user
riscv32-linux-user riscv64-linux-user s390x-linux-user sh4-linux-user
sh4eb-linux-user sparc-linux-user sparc32plus-linux-user
sparc64-linux-user tilegx-linux-user x86_64-linux-user xtensa-linux-user
xtensaeb-linux-user
gprof enabled     no
sparse enabled    no
strip binaries    yes
profiler          no
static build      no
SDL support       no
SDL image support no
GTK support       no
GTK GL support    no
VTE support       no
TLS priority      NORMAL
GNUTLS support    no
libgcrypt         no
nettle            no
libtasn1          no
PAM               no
iconv support     yes
curses support    no
virgl support     no
curl support      no
mingw32 support   no
Audio drivers      oss
Block whitelist (rw)
Block whitelist (ro)
VirtFS support    no
Multipath support no
VNC support       yes
VNC SASL support  no
VNC JPEG support  no
VNC PNG support   no
xen support       no
brlapi support    no
bluez  support    no
Documentation     no
PIE               yes
vde support       no
netmap support    no
Linux AIO support no
ATTR/XATTR support yes
Install blobs     yes
KVM support       yes
HAX support       no
HVF support       no
WHPX support      no
TCG support       yes
TCG debug enabled no
TCG interpreter   no
malloc trim support yes
RDMA support      no
PVRDMA support    no
fdt support       git
membarrier        no
preadv support    yes
fdatasync         yes
madvise           yes
posix_madvise     yes
posix_memalign    yes
libcap-ng support no
vhost-net support yes
vhost-crypto support yes
vhost-scsi support yes
vhost-vsock support yes
vhost-user support yes
Trace backends    log
spice support     no
rbd support       no
xfsctl support    no
smartcard support no
libusb            no
usb net redir     no
OpenGL support    no
OpenGL dmabufs    no
libiscsi support  no
libnfs support    no
build guest agent yes
QGA VSS support   no
QGA w32 disk info no
QGA MSI support   no
seccomp support   no
coroutine backend ucontext
coroutine pool    yes
debug stack usage no
mutex debugging   no
crypto afalg      no
GlusterFS support no
gcov              gcov
gcov enabled      no
TPM support       yes
libssh support    no
QOM debugging     yes
Live block migration yes
lzo support       no
snappy support    no
bzip2 support     no
lzfse support     no
NUMA host support no
libxml2           no
tcmalloc support  no
jemalloc support  no
avx2 optimization yes
replication support yes
VxHS block device no
bochs support     yes
cloop support     yes
dmg support       yes
qcow v1 support   yes
vdi support       yes
vvfat support     yes
qed support       yes
parallels support yes
sheepdog support  yes
capstone          git
docker            no
libpmem support   no
libudev           no
default devices   yes

warning: Python 2 support is deprecated
warning: Python 3 will be required for building future versions of QEMU

NOTE: cross-compilers enabled:  'cc' 'cc'

$

Yay!

$ make
/bin/sh: 1: git: not found
make[1]: Entering directory 'slirp'
make[1]: *** No targets specified and no makefile found.  Stop.
make[1]: Leaving directory 'slirp'
Makefile:503: recipe for target 'slirp/all' failed
make: *** [slirp/all] Error 2

Hmmm I forgot about git, but having git here would suggest we have
Internet connectivity we assumed we don't have. I forgot about it, it
was somehow stupid to work with a cloned repository.

So I'll continue with this tarball instead:
https://github.com/qemu/qemu/archive/v4.1.0-rc0.tar.gz

$ ./configure

ERROR: missing file /tmp/qemu-4.1.0-rc0/ui/keycodemapdb/README

This is not a GIT checkout but module content appears to
be missing. Do not use 'git archive' or GitHub download links
to acquire QEMU source archives. Non-GIT builds are only
supported with source archives linked from:

  https://www.qemu.org/download/

Developers working with GIT can use scripts/archive-source.sh
if they need to create valid source archives.

OK. Oh, this page doesn't link anything... Odd.

Let's look at the last mail from Michael Roth:

---
On behalf of the QEMU Team, I'd like to announce the availability of the
first release candidate for the QEMU 4.1 release.  This release is meant
for testing purposes and should not be used in a production environment.

  http://download.qemu-project.org/qemu-4.1.0-rc0.tar.xz
  http://download.qemu-project.org/qemu-4.1.0-rc0.tar.xz.sig
---

$ tar -xf qemu-4.1.0-rc0.tar.xz
tar: qemu-4.1.0-rc0.tar.xz: Cannot open: No such file or directory
tar: Error is not recoverable: exiting now

Who said this would be easy, eh...

$ type xz
xz is /usr/bin/xz

Oh, we have xz but tar is too old and dunno about it.

$ unxz qemu-4.1.0-rc0.tar.xz
$ tar -xf qemu-4.1.0-rc0.tar

$ ./configure
No C++ compiler available; disabling C++ specific optional code
Install prefix    /usr/local
BIOS directory    /usr/local/share/qemu
firmware path     /usr/local/share/qemu-firmware
binary directory  /usr/local/bin
library directory /usr/local/lib
module directory  /usr/local/lib/qemu
libexec directory /usr/local/libexec
include directory /usr/local/include
config directory  /usr/local/etc
local state directory   /usr/local/var
Manual directory  /usr/local/share/man
ELF interp prefix /usr/gnemul/qemu-%M
Source path       /tmp/qemu-4.1.0-rc0
GIT binary        git
GIT submodules
C compiler        cc
Host C compiler   cc
C++ compiler
Objective-C compiler cc
ARFLAGS           rv
CFLAGS            -O2 -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=2 -g
QEMU_CFLAGS       -I/usr/include/pixman-1 -I$(SRC_PATH)/dtc/libfdt
-pthread -I/usr/include/glib-2.0
-I/usr/lib/x86_64-linux-gnu/glib-2.0/include -fPIE -DPIE -m64 -mcx16
-D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE
-Wstrict-prototypes -Wredundant-decls -Wall -Wundef -Wwrite-strings
-Wmissing-prototypes -fno-strict-aliasing -fno-common -fwrapv -std=gnu99
 -Wendif-labels -Wno-missing-include-dirs -Wempty-body -Wnested-externs
-Wformat-security -Wformat-y2k -Winit-self -Wignored-qualifiers
-Wold-style-declaration -Wold-style-definition -Wtype-limits
-fstack-protector-strong -I$(SRC_PATH)/capstone/include
LDFLAGS           -Wl,--warn-common -Wl,-z,relro -Wl,-z,now -pie -m64 -g
QEMU_LDFLAGS      -L$(BUILD_DIR)/dtc/libfdt
make              make
install           install
python            python -B (2.7.12)
slirp support     internal
smbd              /usr/sbin/smbd
module support    no
host CPU          x86_64
host big endian   no
target list       aarch64-softmmu alpha-softmmu arm-softmmu cris-softmmu
hppa-softmmu i386-softmmu lm32-softmmu m68k-softmmu microblaze-softmmu
microblazeel-softmmu mips-softmmu mips64-softmmu mips64el-softmmu
mipsel-softmmu moxie-softmmu nios2-softmmu or1k-softmmu ppc-softmmu
ppc64-softmmu riscv32-softmmu riscv64-softmmu s390x-softmmu sh4-softmmu
sh4eb-softmmu sparc-softmmu sparc64-softmmu tricore-softmmu
unicore32-softmmu x86_64-softmmu xtensa-softmmu xtensaeb-softmmu
aarch64-linux-user aarch64_be-linux-user alpha-linux-user arm-linux-user
armeb-linux-user cris-linux-user hppa-linux-user i386-linux-user
m68k-linux-user microblaze-linux-user microblazeel-linux-user
mips-linux-user mips64-linux-user mips64el-linux-user mipsel-linux-user
mipsn32-linux-user mipsn32el-linux-user nios2-linux-user or1k-linux-user
ppc-linux-user ppc64-linux-user ppc64abi32-linux-user ppc64le-linux-user
riscv32-linux-user riscv64-linux-user s390x-linux-user sh4-linux-user
sh4eb-linux-user sparc-linux-user sparc32plus-linux-user
sparc64-linux-user tilegx-linux-user x86_64-linux-user xtensa-linux-user
xtensaeb-linux-user
gprof enabled     no
sparse enabled    no
strip binaries    yes
profiler          no
static build      no
SDL support       no
SDL image support no
GTK support       no
GTK GL support    no
VTE support       no
TLS priority      NORMAL
GNUTLS support    no
libgcrypt         no
nettle            no
libtasn1          no
PAM               no
iconv support     yes
curses support    no
virgl support     no
curl support      no
mingw32 support   no
Audio drivers      oss
Block whitelist (rw)
Block whitelist (ro)
VirtFS support    no
Multipath support no
VNC support       yes
VNC SASL support  no
VNC JPEG support  no
VNC PNG support   no
xen support       no
brlapi support    no
bluez  support    no
Documentation     no
PIE               yes
vde support       no
netmap support    no
Linux AIO support no
ATTR/XATTR support yes
Install blobs     yes
KVM support       yes
HAX support       no
HVF support       no
WHPX support      no
TCG support       yes
TCG debug enabled no
TCG interpreter   no
malloc trim support yes
RDMA support      no
PVRDMA support    no
fdt support       git
membarrier        no
preadv support    yes
fdatasync         yes
madvise           yes
posix_madvise     yes
posix_memalign    yes
libcap-ng support no
vhost-net support yes
vhost-crypto support yes
vhost-scsi support yes
vhost-vsock support yes
vhost-user support yes
Trace backends    log
spice support     no
rbd support       no
xfsctl support    no
smartcard support no
libusb            no
usb net redir     no
OpenGL support    no
OpenGL dmabufs    no
libiscsi support  no
libnfs support    no
build guest agent yes
QGA VSS support   no
QGA w32 disk info no
QGA MSI support   no
seccomp support   no
coroutine backend ucontext
coroutine pool    yes
debug stack usage no
mutex debugging   no
crypto afalg      no
GlusterFS support no
gcov              gcov
gcov enabled      no
TPM support       yes
libssh support    no
QOM debugging     yes
Live block migration yes
lzo support       no
snappy support    no
bzip2 support     no
lzfse support     no
NUMA host support no
libxml2           no
tcmalloc support  no
jemalloc support  no
avx2 optimization yes
replication support yes
VxHS block device no
bochs support     yes
cloop support     yes
dmg support       yes
qcow v1 support   yes
vdi support       yes
vvfat support     yes
qed support       yes
parallels support yes
sheepdog support  yes
capstone          internal
docker            no
libpmem support   no
libudev           no
default devices   yes

warning: Python 2 support is deprecated
warning: Python 3 will be required for building future versions of QEMU

NOTE: cross-compilers enabled:  'cc' 'cc'

$ make
[...]
  GEN     util/trace.c
        CHK version_gen.h
         LEX convert-dtsv0-lexer.lex.c
make[1]: flex: Command not found
         BISON dtc-parser.tab.c
make[1]: bison: Command not found
         LEX dtc-lexer.lex.c
make[1]: flex: Command not found
  AR      libcapstone.a
ar: creating /tmp/qemu-4.1.0-rc0/capstone/libcapstone.a
[...]
  CC      mipsel-softmmu/trace/generated-helpers.o
  LINK    mipsel-softmmu/qemu-system-mipsel
[...]
  CC      mips64el-softmmu/target/mips/cp0_timer.o
  GEN     trace/generated-helpers.c
  CC      mips64el-softmmu/trace/control-target.o
  CC      mips64el-softmmu/trace/generated-helpers.o
  LINK    mips64el-softmmu/qemu-system-mips64el
[...]

$ wget
https://mipsdistros.mips.com/LinuxDistro/nanomips/kernels/v4.15.18-432-gb2eb9a8b07a1-20180627102142/generic_nano32r6el_page16k_up.xz

$ unxz generic_nano32r6el_page16k_up.xz

$ ./mipsel-softmmu/qemu-system-mipsel -M malta -cpu I7200 -kernel
generic_nano32r6el_page16k_up -append console=ttyS0 -nographic
[    0.000000] Linux version 4.15.18 (emubuild@mipscs567) (gcc version
6.3.0 (Codescape GNU Tools 2018.04-02 for nanoMIPS Linux)) #1 Wed Jun 27
11:13:09 PDT 2018
[    0.000000] GCRs appear to have been moved (expected them at 0x1fbf8000)!
[    0.000000] GCRs appear to have been moved (expected them at 0x1fbf8000)!
[    0.000000] CPU0 revision is: 00010000 (MIPS GENERIC QEMU)
[    0.000000] MIPS: machine is mti,malta
[    0.000000] Determined physical RAM map:
[    0.000000]  memory: 08000000 @ 00000000 (usable)
[    0.000000] earlycon: ns16550a0 at I/O port 0x3f8 (options '38400n8')
[...]

$ make check-tcg
[...]
  BUILD   TCG tests for mips-softmmu
  BUILD   mips guest-tests SKIPPED
  RUN     TCG tests for mips-softmmu
  RUN     tests for mips SKIPPED
  BUILD   TCG tests for mips64-softmmu
  BUILD   mips64 guest-tests SKIPPED
  RUN     TCG tests for mips64-softmmu
  RUN     tests for mips64 SKIPPED
  BUILD   TCG tests for mips64el-softmmu
  BUILD   mips64el guest-tests SKIPPED
  RUN     TCG tests for mips64el-softmmu
  RUN     tests for mips64el SKIPPED
  BUILD   TCG tests for mipsel-softmmu
  BUILD   mipsel guest-tests SKIPPED
  RUN     TCG tests for mipsel-softmmu
  RUN     tests for mipsel SKIPPED
[...]
  BUILD   x86_64 guest-tests with cc
  RUN     tests for x86_64
  TEST    test-mmap (default) on x86_64
  TEST    sha1 on x86_64
  TEST    linux-test on x86_64
  TEST    testthread on x86_64
  TEST    test-x86_64 on x86_64
  TEST    test-mmap (4096 byte pages) on x86_64
[...]
$

Ah, cross-target tests are skipped because I don't have Docker for
cross-building tests.

Let's see how you use them:

$ cat tests/tcg/mips/user/ase/msa/README
The tests in subdirectories of this directory are supposed to be
compiled for
mips64el MSA-enabled CPU (I6400, I6500), using an appropriate MIPS
toolchain.
For example:

/opt/img/bin/mips-img-linux-gnu-gcc <source file>                  \
-EL -static -mabi=64 -march=mips64r6 -mmsa  -o <executable file>

They are to be executed using QEMU user mode, using command line:

mips64el-linux-user/qemu-mips64el -cpu I6400 <executable file>
[...]

Googling I find this link:
https://www.mips.com/develop/tools/codescape-mips-sdk/

The following host platforms are recommended:
 Windows 10 (64-bit)
 Linux: Ubuntu 16.04 (64-bit) and CentOS 7 (64-bit)

Offline Installer
These are ~ 3Gbyte and include all components in one installer file.

OMG I'm not sure I want to continue with this...

Download in progress.

I already spent 2h on this today, I have to continue other tasks
meanwhile, I might continue later.

