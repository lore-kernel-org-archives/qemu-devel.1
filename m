Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75F6BC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 17:36:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43EAC207D8
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 17:36:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MSzMBbEI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43EAC207D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53776 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1josHS-0006wi-Ik
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 13:36:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45746)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1josGk-0006X2-EY
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 13:36:06 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:29759
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1josGg-0001qG-2O
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 13:36:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593192960;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=89Exa60zlaf8K+mkEb/WEfzK+dHzN4QIV7FfVM9UBeU=;
 b=MSzMBbEIpIVAiWIYXrFR6JQqgk7Lyt5prQVyvy5iDG/FQ6a5pKmaSvpD+N524HhnI1Kqzu
 BC9QKx8rKQMnASMACgj6eupYR5W6es1pRhc90O+FPIrIbw6z3VRkpAPmBH4+paIofZVsGD
 FFa6aQs2sqidHFjFIuLaRcJ1pG/k3W0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-336-MnehnZpwPFWuwF0b5bt3fg-1; Fri, 26 Jun 2020 13:35:58 -0400
X-MC-Unique: MnehnZpwPFWuwF0b5bt3fg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E446F1902EA1;
 Fri, 26 Jun 2020 17:35:56 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.51])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3C9EF768DA;
 Fri, 26 Jun 2020 17:35:41 +0000 (UTC)
Date: Fri, 26 Jun 2020 18:35:38 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Christophe de Dinechin <dinechin@redhat.com>
Subject: Re: [PATCH 09/10] spice: Put spice functions in a separate load module
Message-ID: <20200626173538.GP1028934@redhat.com>
References: <20200626164307.3327380-1-dinechin@redhat.com>
 <20200626164307.3327380-10-dinechin@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200626164307.3327380-10-dinechin@redhat.com>
User-Agent: Mutt/1.14.0 (2020-05-02)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/26 02:19:36
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jun 26, 2020 at 06:43:06PM +0200, Christophe de Dinechin wrote:
> Use the MODIFACE and MODIMPL macros to to redirect the highest-level
> qemu_spice functions into the spice-app.so load module when SPICE is
> compiled as a module.
> 
> With these changes, the following shared libraries are no longer
> necessary in the top-level qemu binary:
> 
>  	libspice-server.so.1 => /lib64/libspice-server.so.1 (HEX)
>  	libopus.so.0 => /lib64/libopus.so.0 (HEX)
>  	liblz4.so.1 => /lib64/liblz4.so.1 (HEX)
>  	libgstapp-1.0.so.0 => /lib64/libgstapp-1.0.so.0 (HEX)
>  	libgstvideo-1.0.so.0 => /lib64/libgstvideo-1.0.so.0 (HEX)
>  	libgstbase-1.0.so.0 => /lib64/libgstbase-1.0.so.0 (HEX)
>  	libgstreamer-1.0.so.0 => /lib64/libgstreamer-1.0.so.0 (HEX)
>  	libssl.so.1.1 => /lib64/libssl.so.1.1 (HEX)
>  	liborc-0.4.so.0 => /lib64/liborc-0.4.so.0 (HEX)
> 
> Signed-off-by: Christophe de Dinechin <dinechin@redhat.com>
> ---
>  include/ui/qemu-spice.h | 24 +++++++++++++++---------
>  monitor/hmp-cmds.c      |  6 ++++++
>  softmmu/vl.c            |  1 +
>  ui/spice-core.c         | 31 +++++++++++++++++++++----------
>  ui/spice-display.c      |  2 +-
>  5 files changed, 44 insertions(+), 20 deletions(-)
> 
> diff --git a/include/ui/qemu-spice.h b/include/ui/qemu-spice.h
> index 8c23dfe717..0f7e139da5 100644
> --- a/include/ui/qemu-spice.h
> +++ b/include/ui/qemu-spice.h
> @@ -24,22 +24,28 @@
>  
>  #include <spice.h>
>  #include "qemu/config-file.h"
> +#include "qemu/module.h"
>  
> -extern int using_spice;
> +#define using_spice     (qemu_is_using_spice())
>  
> -void qemu_spice_init(void);
> +MODIFACE(bool, qemu_is_using_spice,(void));
> +MODIFACE(void, qemu_start_using_spice, (void));
> +MODIFACE(void, qemu_spice_init, (void));
>  void qemu_spice_input_init(void);
>  void qemu_spice_audio_init(void);
> -void qemu_spice_display_init(void);
> -int qemu_spice_display_add_client(int csock, int skipauth, int tls);
> +MODIFACE(void, qemu_spice_display_init, (void));
> +MODIFACE(int, qemu_spice_display_add_client, (int csock, int skipauth, int tls));
>  int qemu_spice_add_interface(SpiceBaseInstance *sin);
>  bool qemu_spice_have_display_interface(QemuConsole *con);
>  int qemu_spice_add_display_interface(QXLInstance *qxlin, QemuConsole *con);
> -int qemu_spice_set_passwd(const char *passwd,
> -                          bool fail_if_connected, bool disconnect_if_connected);
> -int qemu_spice_set_pw_expire(time_t expires);
> -int qemu_spice_migrate_info(const char *hostname, int port, int tls_port,
> -                            const char *subject);
> +MODIFACE(int, qemu_spice_set_passwd, (const char *passwd,
> +                                      bool fail_if_connected,
> +                                      bool disconnect_if_connected));
> +MODIFACE(int, qemu_spice_set_pw_expire,(time_t expires));
> +MODIFACE(int, qemu_spice_migrate_info,(const char *hostname,
> +                                       int port, int tls_port,
> +                                       const char *subject));
> +MODIFACE(struct SpiceInfo *,qemu_spice_query, (Error **errp));

