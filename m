Return-Path: <SRS0=r3/N=VJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB98AC742B3
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 11:30:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2F0D208E4
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 11:30:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2F0D208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48396 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hltkz-000467-OV
	for qemu-devel@archiver.kernel.org; Fri, 12 Jul 2019 07:30:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50305)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgilbert@redhat.com>) id 1hltko-0003hy-RJ
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 07:30:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1hltkm-0001jH-Gj
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 07:30:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40676)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hltkm-0001hV-7g
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 07:30:16 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E3E9DC05566B;
 Fri, 12 Jul 2019 11:30:14 +0000 (UTC)
Received: from work-vm (ovpn-117-214.ams2.redhat.com [10.36.117.214])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 791255F724;
 Fri, 12 Jul 2019 11:30:13 +0000 (UTC)
Date: Fri, 12 Jul 2019 12:30:11 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: "Singh, Brijesh" <brijesh.singh@amd.com>
Message-ID: <20190712113011.GF2730@work-vm>
References: <20190710202219.25939-1-brijesh.singh@amd.com>
 <20190710202219.25939-13-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190710202219.25939-13-brijesh.singh@amd.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Fri, 12 Jul 2019 11:30:15 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 12/13] migration: add support to migrate
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
>  accel/kvm/kvm-all.c      |  4 +++
>  migration/ram.c          | 11 +++++++
>  target/i386/sev.c        | 67 ++++++++++++++++++++++++++++++++++++++++
>  target/i386/trace-events |  2 ++
>  4 files changed, 84 insertions(+)
> 
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index 442b1af36e..9e23088a94 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -1831,6 +1831,10 @@ static int kvm_init(MachineState *ms)
>          kvm_state->memcrypt_encrypt_data = sev_encrypt_data;
>          kvm_state->memcrypt_save_outgoing_page = sev_save_outgoing_page;
>          kvm_state->memcrypt_load_incoming_page = sev_load_incoming_page;
> +        kvm_state->memcrypt_load_incoming_page_enc_bitmap =
> +            sev_load_incoming_page_enc_bitmap;
> +        kvm_state->memcrypt_save_outgoing_page_enc_bitmap =
> +            sev_save_outgoing_page_enc_bitmap;
>      }
>  
>      ret = kvm_arch_init(ms, s);
> diff --git a/migration/ram.c b/migration/ram.c
> index d179867e1b..3a4bdf3c03 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -78,6 +78,7 @@
>  /* 0x80 is reserved in migration.h start with 0x100 next */
>  #define RAM_SAVE_FLAG_COMPRESS_PAGE    0x100
>  #define RAM_SAVE_FLAG_ENCRYPTED_PAGE   0x200
> +#define RAM_SAVE_FLAG_PAGE_ENCRYPTED_BITMAP       0x400 /* used in target/i386/sev.c */

OK, you see now we're toast!  We can't use that bit.

I see two ways around this:

  a) Define a flag to mean 'more flags'  - we can reuse the old
RAM_SAVE_FLAG_FULL to mean more-flags, and then send a second 64bit word
that actually contains the flags

  b) Do something clever where RAM_SAVE_FLAG_ENCRYPTED_PAGE | something
is your bitmap.  But then you need to be careful in any confusion during
the decoding.

