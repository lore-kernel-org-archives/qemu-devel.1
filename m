Return-Path: <SRS0=3Ld+=VU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D844C7618B
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 14:57:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 641F92239F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 14:57:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 641F92239F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44620 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpwED-0008DV-Nu
	for qemu-devel@archiver.kernel.org; Tue, 23 Jul 2019 10:57:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37721)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <sgarzare@redhat.com>) id 1hpwE3-0007oS-Qz
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 10:57:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sgarzare@redhat.com>) id 1hpwE2-0001DV-Rx
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 10:57:11 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50308)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1hpwE2-0001DE-LK
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 10:57:10 -0400
Received: by mail-wm1-f68.google.com with SMTP id v15so38917734wml.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2019 07:57:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=8AZo9Op9ceU7c2/3q7kWF7jpGrExtSlHdhont6ZmeQE=;
 b=KcQknGpEQL6pAS62qzaU2yKInKLF6bWNNUGJKKqYzmEHP/JuYyY/3DSBt3qcRSf34R
 cgNixrthZWz5OBcdVEsHTjZ90HlTHSpofJnW8kOxlzyKoj8k+gabdNceksom7VCdB+Qd
 BVfp665IpOTJ9lM3S0G1WgqQVhy4N4jeMoiZvzRqzYsgNsPq8M8N66sU4Bf/khqzQI1C
 JEOB29B0D+muvrkjfdNnZrQG3D15OcYnYUoelPvAnM2oAH0Uh+akXWAahId5K90oI0ia
 H+tAWV+4NeUpxKFf4spOimbBn5SxpJGJ2NUbqDcM9i3TTIgeSTL4iZ2yi7Y4rgu6Eljb
 nDFw==
X-Gm-Message-State: APjAAAX1Lzg/50gKqhmQDlqmwCeWHXe5ln1XR+5wR9XKEPErm4/otEff
 MC8povxh5opqqJzjVxErPq9Gdg==
X-Google-Smtp-Source: APXvYqzj7J471EMzTiQzqDNhnGpTPXwB8I7lTAZC+oaWW5wlXvjILdFiCfdJLsts/3nVONeh+S//pA==
X-Received: by 2002:a1c:dc07:: with SMTP id t7mr72168662wmg.164.1563893829650; 
 Tue, 23 Jul 2019 07:57:09 -0700 (PDT)
Received: from steredhat (host122-201-dynamic.13-79-r.retail.telecomitalia.it.
 [79.13.201.122])
 by smtp.gmail.com with ESMTPSA id 17sm38572418wmx.47.2019.07.23.07.57.08
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 23 Jul 2019 07:57:09 -0700 (PDT)
Date: Tue, 23 Jul 2019 16:57:06 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20190723145706.cwrtw5ej6zt3nvz3@steredhat>
References: <20190723140445.12748-1-sgarzare@redhat.com>
 <20190723140445.12748-2-sgarzare@redhat.com>
 <e35bc4db-238e-6a31-3725-57c5825cb0a0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e35bc4db-238e-6a31-3725-57c5825cb0a0@redhat.com>
User-Agent: NeoMutt/20180716
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.68
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
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jul 23, 2019 at 04:33:44PM +0200, Paolo Bonzini wrote:
> On 23/07/19 16:04, Stefano Garzarella wrote:
> > +                    /* Increments the reference count to avoid the unmap */
> > +                    g_mapped_file_ref(gmf);
> >                      /* rom_add_elf_program() seize the ownership of 'data' */
> >                      rom_add_elf_program(label, data, file_size, mem_size,
> >                                          addr, as);
> 
> I'm a bit worried about rom_reset g_free'ing rom->data, which goes
> against the comment on top of rom_free:
> 
> /* rom->data must be heap-allocated (do not use with
>    rom_add_elf_program()) */

Thanks for pointing it out. We definitely have to avoid that free in this case.

> 
> 
> Since this is the only call to rom_add_elf_program, what about adding a
> GMappedFile* field to struct Rom and passing it here instead of
> data+file_size?

Ehm, we currently use a subsection of the mmapped file as a ROM.
Should we keep the data+file_size parameter? (plus the new GMappedFile*)

At this point, is it better to call 'g_mapped_file_ref(gmf)' in the
'rom_add_elf_program()'?

> 
> Then the g_mapped_file_ref can be in rom_add_elf_program, and you can
> have a nice
> 
> static void rom_free_data(Rom *rom)
> {
>     if (rom->mapped_file) {
>         g_mapped_file_unref(rom->mapped_file);
>         rom->mapped_file = NULL;
>     } else {
>         g_free(rom->data);
>     }
>     rom->data = NULL;
> }
> 
> that is called from both rom_free and rom_reset.

I'll add this in v3.

Thanks,
Stefano

