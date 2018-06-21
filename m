Received: from eggs.gnu.org ([2001:4830:134:3::10]:45045)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <umangkk5@gmail.com>) id 1fW7NP-0007A4-0b
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 17:44:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <umangkk5@gmail.com>) id 1fW7NN-00028d-Gk
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 17:44:23 -0400
Received: from mail-pg0-x235.google.com ([2607:f8b0:400e:c05::235]:43475)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <umangkk5@gmail.com>) id 1fW7NN-00028D-0m
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 17:44:21 -0400
Received: by mail-pg0-x235.google.com with SMTP id a14-v6so1993783pgw.10
	for <qemu-devel@nongnu.org>; Thu, 21 Jun 2018 14:44:20 -0700 (PDT)
MIME-Version: 1.0
From: Umang Kakaiya <umangkk5@gmail.com>
Date: Thu, 21 Jun 2018 14:44:18 -0700
Message-ID: <CABi5iw=FM2yFzji4HKhAxG0fYmsGb+h5wYp5wJo-DYNgMHuihg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] Problem building QEMU with whpx support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, juterry@microsoft.com

Hi Justin,



We are trying to use QEMU on Windows Hyper-V environment with whpx enabled
for better performance. We were unable to build QEMU with WHPX support. We
used Ubuntu 18.04 server VM with two libraries (WinHv*.lib) from the latest
Windows 10 SDK to build QEMU and added '--enable-whpx' parameter in config.
But building is failing giving the following message:

The command to launch QEMU is as below,



$ ./configure --enable-whpx --enable-debug



The following error was output from the command line,

Error: User requested feature WinHvPlatform

       configure was not able to find it.

       WinHvEmulation is not installed.



We analyzed the issue and found that configure is unable to locate the
WinHvPlatform.h file.

As for providing WinHV*.lib files we tried following steps:

1. We set LD_LIB_PATH to point to the WinHV*.lib files.

2. We used --path_win_sdk option in configure to add the path to Windows
insider SDK.

3. We moved to Windows Environment and tried building QEMU with MSYS2 build
options according to steps mentioned in QEMU blog (Link
<https://wiki.qemu.org/index.php/Hosts/W32#Native_builds_with_MSYS2>)

But it didn't work because base qemu build itself fails. We then      tried
MingW64 to build QEMU but got the same error above with --enable-whpx.




We tried to find any documentation to provide exact steps in building QEMU
with whpx support but didn't make any progress. So there are three
questions:



1. Can we build QEMU with whpx packages on Ubuntu 18.04 or do we need to
use QEMU native build on Windows machine using MSYS2.

2. Where to keep the WinHV*.lib files in QEMU source directories so that
configure can locate the files for build.

3. Can you provide any links or reference to documentation on building QEMU
with whpx support with all dependency packages required.



Below is the configuration of the Hyper-V machine used for this experiment,



Windows OS: Windows Server Datacenter 2016

Windows edition: Server

Windows version: 1803 (OS build 17645.1042)

SDK version: 10.0.17686.0





Best Regards,

Umang
