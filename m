Received: from eggs.gnu.org ([209.51.188.92]:33966)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mprivozn@redhat.com>) id 1hJDLq-0008Ch-1Q
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 04:33:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mprivozn@redhat.com>) id 1hJDBh-0004Ev-Ls
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 04:23:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:25642)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mprivozn@redhat.com>) id 1hJDBW-00044C-1W
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 04:23:21 -0400
References: <20190423212246.3542-1-ehabkost@redhat.com>
From: Michal Privoznik <mprivozn@redhat.com>
Message-ID: <6d2f330c-dcff-52d5-52c8-92f152f97e2b@redhat.com>
Date: Wed, 24 Apr 2019 10:23:06 +0200
MIME-Version: 1.0
In-Reply-To: <20190423212246.3542-1-ehabkost@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/3] Export machine type deprecation info
 through QMP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>

On 4/23/19 11:22 PM, Eduardo Habkost wrote:
> This series adds machine type deprecation information to the
> output of the `query-machines` QMP command.  With this, libvirt
> and management software will be able to show this information to
> users and/or suggest changes to VM configuration to avoid
> deprecated machine types.
> 
> Eduardo Habkost (3):
>    qapi: SupportStatusInfo struct
>    machine: Use SupportStatusInfo for deprecation info
>    qmp: Add deprecation information to query-machines
> 
>   qapi/common.json                   | 24 ++++++++++++++++++++++++
>   qapi/misc.json                     |  5 ++++-
>   include/hw/boards.h                |  7 ++++---
>   hw/i386/pc_piix.c                  |  4 +++-
>   hw/ppc/prep.c                      |  4 +++-
>   vl.c                               | 19 +++++++++++++++----
>   tests/acceptance/query_machines.py | 27 +++++++++++++++++++++++++++
>   7 files changed, 80 insertions(+), 10 deletions(-)
>   create mode 100644 tests/acceptance/query_machines.py
> 

ACK.

Now we need to think how to deal with this in libvirt. Whether it's 
sufficient to expose this in capabilities XML or libvirt needs to do 
something more.

Michal
