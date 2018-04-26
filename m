Received: from eggs.gnu.org ([2001:4830:134:3::10]:39599)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wenchao.wang@linux.intel.com>) id 1fBeQs-0002g7-LP
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 06:47:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wenchao.wang@linux.intel.com>) id 1fBeQp-0001PG-JS
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 06:47:22 -0400
Received: from mga07.intel.com ([134.134.136.100]:60855)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wenchao.wang@linux.intel.com>)
	id 1fBeQp-0001OS-9K
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 06:47:19 -0400
From: Wang Wenchao <wenchao.wang@linux.intel.com>
Message-ID: <2adfc981-9587-3b41-fcb9-f661c71f51c2@linux.intel.com>
Date: Thu, 26 Apr 2018 18:47:15 +0800
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] Cannot launch QEMU with -accel whpx
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: juterry@microsoft.com
Cc: qemu-devel@nongnu.org

Hi, Justin,

We are interested in WHPX but haven't got it to work. We were able to 
build QEMU with WHPX support. We used MSYS2 build environment plus two 
libraries (WinHv*.lib) from the latest Windows 10 SDK Insider Preview to 
build QEMU and added '--enable-whpx' parameter in config. But when we 
ran it on Windows with Hyper-V on, QEMU failed to be launched.

The command to launch QEMU is as below,

 > qemu-system-x86_64.exe -accel whpx

The following errors were output from the command line,

qemu-system-x86_64.exe: WHPX: No accelerator found, hr=00000000
qemu-system-x86_64.exe: failed to initialize WHPX: No space left on device

We analyzed the issue and found when invoking the Windows Hypervisor 
Platform API WHvGetCapability(), it returned whpx_cap.HypervisorPresent 
with FALSE and then WHPX failed to initialize. Do you have any 
suggestion on that? Thanks.

We build and run QEMU on the same machine. Below are its specs,

Windows OS: Windows 10 Insider Preview
Windows edition: Professional
Windows version: 1803 (OS build 17133.1)
SDK version: 10.0.17125.0

Processor: Intel(R) Core(TM) i7-8550U CPU @ 1.80GHz 1.99GHz
RAM: 8.00 GB
System Type: 64-bit Operating System, x64-based processor


Best Regards,
Wenchao
