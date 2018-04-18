Received: from eggs.gnu.org ([2001:4830:134:3::10]:39093)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f8jJG-0003GK-Fr
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 05:23:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f8jJB-0000Ik-Hr
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 05:23:26 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36140 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1f8jJB-0000IQ-Ck
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 05:23:21 -0400
References: <20180329032149.44685-1-aik@ozlabs.ru>
	<bc4100f4-0a01-a526-c6ce-c2602a96e28a@redhat.com>
	<20180416152040.7b88b902@redhat.com>
	<e483d218-0e93-4a2b-43ea-4a961e559c4d@redhat.com>
	<20180416162706.43212a69@redhat.com>
	<13008b1f-4b59-c6e1-69d2-98f8280f6f34@redhat.com>
	<20180417141803.2d588b97@redhat.com>
	<a23e5774-9a46-7354-3f80-1ad629d102f9@redhat.com>
	<87y3hl2fez.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b84fa22b-2658-5a82-6b18-ab30f6a4384e@redhat.com>
Date: Wed, 18 Apr 2018 11:23:09 +0200
MIME-Version: 1.0
In-Reply-To: <87y3hl2fez.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH qemu] RFC: memory/hmp: Print owners/parents
 in "info mtree"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, peter.maydell@linaro.org, qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On 18/04/2018 08:32, Markus Armbruster wrote:
> Paolo Bonzini <pbonzini@redhat.com> writes:
> 
>> On 17/04/2018 14:18, Igor Mammedov wrote:
>>>> What's the point of an object name if it cannot be unique?
>>> It should be sufficient for it to be unique within parent's
>>> scope and object_property_add_child() should make sure that
>>> added object is unique within its parent's namespace.
>>> Having named object from starters is useful as object
>>> won't have to piggyback on parent (object_get_canonical_path_component)
>>> when it need its own name. Then named object could use its name
>>> freely anywhere including initfn, property setters/getters and
>>> let object_property_add_child() take care of possible name
>>> conflict.
>>
>> I agree that it looks nice, but I'm worried that people forget that the
>> path component is only unique until object_unparent().  The use for
>> DEVICE_DELETED events is already a bad thing...
> 
> Hmm.  If the canonical QOM path isn't the proper way to identify a
> device in QMP, what else is?  Honest question!

The canonical path is; the last component alone is not.

Paolo
