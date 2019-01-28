Received: from eggs.gnu.org ([209.51.188.92]:53736)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1go4Z8-0006fe-JC
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 05:54:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1go4Z7-0006wD-OB
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 05:54:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37564)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1go4Z7-0006vs-ET
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 05:54:57 -0500
References: <1548410831-19553-1-git-send-email-pbonzini@redhat.com>
	<1548410831-19553-48-git-send-email-pbonzini@redhat.com>
	<20190125130054.5814333c@x1.home>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0066005b-ee17-392c-2375-70ab7fa5ebac@redhat.com>
Date: Mon, 28 Jan 2019 11:54:50 +0100
MIME-Version: 1.0
In-Reply-To: <20190125130054.5814333c@x1.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 47/52] vfio: express vfio dependencies with
 Kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org, yang.zhong@intel.com, thuth@redhat.com

On 25/01/19 21:00, Alex Williamson wrote:
>>  
>> -config VFIO_SPAPR
>> -    bool
>> -    default y
>> -    depends on VFIO && LINUX && PSERIES
> 
> I can't say I really understand what happened with this through the
> course of the series.  In patch 27 spapr.o became obj-y, VFIO_SPAPR
> came about in patch 32, tweaked in patch 33, then removed in 47.

Oops, that's a rebasing issue that I messed out when I finally got
ppc64-softmmu to build with the series.  I initially assumed that
spapr.o was not needed for non-pseries machines, but as you say below it
is not stubbed yet if not needed.

> .PHONY: allnoconfig defconfig
> allnoconfig defconfig:
>         rm */config-devices.mak config-all-devices.mak
>         $(MAKE) MINIKCONF="$(MINIKCONF) --$<" config-all-devices.mak

This seemed to work here (besides the fact that "rm" should have been
"rm -f").  The makefile needs some work apparently.

Paolo
