Received: from eggs.gnu.org ([2001:4830:134:3::10]:59245)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fLVXq-0004F8-Gk
	for qemu-devel@nongnu.org; Wed, 23 May 2018 11:19:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fLVXk-0007d6-K6
	for qemu-devel@nongnu.org; Wed, 23 May 2018 11:19:18 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40100 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fLVXk-0007cu-FY
	for qemu-devel@nongnu.org; Wed, 23 May 2018 11:19:12 -0400
References: <20180522065922.GA3462@rnd>
From: Eric Blake <eblake@redhat.com>
Message-ID: <aeea0d1e-944c-41a6-871c-1365968357ff@redhat.com>
Date: Wed, 23 May 2018 10:19:10 -0500
MIME-Version: 1.0
In-Reply-To: <20180522065922.GA3462@rnd>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] Add save/load/del[vm] QMP api
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Balaev <mail@void.so>, qemu-devel@nongnu.org

On 05/22/2018 01:59 AM, Pavel Balaev wrote:
> Hello,
> 
> Now savevm, loadvm and delvm commands only allowed from hmp monitor.
> This patch adds ability to send them via QMP api.

Quoting my reply from an earlier similar proposal:
https://lists.gnu.org/archive/html/qemu-devel/2018-01/msg01864.html

> Straightforward mapping of the existing HMP commands into QMP without
> any thought about the design won't make the errors any clearer. My
> argument is that any QMP design for managing internal snapshots must be
> well-designed, but that since we discourage internal snapshots, no one
> has been actively working on that design.

Or an even earlier series that also attempted the same thing, and was 
rejected:
https://lists.gnu.org/archive/html/qemu-devel/2016-01/msg02427.html

You need to actually propose a sane design, and not just a mapping of 
the (awkward) HMP commands into blindly identical QMP commands.


> +# @savevm:
> +#
> +# Save a VM snapshot. Without a name new snapshot is created.
> +#
> +# @name: identifier of a snapshot to be saved
> +#
> +# Returns: Nothing on success
> +#
> +# Since: 2.12

Furthermore, you've missed the 2.12 release.  The next release will be 
3.0 (although you'll find mentions of 2.13 throughout list archives, as 
the decision to use 3.0 instead of 2.13 as the next release is fairly 
recent).

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
