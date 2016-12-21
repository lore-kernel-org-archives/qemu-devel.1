Received: from eggs.gnu.org ([2001:4830:134:3::10]:41878)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1cJcTP-0007T2-K6
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 03:42:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1cJcTM-0000Bc-I8
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 03:42:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48592)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1cJcTM-0000BO-C1
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 03:42:04 -0500
References: <1482255793-19057-1-git-send-email-ehabkost@redhat.com>
	<1482255793-19057-4-git-send-email-ehabkost@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <7452fc0c-805c-d644-1e28-4c32bd430e5f@redhat.com>
Date: Wed, 21 Dec 2016 09:42:00 +0100
MIME-Version: 1.0
In-Reply-To: <1482255793-19057-4-git-send-email-ehabkost@redhat.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC 3/7] kvm: Move some kvm-stub.c code to
 stubs/kvm.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, Christoffer Dall <christoffer.dall@linaro.org>

Am 20.12.2016 um 18:43 schrieb Eduardo Habkost:
> Move the kvm-stub.c code that doesn't depend on cpu.h or CONFIG_*
> defines to stubs/kvm.c.
>
> Notes about copyright, licensing, and authorship:
>
> * There was no copyright not on the original stubs/kvm.c file.
> * As include/sysemu/kvm.h and kvm-all.c are licensed as
>   GPLv2+, I am assuming stubs/kvm.c file is also licensed as
>   GPLv2+.
> * I have copied the copyright info from kvm-stub.c and added the
>   original author of stubs/kvm.c (Christoffer Dall) to the author
>   list.
>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: kvm@vger.kernel.org
> Cc: Christoffer Dall <christoffer.dall@linaro.org>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Reviewed-by: David Hildenbrand <david@redhat.com>

Guess we have to wait for an ack of paolo and christoffer.

-- 

David
