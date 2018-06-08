Received: from eggs.gnu.org ([2001:4830:134:3::10]:36747)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fRA6X-0004WK-Vs
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 01:38:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fRA6V-0003Kk-7J
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 01:38:29 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50810 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fRA6V-0003KS-2P
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 01:38:27 -0400
References: <20180607223111.27792-1-ross.zwisler@linux.intel.com>
	<20180607223111.27792-4-ross.zwisler@linux.intel.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <17f8856c-48d9-d112-cd7f-e1b3679d2f43@redhat.com>
Date: Fri, 8 Jun 2018 07:38:17 +0200
MIME-Version: 1.0
In-Reply-To: <20180607223111.27792-4-ross.zwisler@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu PATCH 4/5] machine: fix some misspelled words
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ross Zwisler <ross.zwisler@linux.intel.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, linux-nvdimm <linux-nvdimm@lists.01.org>, Qemu Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Dan Williams <dan.j.williams@intel.com>

On 08.06.2018 00:31, Ross Zwisler wrote:
> Normally this might not be worth fixing, but several of these are strings
> which are displayed to users.
> 
> Signed-off-by: Ross Zwisler <ross.zwisler@linux.intel.com>
> ---
>  hw/core/machine.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index 617e5f8d75..a21269fa39 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -609,7 +609,7 @@ static void machine_class_init(ObjectClass *oc, void *data)
>          machine_get_igd_gfx_passthru, machine_set_igd_gfx_passthru,
>          &error_abort);
>      object_class_property_set_description(oc, "igd-passthru",
> -        "Set on/off to enable/disable igd passthrou", &error_abort);
> +        "Set on/off to enable/disable igd passthru", &error_abort);

Shouldn't that rather be "passthrough" instead?

 Thomas
