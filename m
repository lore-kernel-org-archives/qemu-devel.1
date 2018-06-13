Received: from eggs.gnu.org ([2001:4830:134:3::10]:46038)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fT9XS-0001pJ-61
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 13:26:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fT9XN-0008L7-4r
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 13:26:30 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57364 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fT9XM-0008Iy-UX
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 13:26:25 -0400
References: <20180611203712.12086-1-ehabkost@redhat.com>
	<a8426bf6-7531-6306-d1c6-bb4c6c2099cd@redhat.com>
	<20180612150153.GK7451@localhost.localdomain>
	<6c9b3744-7323-cd1f-7b07-2b77df7ae80d@redhat.com>
	<20180612182541.GN7451@localhost.localdomain>
	<b93cd6e5-bb2e-b932-bc68-da5c314924a2@redhat.com>
	<20180613171607.GB7451@localhost.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <05f69c85-af96-a53a-a534-ce8f83f7249a@redhat.com>
Date: Wed, 13 Jun 2018 19:26:14 +0200
MIME-Version: 1.0
In-Reply-To: <20180613171607.GB7451@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH] i386: Remove ospke CPUID flag name
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>

On 13/06/2018 19:16, Eduardo Habkost wrote:
>> Second, for user-mode emulation it makes sense to allow flipping of
>> OSPKE and OSXSAVE, because that corresponds to different behaviors of
>> the underlying kernels.  There have been bugs in fact with programs that
>> incorrectly tested XSAVE instead of OSXSAVE, so it's worthwhile to let
>> the user test both configurations.
>
> However, "-cpu ...,-osxsave" has no effect today (user-mode QEMU
> unconditionally sets OSXSAVE), so that would be a new feature.

Yes, understood.

Paolo

> I assume this means I don't need to drop the osxsave patch from
> my queue, either.
> 
>> So to sum up, the default for QEMU user-mode emulation should be
>> OSXSAVE=XSAVE and OSPKE=0.
> Thanks!
