Return-Path: <SRS0=r3/N=VJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04DE3C742C7
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 15:24:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1BF3208E4
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 15:24:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1BF3208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50530 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlxPb-0007uD-47
	for qemu-devel@archiver.kernel.org; Fri, 12 Jul 2019 11:24:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60223)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgilbert@redhat.com>) id 1hlxPP-0007Vn-SY
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 11:24:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1hlxPN-0001yt-Ss
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 11:24:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36258)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hlxPN-0001yT-Ef
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 11:24:25 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1AB282F8BED;
 Fri, 12 Jul 2019 15:24:24 +0000 (UTC)
Received: from work-vm (ovpn-117-214.ams2.redhat.com [10.36.117.214])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BA7215C207;
 Fri, 12 Jul 2019 15:24:22 +0000 (UTC)
Date: Fri, 12 Jul 2019 16:24:19 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: "Singh, Brijesh" <brijesh.singh@amd.com>
Message-ID: <20190712152419.GM2730@work-vm>
References: <20190710202219.25939-1-brijesh.singh@amd.com>
 <20190710202219.25939-10-brijesh.singh@amd.com>
 <20190712104303.GD2730@work-vm>
 <3cd9d79a-eb9b-e935-79d0-268098752235@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3cd9d79a-eb9b-e935-79d0-268098752235@amd.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Fri, 12 Jul 2019 15:24:24 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 09/13] target/i386: sev: add support to
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
> 
> 
> On 7/12/19 5:43 AM, Dr. David Alan Gilbert wrote:
> > * Singh, Brijesh (brijesh.singh@amd.com) wrote:
> >> The sev_save_outgoing_page() provide the implementation to encrypt the
> >> guest private pages during the transit. The routines uses the SEND_START
> >> command to create the outgoing encryption context on the first call then
> >> uses the SEND_UPDATE_DATA command to encrypt the data before writing it
> >> to the socket. While encrypting the data SEND_UPDATE_DATA produces some
> >> metadata (e.g MAC, IV). The metadata is also sent to the target machine.
> >> After migration is completed, we issue the SEND_FINISH command to transition
> >> the SEV guest state from sending to unrunnable state.
> >>
> >> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> >> ---
> >>   accel/kvm/kvm-all.c      |   1 +
> >>   target/i386/sev.c        | 229 +++++++++++++++++++++++++++++++++++++++
> >>   target/i386/sev_i386.h   |   2 +
> >>   target/i386/trace-events |   3 +
> >>   4 files changed, 235 insertions(+)
> >>
> >> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> >> index c935e9366c..a9fb447248 100644
> >> --- a/accel/kvm/kvm-all.c
> >> +++ b/accel/kvm/kvm-all.c
> >> @@ -1792,6 +1792,7 @@ static int kvm_init(MachineState *ms)
> >>           }
> >>   
> >>           kvm_state->memcrypt_encrypt_data = sev_encrypt_data;
> >> +        kvm_state->memcrypt_save_outgoing_page = sev_save_outgoing_page;
> >>       }
> >>   
> >>       ret = kvm_arch_init(ms, s);
> >> diff --git a/target/i386/sev.c b/target/i386/sev.c
> >> index 6c902d0be8..28b36c8035 100644
> >> --- a/target/i386/sev.c
> >> +++ b/target/i386/sev.c
> >> @@ -27,6 +27,8 @@
> >>   #include "sysemu/sysemu.h"
> >>   #include "trace.h"
> >>   #include "migration/blocker.h"
> >> +#include "migration/qemu-file.h"
> >> +#include "migration/misc.h"
> >>   
> >>   #define DEFAULT_GUEST_POLICY    0x1 /* disable debug */
> >>   #define DEFAULT_SEV_DEVICE      "/dev/sev"
> >> @@ -718,6 +720,39 @@ sev_vm_state_change(void *opaque, int running, RunState state)
> >>       }
> >>   }
> >>   
> >> +static void
> >> +sev_send_finish(void)
> >> +{
> >> +    int ret, error;
> >> +
> >> +    trace_kvm_sev_send_finish();
> >> +    ret = sev_ioctl(sev_state->sev_fd, KVM_SEV_SEND_FINISH, 0, &error);
> >> +    if (ret) {
> >> +        error_report("%s: LAUNCH_FINISH ret=%d fw_error=%d '%s'",
> > 
> > why LAUNCH?
> 
> 
> Its typo. I will fix in next rev.
> 
> 
> > 
> >> +                     __func__, ret, error, fw_error_to_str(error));
> >> +    }
> >> +
> >> +    sev_set_guest_state(SEV_STATE_RUNNING);
> >> +}
> >> +
> >> +static void
> >> +sev_migration_state_notifier(Notifier *notifier, void *data)
> >> +{
> >> +    MigrationState *s = data;
> >> +
> >> +    if (migration_has_finished(s) ||
> >> +        migration_in_postcopy_after_devices(s) ||
> >> +        migration_has_failed(s)) {
> >> +        if (sev_check_state(SEV_STATE_SEND_UPDATE)) {
> >> +            sev_send_finish();
> >> +        }
> > 
> > I don't quite understand SEV_SEND_FINISH; is it just terminating the
> > migration process or is it actually making the VM unrunnable?
> > I'm interested in what the behaviour is on a failed migration - do
> > we lose both VMs or do we potentialyl have a memory clone?
> > (Neither are pretty!)
> > 
> 
> 
> The SEV_SEND_FINISH will make the VM unrunnable. So basically a
> failed migration will result both VMs unrunnable. The SEV FW commands
> are designed in that way to prevent the memory clone.

OK, can you add a note to the docs about that - the libvirt people will
also want to know that they can't restart the source on a failure.
(What happens if you try a 'cont' - how does it fail?)

It would be nice to fix this problem; I can imagine a system where
part of the key needed by the destinatino to decrypt the memory isn't
sent until very late in the day, and thus a failure before that point
would be safe.   I've no clue if that's actually doable!

Dave

> 
> >> +    }
> >> +}
> >> +
> >> +static Notifier sev_migration_state_notify = {
> >> +    .notify = sev_migration_state_notifier,
> >> +};
> >> +
> >>   void *
> >>   sev_guest_init(const char *id)
> >>   {
> >> @@ -804,6 +839,7 @@ sev_guest_init(const char *id)
> >>       ram_block_notifier_add(&sev_ram_notifier);
> >>       qemu_add_machine_init_done_notifier(&sev_machine_done_notify);
> >>       qemu_add_vm_change_state_handler(sev_vm_state_change, s);
> >> +    add_migration_state_change_notifier(&sev_migration_state_notify);
> >>   
> >>       return s;
> >>   err:
> >> @@ -836,6 +872,199 @@ void sev_set_migrate_info(const char *pdh, const char *plat_cert,
> >>       s->amd_cert = g_base64_decode(amd_cert, &s->amd_cert_len);
> >>   }
> >>   
> >> +static int
> >> +sev_get_send_session_length(void)
> >> +{
> >> +    int ret, fw_err = 0;
> >> +    struct kvm_sev_send_start *start;
> >> +
> >> +    start = g_new0(struct kvm_sev_send_start, 1);
> > 
> > These are tiny structures; they may as well be on the stack rather than
> > allocating/freeing them.
> 
> 
> Noted.
> 
> 
> > 
> >> +    ret = sev_ioctl(sev_state->sev_fd, KVM_SEV_SEND_START, start, &fw_err);
> >> +    if (fw_err != SEV_RET_INVALID_LEN) {
> >> +        ret = -1;
> >> +        error_report("%s: failed to get session length ret=%d fw_error=%d '%s'",
> >> +                     __func__, ret, fw_err, fw_error_to_str(fw_err));
> >> +        goto err;
> >> +    }
> >> +
> >> +    ret = start->session_len;
> >> +err:
> >> +    g_free(start);
> >> +    return ret;
> >> +}
> >> +
> >> +static int
> >> +sev_send_start(SEVState *s, QEMUFile *f, uint64_t *bytes_sent)
> >> +{
> >> +    gsize pdh_len = 0, plat_cert_len;
> >> +    int session_len, ret, fw_error;
> >> +    struct kvm_sev_send_start *start;
> >> +    guchar *pdh = NULL, *plat_cert = NULL, *session = NULL;
> >> +
> >> +    if (!s->remote_pdh || !s->remote_plat_cert) {
> >> +        error_report("%s: missing remote PDH or PLAT_CERT", __func__);
> >> +        return 1;
> >> +    }
> >> +
> >> +    start = g_new0(struct kvm_sev_send_start, 1);
> >> +
> >> +    start->pdh_cert_uaddr = (unsigned long) s->remote_pdh;
> >> +    start->pdh_cert_len = s->remote_pdh_len;
> >> +
> >> +    start->plat_cert_uaddr = (unsigned long)s->remote_plat_cert;
> >> +    start->plat_cert_len = s->remote_plat_cert_len;
> >> +
> >> +    start->amd_cert_uaddr = (unsigned long)s->amd_cert;
> > 
> > Should these actually be case via a uint64_t ? They're explicitly
> > 64bit - you might have to go via a uintptr_t to make some compilers
> > happy?
> > 
> 
> Noted.
> 
> >> +    start->amd_cert_len = s->amd_cert_len;
> >> +
> >> +    /* get the session length */
> >> +    session_len = sev_get_send_session_length();
> >> +    if (session_len < 0) {
> >> +        ret = 1;
> >> +        goto err;
> >> +    }
> >> +
> >> +    session = g_new0(guchar, session_len);
> >> +    start->session_uaddr = (unsigned long)session;
> >> +    start->session_len = session_len;
> >> +
> >> +    /* Get our PDH certificate */
> >> +    ret = sev_get_pdh_info(s->sev_fd, &pdh, &pdh_len,
> >> +                           &plat_cert, &plat_cert_len);
> >> +    if (ret) {
> >> +        error_report("Failed to get our PDH cert");
> >> +        goto err;
> >> +    }
> >> +
> >> +    trace_kvm_sev_send_start(start->pdh_cert_uaddr, start->pdh_cert_len,
> >> +                             start->plat_cert_uaddr, start->plat_cert_len,
> >> +                             start->amd_cert_uaddr, start->amd_cert_len);
> >> +
> >> +    ret = sev_ioctl(s->sev_fd, KVM_SEV_SEND_START, start, &fw_error);
> >> +    if (ret < 0) {
> >> +        error_report("%s: SEND_START ret=%d fw_error=%d '%s'",
> >> +                __func__, ret, fw_error, fw_error_to_str(fw_error));
> >> +        goto err;
> >> +    }
> >> +
> >> +    qemu_put_be32(f, start->policy);
> >> +    qemu_put_be32(f, pdh_len);
> >> +    qemu_put_buffer(f, (uint8_t *)pdh, pdh_len);
> >> +    qemu_put_be32(f, start->session_len);
> >> +    qemu_put_buffer(f, (uint8_t *)start->session_uaddr, start->session_len);
> >> +    *bytes_sent = 12 + pdh_len + start->session_len;
> >> +
> >> +    sev_set_guest_state(SEV_STATE_SEND_UPDATE);
> >> +
> >> +err:
> >> +    g_free(start);
> >> +    g_free(pdh);
> >> +    g_free(plat_cert);
> >> +    return ret;
> >> +}
> >> +
> >> +static int
> >> +sev_send_get_packet_len(int *fw_err)
> >> +{
> >> +    int ret;
> >> +    struct kvm_sev_send_update_data *update;
> >> +
> >> +    update = g_malloc0(sizeof(*update));
> >> +    if (!update) {
> >> +        return -1;
> >> +    }
> >> +
> >> +    ret = sev_ioctl(sev_state->sev_fd, KVM_SEV_SEND_UPDATE_DATA, update, fw_err);
> >> +    if (*fw_err != SEV_RET_INVALID_LEN) {
> >> +        ret = -1;
> >> +        error_report("%s: failed to get session length ret=%d fw_error=%d '%s'",
> >> +                    __func__, ret, *fw_err, fw_error_to_str(*fw_err));
> >> +        goto err;
> >> +    }
> >> +
> >> +    ret = update->hdr_len;
> >> +
> >> +err:
> >> +    g_free(update);
> >> +    return ret;
> >> +}
> >> +
> >> +static int
> >> +sev_send_update_data(SEVState *s, QEMUFile *f, uint8_t *ptr, uint32_t size,
> >> +                     uint64_t *bytes_sent)
> >> +{
> >> +    int ret, fw_error;
> >> +    guchar *trans;
> >> +    struct kvm_sev_send_update_data *update;
> >> +
> >> +    /* If this is first call then query the packet header bytes and allocate
> >> +     * the packet buffer.
> >> +     */
> >> +    if (!s->send_packet_hdr) {
> >> +        s->send_packet_hdr_len = sev_send_get_packet_len(&fw_error);
> >> +        if (s->send_packet_hdr_len < 1) {
> >> +            error_report("%s: SEND_UPDATE fw_error=%d '%s'",
> >> +                    __func__, fw_error, fw_error_to_str(fw_error));
> >> +            return 1;
> >> +        }
> >> +
> >> +        s->send_packet_hdr = g_new(gchar, s->send_packet_hdr_len);
> > 
> > When does this get freed?
> > 
> 
> Ah, we could free it in SEND_FINISH to avoid leaking.
> 
> 
> >> +    }
> >> +
> >> +    update = g_new0(struct kvm_sev_send_update_data, 1);
> >> +
> >> +    /* allocate transport buffer */
> >> +    trans = g_new(guchar, size);
> >> +
> >> +    update->hdr_uaddr = (unsigned long)s->send_packet_hdr;
> >> +    update->hdr_len = s->send_packet_hdr_len;
> >> +    update->guest_uaddr = (unsigned long)ptr;
> >> +    update->guest_len = size;
> >> +    update->trans_uaddr = (unsigned long)trans;
> >> +    update->trans_len = size;
> >> +
> >> +    trace_kvm_sev_send_update_data(ptr, trans, size);
> >> +
> >> +    ret = sev_ioctl(s->sev_fd, KVM_SEV_SEND_UPDATE_DATA, update, &fw_error);
> >> +    if (ret) {
> >> +        error_report("%s: SEND_UPDATE_DATA ret=%d fw_error=%d '%s'",
> >> +                __func__, ret, fw_error, fw_error_to_str(fw_error));
> >> +        goto err;
> >> +    }
> >> +
> >> +    qemu_put_be32(f, update->hdr_len);
> >> +    qemu_put_buffer(f, (uint8_t *)update->hdr_uaddr, update->hdr_len);
> >> +    *bytes_sent = 4 + update->hdr_len;
> >> +
> >> +    qemu_put_be32(f, update->trans_len);
> >> +    qemu_put_buffer(f, (uint8_t *)update->trans_uaddr, update->trans_len);
> >> +    *bytes_sent += (4 + update->trans_len);
> >> +
> >> +err:
> >> +    g_free(trans);
> >> +    g_free(update);
> >> +    return ret;
> >> +}
> >> +
> >> +int sev_save_outgoing_page(void *handle, QEMUFile *f, uint8_t *ptr,
> >> +                           uint32_t sz, uint64_t *bytes_sent)
> >> +{
> >> +    SEVState *s = sev_state;
> >> +
> >> +    /*
> >> +     * If this is a first buffer then create outgoing encryption context
> >> +     * and write our PDH, policy and session data.
> >> +     */
> >> +    if (!sev_check_state(SEV_STATE_SEND_UPDATE) &&
> >> +        sev_send_start(s, f, bytes_sent)) {
> >> +        error_report("Failed to create outgoing context");
> >> +        return 1;
> >> +    }
> >> +
> >> +    return sev_send_update_data(s, f, ptr, sz, bytes_sent);
> >> +}
> >> +
> >>   static void
> >>   sev_register_types(void)
> >>   {
> >> diff --git a/target/i386/sev_i386.h b/target/i386/sev_i386.h
> >> index 3f3449b346..2fdca5190d 100644
> >> --- a/target/i386/sev_i386.h
> >> +++ b/target/i386/sev_i386.h
> >> @@ -88,6 +88,8 @@ struct SEVState {
> >>       size_t remote_plat_cert_len;
> >>       guchar *amd_cert;
> >>       size_t amd_cert_len;
> >> +    gchar *send_packet_hdr;
> >> +    size_t send_packet_hdr_len;
> >>   };
> >>   
> >>   typedef struct SEVState SEVState;
> >> diff --git a/target/i386/trace-events b/target/i386/trace-events
> >> index 789c700d4a..b41516cf9f 100644
> >> --- a/target/i386/trace-events
> >> +++ b/target/i386/trace-events
> >> @@ -15,3 +15,6 @@ kvm_sev_launch_start(int policy, void *session, void *pdh) "policy 0x%x session
> >>   kvm_sev_launch_update_data(void *addr, uint64_t len) "addr %p len 0x%" PRIu64
> >>   kvm_sev_launch_measurement(const char *value) "data %s"
> >>   kvm_sev_launch_finish(void) ""
> >> +kvm_sev_send_start(uint64_t pdh, int l1, uint64_t plat, int l2, uint64_t amd, int l3) "pdh 0x%" PRIx64 " len %d plat 0x%" PRIx64 " len %d amd 0x%" PRIx64 " len %d"
> >> +kvm_sev_send_update_data(void *src, void *dst, int len) "guest %p trans %p len %d"
> >> +kvm_sev_send_finish(void) ""
> >> -- 
> >> 2.17.1
> >>
> > --
> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> > 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

