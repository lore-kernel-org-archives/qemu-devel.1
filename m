Received: from eggs.gnu.org ([2001:4830:134:3::10]:59012)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1ffTMT-0007eQ-I1
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 13:02:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1ffTMQ-0004U2-Hq
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 13:02:05 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52650 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1ffTMQ-0004Tc-Cu
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 13:02:02 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E13D183221
	for <qemu-devel@nongnu.org>; Tue, 17 Jul 2018 17:02:01 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <74103c99-21bf-58f1-fa28-d575a8899462@redhat.com> (Paolo
	Bonzini's message of "Tue, 17 Jul 2018 15:38:55 +0200")
References: <20180717120414.5852-1-quintela@redhat.com>
	<74103c99-21bf-58f1-fa28-d575a8899462@redhat.com>
Reply-To: quintela@redhat.com
Date: Tue, 17 Jul 2018 19:01:59 +0200
Message-ID: <871sc1zth4.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [RFC 00/14] More patches to disable stuff
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, dgilbert@redhat.com, peterx@redhat.com

Paolo Bonzini <pbonzini@redhat.com> wrote:
> On 17/07/2018 14:04, Juan Quintela wrote:
>> Hi
>> 
>> Notice that this is an RFC because they don't work.  As said on my
>> previous submmision, we need <foo>-softmmu/config-devices.h to make
>> this work.  This series just allow us to disable the devices, but not
>> to enable it back O:-)
>> 
>> Notice:
>> 
>> - scsi stuff: we are testing they in cdrom-test.c, so we need to be
>>   able to config them out.  Notice also that #ifdefs only go in tests/<...>
>> 
>> - virtio stuff: see how we need to also change hw/virtio/virtio-pci.c
>>   to disable it.  The problem appears in the device-instropect-test.c.
>>   As they are defined in the binary, but not complied in.  We can
>>   change for a registration appreach, but that is more work that what
>>   I intended for this series.
>
> Emanuele's GSoC project will be able to do this automatically; tests are
> defined to "consume" some devices, and are not enabled unless the device
> is present.

Nice.  Thanks.

>
> Thanks,
>
> Paolo
