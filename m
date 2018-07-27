Received: from eggs.gnu.org ([2001:4830:134:3::10]:46696)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fj4kC-00070Q-Ei
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 11:33:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fj4k9-0001EL-Bk
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 11:33:28 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60408 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fj4k9-0001Dw-6z
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 11:33:25 -0400
References: <20180727151359.29061-1-armbru@redhat.com>
	<20180727151359.29061-9-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a8fbacd1-170e-bd10-c772-81ffb55a388c@redhat.com>
Date: Fri, 27 Jul 2018 10:33:23 -0500
MIME-Version: 1.0
In-Reply-To: <20180727151359.29061-9-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 08/23] test-qobject-input-visitor: Avoid
 format string ambiguity
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: thuth@redhat.com, f4bug@amsat.org

On 07/27/2018 10:13 AM, Markus Armbruster wrote:
> When visitor_input_test_init_internal()'s argument @ap is null, then
> @json_string is interpreted literally, else it's gets %-escapes
> interpolated.  This is awkward.
> 
> One caller always passes null @ap, and the others never do.  Lift the
> building of the QObject into the callers, where it can be done without
> such ambiguity.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   tests/test-qobject-input-visitor.c | 19 ++++++++++---------
>   1 file changed, 10 insertions(+), 9 deletions(-)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
