Return-Path: <SRS0=r3/N=VJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DC0DC742B2
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 10:00:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35806208E4
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 10:00:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35806208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47850 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlsMB-0000db-79
	for qemu-devel@archiver.kernel.org; Fri, 12 Jul 2019 06:00:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51593)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgilbert@redhat.com>) id 1hlsLy-0000Dk-A0
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 06:00:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1hlsLw-0006Zc-E2
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 06:00:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50196)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hlsLu-0006Wo-Mf
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 06:00:32 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 426D8305E23A;
 Fri, 12 Jul 2019 10:00:29 +0000 (UTC)
Received: from work-vm (ovpn-117-214.ams2.redhat.com [10.36.117.214])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5F849600CD;
 Fri, 12 Jul 2019 10:00:25 +0000 (UTC)
Date: Fri, 12 Jul 2019 11:00:22 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: "Singh, Brijesh" <brijesh.singh@amd.com>, eblake@redhat.com,
 berrange@redhat.com
Message-ID: <20190712100022.GC2730@work-vm>
References: <20190710202219.25939-1-brijesh.singh@amd.com>
 <20190710202219.25939-9-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190710202219.25939-9-brijesh.singh@amd.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Fri, 12 Jul 2019 10:00:29 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 08/13] misc.json: add
 migrate-set-sev-info command
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
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>, "Lendacky,
 Thomas" <Thomas.Lendacky@amd.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Singh, Brijesh (brijesh.singh@amd.com) wrote:
> The command can be used by the hypervisor to specify the target Platform
> Diffie-Hellman key (PDH) and certificate chain before starting the SEV
> guest migration. The values passed through the command will be used while
> creating the outgoing encryption context.
> 
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>

I'm wondering if it would make sense to have these as migration
parameters rather than using a new command.
You could just use string parameters.
(cc'ing Eric and Daniel for interface suggestions)

> ---
>  qapi/misc-target.json  | 18 ++++++++++++++++++
>  target/i386/monitor.c  | 10 ++++++++++
>  target/i386/sev-stub.c |  5 +++++
>  target/i386/sev.c      | 11 +++++++++++
>  target/i386/sev_i386.h |  9 ++++++++-
>  5 files changed, 52 insertions(+), 1 deletion(-)
> 
> diff --git a/qapi/misc-target.json b/qapi/misc-target.json
> index a00fd821eb..938dcaea14 100644
> --- a/qapi/misc-target.json
> +++ b/qapi/misc-target.json
> @@ -266,3 +266,21 @@
>  ##
>  { 'command': 'query-gic-capabilities', 'returns': ['GICCapability'],
>    'if': 'defined(TARGET_ARM)' }
> +
> +##
> +# @migrate-set-sev-info:
> +#
> +# The command is used to provide the target host information used during the
> +# SEV guest.
> +#
> +# @pdh the target host platform diffie-hellman key encoded in base64
> +#
> +# @plat-cert the target host platform certificate chain encoded in base64
> +#
> +# @amd-cert AMD certificate chain which include ASK and OCA encoded in base64
> +#
> +# Since 4.2
> +#
> +##
> +{ 'command': 'migrate-set-sev-info',
> +  'data': { 'pdh': 'str', 'plat-cert': 'str', 'amd-cert' : 'str' }}
> diff --git a/target/i386/monitor.c b/target/i386/monitor.c
> index 1f3b532fc2..4a5f50fb45 100644
> --- a/target/i386/monitor.c
> +++ b/target/i386/monitor.c
> @@ -736,3 +736,13 @@ SevCapability *qmp_query_sev_capabilities(Error **errp)
>  
>      return data;
>  }
> +
> +void qmp_migrate_set_sev_info(const char *pdh, const char *plat_cert,
> +                              const char *amd_cert, Error **errp)
> +{
> +    if (sev_enabled()) {
> +        sev_set_migrate_info(pdh, plat_cert, amd_cert);
> +    } else {
> +        error_setg(errp, "SEV is not enabled");
> +    }
> +}
> diff --git a/target/i386/sev-stub.c b/target/i386/sev-stub.c
> index e5ee13309c..173bfa6374 100644
> --- a/target/i386/sev-stub.c
> +++ b/target/i386/sev-stub.c
> @@ -48,3 +48,8 @@ SevCapability *sev_get_capabilities(void)
>  {
>      return NULL;
>  }
> +
> +void sev_set_migrate_info(const char *pdh, const char *plat_cert,
> +                          const char *amd_cert)
> +{
> +}
> diff --git a/target/i386/sev.c b/target/i386/sev.c
> index 49baf8fef0..6c902d0be8 100644
> --- a/target/i386/sev.c
> +++ b/target/i386/sev.c
> @@ -825,6 +825,17 @@ sev_encrypt_data(void *handle, uint8_t *ptr, uint64_t len)
>      return 0;
>  }
>  
> +void sev_set_migrate_info(const char *pdh, const char *plat_cert,
> +                          const char *amd_cert)
> +{
> +    SEVState *s = sev_state;
> +
> +    s->remote_pdh = g_base64_decode(pdh, &s->remote_pdh_len);
> +    s->remote_plat_cert = g_base64_decode(plat_cert,
> +                                          &s->remote_plat_cert_len);
> +    s->amd_cert = g_base64_decode(amd_cert, &s->amd_cert_len);

What sanity checking is there that it's a valid base64 string of sane
length?

> +}
> +
>  static void
>  sev_register_types(void)
>  {
> diff --git a/target/i386/sev_i386.h b/target/i386/sev_i386.h
> index 55313441ae..3f3449b346 100644
> --- a/target/i386/sev_i386.h
> +++ b/target/i386/sev_i386.h
> @@ -39,7 +39,8 @@ extern uint32_t sev_get_cbit_position(void);
>  extern uint32_t sev_get_reduced_phys_bits(void);
>  extern char *sev_get_launch_measurement(void);
>  extern SevCapability *sev_get_capabilities(void);
> -
> +extern void sev_set_migrate_info(const char *pdh, const char *plat_cert,
> +                                 const char *amd_cert);
>  typedef struct QSevGuestInfo QSevGuestInfo;
>  typedef struct QSevGuestInfoClass QSevGuestInfoClass;
>  
> @@ -81,6 +82,12 @@ struct SEVState {
>      int sev_fd;
>      SevState state;
>      gchar *measurement;
> +    guchar *remote_pdh;
> +    size_t remote_pdh_len;
> +    guchar *remote_plat_cert;
> +    size_t remote_plat_cert_len;
> +    guchar *amd_cert;
> +    size_t amd_cert_len;
>  };
>  
>  typedef struct SEVState SEVState;
> -- 
> 2.17.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

