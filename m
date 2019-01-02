Received: from eggs.gnu.org ([208.118.235.92]:48120)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tao3.xu@intel.com>) id 1geVEP-0008QI-2E
	for qemu-devel@nongnu.org; Tue, 01 Jan 2019 20:22:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tao3.xu@intel.com>) id 1geVEL-00013Z-OX
	for qemu-devel@nongnu.org; Tue, 01 Jan 2019 20:22:00 -0500
Received: from mga18.intel.com ([134.134.136.126]:40345)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tao3.xu@intel.com>) id 1geVEL-0000xj-GH
	for qemu-devel@nongnu.org; Tue, 01 Jan 2019 20:21:57 -0500
References: <20181227024304.12182-1-tao3.xu@intel.com>
From: Tao Xu <tao3.xu@intel.com>
Message-ID: <a608166f-c00e-0699-839e-165b30855c9e@intel.com>
Date: Wed, 2 Jan 2019 09:20:27 +0800
MIME-Version: 1.0
In-Reply-To: <20181227024304.12182-1-tao3.xu@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 0/2] Add MSR based features on Cascadelake
 CPU model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com
Cc: qemu-devel@nongnu.org, robert.hu@linux.intel.com, mark.kanda@oracle.com

Hi Eduardo/Paolo,

Do you have any comments about these patches?

Thanks
Tao

On 12/27/18 10:43 AM, Tao Xu wrote:
> These patches update the stepping and add some MSR based features
> enumerated by ARCH_CAPABILITIES on Cascadelake-Server CPU model.
>
> Tao Xu (2):
>    i386: Update stepping of Cascadelake-Server
>    i386: Add some MSR based features on Cascadelake-Server CPU model
>
>   include/hw/i386/pc.h | 20 ++++++++++++++++++++
>   target/i386/cpu.c    |  8 ++++++--
>   2 files changed, 26 insertions(+), 2 deletions(-)
>
