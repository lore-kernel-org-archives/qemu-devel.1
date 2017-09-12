Received: from eggs.gnu.org ([2001:4830:134:3::10]:55423)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1droI4-0003Gw-UO
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 12:44:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1droI1-0002UR-LU
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 12:44:00 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:34837)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1droI1-0002UH-H9
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 12:43:57 -0400
Received: by mail-qk0-x243.google.com with SMTP id o77so7507061qke.2
	for <qemu-devel@nongnu.org>; Tue, 12 Sep 2017 09:43:57 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170823162004.27337-1-marcandre.lureau@redhat.com>
	<20170823162004.27337-26-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <9c5257e7-45cc-82d3-07b0-dcae77a1b8ac@amsat.org>
Date: Tue, 12 Sep 2017 13:43:53 -0300
MIME-Version: 1.0
In-Reply-To: <20170823162004.27337-26-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 25/27] build-sys: fix libvhost-user.a build
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: changpeng.liu@intel.com, felipe@nutanix.com

On 08/23/2017 01:20 PM, Marc-André Lureau wrote:
> And actually link to it from vhost-user-bridge.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>   Makefile               | 3 ++-
>   tests/Makefile.include | 2 +-
>   2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index 81447b1f08..654b47b9d9 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -345,7 +345,7 @@ dtc/%:
>   	mkdir -p $@
>   
>   $(SUBDIR_RULES): libqemuutil.a libqemustub.a $(common-obj-y) $(chardev-obj-y) \
> -	$(qom-obj-y) $(crypto-aes-obj-$(CONFIG_USER_ONLY))
> +	$(qom-obj-y) $(crypto-aes-obj-$(CONFIG_USER_ONLY)) libvhost-user.a
>   
>   ROMSUBDIR_RULES=$(patsubst %,romsubdir-%, $(ROMS))
>   # Only keep -O and -g cflags
> @@ -366,6 +366,7 @@ Makefile: $(version-obj-y)
>   
>   libqemustub.a: $(stub-obj-y)
>   libqemuutil.a: $(util-obj-y) $(trace-obj-y)
> +libvhost-user.a: $(libvhost-user-obj-y)
>   
>   ######################################################################
>   
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index 37c1bed683..1ca88ef9d2 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -786,7 +786,7 @@ tests/test-filter-redirector$(EXESUF): tests/test-filter-redirector.o $(qtest-ob
>   tests/test-x86-cpuid-compat$(EXESUF): tests/test-x86-cpuid-compat.o $(qtest-obj-y)
>   tests/ivshmem-test$(EXESUF): tests/ivshmem-test.o contrib/ivshmem-server/ivshmem-server.o $(libqos-pc-obj-y) $(libqos-spapr-obj-y)
>   tests/megasas-test$(EXESUF): tests/megasas-test.o $(libqos-spapr-obj-y) $(libqos-pc-obj-y)
> -tests/vhost-user-bridge$(EXESUF): tests/vhost-user-bridge.o contrib/libvhost-user/libvhost-user.o $(test-util-obj-y)
> +tests/vhost-user-bridge$(EXESUF): tests/vhost-user-bridge.o $(test-util-obj-y) libvhost-user.a
>   tests/test-uuid$(EXESUF): tests/test-uuid.o $(test-util-obj-y)
>   tests/test-arm-mptimer$(EXESUF): tests/test-arm-mptimer.o
>   tests/test-qapi-util$(EXESUF): tests/test-qapi-util.o $(test-util-obj-y)
> 
