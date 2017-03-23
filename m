Received: from eggs.gnu.org ([2001:4830:134:3::10]:47863)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cqyoT-0002sj-Ds
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 05:13:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cqyoQ-0003Uv-8M
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 05:13:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35528)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1cqyoP-0003Uf-W9
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 05:13:42 -0400
References: <cover.1489494746.git.janne.huttunen@nokia.com>
	<1489510640.8844.18.camel@redhat.com>
	<1489561105.24841.25.camel@nokia.com>
	<11a3eab4-77f8-87ea-9558-299fbfc77a07@redhat.com>
	<1490164614.19055.31.camel@nokia.com>
	<1558854179.6445757.1490172190685.JavaMail.zimbra@redhat.com>
	<1490173225.19055.48.camel@nokia.com>
	<c1a80bf6-1379-8402-06d4-01247825fcf0@redhat.com>
	<1490191138.19055.92.camel@nokia.com>
	<8616b7ec-8306-25b4-267c-449f94261502@redhat.com>
	<1490195960.19055.105.camel@nokia.com>
	<3229b3f8-7689-94d1-05a8-8b8c34bc0d25@redhat.com>
	<1490251984.25746.15.camel@nokia.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <4d81bf77-0228-32a4-049d-4990f3da862b@redhat.com>
Date: Thu, 23 Mar 2017 10:13:36 +0100
MIME-Version: 1.0
In-Reply-To: <1490251984.25746.15.camel@nokia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC][PATCH 0/6] "bootonceindex" property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Janne Huttunen <janne.huttunen@nokia.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>
Cc: "kraxel@redhat.com" <kraxel@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

On 03/23/17 07:53, Janne Huttunen wrote:
> On Wed, 2017-03-22 at 16:29 +0100, Laszlo Ersek wrote:
>>> I'm not. I'm using QMP to change the index dynamically.
>>>  
>> Wait, if you are already changing the "bootindex" property
>> dynamically (do I understand that right?)
> 
> No, I'm not changing "bootindex" dynamically. I'm changing
> "bootonceindex" dynamically. The point is that whatever
> change I'm making is supposed to affect only one boot, the
> next one. Since the guest can trigger reboots by itself,
> I don't necessarily know when they are going to happen.
> 
> Like I said earlier, I can get very close to the semantics
> I need if set the "bootindex" and get an event when the
> boot happens so that I know when to reset the bootindex
> back to the original value. However doing it like that
> is (at least in theory) racy if the event isn't synchronous
> and it requires some process that actively monitors those
> events which I'm trying to avoid.
> 
>> ...and it could have a significant maintenance footprint,
>> while the feature does look niche (to me anyway).
> 
> Whatever I'm currently doing is definitely a niche, but very
> similar setting of a one time boot source while the system
> is running is e.g. part of the IPMI standard (see "Set
> System Boot Options Command" in IPMI Specification), so
> the concept itself is not that much of a niche.
> 

... Okay, I've spoken my mind on this, and have nothing more to add. I'm
still not convinced, but that doesn't mean you can't convince others.
(And you need to convince others more than me, because I'm not a QEMU
maintainer -- I just wanted to voice my opinion, since this was an RFC.)

What really matters to me though is that the "bootorder" fw_cfg file
preserve
- both its current, exclusive role, for communicating the boot order to
the firmware,
- and its syntax & semantics.

Thanks
Laszlo
