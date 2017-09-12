Received: from eggs.gnu.org ([2001:4830:134:3::10]:46284)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1drkMA-000762-6Y
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 08:32:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1drkM4-0000ng-Md
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 08:31:58 -0400
References: <20170809215510.22802-1-pbonzini@redhat.com>
	<20170809215510.22802-8-pbonzini@redhat.com>
	<20170912104005.GF29136@localhost.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c8262464-87aa-71b6-ffa0-4af8411a9bea@redhat.com>
Date: Tue, 12 Sep 2017 14:31:39 +0200
MIME-Version: 1.0
In-Reply-To: <20170912104005.GF29136@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 07/12] qemu-iotests: disintegrate more
 parts of common.config
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org

On 12/09/2017 12:40, Kevin Wolf wrote:
> Am 09.08.2017 um 23:55 hat Paolo Bonzini geschrieben:
>> Split "check" parts from tests part.
>>
>> For the directory setup, the actual computation of directories goes
>> in "check", while the sanity checks go in the tests.
>>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> 
> Same comment as for patch 1, we may want to keep this working.

Can you explain what is the use case?  For local symlinks I (sort of)
understand it, but not here.  This as far as I understand is code that
never runs.

My preferred alternatives would be one of these:

- add a patch 13 that restores the local symlink feature on top of the
cleaned up code.

- later, rewrite "check" in Python now that it is clear what code is
part of it and what code is part of the tests.

or:

- leave local symlinks broken

- when "check" is rewritten in Python, add a configuration mechanism
based on .ini file syntax that replaces the local symlinks.

What do you think?

Paolo
