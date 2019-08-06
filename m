Return-Path: <SRS0=MhU4=WC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DC71C433FF
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 07:05:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCB1F20B1F
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 07:05:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCB1F20B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59318 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hutWm-0002ES-Vh
	for qemu-devel@archiver.kernel.org; Tue, 06 Aug 2019 03:05:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38606)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hutWN-0001ng-8j
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 03:04:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hutWM-0006hN-AK
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 03:04:35 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55664)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hutWM-0006hB-4g
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 03:04:34 -0400
Received: by mail-wm1-f66.google.com with SMTP id a15so77006941wmj.5
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2019 00:04:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=MJLvt3XoJ3qKYlh4dABCSBQzgF7c+1dS5aVWezTLL7E=;
 b=U8GAQSaWGwr7Lx7xbtK8OOXL3dYwM2/fzEd+2PZEK5BXmlgbgU/TMTsHVYEt5KoYvL
 XTLCYwZPTp7hspSdvfhm9FXqZKB+SuCzamYrF5F7tEkzU12uvMDd3I18w8Z55DNbyt3Q
 bk/98AH84Lu5jTnYxb+vDxvrrb6SzF0OwEofSWpsIYlO2yyDDdILoFZtdybYgQ6BQhbX
 xHSJstQkfP27GS2YV0Ks4IQRKGfqx1mbn6oaZ8M1ahriulwtQmjGJKHTkwY4mO8vIMx8
 jNf5N3U62191Fdkoy01ALWxtOCwz8sr8QTuT6Oyljus5ipSaTXJaQz7v91Gk2FbaoGhv
 sZQg==
X-Gm-Message-State: APjAAAXsY3N7TzDYO1NHrSmJIgz3Ztbz0euGzZc8Eb0MK/UPFfh8JHDZ
 pR+HnHKaeZ5p2tpzQXHAVvXeFEd9dt8=
X-Google-Smtp-Source: APXvYqxoMUXXYk/cudlhIRsbto+voZr5FQ/JNfuStvOpfnIdtD60xUd+eu53HfuN91+6df9PXAFikg==
X-Received: by 2002:a1c:e90d:: with SMTP id q13mr2892948wmc.89.1565075072755; 
 Tue, 06 Aug 2019 00:04:32 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:dc26:ed70:9e4c:3810?
 ([2001:b07:6468:f312:dc26:ed70:9e4c:3810])
 by smtp.gmail.com with ESMTPSA id j10sm92183145wrw.96.2019.08.06.00.04.31
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Tue, 06 Aug 2019 00:04:32 -0700 (PDT)
To: Gerd Hoffmann <kraxel@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <1565042940-8837-1-git-send-email-pbonzini@redhat.com>
 <87imrasv8m.fsf@dusky.pond.sub.org> <877e7qsv2c.fsf@dusky.pond.sub.org>
 <20190806064052.vys5qvm2jvjfr24z@sirius.home.kraxel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <2e43b91c-9589-faf3-73c3-857e4abe8ea3@redhat.com>
Date: Tue, 6 Aug 2019 09:04:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190806064052.vys5qvm2jvjfr24z@sirius.home.kraxel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.66
Subject: Re: [Qemu-devel] [PATCH] Makefile: remove unused variables
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 06/08/19 08:40, Gerd Hoffmann wrote:
> Well, the commit message pretty much says it.  We have sdl.mo in both
> ui/ and audio/ (final module names are audio-sdl.so and ui-sdl.so).
> 
> This certainly was needed back when I added it.  Possibly it can be
> removed now, I don't follow build system changes that closely.  But
> it should be build-tested both ui/sdl and audio/sdl enabled.

Will do.  However, audio-obj-y has not existed since commit b0b68fc671
("build: move audio/ objects to nested Makefile.objs", 2012-06-07), and
ui-obj-y since 8867aef02e ("build: move ui/ objects to nested
Makefile.objs", 2012-06-07).  audio-obj-m and ui-obj-m has never existed
as far as I can tell.

My understanding is that the two are audio/sdl.mo and ui/sdl.mo, and
even though the sdl.mo-* variables seem to conflict, they are rewritten
to audio/sdl.mo-{cflags,libs,objs} and ui/sdl.mo-{cflags,libs,objs} when
unnest-vars-recursive calls fix-paths.

Paolo

