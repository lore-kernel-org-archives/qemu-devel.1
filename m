Received: from eggs.gnu.org ([2001:4830:134:3::10]:35198)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fSkyk-00008R-BU
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 11:13:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fSkyj-00016K-FO
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 11:13:02 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60682 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fSkyj-00015v-9O
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 11:13:01 -0400
References: <20180611203712.12086-1-ehabkost@redhat.com>
	<a8426bf6-7531-6306-d1c6-bb4c6c2099cd@redhat.com>
	<20180612150153.GK7451@localhost.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6c9b3744-7323-cd1f-7b07-2b77df7ae80d@redhat.com>
Date: Tue, 12 Jun 2018 17:12:58 +0200
MIME-Version: 1.0
In-Reply-To: <20180612150153.GK7451@localhost.localdomain>
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

On 12/06/2018 17:01, Eduardo Habkost wrote:
>>>
>>> Remove OSPKE from the feature name array so users don't try to
>>> configure it manually.
>>>
>>> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
>> Yes, it's the same as OSXSAVE.  Thanks!
> CR4_OSXSAVE_MASK is automatically enabled on user-mode QEMU,
> though.
> 
> My question is if it would make any sense to enable CR4_PKE_MASK
> too.

If you mean OSPKE, then yes---if PKU is available.  Likewise, OSXSAVE
should only be enabled if XSAVE is available.

Paolo
