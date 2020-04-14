Return-Path: <SRS0=m554=56=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9610C2BA19
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 11:36:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73AA2206D5
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 11:36:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZVCBEcIJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73AA2206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOJrP-0004PE-M2
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 07:36:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55549)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jOJqe-0003kx-MW
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 07:35:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jOJqd-0004uo-Ij
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 07:35:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38260
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jOJqd-0004ub-F3
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 07:35:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586864123;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TkWkv1sSQkb10ESnJ81NX+eXLN9yPeO5ArhBlLlo7kM=;
 b=ZVCBEcIJY/BgFHdT4Wf1cBHO3gN1fe6cynHaL/ZeZfqyCTpuKXYwYJcipRKqhrOOcySKrA
 K1Doa8Ei+aU2VxM4fefuwQqTQ2I78kCaN8gQ3Q/ogZQT6pTa/gFMXYFEb5lg9iCE8kpYe3
 axL5eRh3WxJ9GfbrwOgIRnf/di8YxQk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-171-A9urk0mkM-6TNsKXBbn-Ow-1; Tue, 14 Apr 2020 07:35:21 -0400
X-MC-Unique: A9urk0mkM-6TNsKXBbn-Ow-1
Received: by mail-wr1-f69.google.com with SMTP id m15so8578166wrb.0
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2020 04:35:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=45deY+ympfnEFZqUmSQTtjgToLUZLlw6E2wOzJRdDj4=;
 b=V16fRhCCrHijE/IyVKl2dK7pK6qa9UgmeZBhXDGoc9Id0KVjuITadjRQs3EmqIY0B/
 6TaMLAx+lRmMIzk0rZMvYENFvcZKH1lMp2+Fuyd+qqdLiIxtH8366TXklIZW+EiKdLg6
 wV9XxrW52ynxMmro4/uwvACcepA20ZUdhhIH9VGB7iZAHHjsILCZDI1XGHxMkeTjnwta
 w/4D6djhw2rnDCH3fZaPLW3XxneMuc2mWIpraBzI2Z4MncNm4hhsxYlxy/1NkOapF4uH
 pH6/rXoyiM95O//E3Qftb4IMo5HMjVIWDgt81z2UTB7SXuXRkEV04wYavs1Mcmgli5LU
 KhZg==
X-Gm-Message-State: AGi0Pub7/O5h9rMAdI2G/P61UJDAL+jfTok90DEhbC3/w9tUmlHGBm9P
 +NcpdDJvCpSjBaKRJqIlZcRczK8XlXQirh3LzRDxMeaOm2cK+mOLig1cTOekS9O6xKGxJuWn9xH
 Zcanvz14Q3lq2UOo=
X-Received: by 2002:a1c:bd8b:: with SMTP id
 n133mr24582582wmf.175.1586864120429; 
 Tue, 14 Apr 2020 04:35:20 -0700 (PDT)
X-Google-Smtp-Source: APiQypJxpzJUPs71ndHLjBXMIIAwJUSa61a2IhohKCQIKujRbnA0a2cGrYPLSN/8L9HsIyecDuogew==
X-Received: by 2002:a1c:bd8b:: with SMTP id
 n133mr24582536wmf.175.1586864120106; 
 Tue, 14 Apr 2020 04:35:20 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id h26sm18105559wmb.19.2020.04.14.04.35.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Apr 2020 04:35:19 -0700 (PDT)
Subject: Re: [PATCH-for-5.1] gdbstub: Rename GByteArray variable 'mem_buf' as
 'array'
To: qemu-devel@nongnu.org
References: <20200414112849.21787-1-philmd@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <09f9ae36-f8e9-8412-cd97-f3f386907b6f@redhat.com>
Date: Tue, 14 Apr 2020 13:35:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200414112849.21787-1-philmd@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Cornelia Huck <cohuck@redhat.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 David Hildenbrand <david@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Max Filippov <jcmvbkbc@gmail.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Marek Vasut <marex@denx.de>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>, qemu-ppc@nongnu.org,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org, Stafford Horne <shorne@gmail.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>, qemu-riscv@nongnu.org,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Chris Wulff <crwulff@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Michael Walle <michael@walle.cc>, Palmer Dabbelt <palmer@dabbelt.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/14/20 1:28 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> GByteArray type has should not be treated as a u8[] buffer.
> The GLib Byte Arrays API should be used instead.
> Rename the 'mem_buf' variable as 'array' to make it more
> obvious in the code.

I forgot to mention this variable was used as u8[] buffer prior to=20
commit a010bdbe719 ("extend GByteArray to read register helpers").

>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
> Based-on: <20200414111846.27495-1-philmd@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>   include/exec/gdbstub.h      | 34 +++++++-------
>   include/hw/core/cpu.h       |  2 +-
>   target/alpha/cpu.h          |  2 +-
>   target/arm/cpu.h            |  4 +-
>   target/cris/cpu.h           |  4 +-
>   target/hppa/cpu.h           |  2 +-
>   target/i386/cpu.h           |  2 +-
>   target/lm32/cpu.h           |  2 +-
>   target/m68k/cpu.h           |  2 +-
>   target/microblaze/cpu.h     |  2 +-
>   target/mips/internal.h      |  2 +-
>   target/openrisc/cpu.h       |  2 +-
>   target/ppc/cpu.h            |  4 +-
>   target/riscv/cpu.h          |  2 +-
>   target/rx/cpu.h             |  2 +-
>   target/s390x/internal.h     |  2 +-
>   target/sh4/cpu.h            |  2 +-
>   target/sparc/cpu.h          |  2 +-
>   target/xtensa/cpu.h         |  2 +-
>   gdbstub.c                   |  6 +--
>   hw/core/cpu.c               |  3 +-
>   target/alpha/gdbstub.c      |  4 +-
>   target/arm/gdbstub.c        | 10 ++--
>   target/arm/gdbstub64.c      | 10 ++--
>   target/cris/gdbstub.c       | 34 +++++++-------
>   target/hppa/gdbstub.c       |  6 +--
>   target/i386/gdbstub.c       | 92 ++++++++++++++++++-------------------
>   target/lm32/gdbstub.c       | 18 ++++----
>   target/m68k/gdbstub.c       | 10 ++--
>   target/m68k/helper.c        | 24 +++++-----
>   target/microblaze/gdbstub.c |  6 +--
>   target/mips/gdbstub.c       | 30 ++++++------
>   target/nios2/cpu.c          |  8 ++--
>   target/openrisc/gdbstub.c   | 10 ++--
>   target/riscv/gdbstub.c      |  6 +--
>   target/rx/gdbstub.c         | 22 ++++-----
>   target/s390x/gdbstub.c      | 28 +++++------
>   target/sh4/gdbstub.c        | 38 +++++++--------
>   target/sparc/gdbstub.c      | 46 +++++++++----------
>   target/xtensa/gdbstub.c     | 20 ++++----
>   40 files changed, 254 insertions(+), 253 deletions(-)


