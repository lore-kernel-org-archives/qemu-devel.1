Received: from eggs.gnu.org ([2001:4830:134:3::10]:58771)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <pl@kamp.de>)
	id 1cZZ6M-0004PT-5h
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 03:20:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pl@kamp.de>) id 1cZZ6J-0003T0-1d
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 03:20:14 -0500
Received: from mx-v6.kamp.de ([2a02:248:0:51::16]:45738 helo=mx01.kamp.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pl@kamp.de>) id 1cZZ6I-0003SB-P3
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 03:20:10 -0500
References: <1485876994-14555-1-git-send-email-pl@kamp.de>
	<ea032a8a-1429-bd95-5b68-4634a0fb0a57@redhat.com>
From: Peter Lieven <pl@kamp.de>
Message-ID: <03b2194a-ea37-c025-53c2-53b030b593f6@kamp.de>
Date: Fri, 3 Feb 2017 09:20:06 +0100
MIME-Version: 1.0
In-Reply-To: <ea032a8a-1429-bd95-5b68-4634a0fb0a57@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] qga: ignore EBUSY when freezing a
 filesystem
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, mdroth@linux.vnet.ibm.com, ct@flyingcircus.io

Am 02.02.2017 um 22:41 schrieb Paolo Bonzini:
>
> On 31/01/2017 07:36, Peter Lieven wrote:
>> the current implementation fails if we try to freeze an
>> already frozen filesystem. This can happen if a filesystem
>> is mounted more than once (e.g. with a bind mount).
>>
>> Suggested-by: Christian Theune <ct@flyingcircus.io>
>> Cc: qemu-stable@nongnu.org
>> Signed-off-by: Peter Lieven <pl@kamp.de>
> What happens when you thaw?
>
> Paolo

If you try to THAW an unfrozen FS you get EINVAL.

The current code thaws until an error is returned.


So it should work as is.


If you feel uncomfortable with the EBUSY approach. The other idea would

be to track all devices which have been successfully frozen and skip consecutive

tries to freeze them.


Peter
