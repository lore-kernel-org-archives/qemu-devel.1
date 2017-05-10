Received: from eggs.gnu.org ([2001:4830:134:3::10]:45181)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d8TjP-000440-V3
	for qemu-devel@nongnu.org; Wed, 10 May 2017 11:40:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d8TjN-0006v2-DJ
	for qemu-devel@nongnu.org; Wed, 10 May 2017 11:40:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53038)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1d8TjN-0006uj-7F
	for qemu-devel@nongnu.org; Wed, 10 May 2017 11:40:49 -0400
References: <1494398933-8366-1-git-send-email-thuth@redhat.com>
	<20170510090841.GF31558@redhat.com>
	<e8f7410f-98d9-2e0e-b75d-0ff38fd81b35@redhat.com>
	<87tw4su3iw.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c5256efb-664d-0d5d-c519-4fc278091372@redhat.com>
Date: Wed, 10 May 2017 17:40:42 +0200
MIME-Version: 1.0
In-Reply-To: <87tw4su3iw.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] hw/i386: Deprecate the machines pc-0.10 to
 pc-0.15
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, kraxel@redhat.com, Richard Henderson <rth@twiddle.net>



On 10/05/2017 17:37, Markus Armbruster wrote:
> Distro vendors put in serious work to keep versions working for 5 - 10
> years.  We can't, and we don't.  All we do is try not to break things,
> which is nice, and helps the distro vendors some, but a far cry from
> anything I'd dare call "support".
> 
> Perhaps an argument could be made that us keeping to try for at least 5
> years would help distro vendors enough to be worthwhile.  Maybe, but
> color me skeptic.

It's the opposite.  Distro vendors care about it, so it is at least
plausible to have things work from 5 years back, even if we don't test it.

Of course there will be bugs and corner cases.

Paolo
