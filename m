Received: from eggs.gnu.org ([2001:4830:134:3::10]:34619)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1er7Nf-0001O4-7s
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 14:27:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1er7Ne-00049q-Dg
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 14:27:11 -0500
References: <20180223235142.21501-1-jsnow@redhat.com>
	<20180223235142.21501-20-jsnow@redhat.com>
	<20180228182526.GN4855@localhost.localdomain>
	<d306211f-54f3-16bb-bbf9-bdf5ed99aeec@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <48ec8dcc-2d42-6fdc-3b59-6ad58400acc6@redhat.com>
Date: Wed, 28 Feb 2018 13:27:00 -0600
MIME-Version: 1.0
In-Reply-To: <d306211f-54f3-16bb-bbf9-bdf5ed99aeec@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [RFC v4 19/21] blockjobs: Expose
 manual property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Cc: jtc@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org

On 02/28/2018 01:20 PM, John Snow wrote:

>>> +    if (!backup->has_manual) {
>>> +        backup->manual = false;
>>> +    }
>>
>> I think this is unnecessary these days, NULL/0/false is the default
>> value for QMP/QAPI.
>>
> 
> That's what I get for cargo cult. Eric, confirm/deny? Should I remove
> the other auto-false defaults too?
> 
> Either we have them all or none of them for consistency.

Someday it would be nice to have QAPI provide decent non-0 defaults as 
desired.  But for now, Kevin is correct - the QAPI generator guarantees 
that you will have NULL/0/false values for 'has' anywhere that 'has_foo' 
is false.  We're less consistent on whether we ensure that we don't 
access 'foo' without checking 'has_foo' first, but if you want to 
simplify by relying on the default initialization to 0, you will not be 
the first person to do so.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
