Received: from eggs.gnu.org ([2001:4830:134:3::10]:44159)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dk8ie-00061K-1P
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 08:55:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dk8iY-0007Df-Iu
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 08:55:44 -0400
Date: Tue, 22 Aug 2017 14:55:05 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170822145505.643f74fa@nial.brq.redhat.com>
In-Reply-To: <1502117160-24655-13-git-send-email-armbru@redhat.com>
References: <1502117160-24655-1-git-send-email-armbru@redhat.com>
	<1502117160-24655-13-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 12/56] pc-dimm: Make size and address
 unsigned in QAPI/QMP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org, quintela@redhat.com, jcody@redhat.com, dgilbert@redhat.com, mreitz@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com, jsnow@redhat.com

On Mon,  7 Aug 2017 16:45:16 +0200
Markus Armbruster <armbru@redhat.com> wrote:

> Sizes and addresses should use QAPI type 'size' (uint64_t).
> PCDIMMDeviceInfo members @addr and @size are 'int' (int64_t).
> qmp_pc_dimm_device_list() implicitly converts from uint64_t.
> 
> Change these PCDIMMDeviceInfo members to 'size'.
> 
> query-memory-devices now reports sizes and addresses above 2^63-1
> correctly instead of their (negative) two's complement.
> 
> HMP's "info memory-devices" already reported them correctly, because
> it printed the signed integers with PRIx64 and PRIu32.
s/signed/unsigned/

 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  qapi-schema.json | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/qapi-schema.json b/qapi-schema.json
> index 23eb60d..6aa6be9 100644
> --- a/qapi-schema.json
> +++ b/qapi-schema.json
> @@ -6057,8 +6057,8 @@
>  ##
>  { 'struct': 'PCDIMMDeviceInfo',
>    'data': { '*id': 'str',
> -            'addr': 'int',
> -            'size': 'int',
> +            'addr': 'size',
> +            'size': 'size',
>              'slot': 'int',
>              'node': 'int',
>              'memdev': 'str',
