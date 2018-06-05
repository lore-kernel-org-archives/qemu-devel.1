Received: from eggs.gnu.org ([2001:4830:134:3::10]:52237)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fQI24-0007FC-CL
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 15:54:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fQI23-0004Xs-Hm
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 15:54:16 -0400
References: <20180524113251.GB4660@redhat.com>
	<d9bb2cb9-d9dc-8fe0-a767-10d9cbbab803@redhat.com>
	<20180528183058.GG2209@redhat.com>
	<20180528183833.GJ4580@localhost.localdomain>
	<20180528212054.GH2209@redhat.com> <20180528212510.GC4660@redhat.com>
	<20180529064415.GA4756@localhost.localdomain>
	<2b3eef00-f326-c1e6-0e4b-b7602646eec4@redhat.com>
	<20180605092159.GA2544@work-vm>
	<20180605190324.GA11372@localhost.localdomain>
	<20180605223934-mutt-send-email-mst@kernel.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a9fdbe0f-2c39-7da3-11f2-6752b74cce08@redhat.com>
Date: Tue, 5 Jun 2018 14:54:07 -0500
MIME-Version: 1.0
In-Reply-To: <20180605223934-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] storing machine data in qcow images?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org, "Richard W.M. Jones" <rjones@redhat.com>, stefanha@redhat.com, Max Reitz <mreitz@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On 06/05/2018 02:47 PM, Michael S. Tsirkin wrote:

>>> Layer 1:
>>>     The string shall always be a JSON 'object'; i.e. of the form
>>>      { "something": ... , "more": ... }
>>>
>>>     The key strings shall be non-null and non-empty and shall
>>>     be unique.

>>
>> I think it would be simpler if layer 0 simply provided a list of
>> names/value pairs, where names are ascii strings, and values are
>> binary data[1].  It would make layer 1 unnecessary, and allow (3)
>> and (4) to happen.
>>
>> [1] In other words, Rich's proposal of "named blobs":
>> https://www.mail-archive.com/qemu-block@nongnu.org/msg37856.html
> 
> I think simple is beautiful, too. But assuming they
> really are binary how are blobs encoded?
> Did binary really mean UTF-8 here?

Binary blobs can always be base64 encoded for representation within a 
valid JSON UTF-8 string (and we already have several QMP interfaces that 
utilize base64 encoding to pass through what is otherwise invalid 
UTF-8).  It does inflate things slightly compared to a format that 
allows a raw length coupled with raw data, but that is not necessarily a 
problem.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
