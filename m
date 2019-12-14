Return-Path: <SRS0=ZS6r=2E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD62EC43603
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Dec 2019 21:42:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96856207FD
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Dec 2019 21:42:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eQxJbPkw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96856207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igFAs-0006x0-No
	for qemu-devel@archiver.kernel.org; Sat, 14 Dec 2019 16:42:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59024)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1igF9v-0006Kt-AC
 for qemu-devel@nongnu.org; Sat, 14 Dec 2019 16:41:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1igF9t-0000tI-QX
 for qemu-devel@nongnu.org; Sat, 14 Dec 2019 16:41:06 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43422
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1igF9t-0000r4-G3
 for qemu-devel@nongnu.org; Sat, 14 Dec 2019 16:41:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576359664;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=71FAYiWen3xeCusJb6+d+V1obs9H2g4G8AXIaasXjQw=;
 b=eQxJbPkwA7qq5pCKO1o/Z/oKKQ1rseJh5uqM+CsRdgsiCv6Vv5B0BX/sStGg2QKkSOnOqC
 4cjWmovLnVImJevX2Jwgo5Lgnj68SpvWGNkkPQqcuyuFJVIcelBAcTpemdYu9dWleebxcx
 HzU70PkYVWm1IFoSj/KBkVyzQUd63BI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-43-QTg8Z68xMdujF3So5nr_Yw-1; Sat, 14 Dec 2019 08:38:50 -0500
Received: by mail-wr1-f70.google.com with SMTP id d8so354818wrq.12
 for <qemu-devel@nongnu.org>; Sat, 14 Dec 2019 05:38:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=71FAYiWen3xeCusJb6+d+V1obs9H2g4G8AXIaasXjQw=;
 b=rEk4rBBNmvXpckEbWl4JNlqZ1TBTXG6BIr25A8eY0HFOCTuT5nEQ2RMAf867wdPLmj
 4oM7qISmEKYBAWN+H2gFFgBdaZ/THMZqbm5t4MKBeeveVPbeyKWNTDKca1rig+qisj/g
 6HgisRJcPotTVmHbXUs1ptV502ZCbKBw+Nuc1YLPFiO3VWQUHr7DQ7JtrtNk6kUjefs2
 lJG2gB0p/ODS7p49T5s0azEjzKO1srJ0LIzMtyc9C7nMHn6AAFp9aoonIRc98TEo3+Xb
 ITHKFHyIrtbly3UvMPK2FyrBXhU9mXI6vOUli/CgxYhEFtLTcDXmYcA40o1biQE386gX
 oP5w==
X-Gm-Message-State: APjAAAUkR8AwJKAExPIqspFewkyMn0i5mleakNTRsuDPKEQrcYOFqeon
 8K3xkj6XhiUcmIX3KWEhuK2AMpKUDTsquUVpcTf+N+INp5Dxtw4mOIY0hia7z/IpNzI88jNrLNu
 TOG4Grh0Udn8V8w0=
X-Received: by 2002:a7b:cc6a:: with SMTP id n10mr20374320wmj.170.1576330729175; 
 Sat, 14 Dec 2019 05:38:49 -0800 (PST)
X-Google-Smtp-Source: APXvYqw4E3RaFkEYB7nGK9bMZvnf+cWXYu46R5Iphqe2jwDKbujuqMVf5AdKCv4Huj/x4b5jrBDkFA==
X-Received: by 2002:a7b:cc6a:: with SMTP id n10mr20374297wmj.170.1576330728971; 
 Sat, 14 Dec 2019 05:38:48 -0800 (PST)
Received: from [192.168.1.35] (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id v83sm3529410wmg.16.2019.12.14.05.38.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Dec 2019 05:38:48 -0800 (PST)
Subject: Re: [PATCH 00/10] Fixes for DP8393X SONIC device emulation
To: Finn Thain <fthain@telegraphics.com.au>, qemu-devel@nongnu.org
References: <157628778601.20418.17236421597625110152@37313f22b938>
 <alpine.LNX.2.21.1.1912141345460.18@nippy.intranet>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <b8c42c79-ed61-031d-a7f7-0af82992bd85@redhat.com>
Date: Sat, 14 Dec 2019 14:38:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <alpine.LNX.2.21.1.1912141345460.18@nippy.intranet>
Content-Language: en-US
X-MC-Unique: QTg8Z68xMdujF3So5nr_Yw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, jasowang@redhat.com,
 qemu-stable@nongnu.org, laurent@vivier.eu, hpoussin@reactos.org,
 Paolo Bonzini <pbonzini@redhat.com>, aleksandar.rikalo@rt-rk.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/14/19 3:52 AM, Finn Thain wrote:
> On Fri, 13 Dec 2019, no-reply@patchew.org wrote:
> 
>> === OUTPUT BEGIN ===
>> 1/10 Checking commit 9c9ffc38e9b9 (dp8393x: Mask EOL bit from descriptor addresses)
>> ERROR: return is not a function, parentheses are not required
>> #24: FILE: hw/net/dp8393x.c:200:
>> +    return (s->regs[SONIC_URDA] << 16) | (s->regs[SONIC_CRDA] & 0xfffe);
>>
>> ERROR: return is not a function, parentheses are not required
>> #33: FILE: hw/net/dp8393x.c:220:
>> +    return (s->regs[SONIC_UTDA] << 16) | (s->regs[SONIC_TTDA] & 0xfffe);
>>
> 
> I expect that checkpatch.pl has no idea about operator precedence, but
> these parentheses could actually be omitted.
> 
> I kept them because I don't want readers to have to remember that bit
> shift operator has higher precedence than bitwise OR operator, or look it
> up if they don't.
> 
> The existing code also has those unnecessary parentheses.
> 
> Please let me know if this patch should include a code style change.

This is a bug in checkpatch. Since this script doesn't have dedicated 
maintainer, I Cc'ed the recent contributors:

$ ./scripts/get_maintainer.pl -f scripts/checkpatch.pl
get_maintainer.pl: No maintainers found, printing recent contributors.


