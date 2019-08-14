Return-Path: <SRS0=fB5B=WK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D529C32753
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 16:38:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 739752084F
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 16:38:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 739752084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxwHu-0007JI-Lt
	for qemu-devel@archiver.kernel.org; Wed, 14 Aug 2019 12:38:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53330)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1hxwHF-0006sM-SM
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 12:37:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1hxwHD-0007ir-Pe
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 12:37:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60832)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hxwHD-0007iU-HW
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 12:37:31 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id DA614203ED;
 Wed, 14 Aug 2019 16:37:30 +0000 (UTC)
Received: from work-vm (ovpn-117-212.ams2.redhat.com [10.36.117.212])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 599FD81E3B;
 Wed, 14 Aug 2019 16:37:28 +0000 (UTC)
Date: Wed, 14 Aug 2019 17:37:26 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: "Singh, Brijesh" <brijesh.singh@amd.com>
Message-ID: <20190814163726.GO2920@work-vm>
References: <20190806165429.19327-1-brijesh.singh@amd.com>
 <20190806165429.19327-14-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190806165429.19327-14-brijesh.singh@amd.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Wed, 14 Aug 2019 16:37:30 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 13/14] migration/ram: add support to
 send encrypted pages
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
> When memory encryption is enabled, the guest memory will be encrypted with
> the guest specific key. The patch introduces RAM_SAVE_FLAG_ENCRYPTED_PAGE
> flag to distinguish the encrypted data from plaintext. Encrypted pages
> may need special handling. The kvm_memcrypt_save_outgoing_page() is used
> by the sender to write the encrypted pages onto the socket, similarly the
> kvm_memcrypt_load_incoming_page() is used by the target to read the
> encrypted pages from the socket and load into the guest memory.
> 
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  migration/ram.c | 131 +++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 130 insertions(+), 1 deletion(-)
> 
> diff --git a/migration/ram.c b/migration/ram.c
> index 57c707525b..100a5a10cd 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -59,6 +59,9 @@
>  #include "qemu/iov.h"
>  #include "hw/boards.h"
>  
> +/* Defines RAM_SAVE_ENCRYPTED_PAGE and  RAM_SAVE_ENCRYPTED_BITMAP */
> +#include "sysemu/sev.h"
> +
>  /***********************************************************/
>  /* ram save/restore */
>  
> @@ -77,6 +80,7 @@
>  #define RAM_SAVE_FLAG_XBZRLE   0x40
>  /* 0x80 is reserved in migration.h start with 0x100 next */
>  #define RAM_SAVE_FLAG_COMPRESS_PAGE    0x100
> +#define RAM_SAVE_FLAG_ENCRYPTED_DATA   0x200
>  
>  static inline bool is_zero_range(uint8_t *p, uint64_t size)
>  {
> @@ -460,6 +464,9 @@ static QemuCond decomp_done_cond;
>  
>  static bool do_compress_ram_page(QEMUFile *f, z_stream *stream, RAMBlock *block,
>                                   ram_addr_t offset, uint8_t *source_buf);
> +static int ram_save_encrypted_page(RAMState *rs, PageSearchStatus *pss,
> +                                   bool last_stage);
> +
>  
>  static void *do_data_compress(void *opaque)
>  {
> @@ -2039,6 +2046,73 @@ static int save_normal_page(RAMState *rs, RAMBlock *block, ram_addr_t offset,
>      return 1;
>  }
>  
> +/**
> + * ram_save_encrypted_page - send the given encrypted page to the stream
> + */
> +static int ram_save_encrypted_page(RAMState *rs, PageSearchStatus *pss,
> +                                   bool last_stage)
> +{
> +    int ret;
> +    uint8_t *p;
> +    RAMBlock *block = pss->block;
> +    ram_addr_t offset = pss->page << TARGET_PAGE_BITS;
> +    uint64_t bytes_xmit;
> +    MachineState *ms = MACHINE(qdev_get_machine());
> +    MachineClass *mc = MACHINE_GET_CLASS(ms);
> +    struct MachineMemoryEncryptionOps *ops = mc->memory_encryption_ops;
> +
> +    p = block->host + offset;
> +
> +    ram_counters.transferred +=
> +        save_page_header(rs, rs->f, block,
> +                    offset | RAM_SAVE_FLAG_ENCRYPTED_DATA);
> +
> +    qemu_put_be32(rs->f, RAM_SAVE_ENCRYPTED_PAGE);
> +    ret = ops->save_outgoing_page(rs->f, p, TARGET_PAGE_SIZE, &bytes_xmit);
> +    if (ret) {
> +        return -1;
> +    }
> +
> +    ram_counters.transferred += bytes_xmit;
> +    ram_counters.normal++;
> +
> +    return 1;
> +}
> +
> +/**
> + * ram_save_encrypted_bitmap: send the encrypted page state bitmap
> + */
> +static int ram_save_encrypted_bitmap(RAMState *rs, QEMUFile *f)
> +{
> +    MachineState *ms = MACHINE(qdev_get_machine());
> +    MachineClass *mc = MACHINE_GET_CLASS(ms);
> +    struct MachineMemoryEncryptionOps *ops = mc->memory_encryption_ops;
> +
> +    save_page_header(rs, rs->f, rs->last_seen_block,
> +                     RAM_SAVE_FLAG_ENCRYPTED_DATA);
> +    qemu_put_be32(rs->f, RAM_SAVE_ENCRYPTED_BITMAP);
> +    return ops->save_outgoing_bitmap(rs->f);
> +}
> +
> +static int load_encrypted_data(QEMUFile *f, uint8_t *ptr)
> +{
> +    MachineState *ms = MACHINE(qdev_get_machine());
> +    MachineClass *mc = MACHINE_GET_CLASS(ms);
> +    struct MachineMemoryEncryptionOps *ops = mc->memory_encryption_ops;
> +    int flag;
> +
> +    flag = qemu_get_be32(f);
> +
> +    if (flag == RAM_SAVE_ENCRYPTED_PAGE) {
> +        return ops->load_incoming_page(f, ptr);
> +    } else if (flag == RAM_SAVE_ENCRYPTED_BITMAP) {
> +        return ops->load_incoming_bitmap(f);
> +    } else {
> +        error_report("unknown encrypted flag %x", flag);
> +        return 1;
> +    }
> +}
> +
>  /**
>   * ram_save_page: send the given page to the stream
>   *
> @@ -2528,6 +2602,22 @@ static bool save_compress_page(RAMState *rs, RAMBlock *block, ram_addr_t offset)
>      return false;
>  }
>  
> +/**
> + * encrypted_test_bitmap: check if the page is encrypted
> + *
> + * Returns a bool indicating whether the page is encrypted.
> + */
> +static bool encrypted_test_bitmap(RAMState *rs, RAMBlock *block,
> +                                  unsigned long page)
> +{
> +    /* ROM devices contains the unencrypted data */
> +    if (memory_region_is_rom(block->mr)) {
> +        return false;
> +    }
> +
> +    return test_bit(page, block->encbmap);
> +}
> +
>  /**
>   * ram_save_target_page: save one target page
>   *
> @@ -2548,6 +2638,17 @@ static int ram_save_target_page(RAMState *rs, PageSearchStatus *pss,
>          return res;
>      }
>  
> +    /*
> +     * If memory encryption is enabled then use memory encryption APIs
> +     * to write the outgoing buffer to the wire. The encryption APIs
> +     * will take care of accessing the guest memory and re-encrypt it
> +     * for the transport purposes.
> +     */
> +    if (memcrypt_enabled() &&
> +        encrypted_test_bitmap(rs, pss->block, pss->page)) {
> +        return ram_save_encrypted_page(rs, pss, last_stage);
> +    }
> +
>      if (save_compress_page(rs, block, offset)) {
>          return 1;
>      }
> @@ -3445,6 +3546,16 @@ void qemu_guest_free_page_hint(void *addr, size_t len)
>      }
>  }
>  
> +static int ram_encrypted_save_setup(void)
> +{
> +    MachineState *ms = MACHINE(qdev_get_machine());
> +    MachineClass *mc = MACHINE_GET_CLASS(ms);
> +    MigrationParameters *p = &migrate_get_current()->parameters;
> +    struct MachineMemoryEncryptionOps *ops = mc->memory_encryption_ops;
> +
> +    return ops->save_setup(p->sev_pdh, p->sev_plat_cert, p->sev_amd_cert);
> +}
> +
>  /*
>   * Each of ram_save_setup, ram_save_iterate and ram_save_complete has
>   * long-running RCU critical section.  When rcu-reclaims in the code
> @@ -3480,6 +3591,12 @@ static int ram_save_setup(QEMUFile *f, void *opaque)
>  
>      rcu_read_lock();
>  
> +    if (memcrypt_enabled()) {
> +        if (ram_encrypted_save_setup()) {
> +            return -1;
> +        }
> +    }
> +
>      qemu_put_be64(f, ram_bytes_total_common(true) | RAM_SAVE_FLAG_MEM_SIZE);
>  
>      RAMBLOCK_FOREACH_MIGRATABLE(block) {
> @@ -3644,6 +3761,11 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
>      flush_compressed_data(rs);
>      ram_control_after_iterate(f, RAM_CONTROL_FINISH);
>  
> +    /* send the page encryption state bitmap */
> +    if (memcrypt_enabled()) {
> +        ret = ram_save_encrypted_bitmap(rs, f);
> +    }
> +
>      rcu_read_unlock();
>  
>      multifd_send_sync_main();
> @@ -4391,7 +4513,8 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
>          }
>  
>          if (flags & (RAM_SAVE_FLAG_ZERO | RAM_SAVE_FLAG_PAGE |
> -                     RAM_SAVE_FLAG_COMPRESS_PAGE | RAM_SAVE_FLAG_XBZRLE)) {
> +                     RAM_SAVE_FLAG_COMPRESS_PAGE | RAM_SAVE_FLAG_XBZRLE |
> +                     RAM_SAVE_FLAG_ENCRYPTED_DATA)) {
>              RAMBlock *block = ram_block_from_stream(f, flags);
>  
>              /*
> @@ -4505,6 +4628,12 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
>                  break;
>              }
>              break;
> +        case RAM_SAVE_FLAG_ENCRYPTED_DATA:
> +            if (load_encrypted_data(f, host)) {
> +                    error_report("Failed to load encrypted data");
> +                    ret = -EINVAL;
> +            }
> +            break;
>          case RAM_SAVE_FLAG_EOS:
>              /* normal exit */
>              multifd_recv_sync_main();
> -- 
> 2.17.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

