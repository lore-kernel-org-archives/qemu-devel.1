Received: from eggs.gnu.org ([2001:4830:134:3::10]:55087)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gJi3U-0004xm-FW
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 11:48:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gJi3P-0005pO-PB
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 11:48:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41254)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gJi3O-0005jg-El
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 11:48:42 -0500
References: <20181023152306.3123-1-david@redhat.com>
	<20181023152306.3123-2-david@redhat.com>
	<87pnvqdvsj.fsf@dusky.pond.sub.org>
	<e8fe86a1-d075-2ea8-d1f4-e08e5dceee07@redhat.com>
	<875zxingqn.fsf@dusky.pond.sub.org>
	<440eb166-73d1-77b6-5dd9-66a0abd7d665@redhat.com>
	<87muqn5ydc.fsf@dusky.pond.sub.org>
	<1ec41fe2-d4b4-fce2-9381-818ee3356409@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e953e363-dfc3-ef93-3b38-b285f8a9b034@redhat.com>
Date: Mon, 5 Nov 2018 10:48:11 -0600
MIME-Version: 1.0
In-Reply-To: <1ec41fe2-d4b4-fce2-9381-818ee3356409@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 1/7] qapi: use qemu_strtoi64() in
 parse_str
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

On 11/5/18 9:53 AM, David Hildenbrand wrote:

>> When I first looked at the ranges stuff in the string input visitor, I
>> felt the urge to clean it up, then sat on my hands until it passed.
>>
>> The rest is reasonable once you understand how it works.  The learning
>> curve is less than pleasant, though.
>>
> 
> Maybe I'll pick this up again when I have more time to invest.
> 
> The general concept
> 
> 1. of having an input visitor that is able to parse different types
> (expected by e.g. a property) sounds sane to me.
> 
> 2. of having a list of *something*, assuming it is int64_t, and assuming
> it is to be parsed into a list of ranges sounds completely broken to me.
> 
> I was not even able to find an example QEMU comand line for 2. Is this
> maybe some very old code that nobody actually uses anymore? (who uses
> list of ranges?)

I believe that the -numa node,cpus=first-last code is an example use of 
a list of ranges.  At any rate, tests/test-string-input-visitor.c has 
test_visitor_in_intList() to ensure we don't break back-compat with the 
existing clients that use ranges, as awkward as they may be.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
