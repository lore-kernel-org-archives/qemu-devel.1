Received: from eggs.gnu.org ([2001:4830:134:3::10]:42000)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gL3kM-0002S7-TR
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 05:10:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gL3kH-0004xM-Fg
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 05:10:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56228)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gL3kC-0004rX-21
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 05:10:29 -0500
References: <dd68d3e8-6448-3a67-3212-fd3d3bfba2e2@redhat.com>
	<20181107192414.GH12503@habkost.net>
	<c6bbfeb8-53c5-0e0c-cf36-14e586cfb581@redhat.com>
	<a0decaa7-d83b-b0ad-60ea-aa0890feb905@redhat.com>
	<20181108130648.GJ12503@habkost.net>
	<95a93d53-f87d-bd96-9363-582c4eae4160@redhat.com>
	<20181108171437.GM12503@habkost.net>
	<dda55f75-58d3-111c-4f43-99a9f686981e@redhat.com>
	<20181108184242.GQ12503@habkost.net>
	<2f4793c3-5509-1def-3157-02bc0d9bbe26@redhat.com>
	<20181108210047.GU12503@habkost.net>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <00978318-b3b4-bd00-25c5-7b843cc09f13@redhat.com>
Date: Fri, 9 Nov 2018 11:10:21 +0100
MIME-Version: 1.0
In-Reply-To: <20181108210047.GU12503@habkost.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] QEMU and Kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, Samuel Ortiz <sameo@linux.intel.com>, "Zhong, Yang" <yang.zhong@intel.com>, Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

On 08/11/2018 22:00, Eduardo Habkost wrote:
> Understood.  My interpretation of "target" was just "a QEMU
> binary".  In other words, I thought we were talking about
> anything that could be compiled in/out from a specific QEMU
> binary.

The idea is "target" as opposed to "host".

> Do you have a specific reason to restrict the scope to only
> guest-visible effects?  Is this just a way to reduce the effort
> required for the task, or there are other caveats I'm missing?

Because that's what default-configs/ is for---producing
config-devices.mak.  IOW it's mostly to reduce the scope, but also
because there are differences between config-devices.mak (produced from
default-configs/) and config-{host,target}.h (produced by configure).

In particular, config-host.h and config-target.h are header files, but
config-devices.mak is not because the same file is linked into multiple
QEMU binaries that can and will enable different devices.  The only way
to use a hypothetical config-devices.h would be to move its users from
common-obj-y to obj-y.

Paolo
