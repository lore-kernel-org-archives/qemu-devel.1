Received: from eggs.gnu.org ([209.51.188.92]:39142)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gn3JQ-0003Xs-Hr
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 10:22:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gn3JL-0002Yu-Ab
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 10:22:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45688)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gn3JL-0002YC-0b
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 10:22:27 -0500
References: <1548410831-19553-1-git-send-email-pbonzini@redhat.com>
	<1548410831-19553-3-git-send-email-pbonzini@redhat.com>
	<8710ddae-0316-f020-de18-442e8a7fb324@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <06768e9a-8149-7173-b44a-0db7f51fccbf@redhat.com>
Date: Fri, 25 Jan 2019 16:22:17 +0100
MIME-Version: 1.0
In-Reply-To: <8710ddae-0316-f020-de18-442e8a7fb324@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 02/52] ide: split ioport registration to a
 separate file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: yang.zhong@intel.com, John Snow <jsnow@redhat.com>

On 25/01/19 15:53, Thomas Huth wrote:
> Since the ioport code clearly depends on ISA, I think you could also
> simply do:
> 
> common-obj-$(CONFIG_ISA_BUS) += ioport.o
> 
> instead of adding it to three different lines here?

No, because that would add the function even if !IDE && ISA_BUS, causing
undefined symbols from ide_ioport_read and friends.

> Well, the linker should be smart enough to deal with multiple entries,
> so it's likely just a matter of taste.

It's not the linker, rules.mak explicitly drops duplicates.
