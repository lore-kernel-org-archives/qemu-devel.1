Received: from eggs.gnu.org ([2001:4830:134:3::10]:56997)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <harrynjit@gmail.com>) id 1cKZ0o-0006gR-Tg
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 18:12:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <harrynjit@gmail.com>) id 1cKZ0o-0003Rj-0K
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 18:12:30 -0500
Received: from mail-qk0-x229.google.com ([2607:f8b0:400d:c09::229]:33163)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <harrynjit@gmail.com>) id 1cKZ0n-0003RU-RX
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 18:12:29 -0500
Received: by mail-qk0-x229.google.com with SMTP id t184so155695956qkd.0
	for <qemu-devel@nongnu.org>; Fri, 23 Dec 2016 15:12:29 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <db89d6ca-f832-aece-27d4-70408b5851b6@redhat.com>
References: <CA+scX6nh8NeTWZ44KG85T_ywzVnSc6bMhO69hhGhzbh8ZLnwOg@mail.gmail.com>
	<db89d6ca-f832-aece-27d4-70408b5851b6@redhat.com>
From: Weiwei Jia <harrynjit@gmail.com>
Date: Fri, 23 Dec 2016 18:12:28 -0500
Message-ID: <CA+scX6=W+UcdUcGMFeaV4k4gc1t9qRxTfck1pZyQjD7VD0gfgw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [libvirt] Cannot add iothreads label in libvirt
 xml configuration file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Ferlan <jferlan@redhat.com>
Cc: libvir-list@redhat.com, qemu-devel@nongnu.org

On Thu, Dec 22, 2016 at 5:01 PM, John Ferlan <jferlan@redhat.com> wrote:
>
>
> On 12/21/2016 12:11 PM, Weiwei Jia wrote:
>> Hi,
>>
>> I cannot add iothreads
>> (https://libvirt.org/formatdomain.html#elementsIOThreadsAllocation) in
>> the libvirt xml configuration file. Once I add
>> "<iothreads>4</iothreads>" and other related config for IOthreads into
>> the libvirt xml configuration file with virsh command and save it,
>> these iothreads related configuration will disappear after I open
>> libvirt xml configuration file again for double-check.
>>
>> The current libvirt xml configuration file is like following.
>>
>
> If I try to just cut-n-paste the following xml into a buffer, then run
> virsh define kvm1.xml, I get:
>
> error: Failed to define domain from kvm1.xml
> error: Cannot check QEMU binary /usr/bin/kvm-spice: No such file or
> directory
>
> In order to support iothreads, it requires an "-object iothread"... The
> "shortest" command line using qemu-kvm would be "qemu-kvm -object
> iothread,id=xxx1", so you could try the same with that
> /usr/bin/kvm-spice image and see what you get.
>
> You could try to figure out from the
> /var/cach/libvirt/qemu/capabilities/*.xml files whether or not the
> "iothread" object exists... I would think though that the reason why
> this is failing for you is that the kvm-spice emulator doesn't have the
> required capability (I forget if there's a magic incantation to ask the
> emulator image what it supports, especially for objects).

Thanks for your suggestions. I have tried your way and the results
tell me there are some problems with my libvirt xml configuration
file. I think I need to fix it with correct libvirt xml configuration
file.

Thanks,
Weiwei Jia
