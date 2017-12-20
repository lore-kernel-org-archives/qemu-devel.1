Received: from eggs.gnu.org ([2001:4830:134:3::10]:48150)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eRnbF-0004d9-Po
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 18:16:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eRnbE-0002QL-P3
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 18:16:33 -0500
References: <20171218101643.20360-1-berrange@redhat.com>
	<e028e73a-cce7-f624-9029-290249d7c9e3@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <29f007e1-582a-e7a7-53b9-bf3d7d07660b@redhat.com>
Date: Wed, 20 Dec 2017 17:16:23 -0600
MIME-Version: 1.0
In-Reply-To: <e028e73a-cce7-f624-9029-290249d7c9e3@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 0/2] Enable full IPv4/IPv6 dual stack
 for NBD server
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org

On 12/18/2017 05:48 AM, Paolo Bonzini wrote:
> On 18/12/2017 11:16, Daniel P. Berrange wrote:
>> These patches were previously posted as part of a larger series:
>>
>>    https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg02064.html
>>
>> These patches port the NBD server to use QIONetListener, which allows for
>> easy setup of multiple listening sockets. This enables full support for
>> IPv4/IPv6 dual stack, by fully honouring all addresses returned from a
>> DNS lookup.
>>
>> There has been no change since v1, except for trivial rebase.
>>
>> Daniel P. Berrange (2):
>>    blockdev: convert internal NBD server to QIONetListener
>>    blockdev: convert qemu-nbd server to QIONetListener
>>
>>   blockdev-nbd.c | 50 +++++++++++++++--------------------------------
>>   qemu-nbd.c     | 61 +++++++++++++++++++++++-----------------------------------
>>   2 files changed, 40 insertions(+), 71 deletions(-)
>>
> 
> Looks good, thanks!

I see these were included in Paolo's pull request, but that it failed 
for other reasons.  If needed, I can take it through the NBD tree.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
