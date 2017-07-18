Received: from eggs.gnu.org ([2001:4830:134:3::10]:59987)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dXUdz-0000dv-Qg
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 11:42:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dXUdy-0006mF-VF
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 11:42:39 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <87379zhrhn.fsf@dusky.pond.sub.org>
	<1229e9b6-d675-ee15-ce98-6ee85a4f421b@redhat.com>
Date: Tue, 18 Jul 2017 17:42:30 +0200
In-Reply-To: <1229e9b6-d675-ee15-ce98-6ee85a4f421b@redhat.com> (Eric Blake's
	message of "Fri, 14 Jul 2017 12:38:50 -0500")
Message-ID: <87o9shrbtl.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] qapi: Stop abusing "special" values for something
 entirely different
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org

Eric Blake <eblake@redhat.com> writes:

> On 07/14/2017 12:12 PM, Markus Armbruster wrote:
>> 
>> Instead of the last part, I prefer either
>> 
>> * so we add a *new* value, such as JSON null.
>
> I like that idea.
>
>> 
>> 1. Stop abusing values the schema accepts, but are invalid to mean "do
>> something else entirely".
>> 
>> 2. Add a first class null type to QAPI.
>> 
>> 3. Turn MigrationParameters members tls-creds and tls-hostname into
>> alternate of str and null.  Deprecate "".
>> 
>> 4. Add a null member to alternate BlockdefRef.  Deprecate "".
>
> Back-compat concerns: would we still accept "" in place of null for a
> release or two?

Yes.

>                  Is it time to figure out how to add deprecation
> notices/events to QMP?

Yes, getting that in the next development cycle would be nice.

>                         Or would this be a clean break-over point (since
> introspection exists), where if introspection shows there is an
> alternate between string and null, then libvirt MUST use null instead of
> "" to get the desired semantics?

Feels unnecessarily harsh to me.

>> I got patches for 2., and I intend to work on 3. and 4.
>> 
>> Since this is "only" about "less than general and ugly", we may decide
>> to leave things as they are if my patches turn out even uglier.
>> 
>> Meanwhile, opinions?
>
> Not much time left for soft freeze (which kind of echoes the dilemma we
> had at 2.9).  Is this something you are aiming for in 2.10, or will it
> be all the harder to worry about back-compat (because we'll have two
> releases rather than one before we introduce the alternate-with-null
> semantics)?

Let's try to get it into 2.10.
