Return-Path: <SRS0=FHOf=VI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37216C74260
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 17:47:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E04F208E4
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 17:47:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E04F208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44430 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hldAi-0004rA-9m
	for qemu-devel@archiver.kernel.org; Thu, 11 Jul 2019 13:47:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40676)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgilbert@redhat.com>) id 1hldAU-0004In-S5
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 13:47:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1hldAS-00024N-Hj
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 13:47:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60838)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hldAQ-0001zV-Gs
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 13:47:40 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0B939308219E;
 Thu, 11 Jul 2019 17:47:37 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.40])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B9E3760BFB;
 Thu, 11 Jul 2019 17:47:35 +0000 (UTC)
Date: Thu, 11 Jul 2019 18:47:33 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: "Singh, Brijesh" <brijesh.singh@amd.com>
Message-ID: <20190711174733.GS3971@work-vm>
References: <20190710202219.25939-1-brijesh.singh@amd.com>
 <20190710202219.25939-3-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190710202219.25939-3-brijesh.singh@amd.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Thu, 11 Jul 2019 17:47:37 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 02/13] kvm: introduce high-level API to
 support encrypted page migration
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
> When memory encryption is enabled in VM, the guest pages will be
> encrypted with the guest-specific key, to protect the confidentiality
> of data in transit. To support the live migration we need to use
> platform specific hooks to access the guest memory.
> 
> The kvm_memcrypt_save_outgoing_page() can be used by the sender to write
> the encrypted pages and metadata associated with it on the socket.
> 
> The kvm_memcrypt_load_incoming_page() can be used by receiver to read the
> incoming encrypted pages from the socket and load into the guest memory.
> 
> Signed-off-by: Brijesh Singh <<brijesh.singh@amd.com>>
> ---
>  accel/kvm/kvm-all.c    | 27 +++++++++++++++++++++++++++
>  accel/kvm/sev-stub.c   | 11 +++++++++++
>  accel/stubs/kvm-stub.c | 12 ++++++++++++
>  include/sysemu/kvm.h   | 12 ++++++++++++
>  include/sysemu/sev.h   |  3 +++
>  5 files changed, 65 insertions(+)
> 
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index 3d86ae5052..162a2d5085 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -110,6 +110,10 @@ struct KVMState
>      /* memory encryption */
>      void *memcrypt_handle;
>      int (*memcrypt_encrypt_data)(void *handle, uint8_t *ptr, uint64_t len);
> +    int (*memcrypt_save_outgoing_page)(void *ehandle, QEMUFile *f,
> +            uint8_t *ptr, uint32_t sz, uint64_t *bytes_sent);
> +    int (*memcrypt_load_incoming_page)(void *ehandle, QEMUFile *f,
> +            uint8_t *ptr);
>  };
>  
>  KVMState *kvm_state;
> @@ -165,6 +169,29 @@ int kvm_memcrypt_encrypt_data(uint8_t *ptr, uint64_t len)
>      return 1;
>  }
>  
> +int kvm_memcrypt_save_outgoing_page(QEMUFile *f, uint8_t *ptr,
> +                                    uint32_t size, uint64_t *bytes_sent)
> +{
> +    if (kvm_state->memcrypt_handle &&
> +        kvm_state->memcrypt_save_outgoing_page) {
> +        return kvm_state->memcrypt_save_outgoing_page(kvm_state->memcrypt_handle,
> +                    f, ptr, size, bytes_sent);
> +    }
> +
> +    return 1;

This needs to be commented saying what the return values mean.
I'm not sure what '1' means for the case when this didn't have
encryption support.

> +}
> +
> +int kvm_memcrypt_load_incoming_page(QEMUFile *f, uint8_t *ptr)
> +{
> +    if (kvm_state->memcrypt_handle &&
> +        kvm_state->memcrypt_load_incoming_page) {
> +        return kvm_state->memcrypt_load_incoming_page(kvm_state->memcrypt_handle,
> +                    f, ptr);
> +    }
> +
> +    return 1;
> +}
> +
>  static KVMSlot *kvm_get_free_slot(KVMMemoryListener *kml)
>  {
>      KVMState *s = kvm_state;
> diff --git a/accel/kvm/sev-stub.c b/accel/kvm/sev-stub.c
> index 4f97452585..c12a8e005e 100644
> --- a/accel/kvm/sev-stub.c
> +++ b/accel/kvm/sev-stub.c
> @@ -24,3 +24,14 @@ void *sev_guest_init(const char *id)
>  {
>      return NULL;
>  }
> +
> +int sev_save_outgoing_page(void *handle, QEMUFile *f, uint8_t *ptr,
> +                           uint32_t size, uint64_t *bytes_sent)
> +{
> +    return 1;
> +}
> +
> +int sev_load_incoming_page(void *handle, QEMUFile *f, uint8_t *ptr)
> +{
> +    return 1;
> +}
> diff --git a/accel/stubs/kvm-stub.c b/accel/stubs/kvm-stub.c
> index 6feb66ed80..e14b879531 100644
> --- a/accel/stubs/kvm-stub.c
> +++ b/accel/stubs/kvm-stub.c
> @@ -114,6 +114,18 @@ int kvm_memcrypt_encrypt_data(uint8_t *ptr, uint64_t len)
>    return 1;
>  }
>  
> +int kvm_memcrypt_save_outgoing_page(QEMUFile *f, uint8_t *ptr,
> +                                    uint32_t size, uint64_t *bytes_sent)
> +{
> +    return 1;
> +}
> +
> +int kvm_memcrypt_load_incoming_page(QEMUFile *f, uint8_t *ptr)
> +{
> +    return 1;
> +}
> +
> +
>  #ifndef CONFIG_USER_ONLY
>  int kvm_irqchip_add_msi_route(KVMState *s, int vector, PCIDevice *dev)
>  {
> diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
> index acd90aebb6..bb6bcc143c 100644
> --- a/include/sysemu/kvm.h
> +++ b/include/sysemu/kvm.h
> @@ -247,6 +247,18 @@ bool kvm_memcrypt_enabled(void);
>   */
>  int kvm_memcrypt_encrypt_data(uint8_t *ptr, uint64_t len);
>  
> +/**
> + * kvm_memcrypt_save_outgoing_buffer - encrypt the outgoing buffer
> + * and write to the wire.
> + */
> +int kvm_memcrypt_save_outgoing_page(QEMUFile *f, uint8_t *ptr, uint32_t size,
> +                                    uint64_t *bytes_sent);
> +
> +/**
> + * kvm_memcrypt_load_incoming_buffer - read the encrypt incoming buffer and copy
> + * the buffer into the guest memory space.
> + */
> +int kvm_memcrypt_load_incoming_page(QEMUFile *f, uint8_t *ptr);
>  
>  #ifdef NEED_CPU_H
>  #include "cpu.h"
> diff --git a/include/sysemu/sev.h b/include/sysemu/sev.h
> index 98c1ec8d38..752a71b1c0 100644
> --- a/include/sysemu/sev.h
> +++ b/include/sysemu/sev.h
> @@ -18,4 +18,7 @@
>  
>  void *sev_guest_init(const char *id);
>  int sev_encrypt_data(void *handle, uint8_t *ptr, uint64_t len);
> +int sev_save_outgoing_page(void *handle, QEMUFile *f, uint8_t *ptr,
> +                           uint32_t size, uint64_t *bytes_sent);
> +int sev_load_incoming_page(void *handle, QEMUFile *f, uint8_t *ptr);
>  #endif
> -- 
> 2.17.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

