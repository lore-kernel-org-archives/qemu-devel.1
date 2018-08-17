Received: from eggs.gnu.org ([2001:4830:134:3::10]:35442)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fqh2z-0006a7-Ui
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 11:52:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fqh2y-0001Le-4T
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 11:52:21 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57750 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fqh2x-0001LQ-Vj
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 11:52:20 -0400
References: <20180817150559.16243-1-armbru@redhat.com>
	<20180817150559.16243-7-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8f9c54b6-337f-5b39-8cb4-70697c43ce5a@redhat.com>
Date: Fri, 17 Aug 2018 10:52:17 -0500
MIME-Version: 1.0
In-Reply-To: <20180817150559.16243-7-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 06/60] test-qga: Clean up how we test
 QGA synchronization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com

On 08/17/2018 10:05 AM, Markus Armbruster wrote:
> To permit recovering from arbitrary JSON parse errors, the JSON parser
> resets itself on lexical errors.  We recommend sending a 0xff byte for
> that purpose, and test-qga covers this usage since commit 5229564b832.
> That commit had to add an ugly hack to qmp_fd_vsend() to make capable
> of sending this byte (it's designed to send only valid JSON).
> 
> The previous commit added a way to send arbitrary text.  Put that to
> use for this purpose, and drop the hack from qmp_fd_vsend().
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   tests/libqtest.c | 39 +++++++++++++++++++++------------------
>   tests/libqtest.h |  2 ++
>   tests/test-qga.c |  3 ++-
>   3 files changed, 25 insertions(+), 19 deletions(-)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
