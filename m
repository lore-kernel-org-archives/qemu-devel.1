Received: from eggs.gnu.org ([2001:4830:134:3::10]:48825)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gX6EH-000506-W4
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 10:15:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gX6EE-0000yl-DY
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 10:15:17 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38288)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gX6EE-0000xs-10
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 10:15:14 -0500
Received: by mail-wm1-f66.google.com with SMTP id m22so6367792wml.3
	for <qemu-devel@nongnu.org>; Wed, 12 Dec 2018 07:15:13 -0800 (PST)
References: <1543851204-41186-1-git-send-email-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <708deeee-7d30-625b-ede3-2d4af6fcd0ba@redhat.com>
Date: Wed, 12 Dec 2018 16:15:10 +0100
MIME-Version: 1.0
In-Reply-To: <1543851204-41186-1-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-4.0 00/71] qtest: qgraph driver
 framework
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>, Laurent Vivier <laurent@vivier.eu>

Hi Paolo,

On 12/3/18 4:32 PM, Paolo Bonzini wrote:
> Patches 1-14 are actually a refactoring of vhost and vhost-user-test so
> that it can be "qtested" on all targets that support virtio-net.
> 
> Patches 15-18 are other small refactorings to the libqos library and fixes
> to the Makefile.
> 
> Patch 19 is the framework, including unit tests, while the rest is conversions
> of existing tests.  We tried to pick tests that used a mix of features of
> qtest, and that cover as many use cases as possible within qgraph. 
> In particular:
> 
> - sdhci-test was the motivating example for the duplication between
>   PCI and MMIO versions of the same devices, so it come first
> 
> - all virtio tests were converted, since they also have both MMIO and
>   PCI variants and they taught us a lot about modeling devices within
>   qgraph
> 
> - all PCI devices that had "nop" tests only were converted, so that they
>   can avoid defining their copy of the test, and can instead use a
>   common test
> 
> - finally, three more PCI devices were converted as an example - e1000e,
>   nvme and megasas
> 
> This submission includes quite a few changes and cleanups that we did
> not manage to complete before Emanuele restarted classes, but this
> is almost entirely his baby; don't be fooled by the number of patches
> authored by him vs. myself.  I have noted my changes to the framework
> in the commit message to patch 19, to help people that followed the
> previous submissions; apart from that my changes consist of porting
> vhost-user-test and turning the nop tests into generic PCI and virtio
> tests (even though Emanuele had done the conversion to qgraph, he had
> left the tests in the nodes due to lack of time).

I'v tested the series and am quite happy with it.
I did not notice anything particular that could block it.
I'll send some comments in few patches that often apply to various patches.

Series:
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

Regards,

Phil.
