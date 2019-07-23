Return-Path: <SRS0=3Ld+=VU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8F0EC7618B
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 15:00:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE6EE2239F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 15:00:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE6EE2239F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44712 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpwHT-00034U-2Y
	for qemu-devel@archiver.kernel.org; Tue, 23 Jul 2019 11:00:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38962)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hpwHD-0002ds-2t
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 11:00:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hpwHC-0005Xi-1P
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 11:00:26 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36101)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hpwHB-0005X2-Nb
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 11:00:25 -0400
Received: by mail-wr1-f65.google.com with SMTP id n4so43620296wrs.3
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2019 08:00:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=8g7AaFl4iCG4Z7k6QzzSars+roApKiQM4Wy7vzFElZc=;
 b=rCipb9l1qHOuTvLuVNMWx7vCOTs2zhfagfIAs3XqCxUTE+ibh6x848JjgXhF7gMzOX
 UJgjjONStOlFmiXA5r0oFzp/GXBwc8cGDsrBMWD7ArSu36/McwrIgw8iA1YOa1yvcNYv
 NFyv9UxHyIObXnFhVZpFqy37mmXxWGkyC/2wzeMyK04uK0bkTVR+hLLpRgMTI2w4pgKl
 6ijxDtf57ZyYdoo+D+I3wYhZgdlvsL3cxZzHX1aElFkXqFXHUi1UIojiqk+3vtvL8Uq/
 FWb/RpgkiFqmSH1YHA2UuCAjmCAXbe3nzKlXGPRY6DSKurtK/H+wrhD5M1m/eJlALf8i
 IOsA==
X-Gm-Message-State: APjAAAXUyzh99CMwkpqkUdBQ1yNmwEaLVB3a7pNPohdawEuNNH+GeIno
 2vx6LLw0YMldT7Yu7/fxI1uqYg==
X-Google-Smtp-Source: APXvYqxfFsLzkZOgqg6/RiU0gGRjdm8kzJjup/Y1jbFDYLcHwZmkBt4rJUgRYKnBd/2mtPoNabjnpQ==
X-Received: by 2002:adf:f206:: with SMTP id p6mr8722077wro.216.1563894024564; 
 Tue, 23 Jul 2019 08:00:24 -0700 (PDT)
Received: from [10.201.49.73] (nat-pool-mxp-u.redhat.com. [149.6.153.187])
 by smtp.gmail.com with ESMTPSA id c1sm91936804wrh.1.2019.07.23.08.00.23
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Tue, 23 Jul 2019 08:00:24 -0700 (PDT)
To: Stefano Garzarella <sgarzare@redhat.com>
References: <20190723140445.12748-1-sgarzare@redhat.com>
 <20190723140445.12748-2-sgarzare@redhat.com>
 <e35bc4db-238e-6a31-3725-57c5825cb0a0@redhat.com>
 <20190723145706.cwrtw5ej6zt3nvz3@steredhat>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <4a605e73-d3cd-36af-92a7-cea80d48506f@redhat.com>
Date: Tue, 23 Jul 2019 17:00:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190723145706.cwrtw5ej6zt3nvz3@steredhat>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.65
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

On 23/07/19 16:57, Stefano Garzarella wrote:
> On Tue, Jul 23, 2019 at 04:33:44PM +0200, Paolo Bonzini wrote:
>> Since this is the only call to rom_add_elf_program, what about adding a
>> GMappedFile* field to struct Rom and passing it here instead of
>> data+file_size?
> 
> Ehm, we currently use a subsection of the mmapped file as a ROM.
> Should we keep the data+file_size parameter? (plus the new GMappedFile*)

Yes, either that or an offset/file_size.

> At this point, is it better to call 'g_mapped_file_ref(gmf)' in the
> 'rom_add_elf_program()'?

Yes, of course.

Paolo

