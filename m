Return-Path: <SRS0=ZEKs=WJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45168C433FF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 17:39:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11D912067D
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 17:39:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11D912067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxale-0004UV-5l
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 13:39:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37956)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgilbert@redhat.com>) id 1hxalD-000404-RM
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 13:39:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1hxalC-000693-Cc
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 13:39:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51178)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hxalC-000688-3M
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 13:39:02 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E39CDC05AA57;
 Tue, 13 Aug 2019 17:38:59 +0000 (UTC)
Received: from work-vm (ovpn-117-72.ams2.redhat.com [10.36.117.72])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 37A2183060;
 Tue, 13 Aug 2019 17:38:57 +0000 (UTC)
Date: Tue, 13 Aug 2019 18:38:55 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: "Singh, Brijesh" <brijesh.singh@amd.com>
Message-ID: <20190813173855.GI2763@work-vm>
References: <20190806165429.19327-1-brijesh.singh@amd.com>
 <20190806165429.19327-11-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190806165429.19327-11-brijesh.singh@amd.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Tue, 13 Aug 2019 17:38:59 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 10/14] target/i386: sev: add support to
 load incoming encrypted page
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
> The sev_load_incoming_page() provide the implementation to read the
> incoming guest private pages from the socket and load it into the guest
> memory. The routines uses the RECEIVE_START command to create the
> incoming encryption context on the first call then uses the
> RECEIEVE_UPDATE_DATA command to load the encrypted pages into the guest
> memory. After migration is completed, we issue the RECEIVE_FINISH command
> to transition the SEV guest to the runnable state so that it can be
> executed.
> 
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>

