Received: from eggs.gnu.org ([2001:4830:134:3::10]:58980)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1diCp9-0004XM-Qg
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 00:54:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1diCp8-0000wO-VM
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 00:54:27 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170814215748.5158-1-ehabkost@redhat.com>
	<20170814215748.5158-9-ehabkost@redhat.com>
	<7327f3f6-16fb-e9c6-4f2a-eed6144f2282@redhat.com>
Date: Thu, 17 Aug 2017 06:54:10 +0200
In-Reply-To: <7327f3f6-16fb-e9c6-4f2a-eed6144f2282@redhat.com> (John Snow's
	message of "Wed, 16 Aug 2017 17:46:18 -0400")
Message-ID: <87mv6yssjx.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [RFC v4 08/13] ide: enumerate_slots implementation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Laine Stump <laine@redhat.com>, qemu-block@nongnu.org

John Snow <jsnow@redhat.com> writes:

> On 08/14/2017 05:57 PM, Eduardo Habkost wrote:
>> Example output when using "-machine q35":
>> 
>>   {
>>     "available": true,
>>     "count": 1,
>>     "device-types": [
>>       "ide-device"
>>     ],
>>     "hotpluggable": false,
>>     "opts": [
>>       { "option": "unit", "values": 0 },
>>       { "option": "bus", "values": "ide.2" }
>>     ],
>>     "opts-complete": true
>>   }
>>   {
>>     "available": false,
>>     "count": 1,
>>     "device": "/machine/unattached/device[19]",
>>     "device-types": [
>>       "ide-device"
>>     ],
>>     "hotpluggable": false,
>>     "opts": [
>>       { "option": "unit", "values": 1 },
>>       { "option": "bus", "values": "ide.2" } ],
>>     "opts-complete": true
>>   }
>>   {
>>     "available": true,
>>     "count": 10,
>>     "device-types": [
>>       "ide-device"
>>     ],
>>     "hotpluggable": false,
>>     "opts": [
>>       { "option": "unit", "values": [ [ 0, 1 ] ] },
>
> Hm, these unit values aren't really correct -- we do not support
> primary/secondary semantics for IDE buses on the AHCI device. I guess
> they technically exist, but you cannot use them for anything.
>
> Should I do something to "disable" or otherwise hide the unusable
> secondary unit slots for AHCI devices?

I think that would make this introspection more useful.
