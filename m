Received: from eggs.gnu.org ([2001:4830:134:3::10]:53367)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dfUAH-0001eU-Vp
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 12:49:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dfUAD-00073f-4Z
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 12:49:02 -0400
Received: from mail-wm0-f49.google.com ([74.125.82.49]:37214)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dfUAC-00073M-Tx
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 12:48:57 -0400
Received: by mail-wm0-f49.google.com with SMTP id i66so1321663wmg.0
	for <qemu-devel@nongnu.org>; Wed, 09 Aug 2017 09:48:56 -0700 (PDT)
References: <20170717134238.1966-1-quintela@redhat.com>
	<20170717134238.1966-11-quintela@redhat.com>
	<20170719190238.GK3500@work-vm>
	<87lgmu8346.fsf@secure.mitica> <20170808163047.GP2081@work-vm>
	<87ziba6iq0.fsf@secure.mitica> <20170808191436.GB2716@work-vm>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <53f77c40-3c4f-ebd0-fad8-877e16c03049@redhat.com>
Date: Wed, 9 Aug 2017 18:48:53 +0200
MIME-Version: 1.0
In-Reply-To: <20170808191436.GB2716@work-vm>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 10/17] migration: Create ram_multifd_page
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>
Cc: lvivier@redhat.com, qemu-devel@nongnu.org, peterx@redhat.com

On 08/08/2017 21:14, Dr. David Alan Gilbert wrote:
>> There is no barrier there that I can see.  I know that it probably work
>> on x86, but in others?  I think that it *** HERE **** we need that
>> memory barrier that we don't have.
> Yes, I think that's smp_mb_release() - and you have to do an
> smp_mb_acquire after reading the pages->num before accessing the iov.

Yes, I think that's correct.

Paolo

> (Probably worth checking with Paolo).
> Or just stick with mutex's.
> 
> 
