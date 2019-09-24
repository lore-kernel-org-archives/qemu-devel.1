Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93110C432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 14:59:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D027207FD
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 14:59:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KcPvb3OP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D027207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46676 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCmHg-0002Sn-QT
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 10:59:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32916)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iCl5u-0004jZ-9z
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 09:43:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iCl5t-0008I3-8g
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 09:43:06 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:44443
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iCl5s-0008H6-Th
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 09:43:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1569332584;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=IaAaaiBuNyFnRW+WwVtEeUZj2iRI/cjyZpL4KInS+/0=;
 b=KcPvb3OPmbOymgPCYDsYHhc0oMlV6/gnSQ6n/Mgzng4Tz1SxAcL4nDESfmQ1lrEyF/2RQ2
 0KxUVqaiI1xAO6xCLckEqgeFnXVxkgCk559Jo4VQlG+yPH0k+zZxdJheygFOCkctI02YcO
 8wj3FbI77NlqwPqxFYlcfOxUTwK+63I=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-295-aLIDyS95Pby1Y-JtU5WS9g-1; Tue, 24 Sep 2019 09:43:02 -0400
Received: by mail-wm1-f69.google.com with SMTP id c188so23198wmd.9
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2019 06:43:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=tCMYsjxij8sNqWPcrfwE0+Wh73+xKTJT1k8/sbZ8AXw=;
 b=l44WN+lmunsYvuPWBtodQN3T/35O/uLaC0P7bLXlWjSAivnKCVO87Ub5nfFj+wHDvf
 EvQH2ebunugBcoT2heA+vTkPAD5WyHpbuPUWtkFjLAUPZDBdAXVssNinmkhNK7zhF7Cs
 WFdJoCwi6LflKoHhn46za/OeWthAfuXikGx4bdoPBWDEeqdULDCRO41QhHFVpNFmwIHL
 H0CEQOfyIo/lqcLeisO1/fXElQTjozhqhb4ssloJQADJ8T1JWZb+RdH0Z/ChXV/F24bi
 eO8uJ5EYSUpxX8dwekGGWO8IcKsF7Y7xLK/2wo8UOsEuZQngnxRkGJCxqO0NGmvw+d0V
 /H7A==
X-Gm-Message-State: APjAAAWJ9eNNbM4yEb0pd9Arf4qENAWEDiGnPJEmjyvK2j+++C4iFLv8
 lGBEZI/ps3+HJIvXfjBkIqZ/8mDyF93ZNXXPaz9B8Gx40ZLIbMpTlkJ44ixtXEh2/M8xisLKlzt
 /D5LB0fI2qpw8OMw=
X-Received: by 2002:adf:e607:: with SMTP id p7mr2317969wrm.230.1569332581769; 
 Tue, 24 Sep 2019 06:43:01 -0700 (PDT)
X-Google-Smtp-Source: APXvYqx289zOYsfThGc6IR0e027sEhHxFDyhOEfIl9LBhoL9vO7kgdRqnjkTpzLlm1ZpcWU+kUA5NQ==
X-Received: by 2002:adf:e607:: with SMTP id p7mr2317942wrm.230.1569332581581; 
 Tue, 24 Sep 2019 06:43:01 -0700 (PDT)
Received: from [192.168.1.115] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id d28sm3327375wrb.95.2019.09.24.06.43.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Sep 2019 06:43:00 -0700 (PDT)
Subject: Re: illegal hardware instruction during MIPS-I ELF linux useremulation
To: Libo Zhou <zhlb29@foxmail.com>, Peter Maydell <peter.maydell@linaro.org>
References: <tencent_28AAA62B694825C348B1DF49@qq.com>
 <CAFEAcA8+bK0UyUWbXOiutyQZkCMSB_0Be7pJLKONSpA3CV9Pbw@mail.gmail.com>
 <tencent_0084E0586ADE9B2D30176A53@qq.com>
 <tencent_6A42D8651281588C41FEE751@qq.com>
 <tencent_6DB0EBDC4C098868592B8A79@qq.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <b4bc1f35-817d-79a0-df4d-07eaa2fdffe5@redhat.com>
Date: Tue, 24 Sep 2019 15:42:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <tencent_6DB0EBDC4C098868592B8A79@qq.com>
Content-Language: en-US
X-MC-Unique: aLIDyS95Pby1Y-JtU5WS9g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 207.211.31.81
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
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/24/19 3:31 PM, Libo Zhou wrote:
>>> I would start by using the QEMU gdbstub to connect a
>>> MIPS-aware gdb. Then when the SIGILL arrives you can see
>>> what instruction the guest program was trying to execute.
>=20
>> Just tried it and found something interesting.
>> I connected gdb-multiarch to QEMU gdbstub. gdb-multiarch's architecture =
was set to mips:3000 automatically (and Wikipedia says r3k uses MIPS-I).
>=20
>> When I did 'layout asm', and compared the instructions displayed against=
 test.s generated by my mipsel-linux-unknown-gcc, they appeared to be a lit=
tle bit different.
>=20
>> The 'store word' instruction in test.s is shown as a hex '0x7f......(don=
't remember the rest)';
>> 'load word' is shown as '0x5f......';
>> 'load immediate' is seen as 'addi';
>> 'j' as 'jr';
>=20
>> When I single-stepped the instructions, the SIGILL was thrown immediatel=
y after the first unrecognized 0x7f......, which is supposed to be a store =
word (sw).
>=20
>> Hence, can I conclude that MIPS-I is not implemented in QEMU out of the =
box? Or is it possible that my compiler doesn't implement MIPS-I correctly?
>=20
> More updates about this. I just disassembled the unrecognized hex by hand=
, and figured out that the store word and load word opcodes are not the sam=
e as specified in translate.c. While the remaining fields of those unrecogn=
ized instructions do match with the source and destination registers.

What is your compiler/assembler versions (on both machines you used)?


