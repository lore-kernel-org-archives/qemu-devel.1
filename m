Received: from eggs.gnu.org ([2001:4830:134:3::10]:48161)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cWoB4-0006KB-8M
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 12:49:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cWoB3-0007ce-GM
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 12:49:42 -0500
Received: from relay4-d.mail.gandi.net ([2001:4b98:c:538::196]:33417)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cWoB3-0007bv-AK
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 12:49:41 -0500
References: <20170126171613.1399-1-stefanha@redhat.com>
	<20170126171613.1399-2-stefanha@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <093d4dea-2486-8542-fb38-2d71d3d18ef8@redhat.com>
Date: Thu, 26 Jan 2017 11:49:36 -0600
MIME-Version: 1.0
In-Reply-To: <20170126171613.1399-2-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 1/2] qapi: add missing
 trace_visit_type_enum() call
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org

On 01/26/2017 11:16 AM, Stefan Hajnoczi wrote:
> A trace event exists for enums but it's never called.  This patch fixes
> this oversight so that enums are traced just like the other QAPI types.
> 
> Suggested-by: Daniel P. Berrange <berrange@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  qapi/qapi-visit-core.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Eric Blake <eblake@redhat.com>

> 
> diff --git a/qapi/qapi-visit-core.c b/qapi/qapi-visit-core.c
> index 63bd97b..e6e93f0 100644
> --- a/qapi/qapi-visit-core.c
> +++ b/qapi/qapi-visit-core.c
> @@ -374,6 +374,7 @@ void visit_type_enum(Visitor *v, const char *name, int *obj,
>                       const char *const strings[], Error **errp)
>  {
>      assert(obj && strings);
> +    trace_visit_type_enum(v, name, obj);
>      switch (v->type) {
>      case VISITOR_INPUT:
>          input_type_enum(v, name, obj, strings, errp);
> 

-- 
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org
