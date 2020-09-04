Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8DBDC433E2
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 09:04:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6CB420748
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 09:04:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6CB420748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kE7de-0007fn-Ni
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 05:04:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56022)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kE7cg-0006h2-Jl
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 05:03:06 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:30105
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kE7ce-0008W6-6j
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 05:03:05 -0400
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-519-wYaLBoU4PP6wQ6dgOJCuGg-1; Fri, 04 Sep 2020 05:03:00 -0400
X-MC-Unique: wYaLBoU4PP6wQ6dgOJCuGg-1
Received: by mail-ed1-f71.google.com with SMTP id r19so2419652edq.12
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2020 02:03:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/owlrH05oLcdb27l+gUDO0iDqQnbh+KlGKD+g+WkV1U=;
 b=eIDjCUAAOZkNBdHxVsNJDpNPqnjimOYqRVAO9JzMN2OK2ytZXW2xFVw+SVcyyPYqWD
 Mha32JUZKg7aLDHGDlHwJSzzSFpSilPTBlm1LCFHQDN5yTzBY25qtg8ZSzJgNK9t1dUp
 mnDjKt6BL1RzSc0seUCaYbC2NV+NYPXm9dTt+gs/V8U8zijxd8ekq0koDdwBa2boB9lN
 3C2TE33WXMs1mv8xHve84y0koXsLq2yl5JjjYFx/7kkHAC3bJBYPjC7u6Lv1A5INqeDv
 OhkHxML72HAXoaxoqychuJ4UPivtblrjuqL9vV2I/e44KNL97TvFhT4RPDUi3cojSisg
 9a/g==
X-Gm-Message-State: AOAM533oXEHTFt/Pca5WsOcyqc0yHLvT6rlaGxxwkvK8ZXydY2F43UaE
 CeGZ/KAYF20rpN61dQYqYUdGs82q9C00XxJAatCzp29YlszvQJ0QeB8RAx+W8kzH3sJ2Vy6R/Tw
 YaFD5cpqtLSiBCWE=
X-Received: by 2002:a17:906:faec:: with SMTP id
 lu44mr6174490ejb.527.1599210179457; 
 Fri, 04 Sep 2020 02:02:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzPcU4l2TjgBmwcagt36DXtQxuYEqe6ilFPncCAeiyANALsKY4/mXm+7SC6Au/FYVijsvsg3w==
X-Received: by 2002:a17:906:faec:: with SMTP id
 lu44mr6174461ejb.527.1599210179151; 
 Fri, 04 Sep 2020 02:02:59 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:6276:52ed:96d5:c094?
 ([2001:b07:6468:f312:6276:52ed:96d5:c094])
 by smtp.gmail.com with ESMTPSA id b6sm5436265eds.46.2020.09.04.02.02.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Sep 2020 02:02:58 -0700 (PDT)
Subject: Re: [PATCH] meson: fix qxl module build
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
References: <20200827064629.23080-1-kraxel@redhat.com>
 <20200904081240.afvjaek5o2owlyeh@sirius.home.kraxel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2706f51d-381f-929e-7c8c-7df83f8491ff@redhat.com>
Date: Fri, 4 Sep 2020 11:02:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200904081240.afvjaek5o2owlyeh@sirius.home.kraxel.org>
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/04 03:57:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.403,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 04/09/20 10:12, Gerd Hoffmann wrote:
>   Hi,
> 
>>  if config_all_devices.has_key('CONFIG_QXL')
>>    qxl_ss = ss.source_set()
>> -  qxl_ss.add(when: 'CONFIG_QXL', if_true: files('qxl.c', 'qxl-logger.c', 'qxl-render.c'))
>> +  qxl_ss.add(files('qxl.c', 'qxl-logger.c', 'qxl-render.c'))
>>    hw_display_modules += {'qxl': qxl_ss}
>>  endif
>>  
>> -softmmu_ss.add(when: 'CONFIG_QXL', if_true: files('qxl.c', 'qxl-logger.c', 'qxl-render.c'))
> 
> Damn.  Turned out to not be that easy.  Modular builds work fine, but
> with non-modular builds I have the problem that qxl_ss is merged into
> softmmu_ss *unconditionally*.  So when building two targets, one with
> qxl enabled (i386 for example) and one without pci support (avr for
> example) I get missing symbols for pci+vga due to the attempt to link
> qxl into avr-softmmu.

You have found why it's got that "when:". :)

> Any hints how to solve that one?

I think this should be enough---fixing it in the common code, not with a
qxl-specific change:

diff --git a/meson.build b/meson.build
index 6ed3c37f46..88f2254f3b 100644
--- a/meson.build
+++ b/meson.build
@@ -923,7 +923,7 @@ softmmu_mods = []
 foreach d, list : modules
   foreach m, module_ss : list
     if enable_modules and targetos != 'windows'
-      module_ss = module_ss.apply(config_host, strict: false)
+      module_ss = module_ss.apply(config_all, strict: false)
       sl = static_library(d + '-' + m, [genh, module_ss.sources()],
                           dependencies: [modulecommon, module_ss.dependencies()], pic: true)
       if d == 'block'

:-O

If you want to get rid of the "if config_all_devices.has_key(...)", you perhaps
could try doing something like

  module_srcs = module_ss.sources()
  if module_srcs.length() == 0
    continue
  endif
  sl = static_library(d + '-' + m, [genh, module_srcs],
                      dependencies: [modulecommon, module_ss.dependencies()], pic: true)

etc.  This would work also for the CONFIG_VIRTIO_GPU changes.

Paolo


