Received: from eggs.gnu.org ([2001:4830:134:3::10]:45403)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eyMK4-0005vK-2V
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 14:49:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eyMK0-0006tM-3W
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 14:49:24 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50808 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eyMJz-0006tD-Uz
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 14:49:20 -0400
References: <20180320173324.30844-1-fl@n621.de>
	<48d11603-23ba-ddbb-34a6-8ba345ac5d28@redhat.com>
	<20180320181100.GE15157@nyx.n621.de>
From: Eric Blake <eblake@redhat.com>
Message-ID: <02adc7d1-4cf1-4d29-e428-1cf4b3e5c39e@redhat.com>
Date: Tue, 20 Mar 2018 13:49:09 -0500
MIME-Version: 1.0
In-Reply-To: <20180320181100.GE15157@nyx.n621.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3] os: truncate pidfile on creation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Florian Larysch <fl@n621.de>
Cc: qemu-devel@nongnu.org, sw@weilnetz.de

On 03/20/2018 01:11 PM, Florian Larysch wrote:
> On Tue, Mar 20, 2018 at 01:00:40PM -0500, Eric Blake wrote:
>> Here after the --- is a nice place to summarize how v3 differs from
>> v2, to save reviewers some time.
> 
> The triviality of the change didn't seem to warrant that, but in
> retrospect, I realize that searching for the sole trivial change when
> reviewing a patch is also (or even more of) a burden. I'll keep that in
> mind for the future.
> 
>> Also, if all that is wrong is a typo in the commit message, a
>> maintainer is often willing to fix that up without you having to
>> send a new revision
> 
> I interpreted your comment on the v2 as a request for me to fix that.
> Sorry for the churn.

No problem - it's okay to learn as you go (we were all once new 
contributors), and some things get easier the longer you've been on the 
list to see the balance between saving yourself time and saving 
reviewers/maintainers time.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
