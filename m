Return-Path: <SRS0=pVGd=WM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA902C3A59C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 11:24:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFED22086C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 11:24:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFED22086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54038 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyaKv-0007mx-LJ
	for qemu-devel@archiver.kernel.org; Fri, 16 Aug 2019 07:24:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47766)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1hyaKH-0007O8-Gl
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 07:23:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hyaKF-0007a9-UL
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 07:23:20 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39994)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hyaKF-0007Zh-OA
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 07:23:19 -0400
Received: by mail-wr1-f68.google.com with SMTP id c3so1204119wrd.7
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2019 04:23:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=U+9Wc86nXpB1wcxPY5Kk+9cno6gu/Mc33xxZzt9nZQM=;
 b=KtaZLHUn4nVPMdr5LgeN1HElEU4vlUV0zGBMfJAuHMGvl3JSthp0Bbcur/wN2UCX+w
 OexcH+D2I/ePQ2oIA3354RoHD/cT/J72XaQBq81fQ/vu6/1GIjE1gFpRyrRdBPK8S2l5
 PUHaX7C088U4DX+tfliHM/cU4JLxCn5J4TCNSbwygRmVrpOWSrJkVGvHdmSE5zAYiRC3
 V0rBpoUbv0/VBikBWgxg4rUW8a4NA9k6xH4zFt4AVUiE6u/mgrFldmnBeTpX9AKEeJPr
 VoTpnnjXPkeUr/bx10tZxZK7vQhl+kH4EfWmlMJdOMG3snTSVRvrCsExZ8o5ukZj7aIr
 r4Rg==
X-Gm-Message-State: APjAAAVS0Um14ISkec0gZ4SJZm7HbdrsieMw1V6K1TW7T0FhI0t/4MN6
 pef/zzpvJWyCqn/etYz5tZ1/1FBWpbs=
X-Google-Smtp-Source: APXvYqwCw35dbpkPXGlWZhlUI4EDn+9JQnhteyB32LwWOOjP/wvpl19QE0KBxa4GhPe86Vw4Gm/8iQ==
X-Received: by 2002:adf:f641:: with SMTP id x1mr10665767wrp.179.1565954598546; 
 Fri, 16 Aug 2019 04:23:18 -0700 (PDT)
Received: from [192.168.1.39] (251.red-88-10-102.dynamicip.rima-tde.net.
 [88.10.102.251])
 by smtp.gmail.com with ESMTPSA id a84sm5462616wmf.29.2019.08.16.04.23.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Aug 2019 04:23:17 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
References: <20190813154653.20568-1-armbru@redhat.com>
 <CAFEAcA9L1yA==UV__H_bkC+HBKNB1vMtAXidQsbNwDGSt6Yokw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <7d6c5482-183e-5373-03ac-18aac5055572@redhat.com>
Date: Fri, 16 Aug 2019 13:23:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9L1yA==UV__H_bkC+HBKNB1vMtAXidQsbNwDGSt6Yokw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.68
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

On 8/16/19 12:59 PM, Peter Maydell wrote:
> On Tue, 13 Aug 2019 at 16:54, Markus Armbruster <armbru@redhat.com> wrote:
>>
>> The following changes since commit 864ab314f1d924129d06ac7b571f105a2b76a4b2:
>>
>>   Update version for v4.1.0-rc4 release (2019-08-06 17:05:21 +0100)
>>
>> are available in the Git repository at:
>>
>>   git://repo.or.cz/qemu/armbru.git tags/pull-include-2019-08-13
>>
>> for you to fetch changes up to 8d111fd683b678d3826e192bc07ffcc349a118b5:
>>
>>   sysemu: Split sysemu/runstate.h off sysemu/sysemu.h (2019-08-13 13:16:20 +0200)
>>
>> ----------------------------------------------------------------
>> Header cleanup patches for 2019-08-13
>>
>> ----------------------------------------------------------------
>> These patches are rather bothersome to rebase, so I'd like to get them
>> into 4.2 early.
>>
> 
> Fails to build on OSX I'm afraid:
> /Users/pm215/src/qemu-for-merges/ui/cocoa.m:1166:5: error: implicit
> declaration of function 'qemu_system_shutdown_request' is invalid in
> C99 [-Werror,-Wimplicit-function-declaration]
>     qemu_system_shutdown_request(SHUTDOWN_CAUSE_HOST_UI);
>     ^

Ah I reported this one while reviewing v2:
https://lists.gnu.org/archive/html/qemu-devel/2019-08/msg01150.html

Then didn't take the time to test OSX on v4 :(

BTW Travis should find this.

