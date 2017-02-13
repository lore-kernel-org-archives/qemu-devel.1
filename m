Received: from eggs.gnu.org ([2001:4830:134:3::10]:49680)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cdFES-0004SS-V4
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 06:55:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cdFEN-0006iJ-UJ
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 06:55:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57826)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cdFEN-0006iA-OG
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 06:55:43 -0500
References: <20170213095148.25500-1-lma@suse.com>
	<d244306c-36df-bb23-3dad-6706545e2476@redhat.com>
	<58A20ED302000062000CF528@prv-mh.provo.novell.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8067935c-fcc6-8b52-d4c8-19813a390ec8@redhat.com>
Date: Mon, 13 Feb 2017 12:55:37 +0100
MIME-Version: 1.0
In-Reply-To: <58A20ED302000062000CF528@prv-mh.provo.novell.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel]
 =?utf-8?b?562U5aSN77yaIFJlOiAgW1BBVENIIHYyIFJFU0VO?=
 =?utf-8?q?D=5D_Makefile=3A_Fix_owner_and_group_for_qemu-version=2Eh=2Etmp?=
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Lin Ma <lma@suse.com>, qemu-devel@nongnu.org
Cc: famz@redhat.com, stefanha@redhat.com



On 13/02/2017 12:53, Lin Ma wrote:
> 
> The content of qemu-version.h recorded the git head info of last build.
> After 'git pull && make ', Because the content of qemu-version.h.tmp is
> generated
> based on the lastest git describe, Now this .h.tmp and the old .h aren't
> consistent,
> So this .h.tmp will be renamed to qemu-version.h.
> Then during 'sudo make install', because there is no .h.tmp any more, a
> new one will be
> generated with privileged permissions.

So is the bug that the "cmp || mv" should be changed to "if cmp ...;
then mv ...; else rm ..."?

Paolo