This macro usage looks kind of unpleasant and its hard to understand
just what is going on, especially why some methods are changed but
others are not.

IIUC, the goal is to turn all these into weak symbols so they don't
need to be resolved immediately at startup, and instead have an
impl of them provided dynamically at runtime.

If so the more normal approach would be to have a struct defining
a set of callbacks, that can be registered. Or if there's a natural
fit with QOM, then a QOM interface that can then have a QOM object
impl registered as a singleton.

>  #if !defined(SPICE_SERVER_VERSION) || (SPICE_SERVER_VERSION < 0xc06)
>  #define SPICE_NEEDS_SET_MM_TIME 1
> diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
> index 2b0b58a336..6bd9c52658 100644
> --- a/monitor/hmp-cmds.c
> +++ b/monitor/hmp-cmds.c
> @@ -56,6 +56,7 @@
>  #include "migration/misc.h"
>  
>  #ifdef CONFIG_SPICE
> +#include "ui/qemu-spice.h"
>  #include <spice/enums.h>
>  #endif
>  
> @@ -573,6 +574,11 @@ void hmp_info_vnc(Monitor *mon, const QDict *qdict)
>  #endif
>  
>  #ifdef CONFIG_SPICE
> +SpiceInfo *qmp_query_spice(Error **errp)
> +{
> +    return qemu_spice_query(errp);
> +}
> +
>  void hmp_info_spice(Monitor *mon, const QDict *qdict)
>  {
>      SpiceChannelList *chan;
> diff --git a/softmmu/vl.c b/softmmu/vl.c
> index 3e15ee2435..c94b4fa49b 100644
> --- a/softmmu/vl.c
> +++ b/softmmu/vl.c
> @@ -22,6 +22,7 @@
>   * THE SOFTWARE.
>   */
>  
> +#define MODULE_STUBS
>  #include "qemu/osdep.h"
>  #include "qemu-common.h"
>  #include "qemu/units.h"
> diff --git a/ui/spice-core.c b/ui/spice-core.c
> index ecc2ec2c55..dbc1886b77 100644
> --- a/ui/spice-core.c
> +++ b/ui/spice-core.c
> @@ -48,7 +48,7 @@ static time_t auth_expires = TIME_MAX;
>  static int spice_migration_completed;
>  static int spice_display_is_running;
>  static int spice_have_target_host;
> -int using_spice = 0;
> +static int is_using_spice = 0;
>  
>  static QemuThread me;
>  
> @@ -503,7 +503,7 @@ static QemuOptsList qemu_spice_opts = {
>      },
>  };
>  
> -SpiceInfo *qmp_query_spice(Error **errp)
> +MODIMPL(SpiceInfo *,qemu_spice_query,(Error **errp))
>  {
>      QemuOpts *opts = QTAILQ_FIRST(&qemu_spice_opts.head);
>      int port, tls_port;
> @@ -579,8 +579,9 @@ static void migration_state_notifier(Notifier *notifier, void *data)
>      }
>  }
>  
> -int qemu_spice_migrate_info(const char *hostname, int port, int tls_port,
> -                            const char *subject)
> +MODIMPL(int, qemu_spice_migrate_info, (const char *hostname,
> +                                       int port, int tls_port,
> +                                       const char *subject))
>  {
>      int ret;
>  
> @@ -634,7 +635,17 @@ static void vm_change_state_handler(void *opaque, int running,
>      }
>  }
>  
> -void qemu_spice_init(void)
> +MODIMPL(bool, qemu_is_using_spice, (void))
> +{
> +    return is_using_spice;
> +}
> +
> +MODIMPL(void, qemu_start_using_spice, (void))
> +{
> +    is_using_spice = 1;
> +}
> +
> +MODIMPL(void, qemu_spice_init, (void))
>  {
>      QemuOpts *opts = QTAILQ_FIRST(&qemu_spice_opts.head);
>      const char *password, *str, *x509_dir, *addr,
> @@ -796,7 +807,7 @@ void qemu_spice_init(void)
>          error_report("failed to initialize spice server");
>          exit(1);
>      };
> -    using_spice = 1;
> +    qemu_start_using_spice();
>  
>      migration_state.notify = migration_state_notifier;
>      add_migration_state_change_notifier(&migration_state);
> @@ -945,8 +956,8 @@ static int qemu_spice_set_ticket(bool fail_if_conn, bool disconnect_if_conn)
>                                     fail_if_conn, disconnect_if_conn);
>  }
>  
> -int qemu_spice_set_passwd(const char *passwd,
> -                          bool fail_if_conn, bool disconnect_if_conn)
> +MODIMPL(int, qemu_spice_set_passwd,(const char *passwd,
> +                                    bool fail_if_conn, bool disconnect_if_conn))
>  {
>      if (strcmp(auth, "spice") != 0) {
>          return -1;
> @@ -957,13 +968,13 @@ int qemu_spice_set_passwd(const char *passwd,
>      return qemu_spice_set_ticket(fail_if_conn, disconnect_if_conn);
>  }
>  
> -int qemu_spice_set_pw_expire(time_t expires)
> +MODIMPL(int, qemu_spice_set_pw_expire, (time_t expires))
>  {
>      auth_expires = expires;
>      return qemu_spice_set_ticket(false, false);
>  }
>  
> -int qemu_spice_display_add_client(int csock, int skipauth, int tls)
> +MODIMPL(int, qemu_spice_display_add_client, (int csock, int skipauth, int tls))
>  {
>      if (tls) {
>          return spice_server_add_ssl_client(spice_server, csock, skipauth);
> diff --git a/ui/spice-display.c b/ui/spice-display.c
> index 19632fdf6c..90529695fe 100644
> --- a/ui/spice-display.c
> +++ b/ui/spice-display.c
> @@ -1164,7 +1164,7 @@ static void qemu_spice_display_init_one(QemuConsole *con)
>      register_displaychangelistener(&ssd->dcl);
>  }
>  
> -void qemu_spice_display_init(void)
> +MODIMPL(void, qemu_spice_display_init,(void))
>  {
>      QemuOptsList *olist = qemu_find_opts("spice");
>      QemuOpts *opts = QTAILQ_FIRST(&olist->head);
> -- 
> 2.26.2
> 
> 

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


