Received: from eggs.gnu.org ([2001:4830:134:3::10]:38259)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ecSy8-0006DN-Dd
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 04:28:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ecSy5-0004g0-86
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 04:28:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42572)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ecSy5-0004dm-1p
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 04:28:13 -0500
Date: Fri, 19 Jan 2018 09:28:08 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20180119092808.GC16798@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <5A61B1CB02000078001A0368@prv-mh.provo.novell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5A61B1CB02000078001A0368@prv-mh.provo.novell.com>
Subject: Re: [Qemu-devel] [PATCH] allow to build with older sed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jan Beulich <JBeulich@suse.com>
Cc: qemu-devel@nongnu.org

On Fri, Jan 19, 2018 at 12:52:27AM -0700, Jan Beulich wrote:
> sed's -E option may not be supported by older distros. As there's no
> point using sed here at all, use just shell mechanisms to establish the
> variable values, starting from the stem instead of the full target.
> 
> Signed-off-by: Jan Beulich <jbeulich@suse.com>

Reviewed-by: Daniel P. Berrange <berrange@redhat.com>

> --- a/Makefile
> +++ b/Makefile
> @@ -242,8 +242,7 @@ GENERATED_FILES += $(KEYCODEMAP_FILES)
>  
>  ui/input-keymap-%.c: $(KEYCODEMAP_GEN) $(KEYCODEMAP_CSV) $(SRC_PATH)/ui/Makefile.objs
>  	$(call quiet-command,\
> -	    src=$$(echo $@ | sed -E -e "s,^ui/input-keymap-(.+)-to-(.+)\.c$$,\1,") && \
> -	    dst=$$(echo $@ | sed -E -e "s,^ui/input-keymap-(.+)-to-(.+)\.c$$,\2,") && \
> +	    stem=$* && src=$${stem%-to-*} dst=$${stem#*-to-} && \
>  	    test -e $(KEYCODEMAP_GEN) && \
>  	    $(PYTHON) $(KEYCODEMAP_GEN) \
>  	          --lang glib2 \

Clever ! I was hoping someone might suggest a cleaner approach one day

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
