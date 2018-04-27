Received: from eggs.gnu.org ([2001:4830:134:3::10]:49987)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wenchao.wang@linux.intel.com>) id 1fBu8v-0001Zf-V7
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 23:33:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wenchao.wang@linux.intel.com>) id 1fBu8s-0005yx-Qk
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 23:33:53 -0400
Received: from mga05.intel.com ([192.55.52.43]:18377)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wenchao.wang@linux.intel.com>)
	id 1fBu8s-0005vg-Eo
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 23:33:50 -0400
References: <2adfc981-9587-3b41-fcb9-f661c71f51c2@linux.intel.com>
	<DM5PR21MB0170B7D8E14270FF25868E23B68E0@DM5PR21MB0170.namprd21.prod.outlook.com>
From: Wang Wenchao <wenchao.wang@linux.intel.com>
Message-ID: <93092163-1199-28ff-6579-76e5ad8f1fc8@linux.intel.com>
Date: Fri, 27 Apr 2018 11:33:42 +0800
MIME-Version: 1.0
In-Reply-To: <DM5PR21MB0170B7D8E14270FF25868E23B68E0@DM5PR21MB0170.namprd21.prod.outlook.com>
Content-Language: en-US
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] Cannot launch QEMU with -accel whpx
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Justin Terry (VM)" <juterry@microsoft.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

Hi, Justin,

That hits the issue. QEMU can be launched with WHPX enabling. Great 
thanks for your reply.


Best Regards,
Wenchao

On 4/27/2018 2:06, Justin Terry (VM) wrote:
>
> Hey Wenchao,
>
> It looks like your specs should fully support running this. Did you by 
> chance forget to enable the Windows optional feature? Having the 
> lib/dll’s from the SDK isn’t all you need.
>
> Try:
>
> (admin) PS> Enable-WindowsOptionalFeature -Online -FeatureName 
> HypervisorPlatform
>
> (reboot the machine)
>
> > qemu-system-x86_64.exe -accel whpx …
>
> Let me know if that wasn’t the issue.
>
> Thanks,
>
> Justin
>
> *From:*Wang Wenchao <wenchao.wang@linux.intel.com>
> *Sent:* Thursday, April 26, 2018 3:47 AM
> *To:* Justin Terry (VM) <juterry@microsoft.com>
> *Cc:* qemu-devel@nongnu.org
> *Subject:* Cannot launch QEMU with -accel whpx
>
> Hi, Justin,
>
> We are interested in WHPX but haven't got it to work. We were able to 
> build QEMU with WHPX support. We used MSYS2 build environment plus two 
> libraries (WinHv*.lib) from the latest Windows 10 SDK Insider Preview 
> to build QEMU and added '--enable-whpx' parameter in config. But when 
> we ran it on Windows with Hyper-V on, QEMU failed to be launched.
>
> The command to launch QEMU is as below,
>
> > qemu-system-x86_64.exe -accel whpx
>
> The following errors were output from the command line,
>
> qemu-system-x86_64.exe: WHPX: No accelerator found, hr=00000000
> qemu-system-x86_64.exe: failed to initialize WHPX: No space left on device
>
> We analyzed the issue and found when invoking the Windows Hypervisor 
> Platform API WHvGetCapability(), it returned 
> whpx_cap.HypervisorPresent with FALSE and then WHPX failed to 
> initialize. Do you have any suggestion on that? Thanks.
>
> We build and run QEMU on the same machine. Below are its specs,
>
> Windows OS: Windows 10 Insider Preview
> Windows edition: Professional
> Windows version: 1803 (OS build 17133.1)
> SDK version: 10.0.17125.0
>
> Processor: Intel(R) Core(TM) i7-8550U CPU @ 1.80GHz 1.99GHz
> RAM: 8.00 GB
> System Type: 64-bit Operating System, x64-based processor
>
>
> Best Regards,
> Wenchao
>
