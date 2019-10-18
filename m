Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34D84CA9EA9
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 14:59:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0751721852
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 14:59:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0751721852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41460 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLTj1-0000My-TV
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 10:59:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37757)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iLThf-00088u-JV
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 10:58:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iLThd-0005fh-DY
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 10:58:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40626)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iLThd-0005fQ-2g
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 10:58:05 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2A33510F12
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2019 14:58:04 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id 7so2815546wrl.2
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2019 07:58:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=N/RYi8XivFUSEtJX3vugc4TwPGQZ8qIGGlo1B+RLNoY=;
 b=Zn6IJv+zeVBoEm9vix2J+XyhvgjOFYqluWipIJLeu18uuvV8eGQ2g6OgAGYf/G2M2A
 JPUkpUe02t7E7tDobN/ZWXXA2PrA/5ICvAh/ciFFhnfbruOCPPWsQnETptRqO0Ahmssj
 aU5cetHXn67nkvdKt7CO/gxLkOCb1lQ3Zbcou0gtNiKfazZ/bME6IKdGdzgjL9jIZ5Tt
 qaTM14+sbxrblLz3PQ4xqWAvKrRGVCcK0Cnoc7YnvmKW7/18CcEUWbrnTXa9BpvuiqRl
 lA5pz/ajM7nWTGnHhBKfDF1N08zcXidOwQuqrdItBa39FtOu2XotQOQlsbjjX/M2ceDf
 H/0g==
X-Gm-Message-State: APjAAAUjk/Z0rUmZEpDBpC6iZlVdV/MmXHJB1xoWW70+GoTqBvFH+G84
 F18OwyGkjceeQzCDhO/Ktm5MXZlasEk7Q7YS7T5Z6JcWz/0hnSrTzLDztpQmYcwvrgL9HhA25Gx
 PObikje+FP9PLHf0=
X-Received: by 2002:adf:8295:: with SMTP id 21mr7960253wrc.14.1571410682815;
 Fri, 18 Oct 2019 07:58:02 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxMUlr+Xum0dfpdO9qyZWy9FMbpEVuPf/Iw0Dm+MmozctJQqe6dI5HI1uIaPvP8eT3WjRF3Pw==
X-Received: by 2002:adf:8295:: with SMTP id 21mr7960235wrc.14.1571410682616;
 Fri, 18 Oct 2019 07:58:02 -0700 (PDT)
Received: from [192.168.1.36] (14.red-88-21-201.staticip.rima-tde.net.
 [88.21.201.14])
 by smtp.gmail.com with ESMTPSA id a9sm7347601wmf.14.2019.10.18.07.58.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Oct 2019 07:58:01 -0700 (PDT)
Subject: Re: Python 2 and test/vm/netbsd
To: Eduardo Habkost <ehabkost@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 Samuel Thibault <samuel.thibault@ens-lyon.org>
References: <20191016030021.GD4084@habkost.net>
 <a83d518a-6e39-0017-203d-2ee3d61935ca@redhat.com>
 <20191016224124.GF4084@habkost.net> <20191017220541.GJ4084@habkost.net>
 <20191017225548.GL4084@habkost.net>
 <20191018104439.c2tojlvi2c5zzesi@sirius.home.kraxel.org>
 <20191018142940.GN4084@habkost.net>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <a0c2df74-360b-79de-132e-f4d5be5bfc12@redhat.com>
Date: Fri, 18 Oct 2019 16:58:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191018142940.GN4084@habkost.net>
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
 Thomas Huth <thuth@redhat.com>, John Snow <jsnow@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Kamil Rytarowski <kamil@netbsd.org>,
 Kevin Wolf <kwolf@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/18/19 4:29 PM, Eduardo Habkost wrote:
> On Fri, Oct 18, 2019 at 12:44:39PM +0200, Gerd Hoffmann wrote:
>>    Hi,
>>
>>>> Running with V=1, I see packages being downloaded at reasonable speeds, but
>>>> there's a huge interval (of various minutes) between each package download.
>>>
>>> I've found the cause for the slowness I'm seeing: for each file
>>> being downloaded, the guest spents at least 75 seconds trying to
>>> connect to the IPv6 address of ftp.NetBSD.org, before trying
>>> IPv4.
>>
>> Ah, that nicely explains why it worked just fine for me.  First, I have
>> a local proxy configured so the installer isn't going to connect to
>> ftp.NetBSD.org directly.  Second I have IPv6 connectivity.
>>
>>> I don't know if this is a NetBSD bug, or a slirp bug.
>>
>> Both I'd say ...
>>
>> First, by default slirp should not send IPv6 router announcements
>> to the user network if the host has no IPv6 connectivity.
>>
>> Second, the recommended way to connect is to try ipv4 and ipv6 in
>> parallel, then use whatever connects first.  Web browsers typically
>> do it that way.  wget and curl don't do that though, they try one
>> address after the other, and I guess this is where the delay comes
>> from ...
> 
> In addition to that, the connect() error should be generating a
> ICMP6_UNREACH message, and I'd expect the NetBSD guest to notice
> it instead of waiting for timeout.

Is this missing in SLiRP?

