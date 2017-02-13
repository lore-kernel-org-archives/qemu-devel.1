Received: from eggs.gnu.org ([2001:4830:134:3::10]:53054)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cdDXH-00064R-74
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 05:07:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cdDXB-0006yr-NX
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 05:07:07 -0500
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:33806)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cdDXB-0006xg-H0
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 05:07:01 -0500
Received: by mail-wr0-x242.google.com with SMTP id 89so23288180wrr.1
	for <qemu-devel@nongnu.org>; Mon, 13 Feb 2017 02:07:00 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20170213095148.25500-1-lma@suse.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d244306c-36df-bb23-3dad-6706545e2476@redhat.com>
Date: Mon, 13 Feb 2017 11:07:00 +0100
MIME-Version: 1.0
In-Reply-To: <20170213095148.25500-1-lma@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 RESEND] Makefile: Fix owner and group
 for qemu-version.h.tmp
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Lin Ma <lma@suse.com>, qemu-devel@nongnu.org
Cc: famz@redhat.com, stefanha@redhat.com



On 13/02/2017 10:51, Lin Ma wrote:
> By commit 67a1de0d, When we perform 'git pull && make && sudo make install',
> In 'make' stage a qemu-version.h.tmp will be generated. If the content of
> qemu-version.h.tmp and qemu-version.h aren't consistent, The qemu-version.h.tmp
> will be renamed to qemu-version.h. Because of the target FORCE, The same action
> will be do again in 'make install' stage.

But why does the content of .h and .h.tmp not match during "make install"?

Paolo

> diff --git a/Makefile b/Makefile
> index 1a8bfb2..1ca45b2 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -184,7 +184,7 @@ qemu-version.h: FORCE
>  				printf '""\n'; \
>  			fi; \
>  		fi) > $@.tmp)
> -	$(call quiet-command, cmp -s $@ $@.tmp || mv $@.tmp $@)
> +	$(call quiet-command, cmp -s $@ $@.tmp || cp $@.tmp $@)
