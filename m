Received: from eggs.gnu.org ([2001:4830:134:3::10]:48122)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gS3EB-0000cf-Fh
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 12:02:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gS3E6-00010v-W3
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 12:02:18 -0500
References: <20181121151211.15997-1-paul.durrant@citrix.com>
	<20181121151211.15997-3-paul.durrant@citrix.com>
	<20181128161917.GE4222@dhcp-200-186.str.redhat.com>
	<48596f1fe100419c8b28ed54bda0117b@AMSPEX02CL03.citrite.net>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f4800b8b-1443-1bbf-8bcd-92b66e8d2631@redhat.com>
Date: Wed, 28 Nov 2018 11:01:06 -0600
MIME-Version: 1.0
In-Reply-To: <48596f1fe100419c8b28ed54bda0117b@AMSPEX02CL03.citrite.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 02/18] xen: introduce new
 'XenBus' and 'XenDevice' object hierarchy
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paul Durrant <Paul.Durrant@citrix.com>, 'Kevin Wolf' <kwolf@redhat.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>, Eduardo Habkost <ehabkost@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Anthony Perard <anthony.perard@citrix.com>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, Richard Henderson <rth@twiddle.net>

On 11/28/18 10:26 AM, Paul Durrant wrote:

>>> +++ b/hw/xen/xen-bus.c
>>> @@ -0,0 +1,125 @@
>>> +/*
>>> + * Copyright (c) Citrix Systems Inc.
>>> + * All rights reserved.
>>> + */
>>
>> This doesn't look very compatible with the GPL. In fact it might even
>> make it illegal for the QEMU project to distribute this code. :-)
>>
>> Other files you add throughout the series seem to have the same problem.
>>
> 
> I was working on the assumption that a lack of explicit license meant that the overall project license as described in item 2 in LICENSE. Did I misinterpret that text?

No, but you missed the fact that "All rights reserved" is an explicit 
license (or rather, an explicit anti-license that states you are not 
granting rights that the GPL would normally grant), and an implicit 
license does not apply when an explicit (anti-)license is present.

What's more, relying on implicit licenses is prone to misinterpretation, 
so even though the overall project documentation tries to cover what 
will happen, it's much nicer if you DO use an explicit license mention 
in your file so that we don't HAVE to rely on the implicit license.

Yes, the phrase "All rights reserved" exists in several existing files:

$ git grep -il 'all rights reserved' |wc
     138     138    3557

but we should be striving to clean those up, not adding to the mess.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
