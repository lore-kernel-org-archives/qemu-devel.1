Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BF0AC282DE
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 08:41:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C896B206B8
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 08:41:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C896B206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37539 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYRUJ-00075C-Pd
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 04:41:39 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51037)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hYRTR-0006cw-0X
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 04:40:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hYRTP-0003oq-FN
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 04:40:44 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33213)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hYRTP-0003ig-8q
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 04:40:43 -0400
Received: by mail-wr1-f65.google.com with SMTP id n9so6112822wru.0
	for <qemu-devel@nongnu.org>; Wed, 05 Jun 2019 01:40:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=5Zy0VKMS+/+Z6weJ5zHduLr6HV/gyWV6Xu/AW/LD2WQ=;
	b=hR+YIVVpv5F//a1Xz1bZp4RAJzH3Ueq+RFUPlASHfMElbMf+AWbuKbhMz9aKiiBTJq
	DfnLHsJajdCTTq8nmzXoG7V+4SnOimCPgct7xuSbp0mVg4N7BCfbABgt0tZpK9Be2chV
	oMKoPxKVZEZg4qspiGoq9l2p0jUKW2WQVwfbanjg/WYFa3rJS5XYD0cc0NkuD328AHu9
	9MK22rFZL6eZBpXB6cTsghKeA+jZ02M4KkkGKcBVF2lh+npNZMMoWC71o9AwCnbqjc0z
	ROTy/0KMifHOhVXMhFT/FAmuLySjjSojHI+n5timC9a8pnGjb2GNi7V9m/lI4cbvyOPp
	Qvyw==
X-Gm-Message-State: APjAAAXrDWaHoaSga4cwhANeWRnTSVWDmVufU6iDDRLMGPccUy31jUpY
	NA2PZdkrlUE4gm5c8ygzg9iNgR6Ukf4=
X-Google-Smtp-Source: APXvYqwdzV4br/B6waH0GNhIWUon6scdjE4BK8cEpgOUZvEbsWQPJF3WW/gLAkujW8AdIO7CNp/oMQ==
X-Received: by 2002:adf:8086:: with SMTP id 6mr15650178wrl.320.1559724041706; 
	Wed, 05 Jun 2019 01:40:41 -0700 (PDT)
Received: from [192.168.1.38] (183.red-88-21-202.staticip.rima-tde.net.
	[88.21.202.183]) by smtp.gmail.com with ESMTPSA id
	a17sm14747667wrr.80.2019.06.05.01.40.40
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Wed, 05 Jun 2019 01:40:41 -0700 (PDT)
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20190604181618.19980-1-armbru@redhat.com>
	<20190604181618.19980-4-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <87eda0df-0f83-d70f-943d-9d8405351db9@redhat.com>
