Received: from eggs.gnu.org ([2001:4830:134:3::10]:51807)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dhHla-00076q-K8
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 11:58:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dhHlU-0007LF-Ts
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 11:58:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40512)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dhHlU-0007L7-Nu
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 11:58:52 -0400
Date: Mon, 14 Aug 2017 18:58:49 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170814185545-mutt-send-email-mst@kernel.org>
References: <20170814084838.12233-1-wei.yang@ucloud.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170814084838.12233-1-wei.yang@ucloud.cn>
Subject: Re: [Qemu-devel] [PATCH] bios-tables-test: delete a assert about
 block name
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: wei.yang@ucloud.cn
Cc: imammedo@redhat.com, qemu-devel@nongnu.org

On Mon, Aug 14, 2017 at 04:48:38PM +0800, wei.yang@ucloud.cn wrote:
> From: Wei Yang <wei.yang@ucloud.cn>
> 
> The assert would be touched when the version of acpica is greater than or
> equal to 20160318. its reason is that "Disasembler: Update a couple
> output items(commit id: 1ecbb3d)" is introduced by Robert, the patch
> emits the AML filename as a zero-length string, and allows the compiler
> to create the name later.

So how does the output look then? Do you mean there's no comma then?


> 
> Signed-off-by: Yang, Wei <wei.yang@ucloud.com>
> CC: Michael S. Tsirkin <mst@redhat.com>
> CC: Igor Mammedov <imammedo@redhat.com>
> CC: qemu-devel@nongnu.org
> ---
>  tests/bios-tables-test.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
> index 88dbf97853..d2ab073848 100644
> --- a/tests/bios-tables-test.c
> +++ b/tests/bios-tables-test.c
> @@ -350,7 +350,6 @@ static GString *normalize_asl(gchar *asl_code)
>      /* strip def block name (it has file path in it) */
>      if (g_str_has_prefix(asl->str, DEF_BLOCK)) {
>          block_name = g_strstr_len(asl->str, asl->len, BLOCK_NAME_END);
> -        g_assert(block_name);
>          asl = g_string_erase(asl, 0,
>                               block_name + sizeof(BLOCK_NAME_END) - asl->str);

The pointer math here won't do the right thing then, will it?

>      }
> -- 
> 2.11.0
> 
