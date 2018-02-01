Received: from eggs.gnu.org ([2001:4830:134:3::10]:41358)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eh95b-0008KW-Ln
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 02:15:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eh95W-0005i8-Nh
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 02:15:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35272)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1eh95W-0005hp-Go
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 02:15:14 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20180131144846.31697-1-armbru@redhat.com>
	<20180131144846.31697-3-armbru@redhat.com>
	<0d978583-1846-aced-b281-9227cfc5fe8e@redhat.com>
Date: Thu, 01 Feb 2018 08:15:12 +0100
In-Reply-To: <0d978583-1846-aced-b281-9227cfc5fe8e@redhat.com> (Eric Blake's
	message of "Wed, 31 Jan 2018 09:06:01 -0600")
Message-ID: <87bmh9rxj3.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 02/19] Clean up includes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, f4bug@amsat.org

Eric Blake <eblake@redhat.com> writes:

> On 01/31/2018 08:48 AM, Markus Armbruster wrote:
>> Clean up includes so that osdep.h is included first and headers
>> which it implies are not included manually.
>> 
>> This commit was created with scripts/clean-includes, with the change
>> to target/s390x/gen-features.c manually reverted, and blank lines
>> around deletions collapsed.
>
> Is it worth tweaking scripts/clean-includes to add gen-features.c to the
> whitelist of special cases (alongside *.inc.c, perhaps)?

Probably, but I'm in a bit of a time squeeze right now.

A naming convention for .c files that only compile when included into
something else would make sense.  Hmm, like *gasp* .h?

Offenders include crypto/cipher-*.c.  "git-grep '#include.*\.c'" coughs
up more candidates.

>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>
> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!
