Return-Path: <SRS0=pVGd=WM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2AABC3A59C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 12:40:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83B432086C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 12:40:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83B432086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55222 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hybWe-0007em-OZ
	for qemu-devel@archiver.kernel.org; Fri, 16 Aug 2019 08:40:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58505)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1hybVf-0007DC-0Q
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 08:39:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hybVd-0005cH-HI
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 08:39:10 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37639)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hybVd-0005bz-BZ
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 08:39:09 -0400
Received: by mail-wm1-f67.google.com with SMTP id z23so3963808wmf.2
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2019 05:39:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=JIqWNPutHNQXgTOfMbFQ4rFCNVlLt+0IsKVDsVkcZUE=;
 b=kRm6f/1FO5WAq0XZBDT+JJI0VrqCvSRAd/u4Z8iyGcKQDUCoaQI1OZ4RMP+j9lazZb
 8BvyICkjAfubz2G0BeUUIjggSrG9Coc/1oHLWEi/TFcn04sVM5IRXDJN7ecs7eOb80I+
 it+0YNcbK/0d/UMdHQ4Gn4JRWJEVV31OxkXmHDMXSris/FLkMFkAPsnm2niFW113dKp0
 H+eg5zKAIwwN3GBWjI7pbYf4/QYqvhteeULZHKGO+JhLCHuwAYxjI3rce0NZC7aPtqET
 oCxDlCvDfDuQB+3tVHQWtZQrvL9kvUK6ViPllxbybIPoFtaUq8AcCSLKPAVVzfYksKHf
 t86A==
X-Gm-Message-State: APjAAAXZIfK/69G3WsCe0ToRAXllSaELG4a2w5SJFD4W+TC3NOP7M5BQ
 UzJ797CKafw9pNg+L7Q+3xFTNu20n1s=
X-Google-Smtp-Source: APXvYqxjDMBCnhzTzIEVa+XoFPZ2olh3j2OpKA4YtI2R65V0og61M4GNgrcbtwe1VPSh95B/gJqlKQ==
X-Received: by 2002:a1c:2015:: with SMTP id g21mr7059992wmg.33.1565959147947; 
 Fri, 16 Aug 2019 05:39:07 -0700 (PDT)
Received: from [192.168.1.39] (251.red-88-10-102.dynamicip.rima-tde.net.
 [88.10.102.251])
 by smtp.gmail.com with ESMTPSA id f7sm9524844wrf.8.2019.08.16.05.39.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Aug 2019 05:39:07 -0700 (PDT)
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>
References: <20190813154653.20568-1-armbru@redhat.com>
 <CAFEAcA9L1yA==UV__H_bkC+HBKNB1vMtAXidQsbNwDGSt6Yokw@mail.gmail.com>
 <7d6c5482-183e-5373-03ac-18aac5055572@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <80ed7df8-2dfc-4bb0-b3e4-3e58df9d0957@redhat.com>
Date: Fri, 16 Aug 2019 14:39:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <7d6c5482-183e-5373-03ac-18aac5055572@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.67
Subject: Re: [Qemu-devel] [PULL 00/29] Header cleanup patches for 2019-08-13
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/16/19 1:23 PM, Philippe Mathieu-Daudé wrote:
> On 8/16/19 12:59 PM, Peter Maydell wrote:
>> On Tue, 13 Aug 2019 at 16:54, Markus Armbruster <armbru@redhat.com> wrote:
>>>
>>> The following changes since commit 864ab314f1d924129d06ac7b571f105a2b76a4b2:
>>>
>>>   Update version for v4.1.0-rc4 release (2019-08-06 17:05:21 +0100)
>>>
>>> are available in the Git repository at:
>>>
>>>   git://repo.or.cz/qemu/armbru.git tags/pull-include-2019-08-13
>>>
>>> for you to fetch changes up to 8d111fd683b678d3826e192bc07ffcc349a118b5:
>>>
>>>   sysemu: Split sysemu/runstate.h off sysemu/sysemu.h (2019-08-13 13:16:20 +0200)
>>>
>>> ----------------------------------------------------------------
>>> Header cleanup patches for 2019-08-13
>>>
>>> ----------------------------------------------------------------
>>> These patches are rather bothersome to rebase, so I'd like to get them
>>> into 4.2 early.
>>>
>>
>> Fails to build on OSX I'm afraid:
>> /Users/pm215/src/qemu-for-merges/ui/cocoa.m:1166:5: error: implicit
>> declaration of function 'qemu_system_shutdown_request' is invalid in
>> C99 [-Werror,-Wimplicit-function-declaration]
>>     qemu_system_shutdown_request(SHUTDOWN_CAUSE_HOST_UI);
>>     ^
> 
> Ah I reported this one while reviewing v2:
> https://lists.gnu.org/archive/html/qemu-devel/2019-08/msg01150.html
> 
> Then didn't take the time to test OSX on v4 :(
> 
> BTW Travis should find this.

Actually I did try v4 on Travis and it succeeded:
https://travis-ci.org/philmd/qemu/builds/570743079

But Travis seems to have updated smth on their OSX images (or brew is
down?), now I get:

  ERROR: glib-2.40 gthread-2.0 is required to compile QEMU

Anyway, the culprit is:

commit 8d111fd683b678d3826e192bc07ffcc349a118b5 (tag:
pull-include-2019-08-13)
Author: Markus Armbruster <armbru@redhat.com>
Date:   Mon Aug 12 07:23:59 2019 +0200

    sysemu: Split sysemu/runstate.h off sysemu/sysemu.h

    sysemu/sysemu.h is a rather unfocused dumping ground for stuff related
    to the system-emulator.  Evidence:

    * It's included widely: in my "build everything" tree, changing
      sysemu/sysemu.h still triggers a recompile of some 1100 out of 6600
      objects (not counting tests and objects that don't depend on
      qemu/osdep.h, down from 5400 due to the previous two commits).

    * It pulls in more than a dozen additional headers.

ui/cocoa.m now needs to include "sysemu/runstate.h".

