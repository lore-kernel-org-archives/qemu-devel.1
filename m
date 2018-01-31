Received: from eggs.gnu.org ([2001:4830:134:3::10]:37210)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1egw5a-0004xE-AZ
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 12:22:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1egw5W-0001sU-8t
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 12:22:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42230)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1egw5W-0001sD-2P
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 12:22:22 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20180119050906.18930-1-aik@ozlabs.ru>
	<20180119051926.GI30352@umbus.fritz.box>
	<6a3fac69-c1e5-36cf-4781-5bb82b890efa@ozlabs.ru>
	<1516372482.3278.29.camel@redhat.com>
	<1516702111.31897.2.camel@redhat.com> <20180123112025.GI11419@umbus>
	<1516709019.31897.4.camel@redhat.com> <20180123124922.GB14832@umbus>
	<52a52f21-2946-b004-17be-53178ae60a08@ozlabs.ru>
Date: Wed, 31 Jan 2018 18:22:19 +0100
In-Reply-To: <52a52f21-2946-b004-17be-53178ae60a08@ozlabs.ru> (Alexey
	Kardashevskiy's message of "Wed, 31 Jan 2018 20:03:21 +1100")
Message-ID: <87wozyueno.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [RFC PATCH qemu] qmp: Add qom-list-properties to
 list QOM object properties
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: David Gibson <david@gibson.dropbear.id.au>, Andrea Bolognani <abologna@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

Alexey Kardashevskiy <aik@ozlabs.ru> writes:

> On 23/01/18 23:49, David Gibson wrote:
>> On Tue, Jan 23, 2018 at 01:03:39PM +0100, Andrea Bolognani wrote:
>>> On Tue, 2018-01-23 at 22:20 +1100, David Gibson wrote:
>>>>> David, I know you're busy with linux.conf.au, but it would be
>>>>> really helpful if you could carve out five minutes to look over
>>>>> Alexey's proposal again, with my reply above in mind, and let us
>>>>> know whether it looks a reasonable design. Doesn't have to be a
>>>>> review, just a quick feedback on the high-level idea.
>>>>
>>>> It looks ok, I think, but I don't think I'm really the right person to
>>>> ask.  I do wonder if creating a throwaway instance could cause
>>>> trouble, especially for something like machine that might well have
>>>> gotten away with having global side-effects in the past.  I think we
>>>> need to talk with someone who knows more about qom and qapi - Markus
>>>> seems the obvious choice.
>>>
>>> Good point. CC'ing Markus to try and grab his attention :)
>> 
>> It's also occurred to me that making a spapr specific approach to this
>> might not be quite as horrible as I initially thought.  The
>> capabilities table is global (and immutable) so coding up a
>> "get-spapr-caps" qapi entry point which encodes the stuff there into
>> json giving the names and allowed values of each cap would be fairly
>> straightforward.
>> 
>> Accurately retreiving default values would be trickier, not sure if
>> that's important or not.
>
>
>
> So, do we want to push it further? Markus has not reacted, added Paolo.
>
> http://patchwork.ozlabs.org/patch/863325/

I now have.  Sorry for the long delay.
