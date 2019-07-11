Return-Path: <SRS0=FHOf=VI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A54EC74A35
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 12:52:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FB8721537
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 12:52:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FB8721537
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlYYY-0002qn-C3
	for qemu-devel@archiver.kernel.org; Thu, 11 Jul 2019 08:52:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59178)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hlYY3-0002Lq-2a
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 08:51:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hlYY2-00064e-11
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 08:51:43 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46349)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hlYY1-000648-QL
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 08:51:41 -0400
Received: by mail-wr1-f65.google.com with SMTP id z1so6134803wru.13
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2019 05:51:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=SlPxaTmiSiArxzojp0dbqOkx2AWVUzv/4AcMbw5NJDM=;
 b=jzQR/z/wKxJ/lYaaHgN2XzD/+99VmT/AawzfNeQcXs2SKhDLVIh5ntA0EJf5RXfV38
 b/SftJ4Mu4utpiyUVbtXcdH4Tvdf8NGtUxOQfQ3J3O1j7Tb0AoqiNZYMohKTaQTJwH/Y
 qm3Qot5SswHipLDuXBmhxEnarNyiGpGLYPnLicufSL29sMGm7qzmdBzBZSidL/8h+bOp
 khdYu6hqoVo9N0/boEhvlivaKO2D8sAe49wzZeJiyVTWUJnRJAfqI5jqMf0ak0r/g8P/
 n1kLQ5NbyFt62Sn3B4OXAygDUxXT6RU0NNWHf+VaUHVF949G1lZ1+C+8uiJy4Z2S/9jv
 ibZQ==
X-Gm-Message-State: APjAAAVjRYX1rI4vNC/Vg3U1e/g804p2z7bjp7R0WcgPXrOTC9nNVK/R
 YqvK3CU+Sx0YAx+ifJNcbGs7Gw==
X-Google-Smtp-Source: APXvYqxAg1V3WiLb9lgSJJ3TAhcoxAF7RdcdLOAqxLmVbcEVoA7vZ2t1QoKFR0QelOo9+vmDdvLBcA==
X-Received: by 2002:adf:f812:: with SMTP id s18mr5511182wrp.32.1562849500754; 
 Thu, 11 Jul 2019 05:51:40 -0700 (PDT)
Received: from [192.168.1.38] (62.red-83-42-61.dynamicip.rima-tde.net.
 [83.42.61.62])
 by smtp.gmail.com with ESMTPSA id f192sm6258366wmg.30.2019.07.11.05.51.39
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Thu, 11 Jul 2019 05:51:40 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190702005912.15905-1-philmd@redhat.com>
 <20190702005912.15905-25-philmd@redhat.com>
 <CAFEAcA9zUUjvfsmswwnTaKEp+NbB3u+zohD9cH8hufbZLRqGWQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <97b14ab3-2d00-ea23-a31b-101cdbd37836@redhat.com>
Date: Thu, 11 Jul 2019 14:51:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9zUUjvfsmswwnTaKEp+NbB3u+zohD9cH8hufbZLRqGWQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] [PULL 24/27] hw/block/pflash_cfi02: Implement
 erase suspend/resume
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
Cc: Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Stephen Checkoway <stephen.checkoway@oberlin.edu>,
 Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/11/19 2:35 PM, Peter Maydell wrote:
> On Tue, 2 Jul 2019 at 04:29, Philippe Mathieu-Daudé <philmd@redhat.com> wrote:
>>
>> From: Stephen Checkoway <stephen.checkoway@oberlin.edu>
>>
>> During a sector erase (but not a chip erase), the embeded erase program
>> can be suspended. Once suspended, the sectors not selected for erasure
>> may be read and programmed. Autoselect mode is allowed during erase
>> suspend mode. Presumably, CFI queries are similarly allowed so this
>> commit allows them as well.
>>
>> Since guest firmware can use status bits DQ7, DQ6, DQ3, and DQ2 to
>> determine the current state of sector erasure, these bits are properly
>> implemented.
>>
>> @@ -305,13 +364,16 @@ static uint64_t pflash_read(void *opaque, hwaddr offset, unsigned int width)
>>          }
>>          DPRINTF("%s: ID " TARGET_FMT_plx " %" PRIx64 "\n", __func__, boff, ret);
>>          break;
>> -    case 0xA0:
>>      case 0x10:
>>      case 0x30:
>> +        /* Toggle bit 2 during erase, but not program. */
>> +        toggle_dq2(pfl);
>> +    case 0xA0:
>> +        /* Toggle bit 6 */
>> +        toggle_dq6(pfl);
>>          /* Status register read */
>>          ret = pfl->status;
>>          DPRINTF("%s: status %" PRIx64 "\n", __func__, ret);
>> -        toggle_dq6(pfl);
>>          break;
>>      case 0x98:
>>          /* CFI query mode */
> 
> Hi; Coverity (CID 1403012) flags up the case 0x30 as an implicit
> fallthrough. Should it have an explicit "break" or a "/* fall through */"
> comment?

Yes, it is an implicit fallthrough. I'll send a patch.

Thanks,

Phil.

