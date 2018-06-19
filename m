Received: from eggs.gnu.org ([2001:4830:134:3::10]:48961)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fVOn3-0000zQ-E7
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 18:07:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fVOmy-0000y8-Qf
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 18:07:53 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57852 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fVOmy-0000wc-LZ
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 18:07:48 -0400
References: <20180615222855.44421-1-mst@redhat.com>
	<20180615222855.44421-2-mst@redhat.com>
	<b59883c6-1dc0-4e81-439c-587c8f2d3e83@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f87772ab-7d59-4ab2-59e3-c1ac77eaf725@redhat.com>
Date: Tue, 19 Jun 2018 17:07:46 -0500
MIME-Version: 1.0
In-Reply-To: <b59883c6-1dc0-4e81-439c-587c8f2d3e83@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 1/2] kvm: support -dedicated
 cpu-pm=on|off
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: Marcelo Tosatti <mtosatti@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org, Richard Henderson <rth@twiddle.net>

On 06/19/2018 10:17 AM, Paolo Bonzini wrote:
> On 16/06/2018 00:29, Michael S. Tsirkin wrote:
>>   
>> +static QemuOptsList qemu_dedicated_opts = {
>> +    .name = "dedicated",
>> +    .head = QTAILQ_HEAD_INITIALIZER(qemu_dedicated_opts.head),
>> +    .desc = {
>> +        {
>> +            .name = "mem-lock",
>> +            .type = QEMU_OPT_BOOL,
>> +        },
>> +        {
>> +            .name = "cpu-pm",
>> +            .type = QEMU_OPT_BOOL,
>> +        },
>> +        { /* end of list */ }
>> +    },
>> +};
>> +
> 
> Let the bikeshedding begin!
> 
> 1) Should we deprecate -realtime?
> 
> 2) Maybe -hostresource?

What further things might we add in the future?

-dedicated sounds wrong (it is an adjective, while most of our options 
are nouns - thing -machine, -drive, -object, ...)

-hostresource at least sounds like a noun, but is long to type.  But at 
least '-hostresource cpu-pm=on' reads reasonably well.

About the only other noun I could think of would be '-feature cpu-pm=on'.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
