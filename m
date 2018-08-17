Received: from eggs.gnu.org ([2001:4830:134:3::10]:33840)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fqfpO-0007Mt-Vm
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 10:34:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fqfpL-0002d7-HT
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 10:34:14 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58008 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fqfpL-0002cq-AM
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 10:34:11 -0400
References: <20180808120334.10970-1-armbru@redhat.com>
	<20180808120334.10970-57-armbru@redhat.com>
	<0b4553ab-1938-0632-89a4-fa77d0518d76@redhat.com>
	<87bma12xtt.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <45ee52c0-a7e8-d4d0-467a-87a1d07dea21@redhat.com>
Date: Fri, 17 Aug 2018 09:34:06 -0500
MIME-Version: 1.0
In-Reply-To: <87bma12xtt.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 56/56] docs/interop/qmp-spec: How to force
 known good parser state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com

On 08/17/2018 03:37 AM, Markus Armbruster wrote:

>> Perhaps worth documenting is the range of JSON numbers produced by
>> qemu (maybe as a separate patch). Libvirt just hit a bug with the
>> jansson library making it extremely difficult to parse JSON containing
>> numbers larger than INT64_MAX, when compared to yajl which had a way
>> to support up to UINT64_MAX.
>>
>> https://bugzilla.redhat.com/show_bug.cgi?id=1614569
>>
>> Knowing that qemu sends numbers larger than INT64_MAX with the intent
>> that they not be truncated/rounded by conversion to double can be a
>> vital piece of information for implementing a client, when it comes to
>> picking a particular library for JSON parsing.
> 
> Good point.  Doesn't really fit into this commit, though.  Care to
> propose a patch?

Will do, but I'll probably wait for your v2 series to land first.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
