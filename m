Return-Path: <SRS0=8dir=WF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAF73C433FF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 18:55:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4675214C6
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 18:55:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4675214C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33448 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hwA2n-00086l-P7
	for qemu-devel@archiver.kernel.org; Fri, 09 Aug 2019 14:55:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53252)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgilbert@redhat.com>) id 1hwA2D-0007dr-7G
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 14:54:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1hwA2B-0002rC-CC
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 14:54:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49790)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hwA2B-0002qE-1T
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 14:54:39 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4667B7653C;
 Fri,  9 Aug 2019 18:54:38 +0000 (UTC)
Received: from work-vm (ovpn-117-184.ams2.redhat.com [10.36.117.184])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C04A219C70;
 Fri,  9 Aug 2019 18:54:36 +0000 (UTC)
Date: Fri, 9 Aug 2019 19:54:34 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: "Singh, Brijesh" <brijesh.singh@amd.com>
Message-ID: <20190809185434.GH2840@work-vm>
References: <20190806165429.19327-1-brijesh.singh@amd.com>
 <20190806165429.19327-10-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190806165429.19327-10-brijesh.singh@amd.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Fri, 09 Aug 2019 18:54:38 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 09/14] target/i386: sev: add support to
 encrypt the outgoing page
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
> The sev_save_outgoing_page() provide the implementation to encrypt the
> guest private pages during the transit. The routines uses the SEND_START
> command to create the outgoing encryption context on the first call then
> uses the SEND_UPDATE_DATA command to encrypt the data before writing it
> to the socket. While encrypting the data SEND_UPDATE_DATA produces some
> metadata (e.g MAC, IV). The metadata is also sent to the target machine.
> After migration is completed, we issue the SEND_FINISH command to transition
> the SEV guest state from sending to unrunnable state.
> 
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  accel/kvm/kvm-all.c      |   9 ++
>  accel/kvm/sev-stub.c     |   6 ++
>  include/sysemu/sev.h     |   2 +
>  target/i386/sev.c        | 216 +++++++++++++++++++++++++++++++++++++++
>  target/i386/sev_i386.h   |   2 +
>  target/i386/trace-events |   3 +
>  6 files changed, 238 insertions(+)
> 
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index d0304c6947..a5b0ae9363 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -172,8 +172,17 @@ static int kvm_memcrypt_save_setup(const char *pdh, const char *plat_cert,
>                            plat_cert, amd_cert);
>  }
>  
> +static int kvm_memcrypt_save_outgoing_page(QEMUFile *f, uint8_t *ptr,
> +                                           uint32_t size,
> +                                           uint64_t *bytes_sent)
> +{
> +    return sev_save_outgoing_page(kvm_state->memcrypt_handle, f, ptr, size,
> +                                  bytes_sent);
> +}
> +
>  static struct MachineMemoryEncryptionOps sev_memory_encryption_ops = {
>      .save_setup = kvm_memcrypt_save_setup,
> +    .save_outgoing_page = kvm_memcrypt_save_outgoing_page,
>  };
>  
>  int kvm_memcrypt_encrypt_data(uint8_t *ptr, uint64_t len)
> diff --git a/accel/kvm/sev-stub.c b/accel/kvm/sev-stub.c
> index 528f8cf7f1..51b17b8141 100644
> --- a/accel/kvm/sev-stub.c
> +++ b/accel/kvm/sev-stub.c
> @@ -30,3 +30,9 @@ int sev_save_setup(void *handle, const char *pdh, const char *plat_cert,
>  {
>      return 1;
>  }
> +
> +int sev_save_outgoing_page(void *handle, QEMUFile *f, uint8_t *ptr,
> +                           uint32_t size, uint64_t *bytes_sent)
> +{
> +    return 1;
> +}
> diff --git a/include/sysemu/sev.h b/include/sysemu/sev.h
> index d5123d4fa3..f06fd203cd 100644
> --- a/include/sysemu/sev.h
> +++ b/include/sysemu/sev.h
> @@ -20,4 +20,6 @@ void *sev_guest_init(const char *id);
>  int sev_encrypt_data(void *handle, uint8_t *ptr, uint64_t len);
>  int sev_save_setup(void *handle, const char *pdh, const char *plat_cert,
>                     const char *amd_cert);
> +int sev_save_outgoing_page(void *handle, QEMUFile *f, uint8_t *ptr,
> +                           uint32_t size, uint64_t *bytes_sent);
>  #endif
> diff --git a/target/i386/sev.c b/target/i386/sev.c
> index 483d9bb0fa..1820c62a71 100644
> --- a/target/i386/sev.c
> +++ b/target/i386/sev.c
> @@ -28,6 +28,7 @@
>  #include "trace.h"
>  #include "migration/blocker.h"
>  #include "migration/qemu-file.h"
> +#include "migration/misc.h"
>  
>  #define DEFAULT_GUEST_POLICY    0x1 /* disable debug */
>  #define DEFAULT_SEV_DEVICE      "/dev/sev"
> @@ -774,6 +775,40 @@ error:
>      return 1;
>  }
>  
> +static void
> +sev_send_finish(void)
> +{
> +    int ret, error;
> +
> +    trace_kvm_sev_send_finish();
> +    ret = sev_ioctl(sev_state->sev_fd, KVM_SEV_SEND_FINISH, 0, &error);
> +    if (ret) {
> +        error_report("%s: SEND_FINISH ret=%d fw_error=%d '%s'",
> +                     __func__, ret, error, fw_error_to_str(error));
> +    }
> +
> +    g_free(sev_state->send_packet_hdr);
> +    sev_set_guest_state(SEV_STATE_RUNNING);
> +}
> +
> +static void
> +sev_migration_state_notifier(Notifier *notifier, void *data)
> +{
> +    MigrationState *s = data;
> +
> +    if (migration_has_finished(s) ||
> +        migration_in_postcopy_after_devices(s) ||
> +        migration_has_failed(s)) {
> +        if (sev_check_state(SEV_STATE_SEND_UPDATE)) {
> +            sev_send_finish();
> +        }
> +    }
> +}
> +
> +static Notifier sev_migration_state_notify = {
> +    .notify = sev_migration_state_notifier,
> +};
> +
>  void *
>  sev_guest_init(const char *id)
>  {
> @@ -860,6 +895,7 @@ sev_guest_init(const char *id)
>      ram_block_notifier_add(&sev_ram_notifier);
>      qemu_add_machine_init_done_notifier(&sev_machine_done_notify);
>      qemu_add_vm_change_state_handler(sev_vm_state_change, s);
> +    add_migration_state_change_notifier(&sev_migration_state_notify);
>  
>      return s;
>  err:
> @@ -881,6 +917,186 @@ sev_encrypt_data(void *handle, uint8_t *ptr, uint64_t len)
>      return 0;
>  }
>  
> +static int
> +sev_get_send_session_length(void)
> +{
> +    int ret, fw_err = 0;
> +    struct kvm_sev_send_start start = {};
> +
> +    ret = sev_ioctl(sev_state->sev_fd, KVM_SEV_SEND_START, &start, &fw_err);
> +    if (fw_err != SEV_RET_INVALID_LEN) {
> +        ret = -1;
> +        error_report("%s: failed to get session length ret=%d fw_error=%d '%s'",
> +                     __func__, ret, fw_err, fw_error_to_str(fw_err));
> +        goto err;
> +    }
> +
> +    ret = start.session_len;
> +err:
> +    return ret;
> +}
> +
> +static int
> +sev_send_start(SEVState *s, QEMUFile *f, uint64_t *bytes_sent)
> +{
> +    gsize pdh_len = 0, plat_cert_len;
> +    int session_len, ret, fw_error;
> +    struct kvm_sev_send_start start = { };
> +    guchar *pdh = NULL, *plat_cert = NULL, *session = NULL;
> +
> +    if (!s->remote_pdh || !s->remote_plat_cert || !s->amd_cert_len) {
> +        error_report("%s: missing remote PDH or PLAT_CERT", __func__);
> +        return 1;
> +    }
> +
> +    start.pdh_cert_uaddr = (uintptr_t) s->remote_pdh;
> +    start.pdh_cert_len = s->remote_pdh_len;
> +
> +    start.plat_cert_uaddr = (uintptr_t)s->remote_plat_cert;
> +    start.plat_cert_len = s->remote_plat_cert_len;
> +
> +    start.amd_cert_uaddr = (uintptr_t)s->amd_cert;
> +    start.amd_cert_len = s->amd_cert_len;
> +
> +    /* get the session length */
> +    session_len = sev_get_send_session_length();
> +    if (session_len < 0) {
> +        ret = 1;
> +        goto err;
> +    }
> +
> +    session = g_new0(guchar, session_len);
> +    start.session_uaddr = (unsigned long)session;
> +    start.session_len = session_len;
> +
> +    /* Get our PDH certificate */
> +    ret = sev_get_pdh_info(s->sev_fd, &pdh, &pdh_len,
> +                           &plat_cert, &plat_cert_len);
> +    if (ret) {
> +        error_report("Failed to get our PDH cert");
> +        goto err;
> +    }
> +
> +    trace_kvm_sev_send_start(start.pdh_cert_uaddr, start.pdh_cert_len,
> +                             start.plat_cert_uaddr, start.plat_cert_len,
> +                             start.amd_cert_uaddr, start.amd_cert_len);
> +
> +    ret = sev_ioctl(s->sev_fd, KVM_SEV_SEND_START, &start, &fw_error);
> +    if (ret < 0) {
> +        error_report("%s: SEND_START ret=%d fw_error=%d '%s'",
> +                __func__, ret, fw_error, fw_error_to_str(fw_error));
> +        goto err;
> +    }
> +
> +    qemu_put_be32(f, start.policy);
> +    qemu_put_be32(f, pdh_len);
> +    qemu_put_buffer(f, (uint8_t *)pdh, pdh_len);
> +    qemu_put_be32(f, start.session_len);
> +    qemu_put_buffer(f, (uint8_t *)start.session_uaddr, start.session_len);
> +    *bytes_sent = 12 + pdh_len + start.session_len;
> +
> +    sev_set_guest_state(SEV_STATE_SEND_UPDATE);
> +
> +err:
> +    g_free(pdh);
> +    g_free(plat_cert);
> +    return ret;
> +}
> +
> +static int
> +sev_send_get_packet_len(int *fw_err)
> +{
> +    int ret;
> +    struct kvm_sev_send_update_data update = {};
> +
> +    ret = sev_ioctl(sev_state->sev_fd, KVM_SEV_SEND_UPDATE_DATA,
> +                    &update, fw_err);
> +    if (*fw_err != SEV_RET_INVALID_LEN) {
> +        ret = -1;
> +        error_report("%s: failed to get session length ret=%d fw_error=%d '%s'",
> +                    __func__, ret, *fw_err, fw_error_to_str(*fw_err));
> +        goto err;
> +    }
> +
> +    ret = update.hdr_len;
> +
> +err:
> +    return ret;
> +}
> +
> +static int
> +sev_send_update_data(SEVState *s, QEMUFile *f, uint8_t *ptr, uint32_t size,
> +                     uint64_t *bytes_sent)
> +{
> +    int ret, fw_error;
> +    guchar *trans;
> +    struct kvm_sev_send_update_data update = { };
> +
> +    /*
> +     * If this is first call then query the packet header bytes and allocate
> +     * the packet buffer.
> +     */
> +    if (!s->send_packet_hdr) {
> +        s->send_packet_hdr_len = sev_send_get_packet_len(&fw_error);
> +        if (s->send_packet_hdr_len < 1) {
> +            error_report("%s: SEND_UPDATE fw_error=%d '%s'",
> +                    __func__, fw_error, fw_error_to_str(fw_error));
> +            return 1;
> +        }
> +
> +        s->send_packet_hdr = g_new(gchar, s->send_packet_hdr_len);
> +    }
> +
> +    /* allocate transport buffer */
> +    trans = g_new(guchar, size);
> +
> +    update.hdr_uaddr = (uintptr_t)s->send_packet_hdr;
> +    update.hdr_len = s->send_packet_hdr_len;
> +    update.guest_uaddr = (uintptr_t)ptr;
> +    update.guest_len = size;
> +    update.trans_uaddr = (uintptr_t)trans;
> +    update.trans_len = size;
> +
> +    trace_kvm_sev_send_update_data(ptr, trans, size);
> +
> +    ret = sev_ioctl(s->sev_fd, KVM_SEV_SEND_UPDATE_DATA, &update, &fw_error);
> +    if (ret) {
> +        error_report("%s: SEND_UPDATE_DATA ret=%d fw_error=%d '%s'",
> +                __func__, ret, fw_error, fw_error_to_str(fw_error));
> +        goto err;
> +    }
> +
> +    qemu_put_be32(f, update.hdr_len);
> +    qemu_put_buffer(f, (uint8_t *)update.hdr_uaddr, update.hdr_len);
> +    *bytes_sent = 4 + update.hdr_len;
> +
> +    qemu_put_be32(f, update.trans_len);
> +    qemu_put_buffer(f, (uint8_t *)update.trans_uaddr, update.trans_len);
> +    *bytes_sent += (4 + update.trans_len);
> +
> +err:
> +    g_free(trans);
> +    return ret;
> +}
> +
> +int sev_save_outgoing_page(void *handle, QEMUFile *f, uint8_t *ptr,
> +                           uint32_t sz, uint64_t *bytes_sent)
> +{
> +    SEVState *s = sev_state;
> +
> +    /*
> +     * If this is a first buffer then create outgoing encryption context
> +     * and write our PDH, policy and session data.
> +     */
> +    if (!sev_check_state(SEV_STATE_SEND_UPDATE) &&
> +        sev_send_start(s, f, bytes_sent)) {
> +        error_report("Failed to create outgoing context");
> +        return 1;
> +    }
> +
> +    return sev_send_update_data(s, f, ptr, sz, bytes_sent);
> +}
> +
>  static void
>  sev_register_types(void)
>  {
> diff --git a/target/i386/sev_i386.h b/target/i386/sev_i386.h
> index 32906de998..e475304f5f 100644
> --- a/target/i386/sev_i386.h
> +++ b/target/i386/sev_i386.h
> @@ -87,6 +87,8 @@ struct SEVState {
>      size_t remote_plat_cert_len;
>      guchar *amd_cert;
>      size_t amd_cert_len;
> +    gchar *send_packet_hdr;
> +    size_t send_packet_hdr_len;
>  };
>  
>  typedef struct SEVState SEVState;
> diff --git a/target/i386/trace-events b/target/i386/trace-events
> index 789c700d4a..b41516cf9f 100644
> --- a/target/i386/trace-events
> +++ b/target/i386/trace-events
> @@ -15,3 +15,6 @@ kvm_sev_launch_start(int policy, void *session, void *pdh) "policy 0x%x session
>  kvm_sev_launch_update_data(void *addr, uint64_t len) "addr %p len 0x%" PRIu64
>  kvm_sev_launch_measurement(const char *value) "data %s"
>  kvm_sev_launch_finish(void) ""
> +kvm_sev_send_start(uint64_t pdh, int l1, uint64_t plat, int l2, uint64_t amd, int l3) "pdh 0x%" PRIx64 " len %d plat 0x%" PRIx64 " len %d amd 0x%" PRIx64 " len %d"
> +kvm_sev_send_update_data(void *src, void *dst, int len) "guest %p trans %p len %d"
> +kvm_sev_send_finish(void) ""
> -- 
> 2.17.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

