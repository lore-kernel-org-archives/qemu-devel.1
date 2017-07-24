Received: from eggs.gnu.org ([2001:4830:134:3::10]:45408)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dZhn9-0002zZ-4Z
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 14:09:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dZhn5-0004q4-Vw
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 14:09:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32918)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dZhn5-0004pY-Q0
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 14:09:11 -0400
References: <1500886370-14572-1-git-send-email-thuth@redhat.com>
	<1500886370-14572-4-git-send-email-thuth@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <e73044f6-c85e-38a5-b232-5a112d22d55f@redhat.com>
Date: Mon, 24 Jul 2017 20:09:08 +0200
MIME-Version: 1.0
In-Reply-To: <1500886370-14572-4-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 3/5] target/s390x: Rework
 program_interrupt() and related functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Alexander Graf <agraf@suse.de>

On 24.07.2017 10:52, Thomas Huth wrote:
> misc_helper.c won't be compiled with --disable-tcg anymore, but we
> still need the program_interrupt() function in that case. Move it
> to interrupt.c instead, and refactor it to re-use the code from
> trigger_pgm_exception() (for TCG) and enter_pgmcheck() (for KVM,
> which now got renamed to kvm_s390_program_interrupt() for
> clarity).
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

I like that! Looks good to me!

-- 

Thanks,

David
