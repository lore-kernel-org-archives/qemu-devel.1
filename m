Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4067AC432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 13:20:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D0B120833
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 13:20:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D0B120833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iagBq-0006Ug-5o
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 08:20:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50778)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iafSD-000183-1I
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 07:32:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iafS7-00058x-LT
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 07:32:54 -0500
Received: from 8.mo4.mail-out.ovh.net ([188.165.33.112]:60650)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iafS6-00050B-Lu
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 07:32:51 -0500
Received: from player714.ha.ovh.net (unknown [10.109.146.213])
 by mo4.mail-out.ovh.net (Postfix) with ESMTP id 900F621587B
 for <qemu-devel@nongnu.org>; Fri, 29 Nov 2019 13:32:47 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player714.ha.ovh.net (Postfix) with ESMTPSA id 65FC9CA4DA19;
 Fri, 29 Nov 2019 12:32:42 +0000 (UTC)
Date: Fri, 29 Nov 2019 13:32:41 +0100
From: Greg Kurz <groug@kaod.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] virtfs-proxy-helper: switch from libcap to libcap-ng
Message-ID: <20191129133241.738b70ed@bahia.w3ibm.bluemix.net>
In-Reply-To: <20191129111632.22840-2-pbonzini@redhat.com>
References: <20191129111632.22840-2-pbonzini@redhat.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 1148136431425722830
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudeiledgfeelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdqfffguegfifdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtgfesthejredtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdekvddrvdehfedrvddtkedrvdegkeenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjedugedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 188.165.33.112
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Thomas Huth <thuth@redhat.com>, berrange@redhat.com, qemu-devel@nongnu.org,
 dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 29 Nov 2019 12:16:32 +0100
Paolo Bonzini <pbonzini@redhat.com> wrote:

> virtfs-proxy-helper is the only user of libcap; everyone else is using
> the simpler libcap-ng API.  Switch and remove the configure code to
> detect libcap.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---

Nice. :)

Reviewed-by: Greg Kurz <groug@kaod.org>

Paolo,

I can take this through my 9p tree if you want. Otherwise,

Acked-by: Greg Kurz <groug@kaod.org>



Also, this calls for some extra cleanup in travis.yml and gitlab-ci.yml
which were recently amended by Thomas to install libcap-dev.

commit c269447f78b7cfb0e85d14bc7bb8cb0d25d19781
Author: Thomas Huth <thuth@redhat.com>
Date:   Thu Sep 5 13:33:46 2019 +0200

    travis.yml: Install libcap-dev for testing virito-9p

and

commit e7dc804ef0d7cac9ac8b4a1324ab7dbfafb55704
Author: Thomas Huth <thuth@redhat.com>
Date:   Thu Sep 5 12:36:50 2019 +0200

    gitlab-ci.yml: Install libattr-devel and libcap-devel to test virtio-9p



