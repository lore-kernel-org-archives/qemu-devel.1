Return-Path: <SRS0=ZEKs=WJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1566BC32750
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 18:58:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE1FD20578
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 18:58:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE1FD20578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxc09-0001Yz-4p
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 14:58:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48201)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgilbert@redhat.com>) id 1hxbzc-0000rX-GB
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 14:58:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1hxbza-0002nL-QU
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 14:58:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55794)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hxbza-0002n6-Ho
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 14:57:58 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B20E4470C;
 Tue, 13 Aug 2019 18:57:57 +0000 (UTC)
Received: from work-vm (ovpn-117-72.ams2.redhat.com [10.36.117.72])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BC93A1F8;
 Tue, 13 Aug 2019 18:57:54 +0000 (UTC)
Date: Tue, 13 Aug 2019 19:57:52 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: "Singh, Brijesh" <brijesh.singh@amd.com>
Message-ID: <20190813185752.GJ2763@work-vm>
References: <20190806165429.19327-1-brijesh.singh@amd.com>
 <20190806165429.19327-12-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190806165429.19327-12-brijesh.singh@amd.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Tue, 13 Aug 2019 18:57:57 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 11/14] migration: add support to migrate
 page encryption bitmap
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
> When memory encryption is enabled, the hypervisor maintains a page
> encryption bitmap which is referred by hypervisor during migratoin to check
> if page is private or shared. The bitmap is built during the VM bootup and
> must be migrated to the target host so that hypervisor on target host can
> use it for future migration. The KVM_{SET,GET}_PAGE_ENC_BITMAP can be used
> to get and set the bitmap for a given gfn range.
> 
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> ---
>  accel/kvm/kvm-all.c      | 27 ++++++++++++
>  accel/kvm/sev-stub.c     | 11 +++++
>  include/sysemu/sev.h     |  6 +++
>  target/i386/sev.c        | 93 ++++++++++++++++++++++++++++++++++++++++
>  target/i386/trace-events |  2 +
>  5 files changed, 139 insertions(+)
> 
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index ba0e7fa2be..f4d136b022 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -185,10 +185,37 @@ static int kvm_memcrypt_load_incoming_page(QEMUFile *f, uint8_t *ptr)
>      return sev_load_incoming_page(kvm_state->memcrypt_handle, f, ptr);
>  }
>  
> +static int kvm_memcrypt_save_outgoing_bitmap(QEMUFile *f)
> +{
> +    KVMMemoryListener *kml = &kvm_state->memory_listener;
> +    KVMState *s = kvm_state;
> +    int ret = 1, i;
> +
> +    /* iterate through all the registered slots and send the bitmap */
> +    for (i = 0; i < s->nr_slots; i++) {
> +        KVMSlot *mem = &kml->slots[i];
> +        ret = sev_save_outgoing_bitmap(s->memcrypt_handle, f, mem->start_addr,
> +                                       mem->memory_size,
> +                                       (i + 1) == s->nr_slots);
> +        if (ret) {
> +            return 1;
> +        }
> +    }
> +
> +    return ret;
> +}
> +
> +static int kvm_memcrypt_load_incoming_bitmap(QEMUFile *f)
> +{
> +    return sev_load_incoming_bitmap(kvm_state->memcrypt_handle, f);
> +}
> +
>  static struct MachineMemoryEncryptionOps sev_memory_encryption_ops = {
>      .save_setup = kvm_memcrypt_save_setup,
>      .save_outgoing_page = kvm_memcrypt_save_outgoing_page,
>      .load_incoming_page = kvm_memcrypt_load_incoming_page,
> +    .save_outgoing_bitmap = kvm_memcrypt_save_outgoing_bitmap,
> +    .load_incoming_bitmap = kvm_memcrypt_load_incoming_bitmap,
>  };
>  
>  int kvm_memcrypt_encrypt_data(uint8_t *ptr, uint64_t len)
> diff --git a/accel/kvm/sev-stub.c b/accel/kvm/sev-stub.c
> index 1b6773ef72..fa96225abc 100644
> --- a/accel/kvm/sev-stub.c
> +++ b/accel/kvm/sev-stub.c
> @@ -41,3 +41,14 @@ int sev_load_incoming_page(void *handle, QEMUFile *f, uint8_t *ptr)
>  {
>      return 1;
>  }
> +
> +int sev_save_outgoing_bitmap(void *handle, QEMUFile *f,
> +                             unsigned long start, uint64_t length, bool last)
> +{
> +    return 1;
> +}
> +
> +int sev_load_incoming_bitmap(void *handle, QEMUFile *f)
> +{
> +    return 1;
> +}
> diff --git a/include/sysemu/sev.h b/include/sysemu/sev.h
> index e9371bd2dd..f777083c94 100644
> --- a/include/sysemu/sev.h
> +++ b/include/sysemu/sev.h
> @@ -16,6 +16,9 @@
>  
>  #include "sysemu/kvm.h"
>  
> +#define RAM_SAVE_ENCRYPTED_PAGE        0x1
> +#define RAM_SAVE_ENCRYPTED_BITMAP      0x2
> +
>  void *sev_guest_init(const char *id);
>  int sev_encrypt_data(void *handle, uint8_t *ptr, uint64_t len);
>  int sev_save_setup(void *handle, const char *pdh, const char *plat_cert,
> @@ -23,4 +26,7 @@ int sev_save_setup(void *handle, const char *pdh, const char *plat_cert,
>  int sev_save_outgoing_page(void *handle, QEMUFile *f, uint8_t *ptr,
>                             uint32_t size, uint64_t *bytes_sent);
>  int sev_load_incoming_page(void *handle, QEMUFile *f, uint8_t *ptr);
> +int sev_load_incoming_bitmap(void *handle, QEMUFile *f);
> +int sev_save_outgoing_bitmap(void *handle, QEMUFile *f, unsigned long start,
> +                             uint64_t length, bool last);
>  #endif
> diff --git a/target/i386/sev.c b/target/i386/sev.c
> index a689011991..9d643e720c 100644
> --- a/target/i386/sev.c
> +++ b/target/i386/sev.c
> @@ -65,6 +65,8 @@ static const char *const sev_fw_errlist[] = {
>  #define SEV_FW_MAX_ERROR      ARRAY_SIZE(sev_fw_errlist)
>  
>  #define SEV_FW_BLOB_MAX_SIZE            0x4000          /* 16KB */
> +#define ENCRYPTED_BITMAP_CONTINUE       0x1
> +#define ENCRYPTED_BITMAP_END            0x2
>  
>  static int
>  sev_ioctl(int fd, int cmd, void *data, int *error)
> @@ -1232,6 +1234,97 @@ int sev_load_incoming_page(void *handle, QEMUFile *f, uint8_t *ptr)
>      return sev_receive_update_data(f, ptr);
>  }
>  
> +#define ALIGN(x, y)  (((x) + (y) - 1) & ~((y) - 1))
> +
> +int sev_load_incoming_bitmap(void *handle, QEMUFile *f)
> +{
> +    void *bmap;
> +    unsigned long bmap_size, base_gpa;
> +    unsigned long npages, expected_size, length;
> +    struct kvm_page_enc_bitmap e = {};
> +    int status;
> +
> +    status = qemu_get_be32(f);
> +
> +    while (status != ENCRYPTED_BITMAP_END) {

It would be good to be more defensive - I think you're always expecting
ENCRYPTED_BITMAP_CONTINUE?   I'd error out if the status
isn't one of the few things you expect.

(I know I might be a bit paranoid, but I'm used to very broken migration
streams!)

> +        base_gpa = qemu_get_be64(f);
> +        npages = qemu_get_be64(f);
> +        bmap_size = qemu_get_be64(f);

It's also a useful place to try a qemu_file_get_error(f) - it helps spot
whether an error is really a broken header or the stream ran out of
bytes unexpectedly.

But what you have is OK, but never any harm to make it more defensive.


Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> +        /*
> +         * Before allocating the bitmap buffer, lets do some bound check to
> +         * ensure that we are not dealing with corrupted stream.
> +         */
> +        length = npages << TARGET_PAGE_BITS;
> +        expected_size = ALIGN((length >> TARGET_PAGE_BITS), 64) / 8;
> +        if (expected_size != bmap_size) {
> +            error_report("corrupted bitmap expected size %ld got %ld",
> +                    expected_size, bmap_size);
> +            return 1;
> +        }
> +
> +        bmap = g_malloc0(bmap_size);
> +        qemu_get_buffer(f, (uint8_t *)bmap, bmap_size);
> +
> +        trace_kvm_sev_load_bitmap(base_gpa, npages << TARGET_PAGE_BITS);
> +
> +        e.start_gfn = base_gpa >> TARGET_PAGE_BITS;
> +        e.num_pages = npages;
> +        e.enc_bitmap = bmap;
> +        if (kvm_vm_ioctl(kvm_state, KVM_SET_PAGE_ENC_BITMAP, &e) == -1) {
> +            error_report("KVM_SET_PAGE_ENC_BITMAP ioctl failed %d", errno);
> +            g_free(bmap);
> +            return 1;
> +        }
> +
> +        g_free(bmap);
> +
> +        status = qemu_get_be32(f);
> +    }
> +
> +    return 0;
> +}
> +
> +int sev_save_outgoing_bitmap(void *handle, QEMUFile *f,
> +                             unsigned long start, uint64_t length, bool last)
> +{
> +    uint64_t size;
> +    struct kvm_page_enc_bitmap e = {};
> +
> +    if (!length) {
> +        /* nothing to send */
> +        goto done;
> +    }
> +
> +    size = ALIGN((length >> TARGET_PAGE_BITS), 64) / 8;
> +    e.enc_bitmap = g_malloc0(size);
> +    e.start_gfn = start >> TARGET_PAGE_BITS;
> +    e.num_pages = length >> TARGET_PAGE_BITS;
> +
> +    trace_kvm_sev_save_bitmap(start, length);
> +
> +    if (kvm_vm_ioctl(kvm_state, KVM_GET_PAGE_ENC_BITMAP, &e) == -1) {
> +        error_report("%s: KVM_GET_PAGE_ENC_BITMAP ioctl failed %d",
> +                    __func__, errno);
> +        g_free(e.enc_bitmap);
> +        return 1;
> +    }
> +
> +    qemu_put_be32(f, ENCRYPTED_BITMAP_CONTINUE);
> +    qemu_put_be64(f, start);
> +    qemu_put_be64(f, e.num_pages);
> +    qemu_put_be64(f, size);
> +    qemu_put_buffer(f, (uint8_t *)e.enc_bitmap, size);
> +
> +    g_free(e.enc_bitmap);
> +
> +done:
> +    if (last) {
> +        qemu_put_be32(f, ENCRYPTED_BITMAP_END);
> +    }
> +    return 0;
> +}
> +
>  static void
>  sev_register_types(void)
>  {
> diff --git a/target/i386/trace-events b/target/i386/trace-events
> index 609752cca7..853a3870ab 100644
> --- a/target/i386/trace-events
> +++ b/target/i386/trace-events
> @@ -21,3 +21,5 @@ kvm_sev_send_finish(void) ""
>  kvm_sev_receive_start(int policy, void *session, void *pdh) "policy 0x%x session %p pdh %p"
>  kvm_sev_receive_update_data(void *src, void *dst, int len, void *hdr, int hdr_len) "guest %p trans %p len %d hdr %p hdr_len %d"
>  kvm_sev_receive_finish(void) ""
> +kvm_sev_save_bitmap(uint64_t start, uint64_t len) "start 0x%" PRIx64 " len 0x%" PRIx64
> +kvm_sev_load_bitmap(uint64_t start, uint64_t len) "start 0x%" PRIx64 " len 0x%" PRIx64
> -- 
> 2.17.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

