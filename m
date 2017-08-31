Received: from eggs.gnu.org ([2001:4830:134:3::10]:52545)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dnJEg-00012X-71
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 02:45:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dnJEf-0007c1-DC
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 02:45:54 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <cover.1504112256.git.jcody@redhat.com>
	<fc2539281a00353777c10f37dea6ccdb6aae4285.1504112256.git.jcody@redhat.com>
	<20170830172413.GA9720@localhost.localdomain>
	<4f2efa42-4a81-9890-497f-123c2b9a946c@redhat.com>
Date: Thu, 31 Aug 2017 08:45:40 +0200
In-Reply-To: <4f2efa42-4a81-9890-497f-123c2b9a946c@redhat.com> (Eric Blake's
	message of "Wed, 30 Aug 2017 14:23:33 -0500")
Message-ID: <877exki6az.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 2/3] block-jobs: Optionally unregister
 live block operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Jeff Cody <jcody@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org, peterx@redhat.com, dgilbert@redhat.com, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, mrezanin@redhat.com, jsnow@redhat.com

Eric Blake <eblake@redhat.com> writes:

> On 08/30/2017 12:24 PM, Eduardo Habkost wrote:
>> On Wed, Aug 30, 2017 at 01:01:41PM -0400, Jeff Cody wrote:
>>> From: Jeffrey Cody <jcody@redhat.com>
>>>
>>> If configured without live block operations enabled, unregister the
>>> live block operation commands.
>>>
>>> Signed-off-by: Jeff Cody <jcody@redhat.com>
>>> ---
>>>  monitor.c | 16 ++++++++++++++++
>>>  1 file changed, 16 insertions(+)
>>>
>
>> 
>> I suggest using the new mechanisms added by:
>> 
>>   [PATCH 00/26] qapi: add #if pre-processor conditions to generated code
>
> Those haven't landed yet, but as both series are proposed for 2.11, I
> indeed agree that basing this series on top of that one will be a bit
> cleaner.

Rebasing shouldn't be hard.  However, we then have to hold it until the
QAPI series lands.  I don't think holding is necessary, as the conflicts
between the two are obvious, and should be straightforward to resolve.
