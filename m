Received: from eggs.gnu.org ([2001:4830:134:3::10]:43665)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cnITf-0000AD-QJ
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 01:25:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cnITc-0002uz-MQ
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 01:25:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42680)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cnITc-0002uR-Gs
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 01:25:00 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 64A20C0467CE
	for <qemu-devel@nongnu.org>; Mon, 13 Mar 2017 05:24:59 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <CANHSq5DhUak9fVpvjG=VyeetP7VQudHwyEa4VevC21BuieSstw@mail.gmail.com>
	<20170303103919.GA2439@work-vm> <87o9xizhs1.fsf@dusky.pond.sub.org>
	<CANHSq5B4t8g3sDc4m+_Uc9+ya=yCpDK-t3tdd5d=RO-YH5r87w@mail.gmail.com>
Date: Mon, 13 Mar 2017 06:24:56 +0100
In-Reply-To: <CANHSq5B4t8g3sDc4m+_Uc9+ya=yCpDK-t3tdd5d=RO-YH5r87w@mail.gmail.com>
	(Germano Veit Michel's message of "Mon, 13 Mar 2017 12:59:33 +1000")
Message-ID: <87k27tn3yv.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH V2] migration: expose qemu_announce_self()
 via qmp
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Germano Veit Michel <germano@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, Juan Jose Quintela Carreira <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org

Germano Veit Michel <germano@redhat.com> writes:

> On Fri, Mar 3, 2017 at 10:06 PM, Markus Armbruster <armbru@redhat.com> wrote:
>>>> diff --git a/qapi-schema.json b/qapi-schema.json
>>>> index baa0d26..0d9bffd 100644
>>>> --- a/qapi-schema.json
>>>> +++ b/qapi-schema.json
>>>> @@ -6080,3 +6080,21 @@
>>>>  #
>>>>  ##
>>>>  { 'command': 'query-hotpluggable-cpus', 'returns': ['HotpluggableCPU'] }
>>>> +
>>>> +##
>>>> +# @announce-self:
>>>> +#
>>>> +# Trigger generation of broadcast RARP frames to update network switches.
>>>> +# This can be useful when network bonds fail-over the active slave.
>>>> +#
>>>> +# Arguments: None.
>>
>> Please drop this line.
>>
>>>> +#
>>>> +# Example:
>>>> +#
>>>> +# -> { "execute": "announce-self" }
>>>> +# <- { "return": {} }
>>>> +#
>>>> +# Since: 2.9
>>>> +##
>>>> +{ 'command': 'announce-self' }
>>>> +
>>
>
> Hi Markus,
>
> Are you talking about the whole example section or just the empty line
> at the end?

The "Arguments: None" line.

[...]
