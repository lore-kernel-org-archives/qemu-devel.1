Received: from eggs.gnu.org ([2001:4830:134:3::10]:59620)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1e1xEx-0007E6-G4
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 12:18:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1e1xEt-0004MH-HK
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 12:18:43 -0400
Received: from mail-wm0-f54.google.com ([74.125.82.54]:49651)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1e1xEt-0004Lu-BM
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 12:18:39 -0400
Received: by mail-wm0-f54.google.com with SMTP id b189so6657575wmd.4
	for <qemu-devel@nongnu.org>; Tue, 10 Oct 2017 09:18:39 -0700 (PDT)
References: <20170919165226.23022-1-marcandre.lureau@redhat.com>
	<20170919165226.23022-4-marcandre.lureau@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <205093eb-c261-e38a-a74f-c02b5937e761@redhat.com>
Date: Tue, 10 Oct 2017 18:18:35 +0200
MIME-Version: 1.0
In-Reply-To: <20170919165226.23022-4-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 03/27] build-sys: make vhost-user-scsi
 depend on libvhost-user.a
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: felipe@nutanix.com, changpeng.liu@intel.com, f4bug@amsat.org

On 19/09/2017 18:52, Marc-André Lureau wrote:
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  Makefile      | 2 +-
>  Makefile.objs | 1 -
>  2 files changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index 8a64b6afb0..e0aeb77854 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -475,7 +475,7 @@ ivshmem-client$(EXESUF): $(ivshmem-client-obj-y) $(COMMON_LDADDS)
>  ivshmem-server$(EXESUF): $(ivshmem-server-obj-y) $(COMMON_LDADDS)
>  	$(call LINK, $^)
>  endif
> -vhost-user-scsi$(EXESUF): $(vhost-user-scsi-obj-y)
> +vhost-user-scsi$(EXESUF): $(vhost-user-scsi-obj-y) libvhost-user.a
>  	$(call LINK, $^)
>  
>  module_block.h: $(SRC_PATH)/scripts/modules/module_block.py config-host.mak
> diff --git a/Makefile.objs b/Makefile.objs
> index 3a6914c56c..de2d92f8cb 100644
> --- a/Makefile.objs
> +++ b/Makefile.objs
> @@ -115,7 +115,6 @@ libvhost-user-obj-y = contrib/libvhost-user/
>  vhost-user-scsi.o-cflags := $(LIBISCSI_CFLAGS)
>  vhost-user-scsi.o-libs := $(LIBISCSI_LIBS)
>  vhost-user-scsi-obj-y = contrib/vhost-user-scsi/
> -vhost-user-scsi-obj-y += contrib/libvhost-user/libvhost-user.o
>  
>  ######################################################################
>  trace-events-subdirs =
> 

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
