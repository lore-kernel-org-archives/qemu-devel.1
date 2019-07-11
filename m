Return-Path: <SRS0=FHOf=VI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0B82C71142
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 17:36:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B6F22084B
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 17:36:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B6F22084B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlcze-0005Wr-Oh
	for qemu-devel@archiver.kernel.org; Thu, 11 Jul 2019 13:36:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35866)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgilbert@redhat.com>) id 1hlcxn-0005lu-2h
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 13:34:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1hlcxl-0006rZ-JI
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 13:34:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58532)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hlcxl-0006qY-Ak
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 13:34:33 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7441F811DC;
 Thu, 11 Jul 2019 17:34:31 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.40])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 231445C1B4;
 Thu, 11 Jul 2019 17:34:29 +0000 (UTC)
Date: Thu, 11 Jul 2019 18:34:27 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: "Singh, Brijesh" <brijesh.singh@amd.com>
Message-ID: <20190711173427.GR3971@work-vm>
References: <20190710202219.25939-1-brijesh.singh@amd.com>
 <20190710202219.25939-4-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190710202219.25939-4-brijesh.singh@amd.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Thu, 11 Jul 2019 17:34:31 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 03/13] migration/ram: add support to
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
> ---
>  migration/ram.c | 54 ++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 53 insertions(+), 1 deletion(-)
> 
> diff --git a/migration/ram.c b/migration/ram.c
> index 908517fc2b..3c8977d508 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -57,6 +57,7 @@
>  #include "qemu/uuid.h"
>  #include "savevm.h"
>  #include "qemu/iov.h"
> +#include "sysemu/kvm.h"
>  
>  /***********************************************************/
>  /* ram save/restore */
> @@ -76,6 +77,7 @@
>  #define RAM_SAVE_FLAG_XBZRLE   0x40
>  /* 0x80 is reserved in migration.h start with 0x100 next */
>  #define RAM_SAVE_FLAG_COMPRESS_PAGE    0x100
> +#define RAM_SAVE_FLAG_ENCRYPTED_PAGE   0x200

OK, that's our very last usable flag!  Use it wisely!

>  static inline bool is_zero_range(uint8_t *p, uint64_t size)
>  {
> @@ -460,6 +462,9 @@ static QemuCond decomp_done_cond;
>  static bool do_compress_ram_page(QEMUFile *f, z_stream *stream, RAMBlock *block,
>                                   ram_addr_t offset, uint8_t *source_buf);
>  
> +static int ram_save_encrypted_page(RAMState *rs, PageSearchStatus *pss,
> +                                   bool last_stage);
> +
>  static void *do_data_compress(void *opaque)
>  {
>      CompressParam *param = opaque;
> @@ -2006,6 +2011,36 @@ static int ram_save_multifd_page(RAMState *rs, RAMBlock *block,
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
> +
> +    p = block->host + offset;
> +
> +    ram_counters.transferred +=
> +        save_page_header(rs, rs->f, block,
> +                    offset | RAM_SAVE_FLAG_ENCRYPTED_PAGE);
> +
> +    ret = kvm_memcrypt_save_outgoing_page(rs->f, p,

I think you need to somehow abstract the kvm_memcrypt stuff; nothing
else in migration actually knows it's dealing with kvm.  So there
should be some indirection - probably through the cpu or the machine
type or something.

Also, this isn't bisectable - you can't make this call in this patch
because you don't define/declare this function until a later patch.


> +                        TARGET_PAGE_SIZE, &bytes_xmit);
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
>  static bool do_compress_ram_page(QEMUFile *f, z_stream *stream, RAMBlock *block,
>                                   ram_addr_t offset, uint8_t *source_buf)
>  {
> @@ -2450,6 +2485,16 @@ static int ram_save_target_page(RAMState *rs, PageSearchStatus *pss,
>          return res;
>      }
>  
> +    /*
> +     * If memory encryption is enabled then use memory encryption APIs
> +     * to write the outgoing buffer to the wire. The encryption APIs
> +     * will take care of accessing the guest memory and re-encrypt it
> +     * for the transport purposes.
> +     */
> +     if (kvm_memcrypt_enabled()) {
> +        return ram_save_encrypted_page(rs, pss, last_stage);
> +     }
> +
>      if (save_compress_page(rs, block, offset)) {
>          return 1;
>      }
> @@ -4271,7 +4316,8 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
>          }
>  
>          if (flags & (RAM_SAVE_FLAG_ZERO | RAM_SAVE_FLAG_PAGE |
> -                     RAM_SAVE_FLAG_COMPRESS_PAGE | RAM_SAVE_FLAG_XBZRLE)) {
> +                     RAM_SAVE_FLAG_COMPRESS_PAGE | RAM_SAVE_FLAG_XBZRLE |
> +                     RAM_SAVE_FLAG_ENCRYPTED_PAGE)) {
>              RAMBlock *block = ram_block_from_stream(f, flags);
>  
>              /*
> @@ -4391,6 +4437,12 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
>                  break;
>              }
>              break;
> +        case RAM_SAVE_FLAG_ENCRYPTED_PAGE:
> +            if (kvm_memcrypt_load_incoming_page(f, host)) {
> +                    error_report("Failed to encrypted incoming data");

'Failed to *load* encrypted page' ?

> +                    ret = -EINVAL;

Do you want to actually return an error code here from
kvm_memcrypt_load_incoming_page, so we can keep hold of whether
it was something like a simple network error for the file stream
or something more complex.

Dave

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

