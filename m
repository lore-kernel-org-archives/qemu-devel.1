Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7295C4363A
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 15:04:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09A6F20708
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 15:04:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LefTIWdF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09A6F20708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42882 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQXSz-0005cy-MF
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 11:04:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46368)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kQXQw-0004F7-6T
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 11:02:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55017)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kQXQs-0002cX-8c
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 11:02:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602169333;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/bcAF+aBKCvuWU4NZzOXHeiS4vQ4sj9ju9M3mP0Myx8=;
 b=LefTIWdFHpr+hS9pmzU8v+0cXTjwJaq68p7VcsgomWkrk2+v9Y4g3QG1Shh4CG3YTblomi
 I/Wqz7O15mplkjD98VzuUsjOPCvwOZCKsttQcFuXxlWziM7f8f9dEPKNQSpqeL8bs0RiUh
 K94UX8cLgJ1+6pozfBTMeq0sfVrq9NY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-395-jtTV2wcDMLqQwz3Hj5UWFw-1; Thu, 08 Oct 2020 11:02:11 -0400
X-MC-Unique: jtTV2wcDMLqQwz3Hj5UWFw-1
Received: by mail-wr1-f69.google.com with SMTP id x16so3624992wrg.7
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2020 08:02:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/bcAF+aBKCvuWU4NZzOXHeiS4vQ4sj9ju9M3mP0Myx8=;
 b=q2TpYXMLEg7d0RVXIH+7ZMkf9eMXcR98u3/5wJsCrWS4T5KS1faBc0o5tw4apBqlqj
 iOj71p9TXwxzA4o73HcNEhz+9UfbMwYsHe6EXlG8eS9jqzVWPrKRw1QE7wENSXoj5rY9
 myEOiSWoPyIPSY/RY73SLZLe1lXgDCbqMKWNuyGEzH2TTccFHvBDpN1HPG4tHXawqoEI
 T3Dehrkdl9MereNSHzwsM301nePAeV4qcambR3qUxIdlXB8IPcLIO2fg2G0iHKVtTXMI
 D6deRjRHjQJ1ocJnbugcgHK8Fix3C8U+5wmFBUOWMRLzLgAgk1rGmEXEF7I1InTuWONN
 BViA==
X-Gm-Message-State: AOAM532Gom6vAVdYiV+QAAR1vYC29r4G/w66xPhETWR30jd12ndnrIsi
 KvXayBC8IQkZvmU6Wlx9CfAVz4WbpRcUY4BIvPjBJoWrYveeC3yiBnqLK9B0+X7+JEkdlMre39+
 MW3DAq/GCMIRr1AE=
X-Received: by 2002:a5d:51ca:: with SMTP id n10mr9806901wrv.222.1602169330112; 
 Thu, 08 Oct 2020 08:02:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzE627CjcMF5NSaXGi1MlAXEDs5PgjqFCFNd6hSeUaIqh1Ybmm23Ky50u35aAmR2w0ye8LJ/w==
X-Received: by 2002:a5d:51ca:: with SMTP id n10mr9806870wrv.222.1602169329846; 
 Thu, 08 Oct 2020 08:02:09 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:bb8c:429c:6de1:f4ec?
 ([2001:b07:6468:f312:bb8c:429c:6de1:f4ec])
 by smtp.gmail.com with ESMTPSA id z191sm7330274wme.40.2020.10.08.08.02.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Oct 2020 08:02:08 -0700 (PDT)
Subject: Re: does make check now require TCG? Or is it a parallelism issue?
To: Claudio Fontana <cfontana@suse.de>
References: <11ef73ff-4178-b3e8-2e49-44ff014a13ed@suse.de>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <569520f6-adf6-6212-9625-a184bf499e24@redhat.com>
Date: Thu, 8 Oct 2020 17:02:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <11ef73ff-4178-b3e8-2e49-44ff014a13ed@suse.de>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/08 02:56:27
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.214, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: Alex Bennee <alex.bennee@linaro.org>, qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 08/10/20 16:48, Claudio Fontana wrote:
> on master, a build without tcg like:
> 
> exec '../configure' '--disable-tcg' '--enable-kvm' '--enable-hax' "$@"
> 
> make -j120 check
> Generating qemu-version.h with a meson_exe.py custom command
> make: *** No rule to make target 'qemu-system-aarch64', needed by 'check-block'.  Stop.
> make: *** Waiting for unfinished jobs....
> 
> qemu-system-aarch64 is required for check-block now?

No, it's not, it's an unnecessary dependency.  This will fix it:

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 5aca98e60c..1ca70d88ce 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -140,7 +140,7 @@ QEMU_IOTESTS_HELPERS-$(CONFIG_LINUX) = tests/qemu-iotests/socket_scm_helper$(EXE
 check: check-block
 check-block: $(SRC_PATH)/tests/check-block.sh qemu-img$(EXESUF) \
 		qemu-io$(EXESUF) qemu-nbd$(EXESUF) $(QEMU_IOTESTS_HELPERS-y) \
-		$(patsubst %-softmmu,qemu-system-%,$(filter %-softmmu,$(TARGET_DIRS)))
+		qemu-system-$(patsubst ppc64%,ppc64, $(shell uname -m))
 	@$<
 endif
 


> If I run without -j:
> 
> Running test qtest-i386: qmp-cmd-test
> Broken pipe
> ../tests/qtest/libqtest.c:175: kill_qemu() detected QEMU death from signal 6 (Aborted) (core dumped)
> ERROR qtest-i386: qmp-cmd-test - too few tests run (expected 53, got 45)
> make: *** [Makefile.mtest:1074: run-test-151] Error 1

This one is different and I've never seen it.

Paolo


