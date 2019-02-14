Received: from eggs.gnu.org ([209.51.188.92]:47076)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1guNlc-00025d-UJ
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 15:37:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1guNlb-0004Hv-8D
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 15:37:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38814)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1guNla-0004Fi-VK
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 15:37:55 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D38D580E7C
	for <qemu-devel@nongnu.org>; Thu, 14 Feb 2019 20:37:53 +0000 (UTC)
References: <1550165756-21617-1-git-send-email-pbonzini@redhat.com>
	<20190214142251-mutt-send-email-mst@kernel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <dc4366ec-cbb7-47f6-d705-22edf680dfe6@redhat.com>
Date: Thu, 14 Feb 2019 21:37:42 +0100
MIME-Version: 1.0
In-Reply-To: <20190214142251-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 0/9] vhost: enable for all targets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, thuth@redhat.com

On 14/02/19 20:28, Michael S. Tsirkin wrote:
> On Thu, Feb 14, 2019 at 06:35:47PM +0100, Paolo Bonzini wrote:
>> See also "[PATCH for-3.2 00/10] vhost: preparation for qgraph
>> conversion of vhost-user-test".  Some of the other vhost-user-test
>> patches have gone in already, and this is what is left.
>>
>> These patches are a prerequisite for both kconfig and qgraph.
>>
>> I will probably test them on macOS myself before these are included
>> in a pull request, since the previous versions had some issues.
>> Michael, let me know if you want me to send the pull request.
>>
>> Thanks,
>>
>> Paolo
> 
> what's the changelog from v1?

It's rebased and it includes the not-yet-merged parts of "vhost:
preparation for qgraph conversion of vhost-user-test", but otherwise
there are no changes.

Paolo

> 
>> Paolo Bonzini (9):
>>   vhost-net: move stubs to a separate file
>>   vhost-net-user: add stubs for when no virtio-net device is present
>>   vhost: restrict Linux dependency to kernel vhost
>>   vhost-user: support cross-endian vnet headers
>>   vhost-net: compile it on all targets that have virtio-net.
>>   vhost-net: revamp configure logic
>>   vhost-user-test: create a main loop per TestServer
>>   vhost-user-test: small changes to init_hugepagefs
>>   vhost-user-test: create a temporary directory per TestServer
>>
>>  backends/Makefile.objs     |   5 +-
>>  configure                  | 102 ++++++++++++++++++-----------
>>  default-configs/virtio.mak |   4 +-
>>  hw/net/Makefile.objs       |   4 +-
>>  hw/net/vhost_net-stub.c    |  92 ++++++++++++++++++++++++++
>>  hw/net/vhost_net.c         |  85 ++----------------------
>>  hw/virtio/Makefile.objs    |   8 ++-
>>  hw/virtio/vhost-backend.c  |  12 +++-
>>  hw/virtio/vhost-user.c     |  13 +++-
>>  hw/virtio/vhost.c          |   2 +-
>>  include/exec/poison.h      |   1 -
>>  net/Makefile.objs          |   4 +-
>>  net/net.c                  |   2 +-
>>  net/vhost-user-stub.c      |  23 +++++++
>>  net/vhost-user.c           |  13 ++++
>>  tests/Makefile.include     |   5 +-
>>  tests/vhost-user-test.c    | 160 +++++++++++++++++++++++----------------------
>>  17 files changed, 319 insertions(+), 216 deletions(-)
>>  create mode 100644 hw/net/vhost_net-stub.c
>>  create mode 100644 net/vhost-user-stub.c
>>
>> -- 
>> 1.8.3.1
