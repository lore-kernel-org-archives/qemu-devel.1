Return-Path: <SRS0=fB5B=WK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C33BC32753
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 14:16:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5216F2133F
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 14:16:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5216F2133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxu5C-0005qv-DQ
	for qemu-devel@archiver.kernel.org; Wed, 14 Aug 2019 10:16:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57821)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1hxu3v-0005Jl-F7
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 10:15:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hxu3u-0000bA-2C
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 10:15:39 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53040)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hxu3t-0000aj-Sv
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 10:15:38 -0400
Received: by mail-wm1-f67.google.com with SMTP id o4so4600759wmh.2
 for <qemu-devel@nongnu.org>; Wed, 14 Aug 2019 07:15:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Rt+gVo6Mn33Os4MEaHtomV2duMkKiq36r5vK9+6E/mM=;
 b=BcFl8LiWbf6Yyb/3b4zj57X7KcgfLrgWpym4e+TiuTpDAH9lAtlgT3tWcr3wHAiq8O
 /jXWjQ+XY2gbhNrrumdmWzHcZ/EKp8i4dGKrd4lazjPFapYnhflCkt5XRWKTXdGf96y9
 t9OpQJy338XAvGKQaHPS53bxlR7L0gvH2rQ7P5XA/PvTbjGS+a81JWMpHi7+inXDaCVa
 98wxjZ0oAsAVfWyjmVwTKlQXWu4oEkC8PeiXNso2hcrPAqhuuoUCj2+1jQWqYixTzdss
 ej46N/qMKdcjl4e/6LyWiu5491BsDMcvkzixNsa/Bk+fNjONE4Q2FvG5l0SUUnHgWN+k
 BEXw==
X-Gm-Message-State: APjAAAV8GNKDvkAk0JxUjeIxLAfHMTH/hG+15XFvdF6ApNgw8LuEdqev
 eZPsSWQ3aXN/BKSTdsvn87xKXw==
X-Google-Smtp-Source: APXvYqxuVX1lri/eU8EFKANcw0PtRiqFUYwALvFyIUThYE3XNfL42PVrKo16+8cGZDjh8qcIdb7wqA==
X-Received: by 2002:a1c:a5c2:: with SMTP id o185mr8621321wme.172.1565792136812; 
 Wed, 14 Aug 2019 07:15:36 -0700 (PDT)
Received: from [192.168.1.39] (251.red-88-10-102.dynamicip.rima-tde.net.
 [88.10.102.251])
 by smtp.gmail.com with ESMTPSA id v23sm5450892wmj.32.2019.08.14.07.15.35
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Wed, 14 Aug 2019 07:15:36 -0700 (PDT)
To: Andrea Bolognani <abologna@redhat.com>,
 "Richard W . M . Jones" <rjones@redhat.com>, qemu-devel@nongnu.org,
 Pino Toscano <ptoscano@redhat.com>
References: <20190814121527.17876-1-philmd@redhat.com>
 <20190814121527.17876-3-philmd@redhat.com>
 <4876e26ccda980f45e0ad1492097a66b07fe65de.camel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <ca03335f-55a1-322f-401d-a02a2d115b66@redhat.com>
Date: Wed, 14 Aug 2019 16:15:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <4876e26ccda980f45e0ad1492097a66b07fe65de.camel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.67
Subject: Re: [Qemu-devel] [PATCH 2/4] configure: Avoid using libssh
 deprecated API
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
Cc: Kevin Wolf <kwolf@redhat.com>, =?UTF-8?B?5ZGo5paH6Z2S?= <1151451036@qq.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/14/19 3:27 PM, Andrea Bolognani wrote:
> On Wed, 2019-08-14 at 14:15 +0200, Philippe Mathieu-Daudé wrote:
>> The libssh packaged by a distribution can predate version 0.8,
>> but still provides the newer API introduced after version 0.7.
>>
>> Using the deprecated API leads to build failure, as on Ubuntu 18.04:
>>
>>     CC      block/ssh.o
>>   block/ssh.c: In function 'check_host_key_hash':
>>   block/ssh.c:444:5: error: 'ssh_get_publickey' is deprecated [-Werror=deprecated-declarations]
>>        r = ssh_get_publickey(s->session, &pubkey);
>>        ^
>>   In file included from block/ssh.c:27:0:
>>   /usr/include/libssh/libssh.h:489:31: note: declared here
>>    SSH_DEPRECATED LIBSSH_API int ssh_get_publickey(ssh_session session, ssh_key *key);
>>                                  ^~~~~~~~~~~~~~~~~
>>   rules.mak:69: recipe for target 'block/ssh.o' failed
>>   make: *** [block/ssh.o] Error 1
>>
>> Fix by using the newer API if available.
>>
>> Suggested-by: Andrea Bolognani <abologna@redhat.com>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> ---
>>  block/ssh.c | 2 +-
>>  configure   | 7 +++++++
>>  2 files changed, 8 insertions(+), 1 deletion(-)
> 
> Did I really suggest this? I have no recollection of doing so, or
> even getting involved with libssh support in QEMU at all for that
> matter.

I took this suggestion from
https://www.redhat.com/archives/libvir-list/2018-May/msg00597.html

