Received: from eggs.gnu.org ([2001:4830:134:3::10]:50734)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dkPZg-0005Gl-4s
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 02:55:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dkPZc-0000ud-9j
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 02:55:36 -0400
References: <20170822131832.20191-1-pbonzini@redhat.com>
	<20170822131832.20191-11-pbonzini@redhat.com>
	<20170823044926.GB21343@lemon>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <592543c5-cc4c-332a-8169-cf6402ee86e3@redhat.com>
Date: Wed, 23 Aug 2017 08:55:24 +0200
MIME-Version: 1.0
In-Reply-To: <20170823044926.GB21343@lemon>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 10/10] scsi: add persistent reservation
 manager using qemu-pr-helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org

On 23/08/2017 06:49, Fam Zheng wrote:
>> + * Persistent reservation manager that talks to qemu-mpath-helper
> s/qemu-mpath-helper/qemu-pr-helper/

Oops, you got a glimpse into the history of the patches. :)  (it was
first designed for multipath only, then decided that generic PR support
would be both useful and easier to debug and test).

>> + *
>> + * Author: Paolo Bonzini <pbonzini@redhat.com>
>> + *
>> + * This code is licensed under the LGPL.
> 
> Interesting, I think the version of the license is required?

Cut and paste, will fix.

Paolo
