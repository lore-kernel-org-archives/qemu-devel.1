Return-Path: <SRS0=r3/N=VJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 410A0C742D2
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 16:54:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08BF02064B
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 16:54:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08BF02064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51222 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlyo8-0004Hn-BO
	for qemu-devel@archiver.kernel.org; Fri, 12 Jul 2019 12:54:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56108)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hlynx-0003pF-Ha
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 12:53:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hlynw-0003Wu-BY
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 12:53:53 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39930)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hlynw-0003WU-4n
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 12:53:52 -0400
Received: by mail-wr1-f67.google.com with SMTP id x4so10650545wrt.6
 for <qemu-devel@nongnu.org>; Fri, 12 Jul 2019 09:53:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=R1hCJKQHxAvyuLivzhMcPrCvCfXf2qsShjPpR+LLNWA=;
 b=eVegJySZBYHaARXOA41Sj97DMhD1wI7LhnHZvpAj0zQeChGNdbFGbo07DGB2BkeCHC
 50RALHiVMODHYPjEhg64cWCIBP9WdxIHuwYYqImcI1jEr9jQwxjIx2XD+v3jWIETwhUR
 9WUhB0sGhzLg8F8OINqyr2EbUx6/p8OvK79w1NDunicpweKBwYz3Xs1IPXUIGAinjN+u
 Dsdq4SEWveyX6jvLx3FO4C991XOXEi8G7QeEll8A7Q3HbAcXOzpogMHqo7Lu5vcmNXFI
 dI/rjyH7Ywi+IBMrD3Cj2Av/Hv6vkZO8MNmxaKTYEgzWEKbfvNAjPIQfKwy+gqX4wsYl
 q/oQ==
X-Gm-Message-State: APjAAAX2aJ+HfYGTTdhrltNFvSlt5HxWAaFdOmOiSErTIQ3zPcehU7yf
 yzMYFvM4x3pV5Oc5QZaG2nsblg==
X-Google-Smtp-Source: APXvYqyZuCV27Si7k6opLbVRewXpivz/drRFTOor8cTID7UGsaLUFPi5HatRw3bZn/Uy4C0gebx38A==
X-Received: by 2002:a5d:51c8:: with SMTP id n8mr6386159wrv.46.1562950431186;
 Fri, 12 Jul 2019 09:53:51 -0700 (PDT)
Received: from [192.168.1.37] (62.red-83-42-61.dynamicip.rima-tde.net.
 [83.42.61.62])
 by smtp.gmail.com with ESMTPSA id h6sm8709246wre.82.2019.07.12.09.53.50
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 12 Jul 2019 09:53:50 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190711155703.15627-1-philmd@redhat.com>
 <20190711155703.15627-3-philmd@redhat.com>
 <CAFEAcA8RQDOJNgyWSpr5L0sgXoxvoToU3EGTX8O0+D5kmeMegg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <b903d7ae-968c-b02e-55e6-65ef0208da6e@redhat.com>
Date: Fri, 12 Jul 2019 18:53:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8RQDOJNgyWSpr5L0sgXoxvoToU3EGTX8O0+D5kmeMegg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.67
Subject: Re: [Qemu-devel] [PATCH-for-4.1 v4 2/5] hw/block/pflash_cfi01: Use
 the correct READ_ARRAY value
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
Cc: Kevin Wolf <kwolf@redhat.com>, Qemu-block <qemu-block@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>, John Snow <jsnow@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>, Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/12/19 5:15 PM, Peter Maydell wrote:
> On Thu, 11 Jul 2019 at 16:58, Philippe Mathieu-Daudé <philmd@redhat.com> wrote:
>>
>> In the "Read Array Flowchart" the command has a value of 0xFF.
>>
>> In the document [*] the "Read Array Flowchart", the READ_ARRAY
>> command has a value of 0xff.
>>
>> Use the correct value in the pflash model.
>>
>> There is no change of behavior in the guest, because:
>> - when the guest were sending 0xFF, the reset_flash label
>>   was setting the command value as 0x00
>> - 0x00 was used internally for READ_ARRAY
>>
>> To keep migration with older versions behaving correctly, we
>> decide to always migrate the READ_ARRAY as 0x00.
>>
>> [*] "Common Flash Interface (CFI) and Command Sets"
>>     (Intel Application Note 646)
>>     Appendix B "Basic Command Set"
>>
>> Reviewed-by: John Snow <jsnow@redhat.com>
>> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
>> Regression-tested-by: Laszlo Ersek <lersek@redhat.com>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> ---
> 
> These changes look correct as far as they go, but are
> we sure that command value 0x00 will never be a valid
> command in some future version? If it ever does, then we
> have a problem because we can't distinguish "0xff with
> a silly encoding" from "really 0x00" in the incoming
> migration data stream.
> 
> If we're 100% confident that there will never be a true
> command 0x00 then this approach is OK.

I am not confident, the industry can surprise us.

If a CFI command of value 0x00 is ever published, then this device will
be in troubles because it can not support it (due to back-migration).
Neither in its current state, neither after this patch.

So if this ever happens, this device will never be able to announce it
supports features with a such command. And if guests require we model
this feature, then we'll increase the migration version and the device
won't be backward-migratable.

I'll try to explain that in the commit description.

