Received: from eggs.gnu.org ([2001:4830:134:3::10]:51295)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cZieB-0005zR-63
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 13:31:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cZie9-0004GF-1r
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 13:31:47 -0500
References: <1485876994-14555-1-git-send-email-pl@kamp.de>
	<ea032a8a-1429-bd95-5b68-4634a0fb0a57@redhat.com>
	<03b2194a-ea37-c025-53c2-53b030b593f6@kamp.de>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d4fc2724-6ad7-8006-318b-989855dbc575@redhat.com>
Date: Fri, 3 Feb 2017 10:31:36 -0800
MIME-Version: 1.0
In-Reply-To: <03b2194a-ea37-c025-53c2-53b030b593f6@kamp.de>
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
To: Peter Lieven <pl@kamp.de>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, mdroth@linux.vnet.ibm.com, ct@flyingcircus.io



On 03/02/2017 00:20, Peter Lieven wrote:
> Am 02.02.2017 um 22:41 schrieb Paolo Bonzini:
>>
>> On 31/01/2017 07:36, Peter Lieven wrote:
>>> the current implementation fails if we try to freeze an
>>> already frozen filesystem. This can happen if a filesystem
>>> is mounted more than once (e.g. with a bind mount).
>>>
>>> Suggested-by: Christian Theune <ct@flyingcircus.io>
>>> Cc: qemu-stable@nongnu.org
>>> Signed-off-by: Peter Lieven <pl@kamp.de>
>> What happens when you thaw?
>>
>> Paolo
> 
> If you try to THAW an unfrozen FS you get EINVAL.
> The current code thaws until an error is returned.
> 
> So it should work as is.
> 
> If you feel uncomfortable with the EBUSY approach. The other idea would
> be to track all devices which have been successfully frozen and skip consecutive
> tries to freeze them.

No, just asking.

Reeviewed-by: Paolo Bonzini <pbonzini@redhat.com>
