Received: from eggs.gnu.org ([2001:4830:134:3::10]:48056)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gSTEy-00064g-QX
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 15:48:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gSTEu-0004el-6a
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 15:48:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39488)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gSTEu-0004eX-0G
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 15:48:48 -0500
References: <1543513531-1151-1-git-send-email-pbonzini@redhat.com>
	<1543513531-1151-2-git-send-email-pbonzini@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6d6ac493-d383-832e-2057-d292b7590a28@redhat.com>
Date: Thu, 29 Nov 2018 14:48:46 -0600
MIME-Version: 1.0
In-Reply-To: <1543513531-1151-2-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/2] test: execute g_test_run when tests
 are skipped
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, berrange@redhat.com

On 11/29/18 11:45 AM, Paolo Bonzini wrote:
> Sometimes a test's main() function recognizes that the environment
> does not support the test, and therefore exits.  In this case, we
> still should run g_test_run() so that a TAP harness will print the
> test plan ("1..0") and the test will be marked as skipped.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   tests/cdrom-test.c     | 2 +-
>   tests/migration-test.c | 8 ++++----
>   2 files changed, 5 insertions(+), 5 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
