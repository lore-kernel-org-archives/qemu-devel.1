Received: from eggs.gnu.org ([2001:4830:134:3::10]:55187)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gG1bN-0005Vb-Gt
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 08:52:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gG1XZ-0000kD-TX
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 08:48:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45118)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1gG1XU-0000fn-4f
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 08:48:35 -0400
References: <20181023152306.3123-1-david@redhat.com>
	<20181023152306.3123-3-david@redhat.com>
	<20181025144107.GB2697@umbus.hotspot.internet-for-guests.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <305a3492-4b16-84b2-2757-1c8e1cf481da@redhat.com>
Date: Fri, 26 Oct 2018 14:48:20 +0200
MIME-Version: 1.0
In-Reply-To: <20181025144107.GB2697@umbus.hotspot.internet-for-guests.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 2/7] qapi: correctly parse uint64_t
 values from strings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Eduardo Habkost <ehabkost@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>


> 
> It's not obvious to me why this looks so different from the code in
> parse_type_int64().  Should we be using qemu_strtoi64() in the
> pre-existing function, instead of what's there now?

The existing function has to be that complicated because it calls into
the same function used to parse ranges. We don't need ranges (or
create/modify) any, so this is not necessary.

This function is similar to the other parse functions (not parsing
ranges), e.g. parse_type_bool(). Thanks!

> 
>>  
>>  static void parse_type_size(Visitor *v, const char *name, uint64_t *obj,
> 


-- 

Thanks,

David / dhildenb
