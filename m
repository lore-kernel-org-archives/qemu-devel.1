Return-Path: <SRS0=qU7A=VV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60527C7618B
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 13:08:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3802221738
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 13:08:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3802221738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqGzz-0003YC-DF
	for qemu-devel@archiver.kernel.org; Wed, 24 Jul 2019 09:08:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33015)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hqGzp-00039d-1t
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 09:07:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hqGzo-00056A-5p
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 09:07:52 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36889)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hqGzn-00054b-W9
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 09:07:52 -0400
Received: by mail-wm1-f67.google.com with SMTP id f17so41560619wme.2
 for <qemu-devel@nongnu.org>; Wed, 24 Jul 2019 06:07:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=XRmRK7otL0PTNFK2R4uXOUWmEVsFSY93MXqz0Z73PdM=;
 b=eiaOEgDzfZ9qZj7+i9qVBbXux8bqUJ0PfL9VE6i4sSh940JfBxCtUV4gZtP9TT86HS
 k/cYwiK6rtXFVgV3iSgBz1kEMsUaN5uZ+E6Ok/PEV/VbaxAsB0hdgV2i+961tyP+iSa6
 thi9qQlkgf5Ip8OUVmOabzKrWUHVTRn70rimzofZEXRchea0r+DXZMw+8r8HQYJsmTzL
 wzBrcpw6GqtoOKX7fufuxUYvXBToHrapSgKyEoGMi0EZeDxihkCnJ/20q93TTwv+qyNv
 27xWYehcUpYPGjnf56zgTMY2EVuqjtE1Z0nMY1S3ltNdOxWyjzhklEorrbVqDYoqHAxq
 8xnQ==
X-Gm-Message-State: APjAAAWurAko/6sB5BQGEzWM4hYSCx547qtBinyPNQboMxSFUZezEJSr
 dh4EFmRsKGQCKMJN0U3L1YVeIQ==
X-Google-Smtp-Source: APXvYqz2He7MIVLTlexvDwyBrbce/kTp9QVgaUqbklZ5sMFfovK04dCgGy0BQ6HgptLwRRngukb0Xg==
X-Received: by 2002:a7b:ce95:: with SMTP id q21mr75727449wmj.65.1563973670835; 
 Wed, 24 Jul 2019 06:07:50 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:10f7:67c8:abb4:8512?
 ([2001:b07:6468:f312:10f7:67c8:abb4:8512])
 by smtp.gmail.com with ESMTPSA id z25sm50749700wmf.38.2019.07.24.06.07.49
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Wed, 24 Jul 2019 06:07:50 -0700 (PDT)
To: Stefano Garzarella <sgarzare@redhat.com>
References: <20190724112531.232260-1-sgarzare@redhat.com>
 <20190724112531.232260-3-sgarzare@redhat.com>
 <08e22ee6-8216-8563-e35a-8c02fc201fc9@redhat.com>
 <20190724123527.7jfmoisbcogoiqex@steredhat>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <2620e7b3-af94-1f96-6968-dd1d7a1e378d@redhat.com>
Date: Wed, 24 Jul 2019 15:07:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190724123527.7jfmoisbcogoiqex@steredhat>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.67
Subject: Re: [Qemu-devel] [PATCH v3 2/3] elf-ops.h: Map into memory the ELF
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
 qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 24/07/19 14:35, Stefano Garzarella wrote:
>> Isn't the success case missing a g_mapped_file_unref?  It has to be done
>> unconditionally since now rom_add_elf_program adds a separate reference.
> Sure, I had this in mind, since I initialized mapped_file to NULL, but
> I didn't see the return before "fail:" label!
> Maybe I'll change the end of load_elf() in this way:
> 
> -    g_free(phdr);
>      if (lowaddr)
>          *lowaddr = (uint64_t)(elf_sword)low;
>      if (highaddr)
>          *highaddr = (uint64_t)(elf_sword)high;
> -    return total_size;
> +    ret = total_size;
>   fail:
> -    g_free(data);
> +    g_mapped_file_unref(mapped_file);
>      g_free(phdr);
>      return ret;
>  }
> 
> 

Yes, this looks better!

Paolo

