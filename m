Return-Path: <SRS0=3Ld+=VU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F4B9C7618B
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 14:34:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15E88218EA
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 14:34:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15E88218EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42996 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpvri-0004pG-3c
	for qemu-devel@archiver.kernel.org; Tue, 23 Jul 2019 10:34:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52127)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hpvrV-0004Mc-HI
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 10:33:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hpvrT-0007TH-Id
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 10:33:53 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42696)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hpvrS-0007Rz-Ui
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 10:33:51 -0400
Received: by mail-wr1-f67.google.com with SMTP id x1so28453201wrr.9
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2019 07:33:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ido9wbOemCpV0AIOKuHyk55LcgO+5r1PM/cI0da8qs4=;
 b=CpbGen6UuO7FdXvVs8u+b+mqnvsFzftUaS4t/0bsvyKJv0RkYKSnfUhQ1sweE2u4uO
 JsVuq9D4ivXw6tumdLUmuq2rBTSUMUx45LBe/rFTh1Aa5wB0oBHb3cB7P/i5fR+cHVdd
 1OMf/XqXBZD4WfyUINznXsRLRLImIq2Km7vb0T5gVieq/SXdALpCD9tZ3FsGxeJZEGHD
 jWWhRC0YnDZrqTK+fSS7xKuOwUq1WBmSKrDUsbeGO/eYqtZsKotuiI2C+yH8t3f91IZq
 UEsPfbv9ZFEDoIJJrYg6flaoDh4oiJm3o0zGVrBeq1+vsZ2o5PwrWGGIaKYML46AYll0
 msoA==
X-Gm-Message-State: APjAAAXSA1ScmInaRU3K700+wKVd9u4EdmTrnqEyT0JVPTw193qFvMRb
 epuQ4Rs4/2R31qp/zgSg/Svi3g==
X-Google-Smtp-Source: APXvYqynlzBhXFBC3HbyTG+AmIynpRLJO8Gj2aFlTm9dSHr08SPR+Zv8BD1lrrn1DLWFah68KZtBlA==
X-Received: by 2002:adf:e841:: with SMTP id d1mr1978839wrn.204.1563892428154; 
 Tue, 23 Jul 2019 07:33:48 -0700 (PDT)
Received: from [10.201.49.73] (nat-pool-mxp-u.redhat.com. [149.6.153.187])
 by smtp.gmail.com with ESMTPSA id x17sm30479026wrq.64.2019.07.23.07.33.45
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Tue, 23 Jul 2019 07:33:47 -0700 (PDT)
To: Stefano Garzarella <sgarzare@redhat.com>, qemu-devel@nongnu.org
References: <20190723140445.12748-1-sgarzare@redhat.com>
 <20190723140445.12748-2-sgarzare@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <e35bc4db-238e-6a31-3725-57c5825cb0a0@redhat.com>
Date: Tue, 23 Jul 2019 16:33:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190723140445.12748-2-sgarzare@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.67
Subject: Re: [Qemu-devel] [PATCH v2 1/2] elf-ops.h: Map into memory the ELF
 to load
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Julio Montes <julio.montes@intel.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 23/07/19 16:04, Stefano Garzarella wrote:
> +                    /* Increments the reference count to avoid the unmap */
> +                    g_mapped_file_ref(gmf);
>                      /* rom_add_elf_program() seize the ownership of 'data' */
>                      rom_add_elf_program(label, data, file_size, mem_size,
>                                          addr, as);

I'm a bit worried about rom_reset g_free'ing rom->data, which goes
against the comment on top of rom_free:

/* rom->data must be heap-allocated (do not use with
   rom_add_elf_program()) */


Since this is the only call to rom_add_elf_program, what about adding a
GMappedFile* field to struct Rom and passing it here instead of
data+file_size?

Then the g_mapped_file_ref can be in rom_add_elf_program, and you can
have a nice

static void rom_free_data(Rom *rom)
{
    if (rom->mapped_file) {
        g_mapped_file_unref(rom->mapped_file);
        rom->mapped_file = NULL;
    } else {
        g_free(rom->data);
    }
    rom->data = NULL;
}

that is called from both rom_free and rom_reset.

Thanks,

Paolo

> @@ -531,7 +540,6 @@ static int glue(load_elf, SZ)(const char *name, int fd,
>                      address_space_write(as ? as : &address_space_memory,
>                                          addr, MEMTXATTRS_UNSPECIFIED,
>                                          data, file_size);
> -                    g_free(data);
>                  }
>              }
>  
> @@ -547,16 +555,15 @@ static int glue(load_elf, SZ)(const char *name, int fd,
>              struct elf_note *nhdr = NULL;
>  
>              file_size = ph->p_filesz; /* Size of the range of ELF notes */
> -            data = g_malloc0(file_size);
> -            if (ph->p_filesz > 0) {
> -                if (lseek(fd, ph->p_offset, SEEK_SET) < 0) {
> -                    goto fail;
> -                }
> -                if (read(fd, data, file_size) != file_size) {
> -                    goto fail;
> -                }
> +            data_offset = ph->p_offset; /* Offset where the notes are located */
> +
> +            if (g_mapped_file_get_length(gmf) < file_size + data_offset) {
> +                goto fail;
>              }
>  
> +            data = (uint8_t *)g_mapped_file_get_contents(gmf);
> +            data += data_offset;
> +
>              /*
>               * Search the ELF notes to find one with a type matching the
>               * value passed in via 'translate_opaque'
> @@ -570,7 +577,6 @@ static int glue(load_elf, SZ)(const char *name, int fd,
>                      sizeof(struct elf_note) == sizeof(struct elf64_note);
>                  elf_note_fn((void *)nhdr, (void *)&ph->p_align, is64);
>              }
> -            g_free(data);
>              data = NULL;
>          }
>      }
> @@ -582,7 +588,7 @@ static int glue(load_elf, SZ)(const char *name, int fd,
>          *highaddr = (uint64_t)(elf_sword)high;
>      return total_size;
>   fail:
> -    g_free(data);
> +    g_mapped_file_unref(gmf);
>      g_free(phdr);
>      return ret;
>  }
> 


