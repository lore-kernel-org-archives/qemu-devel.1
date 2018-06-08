Received: from eggs.gnu.org ([2001:4830:134:3::10]:51073)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fRLhf-0005IZ-Ua
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 14:01:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fRLhf-0006xt-5C
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 14:01:36 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43466 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fRLhf-0006xi-1h
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 14:01:35 -0400
References: <20180607223111.27792-1-ross.zwisler@linux.intel.com>
	<20180607223111.27792-4-ross.zwisler@linux.intel.com>
	<17f8856c-48d9-d112-cd7f-e1b3679d2f43@redhat.com>
	<20180608174114.GA30678@linux.intel.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <480726b0-4a0a-9287-0378-6716b2a196f8@redhat.com>
Date: Fri, 8 Jun 2018 13:01:26 -0500
MIME-Version: 1.0
In-Reply-To: <20180608174114.GA30678@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu PATCH 4/5] machine: fix some misspelled words
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ross Zwisler <ross.zwisler@linux.intel.com>, Thomas Huth <thuth@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, linux-nvdimm <linux-nvdimm@lists.01.org>, "Michael S. Tsirkin" <mst@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Dan Williams <dan.j.williams@intel.com>

On 06/08/2018 12:41 PM, Ross Zwisler wrote:

>>> -        "Set on/off to enable/disable igd passthrou", &error_abort);
>>> +        "Set on/off to enable/disable igd passthru", &error_abort);
>>
>> Shouldn't that rather be "passthrough" instead?
> 
> Either works, I think.  "thru" and "passthru" are short informal versions of
> "through" and "passthrough", but both the long and short versions of both
> words are used all over the QEMU source.  "passthrou" is clearly wrong.  If
> the longer version is preferred in this case please feel free to fix up when
> you apply.

"passthru" is fine as an abbreviation in source code (and gcc 
understands it).  But in English text presented to the end user, as is 
the case here, you should use the correct spelling "passthrough", and 
not an abbreviation.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
