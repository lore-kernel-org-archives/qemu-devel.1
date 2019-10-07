Return-Path: <SRS0=TwS2=YA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 701B0ECE599
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 17:56:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B94020684
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 17:56:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B94020684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHXF2-0005N6-CW
	for qemu-devel@archiver.kernel.org; Mon, 07 Oct 2019 13:56:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45878)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iHXDy-0004iM-Dd
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 13:55:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iHXDt-0005Y2-D7
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 13:55:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:31683)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iHXDt-0005XJ-1T
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 13:55:05 -0400
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id EE9DF757C2
 for <qemu-devel@nongnu.org>; Mon,  7 Oct 2019 17:55:03 +0000 (UTC)
Received: by mail-wm1-f69.google.com with SMTP id z205so147101wmb.7
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2019 10:55:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ysIOHYSUMTwRT9D1EWw3AVUg8ppTg2vwmFWK7HDkU2Q=;
 b=uj5Y21clkCrRMY45WGjczna4vt5nDtq3SpJFfbnQ6+2wlSgP7Xmo7uw5bSRYhTMurE
 poaLsQWAQyAKOr143/4ISDUfUavWIxJg/A0zS2iKIya8oTGwd3+chvXOzWIOQK9TafHn
 YyEjaeFDDwc0scjmhat4cxF+VBMTw0msx9M7zJRLhaiynXRNdPCtC+i40+A+uZSPSMcg
 LxL0iHzi+80gPsYLDVStqQnEqz34ZQrI8EV1yLaTuqdSqoYztlIkRZaGxU80jzIbRKsU
 Zh8FWViP6xvGfRrRHKknDwlpEVHoC4uSJlqOUJkqITMFtzCBN2hXnTYAfo5KGQUr8Hnp
 hTdA==
X-Gm-Message-State: APjAAAUiTZE5W2REVjb92ZlhY9rd8z8rZvNBTIZfcLxMIIe6zEmREm9P
 ZQO3I/nhh4nBwJGXBETpyH8PcW6XnvhhKYSdqKyZKtkjyFVAfnxb65F7G3Ziw8ULs9YLeyFCukm
 PxM+kuBXZ/vBF2jc=
X-Received: by 2002:adf:fd0f:: with SMTP id e15mr11968501wrr.187.1570470902676; 
 Mon, 07 Oct 2019 10:55:02 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwFo7W/u0eeX0UzeakQ8yqJg5PXZ5fTqXWT49glMh5QnCBcUy2A5TMT7i+dj0P/iYlwqY8rhw==
X-Received: by 2002:adf:fd0f:: with SMTP id e15mr11968480wrr.187.1570470902447; 
 Mon, 07 Oct 2019 10:55:02 -0700 (PDT)
Received: from [192.168.1.35] (46.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.46])
 by smtp.gmail.com with ESMTPSA id w22sm235532wmc.16.2019.10.07.10.55.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Oct 2019 10:55:01 -0700 (PDT)
Subject: Re: [PULL v2 0/8] Ide patches
To: John Snow <jsnow@redhat.com>, Sam Eiderman <shmuel.eiderman@oracle.com>
References: <20191003193245.8993-1-jsnow@redhat.com>
 <CAFEAcA9Z92iuYwEUdsSpej_pGiAX6H6FBaGySqKxXHGjGRueNw@mail.gmail.com>
 <e8e86add-677c-4eb5-4629-aaadfd0be2a4@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <e0945918-d1cf-abf8-218a-6c5e8be80b70@redhat.com>
Date: Mon, 7 Oct 2019 19:55:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <e8e86add-677c-4eb5-4629-aaadfd0be2a4@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Qemu-block <qemu-block@nongnu.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 "Gonglei \(Arei\)" <arei.gonglei@huawei.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/7/19 7:35 PM, John Snow wrote:
> On 10/7/19 8:33 AM, Peter Maydell wrote:
>> On Thu, 3 Oct 2019 at 20:33, John Snow <jsnow@redhat.com> wrote:
>>>
>>> The following changes since commit 7f21573c822805a8e6be379d9bcf3ad9effef3dc:
>>>
>>>    Merge remote-tracking branch 'remotes/huth-gitlab/tags/pull-request-2019-10-01' into staging (2019-10-01 13:13:38 +0100)
>>>
>>> are available in the Git repository at:
>>>
>>>    https://github.com/jnsnow/qemu.git tags/ide-pull-request
>>>
>>> for you to fetch changes up to f6d61c9509c56eea3cdd2d23b40d285601b1c1ca:
>>>
>>>    hd-geo-test: Add tests for lchs override (2019-10-03 14:36:54 -0400)
>>>
>>> ----------------------------------------------------------------
>>> Pull request V2
>>>
>>> - Added signoff into the mirrored commits themselves (vs just the email)
>>> - Kudos to `stg-foreach stg edit --sign`
>>>
>>> ----------------------------------------------------------------
>>
>> Hi; the new tests in hd-geo-test seem to hang on
>> big-endian hosts (both s390x and ppc64 hung here):
>>
>> linux1@lxub05:~/qemu/build/all$ QTEST_QEMU_IMG=./qemu-img
>> QTEST_QEMU_BINARY=x86_64-softmmu/qemu-system-x86_64
>> ./tests/hd-geo-test
>> /x86_64/hd-geo/ide/none: OK
>> /x86_64/hd-geo/ide/drive/cd_0: OK
>> /x86_64/hd-geo/ide/drive/mbr/blank: OK
>> /x86_64/hd-geo/ide/drive/mbr/lba: OK
>> /x86_64/hd-geo/ide/drive/mbr/chs: OK
>> /x86_64/hd-geo/ide/device/mbr/blank: OK
>> /x86_64/hd-geo/ide/device/mbr/lba: OK
>> /x86_64/hd-geo/ide/device/mbr/chs: OK
>> /x86_64/hd-geo/ide/device/user/chs: OK
>> /x86_64/hd-geo/ide/device/user/chst: OK
>> /x86_64/hd-geo/override/ide:
>>
> 
> :(
> 
>>
>> thanks
>> -- PMM
>>
> 
> Sam, can you investigate this?

Not seeing my T-b tags makes me grumble because I don't remember which I 
reviewed and need to go check on the list.

If the error is a endianess bug related to fw_cfg, you can add the 
"-trace fw_cfg*" in hd-geo-test::create_args() and rerun the tests on a 
BE system, the bug should appear straightly on stdout.

Are FWLCHSEntry fields little-endian? Shouldn't 
get_boot_devices_lchs_list() use some le32_to_cpu() call for the LCHS 
values?

