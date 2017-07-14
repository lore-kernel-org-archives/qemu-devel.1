Received: from eggs.gnu.org ([2001:4830:134:3::10]:44072)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dW2vo-0000E5-Jj
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 11:55:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dW2vn-0003kS-MU
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 11:55:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56208)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1dW2vn-0003jw-GB
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 11:55:03 -0400
References: <20170714152820.24034-1-dgilbert@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <713e6b4a-137d-b589-ca30-82180821f032@redhat.com>
Date: Fri, 14 Jul 2017 11:55:00 -0400
MIME-Version: 1.0
In-Reply-To: <20170714152820.24034-1-dgilbert@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] tests/ahci-test: Be mean with RAM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>, qemu-devel@nongnu.org, peter.maydell@linaro.org



On 07/14/2017 11:28 AM, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> The migration tests used two VMs each with -m 1024 this caused
> problems when run in some small, pessimistic test VMs (netbsd).
> We can just be meaner with the amount of RAM in the test and use -m 384
> 
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  tests/ahci-test.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/tests/ahci-test.c b/tests/ahci-test.c
> index ef17629345..999121bb7c 100644
> --- a/tests/ahci-test.c
> +++ b/tests/ahci-test.c
> @@ -1132,9 +1132,9 @@ static void test_migrate_sanity(void)
>      AHCIQState *src, *dst;
>      char *uri = g_strdup_printf("unix:%s", mig_socket);
>  
> -    src = ahci_boot("-m 1024 -M q35 "
> +    src = ahci_boot("-m 384 -M q35 "
>                      "-drive if=ide,file=%s,format=%s ", tmp_path, imgfmt);
> -    dst = ahci_boot("-m 1024 -M q35 "
> +    dst = ahci_boot("-m 384 -M q35 "
>                      "-drive if=ide,file=%s,format=%s "
>                      "-incoming %s", tmp_path, imgfmt, uri);
>  
> @@ -1157,10 +1157,10 @@ static void ahci_migrate_simple(uint8_t cmd_read, uint8_t cmd_write)
>      unsigned char *rx = g_malloc0(bufsize);
>      char *uri = g_strdup_printf("unix:%s", mig_socket);
>  
> -    src = ahci_boot_and_enable("-m 1024 -M q35 "
> +    src = ahci_boot_and_enable("-m 384 -M q35 "
>                                 "-drive if=ide,format=%s,file=%s ",
>                                 imgfmt, tmp_path);
> -    dst = ahci_boot("-m 1024 -M q35 "
> +    dst = ahci_boot("-m 384 -M q35 "
>                      "-drive if=ide,format=%s,file=%s "
>                      "-incoming %s", imgfmt, tmp_path, uri);
>  
> 

Totally.

Reviewed-by: John Snow <jsnow@redhat.com>

Thanks, applied to my IDE tree:

https://github.com/jnsnow/qemu/commits/ide
https://github.com/jnsnow/qemu.git

--js
