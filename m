Return-Path: <SRS0=huOX=VG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F448C73C46
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 15:10:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 371742166E
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 15:10:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 371742166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50824 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkrlZ-0000aV-Hf
	for qemu-devel@archiver.kernel.org; Tue, 09 Jul 2019 11:10:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38881)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hkrdw-0007KG-Ut
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 11:02:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hkrdu-0004zO-Sk
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 11:02:56 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34953)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hkrds-0004qk-SS
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 11:02:53 -0400
Received: by mail-wr1-f66.google.com with SMTP id y4so12821941wrm.2
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2019 08:02:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=hTuGM+F3hp+FhjvmMZcT6HFwxCQotX/raxmohRT0Kuk=;
 b=rZHnF54KL+++i1Moz7EsY88as/NoYWnssRvZrSnNEiUI4NS3qaVmEG+WuLDhYl5NCr
 ui2Ecy9IYrkbtCJfxb/8rGsbUJiPEL4jOiL3/00502YSEhNHreWMTNBE3mIdWboOdid4
 /FOhwBmtm+sptJZkWVhmcWIJaJnesMnhF+I4KTwEcirzeeIKrNl3rSlUSeVOx2nCoM31
 DaNRbKCzTziI9pq4mOtevNXehXPJW4DJc4S0qiQVum0jmk83Fo00bGdqw91Up8HyxiON
 evs9bdXEqjzo2RiSdsa1jRqWiGB7CoQk2C7OWPUoulhyGforFLPFXdjaJNFySsL+zsXf
 +dAg==
X-Gm-Message-State: APjAAAWyhjwoCrYuvPHmS7Y8Rpyyt+k1L4vlgbH01ylKpMMGscMb/2j3
 TQH7nnK8fMPqU89uwNv3uKavIQ==
X-Google-Smtp-Source: APXvYqyVUeqS2dD+RmVeVtf71g4DX/csHqrC5eRAb4RPP5m0TVpMhH7cbdUO5BjoUCtH35UoWMoW4A==
X-Received: by 2002:a5d:4085:: with SMTP id o5mr25698115wrp.101.1562684549426; 
 Tue, 09 Jul 2019 08:02:29 -0700 (PDT)
Received: from [192.168.1.38] (62.red-83-42-61.dynamicip.rima-tde.net.
 [83.42.61.62])
 by smtp.gmail.com with ESMTPSA id n14sm39746667wra.75.2019.07.09.08.02.28
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Tue, 09 Jul 2019 08:02:28 -0700 (PDT)
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20190709143801.4517-1-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <15d4b8ef-e8cf-9938-cff0-2dcf8d855a16@redhat.com>
Date: Tue, 9 Jul 2019 17:02:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190709143801.4517-1-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.66
Subject: Re: [Qemu-devel] [PATCH] Makefile: Fix "make clean" in
 "unconfigured" source directory
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
Cc: peter.maydell@linaro.org, borntraeger@de.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/9/19 4:38 PM, Markus Armbruster wrote:
> Recent commit "Makefile: Reuse all's recursion machinery for clean and
> install" broke targets clean and distclean in the source directory
> before running configure:
> 
>     $ make clean
>       LD      recurse-clean.mo
>     cc: fatal error: no input files
>     compilation terminated.
>     make: *** [rules.mak:118: recurse-clean.mo] Error 1
> 
> Root cause is missing .PHONY.  Fix that.
> 
> Fixes: 1338a4b72659ce08eacb9de0205fe16202a22d9c
> Reported-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  Makefile | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Makefile b/Makefile
> index c63de4e36c..1fcbaed62c 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -518,6 +518,7 @@ ROM_DIRS_RULES=$(foreach t, all clean, $(addsuffix /$(t), $(ROM_DIRS)))
>  $(ROM_DIRS_RULES):
>  	$(call quiet-command,$(MAKE) $(SUBDIR_MAKEFLAGS) -C $(dir $@) V="$(V)" TARGET_DIR="$(dir $@)" CFLAGS="$(filter -O% -g%,$(CFLAGS))" $(notdir $@),)
>  
> +.PHONY: recurse-all recurse-clean recurse-install
>  recurse-all: $(addsuffix /all, $(TARGET_DIRS) $(ROM_DIRS))
>  recurse-clean: $(addsuffix /clean, $(TARGET_DIRS) $(ROM_DIRS))
>  recurse-install: $(addsuffix /install, $(TARGET_DIRS))
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

