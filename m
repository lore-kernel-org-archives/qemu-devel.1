Received: from eggs.gnu.org ([209.51.188.92]:37940)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gkTkZ-0005XT-FH
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 07:59:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gkTkW-0007w8-53
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 07:59:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43196)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gkTkV-0007qX-T1
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 07:59:52 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4E43B23E6C8
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 12:59:49 +0000 (UTC)
References: <1547576349-13337-1-git-send-email-pbonzini@redhat.com>
	<1547576349-13337-5-git-send-email-pbonzini@redhat.com>
	<54cda442-8e0b-076a-d2bf-b8f1fbf9370c@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <874deae2-25b0-97ea-7236-f6257307c7f6@redhat.com>
Date: Fri, 18 Jan 2019 13:59:45 +0100
MIME-Version: 1.0
In-Reply-To: <54cda442-8e0b-076a-d2bf-b8f1fbf9370c@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 4/5] tests/libqos: embed allocators instead
 of malloc-ing them separately
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: lvivier@redhat.com

On 18/01/19 13:52, Thomas Huth wrote:
> 
>> +                uint64_t start, uint64_t end,
>> +                size_t page_size)
>>  {
>> -    QGuestAllocator *s = g_malloc0(sizeof(*s));
>>      MemBlock *node;
>>  
>>      s->start = start;
>> @@ -313,26 +301,7 @@ QGuestAllocator *alloc_init(uint64_t start, uint64_t end)
>>      node = mlist_new(s->start, s->end - s->start);
>>      QTAILQ_INSERT_HEAD(s->free, node, MLIST_ENTNAME);
>>  
>> -    s->page_size = DEFAULT_PAGE_SIZE;
>> -
>> -    return s;
>> -}
>> -
>> -QGuestAllocator *alloc_init_flags(QAllocOpts opts,
>> -                                  uint64_t start, uint64_t end)
>> -{
>> -    QGuestAllocator *s = alloc_init(start, end);
>> -    s->opts = opts;
> i.e. keep this line ^ ?
> 

I'll add the line back.  It's used by the legacy QOSOps.

Paolo
