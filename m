Received: from eggs.gnu.org ([2001:4830:134:3::10]:45412)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fj2dM-0005gD-4S
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 09:18:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fj2dI-00013k-5b
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 09:18:16 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46356 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fj2dI-00013Y-07
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 09:18:12 -0400
References: <20180727062204.10401-1-armbru@redhat.com>
	<20180727062204.10401-2-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <3d7d621c-19d0-6c02-f34f-cfd4e3e6afbe@redhat.com>
Date: Fri, 27 Jul 2018 08:18:10 -0500
MIME-Version: 1.0
In-Reply-To: <20180727062204.10401-2-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/2] qstring: Assert size calculations
 don't overflow
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: liujunjie23@huawei.com

On 07/27/2018 01:22 AM, Markus Armbruster wrote:
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   qobject/qstring.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

> 
> diff --git a/qobject/qstring.c b/qobject/qstring.c
> index 18b8eb82f8..1bb7784a88 100644
> --- a/qobject/qstring.c
> +++ b/qobject/qstring.c
> @@ -41,17 +41,19 @@ QString *qstring_from_substr(const char *str, size_t start, size_t end)
>   {
>       QString *qstring;
>   
> +    assert(start <= end + 1);

Could also be spelled assert(start < end), but the next patch gets rid 
of the +1 so this form is fine.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
