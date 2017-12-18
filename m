Received: from eggs.gnu.org ([2001:4830:134:3::10]:51545)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eQqLV-0005Ym-Gz
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 03:00:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eQqLR-0000DA-E7
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 03:00:21 -0500
References: <151350631739.45.12182008427471484789@5adcb62bf0d6>
	<766e1250-9930-3af7-099c-29fafd37c270@weilnetz.de>
	<f358f063-dcb7-84c5-97c6-010618a6e24d@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <a55c3dec-23ac-aa78-ac18-3df1e94afee4@redhat.com>
Date: Mon, 18 Dec 2017 09:00:10 +0100
MIME-Version: 1.0
In-Reply-To: <f358f063-dcb7-84c5-97c6-010618a6e24d@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH] s390x: Add missing
 QEMU_NORETURN attribute (CID 1383842)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Stefan Weil <sw@weilnetz.de>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, famz@redhat.com, agraf@suse.de, rth@twiddle.net


> I think the best solution would be to call tcg_s390_program_interrupt()
> directly from helper_divs64() instead of going through the
> s390_program_interrupt() wrapper. helper_divs64() is for TCG only, so it
> should be fine to directly use the tcg_s390_program_interrupt() function
> there.


Just add a return after s390_program_interrupt().

> 
>  Thomas
> 


-- 

Thanks,

David / dhildenb