>  static inline bool is_zero_range(uint8_t *p, uint64_t size)
>  {
> @@ -3595,6 +3596,10 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
>      flush_compressed_data(rs);
>      ram_control_after_iterate(f, RAM_CONTROL_FINISH);
>  
> +    if (kvm_memcrypt_enabled()) {
> +        ret = kvm_memcrypt_save_outgoing_page_enc_bitmap(f);
> +    }
> +
>      rcu_read_unlock();
>  
>      multifd_send_sync_main();
> @@ -4469,6 +4474,12 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
>                      ret = -EINVAL;
>              }
>              break;
> +        case RAM_SAVE_FLAG_PAGE_ENCRYPTED_BITMAP:
> +            if (kvm_memcrypt_load_incoming_page_enc_bitmap(f)) {
> +                error_report("Failed to load page enc bitmap");
> +                ret = -EINVAL;
> +            }
> +            break;
>          case RAM_SAVE_FLAG_EOS:
>              /* normal exit */
>              multifd_recv_sync_main();
> diff --git a/target/i386/sev.c b/target/i386/sev.c
> index 09a62d6f88..93c6a90806 100644
> --- a/target/i386/sev.c
> +++ b/target/i386/sev.c
> @@ -63,6 +63,7 @@ static const char *const sev_fw_errlist[] = {
>  };
>  
>  #define SEV_FW_MAX_ERROR      ARRAY_SIZE(sev_fw_errlist)
> +#define RAM_SAVE_FLAG_PAGE_ENCRYPTED_BITMAP       0x400
>  
>  static int
>  sev_ioctl(int fd, int cmd, void *data, int *error)
> @@ -1189,6 +1190,72 @@ int sev_load_incoming_page(void *handle, QEMUFile *f, uint8_t *ptr)
>      return sev_receive_update_data(f, ptr);
>  }
>  
> +#define ALIGN(x, y)  (((x)+(y)-1) & ~((y)-1))
> +
> +int sev_load_incoming_page_enc_bitmap(void *handle, QEMUFile *f)
> +{
> +    void *bmap;
> +    unsigned long npages;
> +    unsigned long bmap_size, base_gpa;
> +    struct kvm_page_enc_bitmap e = {};
> +
> +    base_gpa = qemu_get_be64(f);
> +    npages = qemu_get_be64(f);
> +    bmap_size = qemu_get_be64(f);
> +
> +    bmap = g_malloc0(bmap_size);
> +    qemu_get_buffer(f, (uint8_t *)bmap, bmap_size);

You should validate npages against bmap_size and validate bmap_size
for being huge if possible (although huge VMs are legal).
You could also sanity check base_gpa for alignment.

Treat data coming off the wire as hostile.

> +    if (kvm_vm_ioctl(kvm_state, KVM_SET_PAGE_ENC_BITMAP, &e) == -1) {
> +
> +    trace_kvm_sev_load_page_enc_bitmap(base_gpa, npages << TARGET_PAGE_BITS);
> +
> +    e.start_gfn = base_gpa >> TARGET_PAGE_BITS;
> +    e.num_pages = npages;
> +    e.enc_bitmap = bmap;

> +        error_report("KVM_SET_PAGE_ENC_BITMAP ioctl failed %d", errno);
> +        g_free(bmap);
> +        return 1;
> +    }
> +
> +    g_free(bmap);
> +
> +    return 0;
> +}
> +
> +int sev_save_outgoing_page_enc_bitmap(void *handle, QEMUFile *f,
> +                                      unsigned long start, uint64_t length)
> +{
> +    uint64_t size;
> +    struct kvm_page_enc_bitmap e = {};
> +
> +    if (!length) {
> +        return 0;
> +    }
> +
> +    size = ALIGN((length >> TARGET_PAGE_BITS), /*HOST_LONG_BITS*/ 64) / 8;
> +    e.enc_bitmap = g_malloc0(size);
> +    e.start_gfn = start >> TARGET_PAGE_BITS;
> +    e.num_pages = length >> TARGET_PAGE_BITS;
> +
> +    trace_kvm_sev_save_page_enc_bitmap(start, length);
> +
> +    if (kvm_vm_ioctl(kvm_state, KVM_GET_PAGE_ENC_BITMAP, &e) == -1) {
> +        error_report("%s: KVM_GET_PAGE_ENC_BITMAP ioctl failed %d",
> +                    __func__, errno);
> +        g_free(e.enc_bitmap);
> +        return 1;
> +    }
> +
> +    qemu_put_be64(f, RAM_SAVE_FLAG_PAGE_ENCRYPTED_BITMAP);
> +    qemu_put_be64(f, start);
> +    qemu_put_be64(f, e.num_pages);
> +    qemu_put_be64(f, size);
> +    qemu_put_buffer(f, (uint8_t *)e.enc_bitmap, size);
> +
> +    g_free(e.enc_bitmap);

This question is related to a question I had on an earlier patch;
but how 'stable' is this bitmap - i.e. cpa it change? Even across
a guest reboot?

> +    return 0;
> +}
> +
>  static void
>  sev_register_types(void)
>  {
> diff --git a/target/i386/trace-events b/target/i386/trace-events
> index 609752cca7..4c2be570f9 100644
> --- a/target/i386/trace-events
> +++ b/target/i386/trace-events
> @@ -21,3 +21,5 @@ kvm_sev_send_finish(void) ""
>  kvm_sev_receive_start(int policy, void *session, void *pdh) "policy 0x%x session %p pdh %p"
>  kvm_sev_receive_update_data(void *src, void *dst, int len, void *hdr, int hdr_len) "guest %p trans %p len %d hdr %p hdr_len %d"
>  kvm_sev_receive_finish(void) ""
> +kvm_sev_save_page_enc_bitmap(uint64_t start, uint64_t len) "start 0x%" PRIx64 " len 0x%" PRIx64
> +kvm_sev_load_page_enc_bitmap(uint64_t start, uint64_t len) "start 0x%" PRIx64 " len 0x%" PRIx64
> -- 
> 2.17.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

