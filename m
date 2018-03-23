Received: from eggs.gnu.org ([2001:4830:134:3::10]:34953)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ezOx3-0006i6-Tt
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 11:49:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ezOwz-0005Xn-CA
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 11:49:57 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56244 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ezOwz-0005XS-7A
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 11:49:53 -0400
References: <20180323140821.28957-1-peterx@redhat.com>
	<20180323140821.28957-2-peterx@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <bcea82bf-0ff8-4af6-add9-2f4f283ba833@redhat.com>
Date: Fri, 23 Mar 2018 10:49:31 -0500
MIME-Version: 1.0
In-Reply-To: <20180323140821.28957-2-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.12 1/4] Revert "monitor: enable IO
 thread for (qmp & !mux) typed"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Auger <eric.auger@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

On 03/23/2018 09:08 AM, Peter Xu wrote:
> This reverts commit 3fd2457d18edf5736f713dfe1ada9c87a9badab1.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>

Not fatal to taking this patch as-is, but it's always nice to include a 
rationale when reverting, something along the lines of:

It turns out that enabling OOB caused several iotests to break; 
disabling OOB is the fastest and safest approach for reducing the risk 
of a broken release, while working on the fixes for the problems uncovered.

(Probably similar comments will be needed on the remaining patches...)

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
