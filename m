Received: from eggs.gnu.org ([2001:4830:134:3::10]:51968)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <harrynjit@gmail.com>) id 1cK9SW-0007wt-AA
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 14:55:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <harrynjit@gmail.com>) id 1cK9SV-0001zc-Kt
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 14:55:24 -0500
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:33332)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <harrynjit@gmail.com>) id 1cK9SV-0001zI-Gq
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 14:55:23 -0500
Received: by mail-qk0-x241.google.com with SMTP id n21so14437457qka.0
	for <qemu-devel@nongnu.org>; Thu, 22 Dec 2016 11:55:23 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20161222093311.GJ965@redhat.com>
References: <CA+scX6nh8NeTWZ44KG85T_ywzVnSc6bMhO69hhGhzbh8ZLnwOg@mail.gmail.com>
	<20161222093311.GJ965@redhat.com>
From: Weiwei Jia <harrynjit@gmail.com>
Date: Thu, 22 Dec 2016 14:55:22 -0500
Message-ID: <CA+scX6kaduSGER8SsKYScZHe9stJR6YF2rGdrDeybE=+SZ=K_A@mail.gmail.com>
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
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: libvir-list@redhat.com, qemu-devel@nongnu.org

On Thu, Dec 22, 2016 at 4:33 AM, Daniel P. Berrange <berrange@redhat.com> wrote:
> On Wed, Dec 21, 2016 at 12:11:51PM -0500, Weiwei Jia wrote:
>> Hi,
>>
>> I cannot add iothreads
>> (https://libvirt.org/formatdomain.html#elementsIOThreadsAllocation) in
>> the libvirt xml configuration file. Once I add
>> "<iothreads>4</iothreads>" and other related config for IOthreads into
>> the libvirt xml configuration file with virsh command and save it,
>> these iothreads related configuration will disappear after I open
>> libvirt xml configuration file again for double-check.
>
> If XML disappears after saving it, this usually indicates that either you
> made a mistake and used the wrong XML element or in the wrong place, or
> that your libvirt version is too old to support it. You can use the
> virt-xml-validate too to verify your XML file against the schema for
> your installed version of libvirt, which will report any errrors.

virt-xml-validate has no help. Let me try libvirt 2.5.0 and QEMU
2.7.0. Thank you.

Best,
Weiwei Jia
