Received: from eggs.gnu.org ([2001:4830:134:3::10]:44264)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1cG9Wb-0001g7-Sx
	for qemu-devel@nongnu.org; Sun, 11 Dec 2016 14:11:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1cG9WW-0000CO-U9
	for qemu-devel@nongnu.org; Sun, 11 Dec 2016 14:11:05 -0500
Received: from mail-yw0-f195.google.com ([209.85.161.195]:34705)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bobby.prani@gmail.com>)
	id 1cG9WW-0008Pn-P3
	for qemu-devel@nongnu.org; Sun, 11 Dec 2016 14:11:00 -0500
Received: by mail-yw0-f195.google.com with SMTP id a10so6065745ywa.1
	for <qemu-devel@nongnu.org>; Sun, 11 Dec 2016 11:10:39 -0800 (PST)
From: Pranith Kumar <bobby.prani@gmail.com>
Date: Sun, 11 Dec 2016 14:09:36 -0500
Message-ID: <87lgvm1dvz.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] aarch64-linux-user compilation error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org

Hi,

I am getting a strange compilation error lately for aarch64-linux-user. I
think it is somehow related to TYPE_PTRVOID handling but my investigation has
not led to anything concrete. I think this is a compiler error since the build
passes on an other system with gcc-6.

Info: ubuntu 16.04 x86_64 system

$ gcc --version
gcc (Ubuntu 5.4.1-2ubuntu1~16.04) 5.4.1 20160904

Error:
/home/pranith/devops/code/qemu/linux-user/ioctls.h:224:9: error: ‘SNDCTL_DSP_MAPINBUF’ undeclared here (not in a function)
   IOCTL(SNDCTL_DSP_MAPINBUF, IOC_R, MK_PTR(MK_STRUCT(STRUCT_buffmem_desc)))
         ^
/home/pranith/devops/code/qemu/linux-user/syscall.c:5453:23: note: in definition of macro ‘IOCTL’
     { TARGET_ ## cmd, cmd, #cmd, access, 0, {  __VA_ARGS__ } },
                       ^
/home/pranith/devops/code/qemu/linux-user/ioctls.h:225:9: error: ‘SNDCTL_DSP_MAPOUTBUF’ undeclared here (not in a function)
   IOCTL(SNDCTL_DSP_MAPOUTBUF, IOC_R, MK_PTR(MK_STRUCT(STRUCT_buffmem_desc)))
         ^
/home/pranith/devops/code/qemu/linux-user/syscall.c:5453:23: note: in definition of macro ‘IOCTL’
     { TARGET_ ## cmd, cmd, #cmd, access, 0, {  __VA_ARGS__ } },
                       ^
/home/pranith/devops/code/qemu/linux-user/ioctls.h:280:9: error: ‘SOUND_MIXER_ACCESS’ undeclared here (not in a function)
   IOCTL(SOUND_MIXER_ACCESS, 0, TYPE_PTRVOID)
         ^
/home/pranith/devops/code/qemu/linux-user/syscall.c:5453:23: note: in definition of macro ‘IOCTL’
     { TARGET_ ## cmd, cmd, #cmd, access, 0, {  __VA_ARGS__ } },
                       ^
/home/pranith/devops/code/qemu/rules.mak:60: recipe for target 'linux-user/syscall.o' failed

-- 
Pranith
