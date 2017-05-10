Received: from eggs.gnu.org ([2001:4830:134:3::10]:43944)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d8Tg8-0002KN-Rk
	for qemu-devel@nongnu.org; Wed, 10 May 2017 11:37:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d8Tg6-0005BK-9L
	for qemu-devel@nongnu.org; Wed, 10 May 2017 11:37:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50820)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1d8Tg6-00059r-3G
	for qemu-devel@nongnu.org; Wed, 10 May 2017 11:37:26 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1494398933-8366-1-git-send-email-thuth@redhat.com>
	<20170510090841.GF31558@redhat.com>
	<e8f7410f-98d9-2e0e-b75d-0ff38fd81b35@redhat.com>
Date: Wed, 10 May 2017 17:37:11 +0200
In-Reply-To: <e8f7410f-98d9-2e0e-b75d-0ff38fd81b35@redhat.com> (Thomas Huth's
	message of "Wed, 10 May 2017 12:05:16 +0200")
Message-ID: <87tw4su3iw.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
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
To: Thomas Huth <thuth@redhat.com>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, kraxel@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

Thomas Huth <thuth@redhat.com> writes:

> On 10.05.2017 11:08, Daniel P. Berrange wrote:
>> On Wed, May 10, 2017 at 08:48:53AM +0200, Thomas Huth wrote:
[...]
>> Also unless we're going to get more serious about automated testing to
>> validate machine type compatibility between *all* previously releases,
>> I think that 6 years / 18 releases is too long a time to have any
>> confidence in migration compatibility between versions.

Seconded.

> Distro vendors often offer 5 - 10 years support for certain versions of
> their Linux distros, so I think we should at least support 5 years, too.

Non sequitur.

Distro vendors put in serious work to keep versions working for 5 - 10
years.  We can't, and we don't.  All we do is try not to break things,
which is nice, and helps the distro vendors some, but a far cry from
anything I'd dare call "support".

Perhaps an argument could be made that us keeping to try for at least 5
years would help distro vendors enough to be worthwhile.  Maybe, but
color me skeptic.

>> IOW, I think you should be more aggressive in culling old machine types
>> that this patch is...
>
> Actually, I like the idea of using the major release versions for
> defining the set of removal - hoping that we will do a v3.0 next year
> which then would support the previous two major release versions 1.x and
> 2.x, but drops support for the 0.xx versions completely ...

I wouldn't put *that* much weight into our past version numbers.  If I
remember correctly, there was no more to 1.0 than a feeling of "this 0.x
thing is getting ridiculous".
