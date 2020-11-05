Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81FCAC388F7
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 19:52:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A64020728
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 19:52:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QZ4KQhrn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A64020728
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44076 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kalIo-0001sV-4q
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 14:52:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34120)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <waynli329@gmail.com>)
 id 1kalH3-0000Z2-L6
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 14:50:21 -0500
Received: from mail-io1-xd33.google.com ([2607:f8b0:4864:20::d33]:45159)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <waynli329@gmail.com>)
 id 1kalH1-0002bs-JP
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 14:50:21 -0500
Received: by mail-io1-xd33.google.com with SMTP id u21so3016897iol.12
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2020 11:50:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=rA5QAnjWGfMHOQphxrLYyNHFiRuFRup25Jgsd4iJgss=;
 b=QZ4KQhrnZcU0sd4w0UpBixzn2vyOWJrCKasOv/DNTkesi00/BVT4rvbxvGk52/rIGQ
 KR4fMmWkB9tLXZVQlFyr0JaFw72srihAU6DDW0Wb1WOeo+KgJlXkf/CbwauV6GqszYCf
 OZplQrh0d25o9c2Bnp9CSKpn82Ef+gFppbkBhSbj+/CeNIZA5D7rlMkIqYcvnReYfH4c
 GHSVLIk/4NOuIGH+wJPIuOmzCumMhfXoh1rJuD/q9MIIB4vOZWrB9y2MJXTsKTiXwAdB
 fDqx802ep/f2LFjlnXxS3zftJ+AHBEeHra4ghWIxTKL8i84A+tdxwN0joADwDRiMxY0x
 D/ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=rA5QAnjWGfMHOQphxrLYyNHFiRuFRup25Jgsd4iJgss=;
 b=pN6T3/0vnSWMI2Kp3n9C+ukcZBydbe97KOim9dp58Qq+9BJXKWk1icErkK94wFRhqd
 tAZgekEXdI/OEHJm7ONnpke1ojk31KFm9d59RKUaNuwr0D7fSZ9cVYF1bbfUICGJQlyN
 JYlQIRfdInN1aj4yo7po7ISuaYbWSiDDsa5BcW2a28cbwKpo8HUo4W3CljdtjjIQTbps
 6oJepo6+YXj+IgyKdu1nap28lUJZGfHp2QA+XKAIjxcf53Q6Tux+wisT77FvDU2Oqh1S
 F7fB+rt4f4pn9ChfsV1GS61BYIzitccJhIXeeQp5jEOTPY5mi+WzoMUiJBH0S2HnFmfA
 ouHA==
X-Gm-Message-State: AOAM531MSuoUGyQsgeAD7D9JW7x2Lw5Sm+P8qCex1iWz3Us74mF6MHot
 SpCSNO4BJFXQshDwUQccblzCNYUZHaxM6g6VFinx6QI6Zq8nvw==
X-Google-Smtp-Source: ABdhPJxj8HV45+ZduqyIu/IMBEBq3VnOLSQ9bt0dp39dItgxwmdRoYHqbo8y5tuMCdMyRmenP0b10Ulkat/O3wjduH8=
X-Received: by 2002:a02:cd02:: with SMTP id g2mr3561978jaq.22.1604605817061;
 Thu, 05 Nov 2020 11:50:17 -0800 (PST)
MIME-Version: 1.0
From: Wayne Li <waynli329@gmail.com>
Date: Thu, 5 Nov 2020 13:50:06 -0600
Message-ID: <CAM2K0npECL3MpdkXH99htxGdTUTyC47PtnGAT4nkazpV6_rUPA@mail.gmail.com>
Subject: QEMU RAM allocation function fails
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d33;
 envelope-from=waynli329@gmail.com; helo=mail-io1-xd33.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Dear QEMU list members,

We developed a virtual machine that runs on QEMU.  This virtual
machine is pretty much an emulated P4080 processor with some
peripherals attached.  Initializing one of these peripherals, i.e. the
RAM, seems to be having problems.  I use the function
"memory_region_init_ram" to initialize the RAM and farther down the
call stack I see that the "qemu_ram_alloc" function returns an address
of 0 proving the RAM allocation wasn't successful.  Here is the block
of code in question copied from the file memory.c:

void memory_region_init_ram_shared_nomigrate(MemoryRegion *mr,
                                             Object *owner,
                                             const char *name,
                                             uint64_t size,
                                             bool share,
                                             Error **errp)
{
    memory_region_init(mr, owner, name, size);
    mr->ram = true;
    mr->terminates = true;
    mr->destructor = memory_region_destructor_ram;
    mr->ram_block = qemu_ram_alloc(size, share, mr, errp);
    mr->dirty_log_mask = tcg_enabled() ? (1 << DIRTY_MEMORY_CODE) : 0;
}

Tracing farther into the "qemu_ram_alloc" function reveals that the
function fails because inside the "qemu_ram_alloc_internal" function
in file exec.c, the function "ram_block_add" fails.  Interestingly, a
local_err object is populated here and the msg field in this object is
populated with the String "cannot set up guest memory 'ram0': Invalid
argument".  Here is the block of code in question copied from the file
exec.c:

RAMBlock *qemu_ram_alloc_internal(ram_addr_t size, ram_addr_t max_size,
                                  void (*resized)(const char*,
                                                  uint64_t length,
                                                  void *host),
                                  void *host, bool resizeable, bool share,
                                  MemoryRegion *mr, Error **errp)
{
    RAMBlock *new_block;
    Error *local_err = NULL;

    size = HOST_PAGE_ALIGN(size);
    max_size = HOST_PAGE_ALIGN(max_size);
    new_block = g_malloc0(sizeof(*new_block));
    new_block->mr = mr;
    new_block->resized = resized;
    new_block->used_length = size;
    new_block->max_length = max_size;
    assert(max_size >= size);
    new_block->fd = -1;
    new_block->page_size = getpagesize();
    new_block->host = host;
    if (host) {
        new_block->flags |= RAM_PREALLOC;
    }
    if (resizeable) {
        new_block->flags |= RAM_RESIZEABLE;
    }
    ram_block_add(new_block, &local_err, share);
    if (local_err) {
        g_free(new_block);
        error_propagate(errp, local_err);
        return NULL;
    }
    return new_block;
}

Anyway, our VM runs fine until it tries to access the RAM region so
this is a pretty critical problem for us to solve.  Does anyone know
much about these QEMU functions?  What could be causing these RAM
initialzation functions to fail in this way?

-Thanks, Wayne Li