>  configure                   |  18 +------
>  fsdev/virtfs-proxy-helper.c | 100 ++++++++++++++++--------------------
>  2 files changed, 46 insertions(+), 72 deletions(-)
> 
> diff --git a/configure b/configure
> index afe9393f04..2216662bf6 100755
> --- a/configure
> +++ b/configure
> @@ -3863,22 +3863,6 @@ else
>    mpathpersist=no
>  fi
>  
> -##########################################
> -# libcap probe
> -
> -if test "$cap" != "no" ; then
> -  cat > $TMPC <<EOF
> -#include <stdio.h>
> -#include <sys/capability.h>
> -int main(void) { cap_t caps; caps = cap_init(); return caps != NULL; }
> -EOF
> -  if compile_prog "" "-lcap" ; then
> -    cap=yes
> -  else
> -    cap=no
> -  fi
> -fi
> -
>  ##########################################
>  # pthread probe
>  PTHREADLIBS_LIST="-pthread -lpthread -lpthreadGC2"
> @@ -6204,7 +6188,7 @@ if test "$want_tools" = "yes" ; then
>  fi
>  if test "$softmmu" = yes ; then
>    if test "$linux" = yes; then
> -    if test "$virtfs" != no && test "$cap" = yes && test "$attr" = yes ; then
> +    if test "$virtfs" != no && test "$cap_ng" = yes && test "$attr" = yes ; then
>        virtfs=yes
>        tools="$tools fsdev/virtfs-proxy-helper\$(EXESUF)"
>      else
> diff --git a/fsdev/virtfs-proxy-helper.c b/fsdev/virtfs-proxy-helper.c
> index 6f132c5ff1..0d4de49dcf 100644
> --- a/fsdev/virtfs-proxy-helper.c
> +++ b/fsdev/virtfs-proxy-helper.c
> @@ -13,7 +13,6 @@
>  #include <sys/resource.h>
>  #include <getopt.h>
>  #include <syslog.h>
> -#include <sys/capability.h>
>  #include <sys/fsuid.h>
>  #include <sys/vfs.h>
>  #include <sys/ioctl.h>
> @@ -21,6 +20,7 @@
>  #ifdef CONFIG_LINUX_MAGIC_H
>  #include <linux/magic.h>
>  #endif
> +#include <cap-ng.h>
>  #include "qemu-common.h"
>  #include "qemu/sockets.h"
>  #include "qemu/xattr.h"
> @@ -79,49 +79,10 @@ static void do_perror(const char *string)
>      }
>  }
>  
> -static int do_cap_set(cap_value_t *cap_value, int size, int reset)
> -{
> -    cap_t caps;
> -    if (reset) {
> -        /*
> -         * Start with an empty set and set permitted and effective
> -         */
> -        caps = cap_init();
> -        if (caps == NULL) {
> -            do_perror("cap_init");
> -            return -1;
> -        }
> -        if (cap_set_flag(caps, CAP_PERMITTED, size, cap_value, CAP_SET) < 0) {
> -            do_perror("cap_set_flag");
> -            goto error;
> -        }
> -    } else {
> -        caps = cap_get_proc();
> -        if (!caps) {
> -            do_perror("cap_get_proc");
> -            return -1;
> -        }
> -    }
> -    if (cap_set_flag(caps, CAP_EFFECTIVE, size, cap_value, CAP_SET) < 0) {
> -        do_perror("cap_set_flag");
> -        goto error;
> -    }
> -    if (cap_set_proc(caps) < 0) {
> -        do_perror("cap_set_proc");
> -        goto error;
> -    }
> -    cap_free(caps);
> -    return 0;
> -
> -error:
> -    cap_free(caps);
> -    return -1;
> -}
> -
>  static int init_capabilities(void)
>  {
>      /* helper needs following capabilities only */
> -    cap_value_t cap_list[] = {
> +    int cap_list[] = {
>          CAP_CHOWN,
>          CAP_DAC_OVERRIDE,
>          CAP_FOWNER,
> @@ -130,7 +91,34 @@ static int init_capabilities(void)
>          CAP_MKNOD,
>          CAP_SETUID,
>      };
> -    return do_cap_set(cap_list, ARRAY_SIZE(cap_list), 1);
> +    int i;
> +
> +    capng_clear(CAPNG_SELECT_BOTH);
> +    for (i = 0; i < ARRAY_SIZE(cap_list); i++) {
> +        if (capng_update(CAPNG_ADD, CAPNG_EFFECTIVE | CAPNG_PERMITTED,
> +                         cap_list[i]) < 0) {
> +            do_perror("capng_update");
> +            return -1;
> +        }
> +    }
> +    if (capng_apply(CAPNG_SELECT_BOTH) < 0) {
> +        do_perror("capng_apply");
> +        return -1;
> +    }
> +
> +    /* Prepare effective set for setugid.  */
> +    for (i = 0; i < ARRAY_SIZE(cap_list); i++) {
> +        if (cap_list[i] == CAP_DAC_OVERRIDE) {
> +            continue;
> +        }
> +
> +        if (capng_update(CAPNG_DROP, CAPNG_EFFECTIVE,
> +                         cap_list[i]) < 0) {
> +            do_perror("capng_update");
> +            return -1;
> +        }
> +    }
> +    return 0;
>  }
>  
>  static int socket_read(int sockfd, void *buff, ssize_t size)
> @@ -295,14 +283,6 @@ static int setugid(int uid, int gid, int *suid, int *sgid)
>  {
>      int retval;
>  
> -    /*
> -     * We still need DAC_OVERRIDE because we don't change
> -     * supplementary group ids, and hence may be subjected DAC rules
> -     */
> -    cap_value_t cap_list[] = {
> -        CAP_DAC_OVERRIDE,
> -    };
> -
>      *suid = geteuid();
>      *sgid = getegid();
>  
> @@ -316,11 +296,21 @@ static int setugid(int uid, int gid, int *suid, int *sgid)
>          goto err_sgid;
>      }
>  
> -    if (uid != 0 || gid != 0) {
> -        if (do_cap_set(cap_list, ARRAY_SIZE(cap_list), 0) < 0) {
> -            retval = -errno;
> -            goto err_suid;
> -        }
> +    if (uid == 0 && gid == 0) {
> +        /* Linux has already copied the permitted set to the effective set.  */
> +        return 0;
> +    }
> +
> +    /*
> +     * All capabilities have been cleared from the effective set.  However
> +     * we still need DAC_OVERRIDE because we don't change supplementary
> +     * group ids, and hence may be subject to DAC rules.  init_capabilities
> +     * left the set of capabilities that we want in libcap-ng's state.
> +     */
> +    if (capng_apply(CAPNG_SELECT_CAPS) < 0) {
> +        retval = -errno;
> +        do_perror("capng_apply");
> +        goto err_suid;
>      }
>      return 0;
>  


