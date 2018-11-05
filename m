Received: from eggs.gnu.org ([2001:4830:134:3::10]:33386)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gJo6j-0007Dk-7G
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 18:16:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gJo6g-00081o-0O
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 18:16:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35246)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gJo6f-0007wF-O8
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 18:16:29 -0500
References: <1539894735-14232-1-git-send-email-pbonzini@redhat.com>
	<1539894735-14232-4-git-send-email-pbonzini@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <01124fd1-83b2-c0c8-21d7-1f031a21ff3b@redhat.com>
Date: Mon, 5 Nov 2018 17:16:27 -0600
MIME-Version: 1.0
In-Reply-To: <1539894735-14232-4-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 03/48] qemu-timer: introduce timer attributes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Artem Pisarenko <artem.k.pisarenko@gmail.com>

On 10/18/18 3:31 PM, Paolo Bonzini wrote:
> From: Artem Pisarenko <artem.k.pisarenko@gmail.com>
> 
> Attributes are simple flags, associated with individual timers for their
> whole lifetime.  They intended to be used to mark individual timers for
> special handling when they fire.
> 
> New/init functions family in timer interface updated and refactored (new
> 'attribute' argument added, timer_list replaced with timer_list_group+type
> combinations, comments improved to avoid info duplication).  Also existing
> aio interface extended with attribute-enabled variants of functions,
> which create/initialize timers.
> 
> Signed-off-by: Artem Pisarenko <artem.k.pisarenko@gmail.com>
> Message-Id: <f47b81dbce734e9806f9516eba8ca588e6321c2f.1539764043.git.artem.k.pisarenko@gmail.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---

git bisect points to this patch as the reason that 'make check' is 
failing for me with:

   LINK    tests/ptimer-test
   LINK    tests/test-qapi-util
hw/core/ptimer.o: In function `timer_new_tl':
/home/eblake/qemu/include/qemu/timer.h:536: undefined reference to 
`timer_init_tl'
collect2: error: ld returned 1 exit status
make: *** [/home/eblake/qemu/rules.mak:124: tests/ptimer-test] Error 1
make: *** Waiting for unfinished jobs....

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
