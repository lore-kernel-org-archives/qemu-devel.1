Received: from eggs.gnu.org ([2001:4830:134:3::10]:58267)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f8TVs-0004Uq-Iv
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 12:31:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f8TVn-000328-G5
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 12:31:24 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41934 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1f8TVn-00031z-9p
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 12:31:19 -0400
References: <20180329032149.44685-1-aik@ozlabs.ru>
	<bc4100f4-0a01-a526-c6ce-c2602a96e28a@redhat.com>
	<20180416152040.7b88b902@redhat.com>
	<e483d218-0e93-4a2b-43ea-4a961e559c4d@redhat.com>
	<20180416162706.43212a69@redhat.com>
	<13008b1f-4b59-c6e1-69d2-98f8280f6f34@redhat.com>
	<20180417141803.2d588b97@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a23e5774-9a46-7354-3f80-1ad629d102f9@redhat.com>
Date: Tue, 17 Apr 2018 18:31:08 +0200
MIME-Version: 1.0
In-Reply-To: <20180417141803.2d588b97@redhat.com>
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
To: Igor Mammedov <imammedo@redhat.com>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, peter.maydell@linaro.org

On 17/04/2018 14:18, Igor Mammedov wrote:
>> What's the point of an object name if it cannot be unique?
> It should be sufficient for it to be unique within parent's
> scope and object_property_add_child() should make sure that
> added object is unique within its parent's namespace.
> Having named object from starters is useful as object
> won't have to piggyback on parent (object_get_canonical_path_component)
> when it need its own name. Then named object could use its name
> freely anywhere including initfn, property setters/getters and
> let object_property_add_child() take care of possible name
> conflict.

I agree that it looks nice, but I'm worried that people forget that the
path component is only unique until object_unparent().  The use for
DEVICE_DELETED events is already a bad thing...

Paolo
