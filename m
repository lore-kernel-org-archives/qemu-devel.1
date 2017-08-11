Received: from eggs.gnu.org ([2001:4830:134:3::10]:55225)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dg5h9-0001b6-OB
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 04:53:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dg5h7-0003P4-5e
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 04:53:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60626)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dg5h7-0003Oi-0M
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 04:53:25 -0400
References: <150243866500.69.2992682353878264478@dd743fd916bd>
From: David Hildenbrand <david@redhat.com>
Message-ID: <af0b8abb-71a1-ca76-4793-6969cbb4d5c5@redhat.com>
Date: Fri, 11 Aug 2017 10:53:18 +0200
MIME-Version: 1.0
In-Reply-To: <150243866500.69.2992682353878264478@dd743fd916bd>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH RFC 0/5] target/s390x: introduce internal.h
 and cleanup cpu.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, thuth@redhat.com, cohuck@redhat.com, borntraeger@de.ibm.com, aurelien@aurel32.net, rth@twiddle.net


> /var/tmp/patchew-tester-tmp-05mor12r/src/hw/intc/s390_flic_kvm.c:125:5:=
 error: no previous prototype for =E2=80=98kvm_s390_inject_flic=E2=80=99 =
[-Werror=3Dmissing-prototypes]
>  int kvm_s390_inject_flic(struct kvm_s390_irq *irq)
>      ^~~~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors

Easily fixed, not moving kvm_s390_inject_flic in "target/s390x: remove
all CONFIG_KVM from cpu.h"


--=20

Thanks,

David