Date: Wed, 5 Jun 2019 10:40:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190604181618.19980-4-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] [PATCH 3/4] Clean up a few header guard symbols
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/4/19 8:16 PM, Markus Armbruster wrote:
> Commit 58ea30f5145 "Clean up header guards that don't match their file
> name" messed up contrib/elf2dmp/qemu_elf.h and
> tests/migration/migration-test.h.
> 
> It missed target/cris/opcode-cris.h and
> tests/uefi-test-tools/UefiTestToolsPkg/Include/Guid/BiosTablesTest.h
> due to the scripts/clean-header-guards.pl bug fixed in the previous
> commit.
> 
> Commit a8b991b52dc "Clean up ill-advised or unusual header guards"
> missed include/hw/xen/io/ring.h for the same reason.
> 
> Commit 3979fca4b69 "disas: Rename include/disas/bfd.h back to
> include/disas/dis-asm.h" neglected to update the guard symbol for the
> rename.
> 
> Commit a331c6d7741 "semihosting: implement a semihosting console"
> created include/hw/semihosting/console.h with an ill-advised guard
> symbol.
> 
> Clean them up.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  contrib/elf2dmp/qemu_elf.h                                  | 5 ++---
>  include/disas/dis-asm.h                                     | 6 +++---
>  include/hw/semihosting/console.h                            | 6 +++---
>  include/hw/xen/io/ring.h                                    | 6 +++---
>  target/cris/opcode-cris.h                                   | 6 +++---
>  tests/migration/migration-test.h                            | 2 +-
>  .../UefiTestToolsPkg/Include/Guid/BiosTablesTest.h          | 6 +++---
>  7 files changed, 18 insertions(+), 19 deletions(-)
> 
> diff --git a/contrib/elf2dmp/qemu_elf.h b/contrib/elf2dmp/qemu_elf.h
> index 66ee1f0ed5..b2f0d9cbc9 100644
> --- a/contrib/elf2dmp/qemu_elf.h
> +++ b/contrib/elf2dmp/qemu_elf.h
> @@ -2,11 +2,10 @@
>   * Copyright (c) 2018 Virtuozzo International GmbH
>   *
>   * This work is licensed under the terms of the GNU GPL, version 2 or later.
> - *
>   */
>  
> -#ifndef EMPF2DMP_QEMU_ELF_H
> -#define EMPF2DMP_QEMU_ELF_H
> +#ifndef ELF2DMP_QEMU_ELF_H
> +#define ELF2DMP_QEMU_ELF_H
>  
>  #include "elf.h"
>  
> diff --git a/include/disas/dis-asm.h b/include/disas/dis-asm.h
> index 9240ec32c2..e9c7dd8eb4 100644
> --- a/include/disas/dis-asm.h
> +++ b/include/disas/dis-asm.h
> @@ -6,8 +6,8 @@
>     interface, for making instruction-processing programs more independent
>     of the instruction set being processed.  */
>  
> -#ifndef DISAS_BFD_H
> -#define DISAS_BFD_H
> +#ifndef DISAS_DIS_ASM_H
> +#define DISAS_DIS_ASM_H
>  
>  typedef void *PTR;
>  typedef uint64_t bfd_vma;
> @@ -508,4 +508,4 @@ bfd_vma bfd_getl16 (const bfd_byte *addr);
>  bfd_vma bfd_getb16 (const bfd_byte *addr);
>  typedef bool bfd_boolean;
>  
> -#endif /* DISAS_BFD_H */
> +#endif /* DISAS_DIS_ASM_H */
> diff --git a/include/hw/semihosting/console.h b/include/hw/semihosting/console.h
> index 30e66ae20a..9eb45b7c53 100644
> --- a/include/hw/semihosting/console.h
> +++ b/include/hw/semihosting/console.h
> @@ -6,8 +6,8 @@
>   * SPDX-License-Identifier: GPL-2.0-or-later
>   */
>  
> -#ifndef _SEMIHOST_CONSOLE_H_
> -#define _SEMIHOST_CONSOLE_H_
> +#ifndef SEMIHOST_CONSOLE_H
> +#define SEMIHOST_CONSOLE_H
>  
>  /**
>   * qemu_semihosting_console_out:
> @@ -35,4 +35,4 @@ int qemu_semihosting_console_out(CPUArchState *env, target_ulong s, int len);
>   */
>  int qemu_semihosting_log_out(const char *s, int len);
>  
> -#endif /* _SEMIHOST_CONSOLE_H_ */
> +#endif /* SEMIHOST_CONSOLE_H */
> diff --git a/include/hw/xen/io/ring.h b/include/hw/xen/io/ring.h
> index 1adacf09f9..62abfd7a6e 100644
> --- a/include/hw/xen/io/ring.h
> +++ b/include/hw/xen/io/ring.h
> @@ -24,8 +24,8 @@
>   * Tim Deegan and Andrew Warfield November 2004.
>   */
>  
> -#ifndef __XEN_PUBLIC_IO_RING_H__
> -#define __XEN_PUBLIC_IO_RING_H__
> +#ifndef XEN_PUBLIC_IO_RING_H
> +#define XEN_PUBLIC_IO_RING_H
>  
>  /*
>   * When #include'ing this header, you need to provide the following
> @@ -469,7 +469,7 @@ struct name##_data_intf {                                                     \
>  };                                                                            \
>  DEFINE_XEN_FLEX_RING(name)
>  
> -#endif /* __XEN_PUBLIC_IO_RING_H__ */
> +#endif /* XEN_PUBLIC_IO_RING_H */
>  
>  /*
>   * Local variables:
> diff --git a/target/cris/opcode-cris.h b/target/cris/opcode-cris.h
> index e7ebb98cd0..40509c88db 100644
> --- a/target/cris/opcode-cris.h
> +++ b/target/cris/opcode-cris.h
> @@ -19,8 +19,8 @@ GNU General Public License for more details.
>  You should have received a copy of the GNU General Public License
>  along with this program; if not, see <http://www.gnu.org/licenses/>.  */
>  
> -#ifndef __CRIS_H_INCLUDED_
> -#define __CRIS_H_INCLUDED_
> +#ifndef TARGET_CRIS_OPCODE_CRIS_H
> +#define TARGET_CRIS_OPCODE_CRIS_H
>  
>  #if !defined(__STDC__) && !defined(const)
>  #define const
> @@ -345,7 +345,7 @@ extern const struct cris_opcode cris_opcodes[];
>     sign-extended before adding to "target".  */
>  #define CRIS_DIS_FLAG_MEM_TARGET2_MEM_WORD (1 << 7)
>  
> -#endif /* __CRIS_H_INCLUDED_ */
> +#endif /* TARGET_CRIS_OPCODE_CRIS_H */
>  
>  /*
>   * Local variables:
> diff --git a/tests/migration/migration-test.h b/tests/migration/migration-test.h
> index aa3c3a9625..68512c0b1b 100644
> --- a/tests/migration/migration-test.h
> +++ b/tests/migration/migration-test.h
> @@ -32,4 +32,4 @@
>   */
>  #define ARM_TEST_MAX_KERNEL_SIZE (512 * 1024)
>  
> -#endif /* _MIGRATION_TEST_H */
> +#endif /* MIGRATION_TEST_H */
> diff --git a/tests/uefi-test-tools/UefiTestToolsPkg/Include/Guid/BiosTablesTest.h b/tests/uefi-test-tools/UefiTestToolsPkg/Include/Guid/BiosTablesTest.h
> index 7a74c121d5..07808787cc 100644
> --- a/tests/uefi-test-tools/UefiTestToolsPkg/Include/Guid/BiosTablesTest.h
> +++ b/tests/uefi-test-tools/UefiTestToolsPkg/Include/Guid/BiosTablesTest.h
> @@ -21,8 +21,8 @@
>    WARRANTIES OR REPRESENTATIONS OF ANY KIND, EITHER EXPRESS OR IMPLIED.
>  **/
>  
> -#ifndef __BIOS_TABLES_TEST_H__
> -#define __BIOS_TABLES_TEST_H__
> +#ifndef BIOSTABLESTEST_H
> +#define BIOSTABLESTEST_H
>  
>  #include <Uefi/UefiBaseType.h>
>  
> @@ -77,4 +77,4 @@ typedef struct {
>  } BIOS_TABLES_TEST;
>  #pragma pack ()
>  
> -#endif // __BIOS_TABLES_TEST_H__
> +#endif /* BIOSTABLESTEST_H */
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

