Return-Path: <SRS0=Rh1V=WE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69544C0650F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 11:19:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42424216C8
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 11:19:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42424216C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvgSV-00065x-Ap
	for qemu-devel@archiver.kernel.org; Thu, 08 Aug 2019 07:19:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43181)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgilbert@redhat.com>) id 1hvgS7-0005g1-QX
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 07:19:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1hvgS6-00044X-Jk
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 07:19:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38646)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hvgS6-000442-Bs
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 07:19:26 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3E71130860DC;
 Thu,  8 Aug 2019 11:19:24 +0000 (UTC)
Received: from work-vm (ovpn-117-208.ams2.redhat.com [10.36.117.208])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3077F60A97;
 Thu,  8 Aug 2019 11:19:18 +0000 (UTC)
Date: Thu, 8 Aug 2019 12:19:16 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: "Singh, Brijesh" <brijesh.singh@amd.com>
Message-ID: <20190808111916.GF2852@work-vm>
References: <20190806165429.19327-1-brijesh.singh@amd.com>
 <20190806165429.19327-8-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190806165429.19327-8-brijesh.singh@amd.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Thu, 08 Aug 2019 11:19:24 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 07/14] target/i386: sev: provide
 callback to setup outgoing context
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
> The user provides the target machine's Platform Diffie-Hellman key (PDH)
> and certificate chain before starting the SEV guest migration. Cache the
> certificate chain as we need them while creating the outgoing context.
> 
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> ---
>  accel/kvm/kvm-all.c    | 12 +++++++++++
>  accel/kvm/sev-stub.c   |  6 ++++++
>  include/sysemu/sev.h   |  2 ++
>  target/i386/sev.c      | 45 ++++++++++++++++++++++++++++++++++++++++++
>  target/i386/sev_i386.h |  6 ++++++
>  5 files changed, 71 insertions(+)
> 
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index f450f25295..d0304c6947 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -165,6 +165,17 @@ bool kvm_memcrypt_enabled(void)
>      return false;
>  }
>  
> +static int kvm_memcrypt_save_setup(const char *pdh, const char *plat_cert,
> +                                   const char *amd_cert)
> +{
> +    return sev_save_setup(kvm_state->memcrypt_handle, pdh,
> +                          plat_cert, amd_cert);
> +}
> +
> +static struct MachineMemoryEncryptionOps sev_memory_encryption_ops = {
> +    .save_setup = kvm_memcrypt_save_setup,
> +};
> +
>  int kvm_memcrypt_encrypt_data(uint8_t *ptr, uint64_t len)
>  {
>      if (kvm_state->memcrypt_handle &&
> @@ -1968,6 +1979,7 @@ static int kvm_init(MachineState *ms)
>          }
>  
>          kvm_state->memcrypt_encrypt_data = sev_encrypt_data;
> +        mc->memory_encryption_ops = &sev_memory_encryption_ops;

It surprises me that this isn't in target/i386/kvm.c somehow

>      }
>  
>      ret = kvm_arch_init(ms, s);
> diff --git a/accel/kvm/sev-stub.c b/accel/kvm/sev-stub.c
> index 4f97452585..528f8cf7f1 100644
> --- a/accel/kvm/sev-stub.c
> +++ b/accel/kvm/sev-stub.c
> @@ -24,3 +24,9 @@ void *sev_guest_init(const char *id)
>  {
>      return NULL;
>  }
> +
> +int sev_save_setup(void *handle, const char *pdh, const char *plat_cert,
> +                   const char *amd_cert)
> +{
> +    return 1;
> +}
> diff --git a/include/sysemu/sev.h b/include/sysemu/sev.h
> index 98c1ec8d38..d5123d4fa3 100644
> --- a/include/sysemu/sev.h
> +++ b/include/sysemu/sev.h
> @@ -18,4 +18,6 @@
>  
>  void *sev_guest_init(const char *id);
>  int sev_encrypt_data(void *handle, uint8_t *ptr, uint64_t len);
> +int sev_save_setup(void *handle, const char *pdh, const char *plat_cert,
> +                   const char *amd_cert);
>  #endif
> diff --git a/target/i386/sev.c b/target/i386/sev.c
> index f1423cb0c0..70e9d86815 100644
> --- a/target/i386/sev.c
> +++ b/target/i386/sev.c
> @@ -27,6 +27,7 @@
>  #include "sysemu/sysemu.h"
>  #include "trace.h"
>  #include "migration/blocker.h"
> +#include "migration/qemu-file.h"

Do you need that yet?

>  #define DEFAULT_GUEST_POLICY    0x1 /* disable debug */
>  #define DEFAULT_SEV_DEVICE      "/dev/sev"
> @@ -62,6 +63,8 @@ static const char *const sev_fw_errlist[] = {
>  
>  #define SEV_FW_MAX_ERROR      ARRAY_SIZE(sev_fw_errlist)
>  
> +#define SEV_FW_BLOB_MAX_SIZE            0x4000          /* 16KB */
> +
>  static int
>  sev_ioctl(int fd, int cmd, void *data, int *error)
>  {
> @@ -729,6 +732,48 @@ sev_vm_state_change(void *opaque, int running, RunState state)
>      }
>  }
>  
> +static inline bool check_blob_length(size_t value)
> +{
> +    if (value > SEV_FW_BLOB_MAX_SIZE) {
> +        error_report("invalid length max=%ld got=%d",
> +                     value, SEV_FW_BLOB_MAX_SIZE);

Those two parameters are the wrong way around aren't they?

> +        return false;
> +    }
> +
> +    return true;
> +}
> +
> +int sev_save_setup(void *handle, const char *pdh, const char *plat_cert,
> +                   const char *amd_cert)
> +{
> +    SEVState *s = (SEVState *)handle;
> +
> +    s->remote_pdh = g_base64_decode(pdh, &s->remote_pdh_len);
> +    if (!check_blob_length(s->remote_pdh_len)) {

Print something to say what went wrong.

> +        goto error;
> +    }
> +
> +    s->remote_plat_cert = g_base64_decode(plat_cert,
> +                                          &s->remote_plat_cert_len);
> +    if (!check_blob_length(s->remote_plat_cert_len)) {
> +        goto error;
> +    }
> +
> +    s->amd_cert = g_base64_decode(amd_cert, &s->amd_cert_len);
> +    if (!check_blob_length(s->amd_cert_len)) {
> +        goto error;
> +    }
> +
> +    return 0;
> +
> +error:
> +    g_free(s->remote_pdh);
> +    g_free(s->remote_plat_cert);
> +    g_free(s->amd_cert);
> +
> +    return 1;
> +}
> +
>  void *
>  sev_guest_init(const char *id)
>  {
> diff --git a/target/i386/sev_i386.h b/target/i386/sev_i386.h
> index 55313441ae..32906de998 100644
> --- a/target/i386/sev_i386.h
> +++ b/target/i386/sev_i386.h
> @@ -81,6 +81,12 @@ struct SEVState {
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

