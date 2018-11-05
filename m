Received: from eggs.gnu.org ([2001:4830:134:3::10]:59590)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gJo2e-0001RL-Le
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 18:12:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gJnsW-0007cJ-TM
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 18:01:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47426)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gJnsW-0007b2-Ja
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 18:01:52 -0500
References: <1541156463-2730-1-git-send-email-liq3ea@gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <64f88d81-8de1-a4b3-196f-c5c95a45e4e5@redhat.com>
Date: Mon, 5 Nov 2018 17:01:50 -0600
MIME-Version: 1.0
In-Reply-To: <1541156463-2730-1-git-send-email-liq3ea@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] qapi: misc: change the 'pc' to unsinged 64
 in CpuInfo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@gmail.com>, armbru@redhat.com
Cc: qemu-devel@nongnu.org

On 11/2/18 6:01 AM, Li Qiang wrote:
> When trigger a 'query-cpus' qmp, the pc is an signed value like
> following:
> {"arch": "x86", ...  "pc": -1732653994, "halted": true,...}
> It is strange. Change it to uint64_t.
> 
> Signed-off-by: Li Qiang <liq3ea@gmail.com>
> ---
>   qapi/misc.json | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)

I don't see this as causing any major backwards-incompatible behavior to 
clients that can parse full 64-bit unsigned numbers (note that not all 
JSON parsers do so - here's frowning at you, jansson - but libvirt is okay).

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
