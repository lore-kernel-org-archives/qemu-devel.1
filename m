Received: from eggs.gnu.org ([2001:4830:134:3::10]:49988)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gNI60-0002CH-Sn
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 08:54:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gNI5v-0006Je-Ud
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 08:54:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47520)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1gNI5v-0006Ip-JN
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 08:54:07 -0500
References: <20181109110221.10553-1-david@redhat.com>
	<20181109110221.10553-3-david@redhat.com>
	<87r2fnod2p.fsf@dusky.pond.sub.org>
	<359e518d-ffdc-e062-c9c7-20034155051e@redhat.com>
	<8d78da85-c758-a281-6a20-9f1335b50fe8@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <c25b8530-7451-7291-471c-1f30c2c35655@redhat.com>
Date: Thu, 15 Nov 2018 14:54:04 +0100
MIME-Version: 1.0
In-Reply-To: <8d78da85-c758-a281-6a20-9f1335b50fe8@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC 2/6] qapi: use qemu_strtod() in
 string-input-visitor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>

On 15.11.18 14:17, Eric Blake wrote:
> On 11/15/18 5:09 AM, David Hildenbrand wrote:
> 
>>> Three more: in qobject-input-visitor.c's
>>> qobject_input_type_number_keyval(),
>>
>> This one is interesting, as it properly bails out when parsing "inf"
>> (via isFinite()). - should we do the same for the string input visitor?
>>
>> Especially, should we forbid "inf" and "NaN" in both scenarios?
> 
> JSON can't represent non-finite doubles. Internally, we might be able to 
> use them, but you have a point that consistently rejecting non-finite in 
> all of our QAPI parsers makes it easier to reason about the code base 
> (the command line can't be used to inject a value not possible via QMP). 
> So that makes sense to me.  qemu_strtod() shouldn't reject non-finite 
> numbers (because it is useful for more than just qapi), but we could add 
> a new qemu_strtod_finite() if that would help avoid duplication.
> 

Yes, I'll exactly add that! Thanks

-- 

Thanks,

David / dhildenb
