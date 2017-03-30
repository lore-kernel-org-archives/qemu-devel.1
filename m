Received: from eggs.gnu.org ([2001:4830:134:3::10]:51184)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ctTxl-0004g6-MW
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 02:53:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ctTxk-0002dQ-UN
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 02:53:41 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1490805920-17029-1-git-send-email-armbru@redhat.com>
	<1490805920-17029-7-git-send-email-armbru@redhat.com>
	<dbf432c4-405c-9197-3795-8f2600edaf38@redhat.com>
Date: Thu, 30 Mar 2017 08:53:34 +0200
In-Reply-To: <dbf432c4-405c-9197-3795-8f2600edaf38@redhat.com> (Max Reitz's
	message of "Wed, 29 Mar 2017 21:42:44 +0200")
Message-ID: <87bmsjfe6p.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [for-2.9 6/8] qapi-schema: SocketAddressFlat
 variants 'vsock' and 'fd'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, qemu-block@nongnu.org, mitake.hitoshi@lab.ntt.co.jp, jcody@redhat.com, pbonzini@redhat.com, namei.unix@gmail.com

Max Reitz <mreitz@redhat.com> writes:

> On 29.03.2017 18:45, Markus Armbruster wrote:
>> Note that the new variants are impossible in qemu_gluster_glfs_init(),
>> because the gconf->server can only come from qemu_gluster_parse_uri()
>> or qemu_gluster_parse_json(), and neither can create anything but
>> 'tcp' or 'unix'.
>
> s/tcp/inet/

Fixing...

>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  block/gluster.c  |  2 ++
>>  qapi-schema.json | 19 ++++++++-----------
>>  2 files changed, 10 insertions(+), 11 deletions(-)
>> 
>
> Reviewed-by: Max Reitz <mreitz@redhat.com>

Thanks!
