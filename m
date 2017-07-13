Received: from eggs.gnu.org ([2001:4830:134:3::10]:51840)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dVhTz-0003ZU-2P
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 13:00:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dVhTw-00046Y-1T
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 13:00:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33358)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dVhTv-00045U-R2
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 13:00:51 -0400
References: <1499964378-24344-1-git-send-email-mst@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c491c6ee-67ed-e7a0-4294-b128f63d6841@redhat.com>
Date: Thu, 13 Jul 2017 19:00:42 +0200
MIME-Version: 1.0
In-Reply-To: <1499964378-24344-1-git-send-email-mst@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] tests: switch pxe and vm gen id tests to
 use kvm
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Ben Warren <ben@skyportsystems.com>

On 13/07/2017 18:47, Michael S. Tsirkin wrote:
> Speed up tests on host systems with kvm support.
> 
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Thomas Huth <thuth@redhat.com>
> Cc: Laurent Vivier <lvivier@redhat.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
> 
> This is on top of my previous patch fixing vmgenid.
> 
> PPC PXE test is reported to be especially slow - does anyone care to try
> it and measure whether this helps?
> 
>  tests/pxe-test.c     | 2 +-
>  tests/vmgenid-test.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/pxe-test.c b/tests/pxe-test.c
> index 34282d3..cf6e225 100644
> --- a/tests/pxe-test.c
> +++ b/tests/pxe-test.c
> @@ -25,7 +25,7 @@ static void test_pxe_one(const char *params, bool ipv6)
>  {
>      char *args;
>  
> -    args = g_strdup_printf("-machine accel=tcg -nodefaults -boot order=n "
> +    args = g_strdup_printf("-machine accel=kvm:tcg -nodefaults -boot order=n "
>                             "-netdev user,id=" NETNAME ",tftp=./,bootfile=%s,"
>                             "ipv4=%s,ipv6=%s %s", disk, ipv6 ? "off" : "on",
>                             ipv6 ? "on" : "off", params);
> diff --git a/tests/vmgenid-test.c b/tests/vmgenid-test.c
> index 0556ba2..6477dcc 100644
> --- a/tests/vmgenid-test.c
> +++ b/tests/vmgenid-test.c
> @@ -132,7 +132,7 @@ static char disk[] = "tests/vmgenid-test-disk-XXXXXX";
>  
>  static char *guid_cmd_strdup(const char *guid)
>  {
> -    return g_strdup_printf("-machine accel=tcg "
> +    return g_strdup_printf("-machine accel=kvm:tcg "
>                             "-device vmgenid,id=testvgid,guid=%s "
>                             "-drive id=hd0,if=none,file=%s,format=raw "
>                             "-device ide-hd,drive=hd0 ",
> 


Acked-by: Paolo Bonzini <pbonzini@redhat.com>

Thanks,

Paolo
