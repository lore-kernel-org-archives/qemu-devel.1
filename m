Return-Path: <SRS0=8dir=WF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EFE6C31E40
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 10:54:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D9952086D
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 10:54:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D9952086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58122 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hw2Xc-0000or-HL
	for qemu-devel@archiver.kernel.org; Fri, 09 Aug 2019 06:54:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34561)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hw2Ws-0000NP-GH
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 06:53:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hw2Wq-0006qD-JB
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 06:53:50 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50251)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hw2Wq-0006py-CC
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 06:53:48 -0400
Received: by mail-wm1-f65.google.com with SMTP id v15so5263748wml.0
 for <qemu-devel@nongnu.org>; Fri, 09 Aug 2019 03:53:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=tKd0ma3fgLYtvgHcLdtp+RIpvu+JOw1QFN0s4gSiDNw=;
 b=jq+j2ZiFQTNDtgaloY353J+TkndgOK5o4Mjml5lyFQwEQNUwHyv5pvm7DYwamGeh3c
 F+beYFza0dC3dMAWNPUeNIHpv47UIymCt1hspVBKhfO0lis+O6SQgvLZKFRWNjFMMUiT
 yxyhT9jI8lsmLXUIpl5wzKf4VKgh4YVYYOrw7uBXMXlJZY9Q0Jng49ctznlwsKukykRM
 7NATSP7l+S5pf7utIZz2O9MMT68QA4p7/j5XoMtUouX1Uq2I+N9n8AktaGTCa9zo1l8q
 pMoxkS1mF4eSiBNSpLI2XQqNnc0vaekF5btYxWXqp9pLGFS2kde5+FZlVXWz+AwDBc3l
 0wpQ==
X-Gm-Message-State: APjAAAUAIcgKuvDdg47xQd1+48Jf/vxgFzkH+EeoA/mbGQ6iiaAkJSU1
 +Jhe+mWzEmmVOASAY1J+8rbnsQ==
X-Google-Smtp-Source: APXvYqxl+5/FOYeljQaovjyt9qvCemN9DA13VWK+yZ5Rf4noGKQKJJs2rQi4OjEunS7nNJVgOLIQ3Q==
X-Received: by 2002:a05:600c:21d3:: with SMTP id
 x19mr10043701wmj.45.1565348027228; 
 Fri, 09 Aug 2019 03:53:47 -0700 (PDT)
Received: from [192.168.50.36] (243.red-88-26-246.staticip.rima-tde.net.
 [88.26.246.243])
 by smtp.gmail.com with ESMTPSA id j2sm1203395wmh.43.2019.08.09.03.53.46
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 09 Aug 2019 03:53:46 -0700 (PDT)
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20190809064645.22656-1-armbru@redhat.com>
 <20190809064645.22656-26-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <85ff3748-2f7e-7043-4189-59ffdef83825@redhat.com>
Date: Fri, 9 Aug 2019 12:53:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190809064645.22656-26-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.65
Subject: Re: [Qemu-devel] [PATCH v3 25/29] numa: Move remaining NUMA
 declarations from sysemu.h to numa.h
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
Cc: Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/9/19 8:46 AM, Markus Armbruster wrote:
> Commit e35704ba9c "numa: Move NUMA declarations from sysemu.h to
> numa.h" left a few NUMA-related macros behind.  Move them now.
> 
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>


