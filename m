Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9E7EC35DF9
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 11:14:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BB0721556
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 11:14:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BB0721556
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52754 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6YAK-0006A0-O1
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 06:14:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40455)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jirislaby@gmail.com>) id 1j6Y9a-0005CZ-45
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:13:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jirislaby@gmail.com>) id 1j6Y9W-00044y-CL
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:13:30 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55441)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jirislaby@gmail.com>) id 1j6Y9W-00040c-6D
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:13:26 -0500
Received: by mail-wm1-f66.google.com with SMTP id q9so2547571wmj.5
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 03:13:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=wzb/3nww0AcI8OgbfGFcrhz8/ehPbcJx821qqME+Fhc=;
 b=Idyif8DcNNTnd8vxoNDD3PjoIjyIM/MMYb6bHYjtsj72FX+n2YyOVXFgJxFfaHjCFg
 v2gpM0j5GiK15yulxpXtrUrpfwsblAhzW8NF3Hb4LCc3psJyFYhbBsECgPTX2mG5JhgW
 5Fzxv116wccfrKaCOfsaanaFY8FhI7AYSG46EGecmvSb1B6hPor6sUzhQKMr5IK37hBp
 hZsNw6Qajjz3xs4bJE4HGcLOYvAqaWcWfySH+ERxGd8pD/7dGRJJYuTJmanvEsbJmMVq
 BmIHJSgymKoflOqhCO0jweRxGczQ9X+O8NSnzU4Hv/ISdEoZxMynl9yGhwDzAFEf+k8m
 9jHg==
X-Gm-Message-State: APjAAAXNevTEmGt3j5DB14cKQuToh+cCz9mTaPtZDlIx5ZvjxN30siaW
 0xfma+a9nbdctBEf/CefKGAjILlZVLM=
X-Google-Smtp-Source: APXvYqxU9Ghix78TaqokvuvJk8SCCB0gR10RYti2dhV7ip+xtncDiQMPxFrvfXYJzW+NDbvJgfW3Sg==
X-Received: by 2002:a1c:670a:: with SMTP id b10mr4672485wmc.2.1582629204741;
 Tue, 25 Feb 2020 03:13:24 -0800 (PST)
Received: from [192.168.1.49] (185-219-167-24-static.vivo.cz. [185.219.167.24])
 by smtp.gmail.com with ESMTPSA id v131sm3860163wme.23.2020.02.25.03.13.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Feb 2020 03:13:24 -0800 (PST)
Subject: Re: [PATCH] slirp: samba, set 'server min protocol' to NT1
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20200225102758.21074-1-jslaby@suse.cz>
 <20200225104338.GC1148628@redhat.com>
From: Jiri Slaby <jslaby@suse.cz>
Autocrypt: addr=jslaby@suse.cz; prefer-encrypt=mutual; keydata=
 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
Message-ID: <b723072f-6e83-c089-f16a-34fb84452046@suse.cz>
Date: Tue, 25 Feb 2020 12:13:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200225104338.GC1148628@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.66
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
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 25. 02. 20, 11:43, Daniel P. Berrangé wrote:
> On Tue, Feb 25, 2020 at 11:27:58AM +0100, Jiri Slaby wrote:
>> Samba changed the default of server min protocol from LANMAN1 (very old
>> protocol) to SMB2_02 (only Vista and newer) in commit 840b8501b436
>> (docs-xml: change "server min protocol" to SMB2_02).
>>
>> WXP guests cannot use the samba shares since then as it uses a protocol
>> newer than LANMAN1, but older than SMB2_02: NT1 protocol. So set 'server
>> min protocol' in the samba config used in qemu to NT1. This restores
>> support for WinNT and newer (WXP including).
>>
>> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
>> ---
>>  net/slirp.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/net/slirp.c b/net/slirp.c
>> index c4334ee876c7..b3bc4a2bded7 100644
>> --- a/net/slirp.c
>> +++ b/net/slirp.c
>> @@ -887,6 +887,7 @@ static int slirp_smb(SlirpState* s, const char *exported_dir,
>>              "printing = bsd\n"
>>              "disable spoolss = yes\n"
>>              "usershare max shares = 0\n"
>> +            "server min protocol = NT1\n"
>>              "[qemu]\n"
>>              "path=%s\n"
>>              "read only=no\n"
> 
> IIUC, the older protocol version has a number of downsides, both security
> and performance related, which is why Samba has removed it from the
> default config.

Sure, but is it that relevant for a VM? I mean, it's "min" protocol,
newer Win will negotiate the latest.

>  Do we really want to revert this defaults change that
> Samba maintainers made, in order to cope with a guest OS which was
> end-of-life 11 years ago ? It feels questionable to me.

It's 6 years, Vista is 3. (The current default still allows Vista.)

> Maybe QEMU's command line needs to include an option to set the min
> protocol version, so that we don't need to hardcode this obsolete protocol
> version in the source.

That would be great. Though I have no idea how to add one :). Something
like "-net user,smb=/home/smb,smbminproto=NT1" would be perfect by me.

thanks,
-- 
js
suse labs

