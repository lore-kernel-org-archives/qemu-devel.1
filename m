Received: from eggs.gnu.org ([2001:4830:134:3::10]:54527)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dYGuf-0000oU-85
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 15:15:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dYGue-0000Pz-DF
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 15:15:05 -0400
Sender: Richard Henderson <rth7680@gmail.com>
References: <1500568290-7966-1-git-send-email-peter.maydell@linaro.org>
	<d4b6f6a0-3479-795a-97b2-68c98a6b0c24@twiddle.net>
	<c1526558-db87-734b-c1dd-7601ceaa682c@redhat.com>
	<06919388-6794-d0a0-f014-b95a9cc68460@twiddle.net>
	<10223971-6e02-fe3f-337f-de9c14081582@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <196b152f-6bc9-fcef-4fcb-27cb9acf4a25@twiddle.net>
Date: Thu, 20 Jul 2017 09:14:44 -1000
MIME-Version: 1.0
In-Reply-To: <10223971-6e02-fe3f-337f-de9c14081582@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.10] Use qemu_tolower() and
 qemu_toupper(), not tolower() and toupper()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Cc: patches@linaro.org, Cornelia Huck <cohuck@redhat.com>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, Kamil Rytarowski <kamil@netbsd.org>, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

On 07/20/2017 09:04 AM, Eric Blake wrote:
> And I found this in C11:
> 
> 7.4 Character handling <ctype.h>
> 1 The header <ctype.h> declares several functions useful for classifying
> and mapping
> characters. 198) In all cases the argument is an int, the value of which
> shall be
> representable as an unsigned char or shall equal the value of the macro
> EOF. If the
> argument has any other value, the behavior is undefined.


Thanks.  I should have looked up there.


r~
