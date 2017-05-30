Received: from eggs.gnu.org ([2001:4830:134:3::10]:37424)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dFim9-000740-W4
	for qemu-devel@nongnu.org; Tue, 30 May 2017 11:09:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dFim9-00066z-34
	for qemu-devel@nongnu.org; Tue, 30 May 2017 11:09:37 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <149615665491.28067.17765793725374594694.stgit@bahia.lan>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <118a46f3-4913-a2d2-947e-49cd7235b86a@amsat.org>
Date: Tue, 30 May 2017 12:09:27 -0300
MIME-Version: 1.0
In-Reply-To: <149615665491.28067.17765793725374594694.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH] pc-bios/s390-ccw: use STRIP
 variable in Makefile
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-trivial@nongnu.org, Fam Zheng <famz@redhat.com>, Alexander Graf <agraf@suse.de>

On 05/30/2017 12:04 PM, Greg Kurz wrote:
> The docker-run-test-build@debian-s390x-cross target fails with:
>
> strip --strip-unneeded s390-ccw.elf -o s390-ccw.img
> strip: Unable to recognise the format of the input file `s390-ccw.elf'
>
> The configure script defines a STRIP makefile variable whose default
> value is ${cross_prefix}strip. Let's use it.
>
> Signed-off-by: Greg Kurz <groug@kaod.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  pc-bios/s390-ccw/Makefile |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/pc-bios/s390-ccw/Makefile b/pc-bios/s390-ccw/Makefile
> index 79a46b67356f..7af57dad109c 100644
> --- a/pc-bios/s390-ccw/Makefile
> +++ b/pc-bios/s390-ccw/Makefile
> @@ -22,7 +22,7 @@ s390-ccw.elf: $(OBJECTS)
>  	$(call quiet-command,$(CC) $(LDFLAGS) -o $@ $(OBJECTS),"BUILD","$(TARGET_DIR)$@")
>
>  s390-ccw.img: s390-ccw.elf
> -	$(call quiet-command,strip --strip-unneeded $< -o $@,"STRIP","$(TARGET_DIR)$@")
> +	$(call quiet-command,$(STRIP) --strip-unneeded $< -o $@,"STRIP","$(TARGET_DIR)$@")
>
>  $(OBJECTS): Makefile
>
>
>