OK, some comments about the return values of the functions would help,
but other than that.


Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  accel/kvm/kvm-all.c      |   6 ++
>  accel/kvm/sev-stub.c     |   5 ++
>  include/sysemu/sev.h     |   1 +
>  target/i386/sev.c        | 137 ++++++++++++++++++++++++++++++++++++++-
>  target/i386/trace-events |   3 +
>  5 files changed, 151 insertions(+), 1 deletion(-)
> 
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index a5b0ae9363..ba0e7fa2be 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -180,9 +180,15 @@ static int kvm_memcrypt_save_outgoing_page(QEMUFile *f, uint8_t *ptr,
>                                    bytes_sent);
>  }
>  
> +static int kvm_memcrypt_load_incoming_page(QEMUFile *f, uint8_t *ptr)
> +{
> +    return sev_load_incoming_page(kvm_state->memcrypt_handle, f, ptr);
> +}
> +
>  static struct MachineMemoryEncryptionOps sev_memory_encryption_ops = {
>      .save_setup = kvm_memcrypt_save_setup,
>      .save_outgoing_page = kvm_memcrypt_save_outgoing_page,
> +    .load_incoming_page = kvm_memcrypt_load_incoming_page,
>  };
>  
>  int kvm_memcrypt_encrypt_data(uint8_t *ptr, uint64_t len)
> diff --git a/accel/kvm/sev-stub.c b/accel/kvm/sev-stub.c
> index 51b17b8141..1b6773ef72 100644
> --- a/accel/kvm/sev-stub.c
> +++ b/accel/kvm/sev-stub.c
> @@ -36,3 +36,8 @@ int sev_save_outgoing_page(void *handle, QEMUFile *f, uint8_t *ptr,
>  {
>      return 1;
>  }
> +
> +int sev_load_incoming_page(void *handle, QEMUFile *f, uint8_t *ptr)
> +{
> +    return 1;
> +}
> diff --git a/include/sysemu/sev.h b/include/sysemu/sev.h
> index f06fd203cd..e9371bd2dd 100644
> --- a/include/sysemu/sev.h
> +++ b/include/sysemu/sev.h
> @@ -22,4 +22,5 @@ int sev_save_setup(void *handle, const char *pdh, const char *plat_cert,
>                     const char *amd_cert);
>  int sev_save_outgoing_page(void *handle, QEMUFile *f, uint8_t *ptr,
>                             uint32_t size, uint64_t *bytes_sent);
> +int sev_load_incoming_page(void *handle, QEMUFile *f, uint8_t *ptr);
>  #endif
> diff --git a/target/i386/sev.c b/target/i386/sev.c
> index 1820c62a71..a689011991 100644
> --- a/target/i386/sev.c
> +++ b/target/i386/sev.c
> @@ -721,13 +721,34 @@ sev_launch_finish(SEVState *s)
>      }
>  }
>  
> +static int
> +sev_receive_finish(SEVState *s)
> +{
> +    int error, ret = 1;
> +
> +    trace_kvm_sev_receive_finish();
> +    ret = sev_ioctl(s->sev_fd, KVM_SEV_RECEIVE_FINISH, 0, &error);
> +    if (ret) {
> +        error_report("%s: RECEIVE_FINISH ret=%d fw_error=%d '%s'",
> +                __func__, ret, error, fw_error_to_str(error));
> +        goto err;
> +    }
> +
> +    sev_set_guest_state(SEV_STATE_RUNNING);
> +err:
> +    return ret;
> +}
> +
> +
>  static void
>  sev_vm_state_change(void *opaque, int running, RunState state)
>  {
>      SEVState *s = opaque;
>  
>      if (running) {
> -        if (!sev_check_state(SEV_STATE_RUNNING)) {
> +        if (sev_check_state(SEV_STATE_RECEIVE_UPDATE)) {
> +            sev_receive_finish(s);
> +        } else if (!sev_check_state(SEV_STATE_RUNNING)) {
>              sev_launch_finish(s);
>          }
>      }
> @@ -1097,6 +1118,120 @@ int sev_save_outgoing_page(void *handle, QEMUFile *f, uint8_t *ptr,
>      return sev_send_update_data(s, f, ptr, sz, bytes_sent);
>  }
>  
> +static int
> +sev_receive_start(QSevGuestInfo *sev, QEMUFile *f)
> +{
> +    int ret = 1;
> +    int fw_error;
> +    struct kvm_sev_receive_start start = { };
> +    gchar *session = NULL, *pdh_cert = NULL;
> +
> +    /* get SEV guest handle */
> +    start.handle = object_property_get_int(OBJECT(sev), "handle",
> +                                           &error_abort);
> +
> +    /* get the source policy */
> +    start.policy = qemu_get_be32(f);
> +
> +    /* get source PDH key */
> +    start.pdh_len = qemu_get_be32(f);
> +    if (!check_blob_length(start.pdh_len)) {
> +        return 1;
> +    }
> +
> +    pdh_cert = g_new(gchar, start.pdh_len);
> +    qemu_get_buffer(f, (uint8_t *)pdh_cert, start.pdh_len);
> +    start.pdh_uaddr = (uintptr_t)pdh_cert;
> +
> +    /* get source session data */
> +    start.session_len = qemu_get_be32(f);
> +    if (!check_blob_length(start.session_len)) {
> +        return 1;
> +    }
> +    session = g_new(gchar, start.session_len);
> +    qemu_get_buffer(f, (uint8_t *)session, start.session_len);
> +    start.session_uaddr = (uintptr_t)session;
> +
> +    trace_kvm_sev_receive_start(start.policy, session, pdh_cert);
> +
> +    ret = sev_ioctl(sev_state->sev_fd, KVM_SEV_RECEIVE_START,
> +                    &start, &fw_error);
> +    if (ret < 0) {
> +        error_report("Error RECEIVE_START ret=%d fw_error=%d '%s'",
> +                ret, fw_error, fw_error_to_str(fw_error));
> +        goto err;
> +    }
> +
> +    object_property_set_int(OBJECT(sev), start.handle, "handle", &error_abort);
> +    sev_set_guest_state(SEV_STATE_RECEIVE_UPDATE);
> +err:
> +    g_free(session);
> +    g_free(pdh_cert);
> +
> +    return ret;
> +}
> +
> +static int sev_receive_update_data(QEMUFile *f, uint8_t *ptr)
> +{
> +    int ret = 1, fw_error = 0;
> +    gchar *hdr = NULL, *trans = NULL;
> +    struct kvm_sev_receive_update_data update = {};
> +
> +    /* get packet header */
> +    update.hdr_len = qemu_get_be32(f);
> +    if (!check_blob_length(update.hdr_len)) {
> +        return 1;
> +    }
> +
> +    hdr = g_new(gchar, update.hdr_len);
> +    qemu_get_buffer(f, (uint8_t *)hdr, update.hdr_len);
> +    update.hdr_uaddr = (uintptr_t)hdr;
> +
> +    /* get transport buffer */
> +    update.trans_len = qemu_get_be32(f);
> +    if (!check_blob_length(update.trans_len)) {
> +        goto err;
> +    }
> +
> +    trans = g_new(gchar, update.trans_len);
> +    update.trans_uaddr = (uintptr_t)trans;
> +    qemu_get_buffer(f, (uint8_t *)update.trans_uaddr, update.trans_len);
> +
> +    update.guest_uaddr = (uintptr_t) ptr;
> +    update.guest_len = update.trans_len;
> +
> +    trace_kvm_sev_receive_update_data(trans, ptr, update.guest_len,
> +            hdr, update.hdr_len);
> +
> +    ret = sev_ioctl(sev_state->sev_fd, KVM_SEV_RECEIVE_UPDATE_DATA,
> +                    &update, &fw_error);
> +    if (ret) {
> +        error_report("Error RECEIVE_UPDATE_DATA ret=%d fw_error=%d '%s'",
> +                ret, fw_error, fw_error_to_str(fw_error));
> +        goto err;
> +    }
> +err:
> +    g_free(trans);
> +    g_free(hdr);
> +    return ret;
> +}
> +
> +int sev_load_incoming_page(void *handle, QEMUFile *f, uint8_t *ptr)
> +{
> +    SEVState *s = (SEVState *)handle;
> +
> +    /*
> +     * If this is first buffer and SEV is not in recieiving state then
> +     * use RECEIVE_START command to create a encryption context.
> +     */
> +    if (!sev_check_state(SEV_STATE_RECEIVE_UPDATE) &&
> +        sev_receive_start(s->sev_info, f)) {
> +        return 1;
> +    }
> +
> +    return sev_receive_update_data(f, ptr);
> +}
> +
>  static void
>  sev_register_types(void)
>  {
> diff --git a/target/i386/trace-events b/target/i386/trace-events
> index b41516cf9f..609752cca7 100644
> --- a/target/i386/trace-events
> +++ b/target/i386/trace-events
> @@ -18,3 +18,6 @@ kvm_sev_launch_finish(void) ""
>  kvm_sev_send_start(uint64_t pdh, int l1, uint64_t plat, int l2, uint64_t amd, int l3) "pdh 0x%" PRIx64 " len %d plat 0x%" PRIx64 " len %d amd 0x%" PRIx64 " len %d"
>  kvm_sev_send_update_data(void *src, void *dst, int len) "guest %p trans %p len %d"
>  kvm_sev_send_finish(void) ""
> +kvm_sev_receive_start(int policy, void *session, void *pdh) "policy 0x%x session %p pdh %p"
> +kvm_sev_receive_update_data(void *src, void *dst, int len, void *hdr, int hdr_len) "guest %p trans %p len %d hdr %p hdr_len %d"
> +kvm_sev_receive_finish(void) ""
> -- 
> 2.17.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

