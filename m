Received: from eggs.gnu.org ([2001:4830:134:3::10]:47607)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dG3sJ-0005u9-5L
	for qemu-devel@nongnu.org; Wed, 31 May 2017 09:41:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dG3sH-0006qE-33
	for qemu-devel@nongnu.org; Wed, 31 May 2017 09:41:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57058)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dG3sG-0006oq-Ra
	for qemu-devel@nongnu.org; Wed, 31 May 2017 09:41:20 -0400
Date: Wed, 31 May 2017 21:41:17 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170531134117.GG6170@lemon.lan>
References: <149623617700.4947.12490877660892961664.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <149623617700.4947.12490877660892961664.stgit@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH v2] pc-bios/s390-ccw: use STRIP variable in
 Makefile
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, Cornelia Huck <cornelia.huck@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>

On Wed, 05/31 15:09, Greg Kurz wrote:
> The docker-run-test-build@debian-s390x-cross target fails with:
> 
> strip --strip-unneeded s390-ccw.elf -o s390-ccw.img
> strip: Unable to recognise the format of the input file `s390-ccw.elf'
> 
> The configure script defines a STRIP makefile variable whose default
> value is ${cross_prefix}strip. Let's use it.
> 
> We default to using the non-prefixed strip command in case --enable-debug
> or --disable-strip was passed to configure during a regular build.
> 
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
> v2: - added default value
>     - no longer Cc: qemu-trivial as it turned out to be not that trivial
> 
> Philippe,
> 
> Please give your Reviewed-by again if you're okay with this change.
> ---
>  pc-bios/s390-ccw/Makefile |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/pc-bios/s390-ccw/Makefile b/pc-bios/s390-ccw/Makefile
> index 79a46b67356f..fb88c13bc742 100644
> --- a/pc-bios/s390-ccw/Makefile
> +++ b/pc-bios/s390-ccw/Makefile
> @@ -21,8 +21,10 @@ build-all: s390-ccw.img
>  s390-ccw.elf: $(OBJECTS)
>  	$(call quiet-command,$(CC) $(LDFLAGS) -o $@ $(OBJECTS),"BUILD","$(TARGET_DIR)$@")
>  
> +STRIP ?= strip
> +
>  s390-ccw.img: s390-ccw.elf
> -	$(call quiet-command,strip --strip-unneeded $< -o $@,"STRIP","$(TARGET_DIR)$@")
> +	$(call quiet-command,$(STRIP) --strip-unneeded $< -o $@,"STRIP","$(TARGET_DIR)$@")
>  
>  $(OBJECTS): Makefile
>  
> 
> 

Reviewed-by: Fam Zheng <famz@redhat.com>
