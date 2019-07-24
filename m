Return-Path: <SRS0=qU7A=VV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AA3DC7618B
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 12:35:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FA32214AF
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 12:35:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FA32214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51272 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqGUr-0003Ar-BN
	for qemu-devel@archiver.kernel.org; Wed, 24 Jul 2019 08:35:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49367)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <sgarzare@redhat.com>) id 1hqGUd-0002h8-Nr
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 08:35:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sgarzare@redhat.com>) id 1hqGUc-0002iD-F5
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 08:35:39 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36061)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1hqGUc-0002av-1x
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 08:35:38 -0400
Received: by mail-wr1-f67.google.com with SMTP id n4so46882935wrs.3
 for <qemu-devel@nongnu.org>; Wed, 24 Jul 2019 05:35:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=qMdsXOmG7KB/jIF8M15z2bzb/1DpaLcehL8OJxil72M=;
 b=RF1yLzg/Ih3/WFOWhRVrPVn/DWnRwrqEYAxYlrspbuGzfodKVSO5f12aP8sc55lQr0
 SXPxKE55nFel13Lu1AO9URq6ZjzlIUGhpBRbybmfWBnSW/mBDzV9BhBpO1VBYkz+ODbP
 a2mDMQhDIEjFwIw4AaIwoeWpEBz+/kiMe9IXlxCX97P8Oux+A2znh2Or7RPRYwgiTnDG
 TU3KAiZvKxPVVTInbo8iLMojUg672GvbpGhfMQ6IC2PI6twQp2eP+qqYM6AYv0m8gkl1
 ASZL4kKg7N0MQ89zgSW1RmuxaVvHWXRg9V23R3PAjXpgBiKqnHYglKcAkMUQ91LFslX+
 sphw==
X-Gm-Message-State: APjAAAXV8/YozalCq3duAAMVcJYkYpNpLXUUEupa/nlxULruYt2+lNmv
 80MWr2LJ4hW09l8hu6ZW1+eqoA==
X-Google-Smtp-Source: APXvYqywB4YfubxJ2V9ecw4lB7K2UDUjtpcHf9p/wF6p+Z90IPURQsa9iyou9tHTkrqEEK02AtQTgQ==
X-Received: by 2002:adf:fc8d:: with SMTP id g13mr55915135wrr.234.1563971729967; 
 Wed, 24 Jul 2019 05:35:29 -0700 (PDT)
Received: from steredhat (host122-201-dynamic.13-79-r.retail.telecomitalia.it.
 [79.13.201.122])
 by smtp.gmail.com with ESMTPSA id r11sm57163707wre.14.2019.07.24.05.35.28
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 24 Jul 2019 05:35:29 -0700 (PDT)
Date: Wed, 24 Jul 2019 14:35:27 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20190724123527.7jfmoisbcogoiqex@steredhat>
References: <20190724112531.232260-1-sgarzare@redhat.com>
 <20190724112531.232260-3-sgarzare@redhat.com>
 <08e22ee6-8216-8563-e35a-8c02fc201fc9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08e22ee6-8216-8563-e35a-8c02fc201fc9@redhat.com>
User-Agent: NeoMutt/20180716
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.67
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

On Wed, Jul 24, 2019 at 01:50:58PM +0200, Paolo Bonzini wrote:
> On 24/07/19 13:25, Stefano Garzarella wrote:
> > @@ -582,7 +596,7 @@ static int glue(load_elf, SZ)(const char *name, int fd,
> >          *highaddr = (uint64_t)(elf_sword)high;
> >      return total_size;
> 
> Isn't the success case missing a g_mapped_file_unref?  It has to be done
> unconditionally since now rom_add_elf_program adds a separate reference.

Sure, I had this in mind, since I initialized mapped_file to NULL, but
I didn't see the return before "fail:" label!
Maybe I'll change the end of load_elf() in this way:

-    g_free(phdr);
     if (lowaddr)
         *lowaddr = (uint64_t)(elf_sword)low;
     if (highaddr)
         *highaddr = (uint64_t)(elf_sword)high;
-    return total_size;
+    ret = total_size;
  fail:
-    g_free(data);
+    g_mapped_file_unref(mapped_file);
     g_free(phdr);
     return ret;
 }


> 
> Related to this, the comment
> 
>             /* rom_add_elf_program() seize the ownership of 'data' */
> 
> refers to the g_free(data) that you are removing and is best changed to just
>             /*
>              * rom_add_elf_program() takes its own reference to
>              * mapped_file.
>              */

I'll update the comment.

Thanks,
Stefano

