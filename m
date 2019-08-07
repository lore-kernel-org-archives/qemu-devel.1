Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25591C32751
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 17:14:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED01F21EF2
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 17:14:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED01F21EF2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43710 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvPWJ-000473-83
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 13:14:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52706)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hvPVj-0003Gp-VX
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 13:14:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hvPVi-0005EJ-S1
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 13:14:03 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46185)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hvPVi-0005Cm-ML
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 13:14:02 -0400
Received: by mail-wr1-f66.google.com with SMTP id z1so92138982wru.13
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2019 10:14:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ApFUr7iLGkM9f6Hg9lBnoU65H8XzLr3MZnfZRKAeeXo=;
 b=IL8SMWfMDKsDcRWIc5gtERcPK2KoWnLEvH2vsL2bdL8hVqcd5fMZbPhxircPCwkqHt
 RBz7VFoufggPjabpWthK56ttSgh3s/8zVuOE1GMdrVALedlMbUCvq2/8TNCl/qQ+DpA5
 HHBZRRX+qyg1WJHoKJWr+4rrwoGlPhNP+ioPhbKHqKJXVgIQqhJocli+QrYWx4Qmawc9
 7MWQHIv59aySv8Yh+6LzDg5saQzH8qAuhCQYNHAeB40vQ3DXbqeuWq2tY8agRyeMh91N
 kza655t4SN/ruULlSziwtkqahvuRqeBnG7A/RWz6/JBqlGmBw/oIzpeESgC7+YElQnwV
 4ENQ==
X-Gm-Message-State: APjAAAVP6ZogIfkDBAohoAGZ5fBWNMa+CZqvIsQ0o+hw6gRtFNwUn19x
 qdW9pvBVQ3SZZsGMSGDWevrCu9VG9d0=
X-Google-Smtp-Source: APXvYqx7d1e8X5Bz6Hd7t9yfko7G9GzTLzqvXTZtfJjD2TwijgvUpEzGh+R+NS8EveFV3jtEpb9RZQ==
X-Received: by 2002:adf:fd08:: with SMTP id e8mr12602951wrr.147.1565198041191; 
 Wed, 07 Aug 2019 10:14:01 -0700 (PDT)
Received: from [192.168.1.115] (214.red-83-51-160.dynamicip.rima-tde.net.
 [83.51.160.214])
 by smtp.gmail.com with ESMTPSA id v5sm138330619wre.50.2019.08.07.10.14.00
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Wed, 07 Aug 2019 10:14:00 -0700 (PDT)
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20190806151435.10740-1-armbru@redhat.com>
 <20190806151435.10740-15-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <608c2043-0e1d-f57e-6c79-a4f8438601f8@redhat.com>
Date: Wed, 7 Aug 2019 19:13:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190806151435.10740-15-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.66
Subject: Re: [Qemu-devel] [PATCH v2 14/29] migration: Move the
 VMStateDescription typedef to typedefs.h
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/6/19 5:14 PM, Markus Armbruster wrote:
> We declare incomplete struct VMStateDescription in a couple of places
> so we don't have to include migration/vmstate.h for the typedef.
> That's fine with me.  However, the next commit will drop
> migration/vmstate.h from a massive number of compiles.  Move the
> typedef to qemu/typedefs.h now, so I don't have to insert struct in
> front of VMStateDescription all over the place then.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  include/hw/qdev-core.h      | 6 ++----
>  include/migration/vmstate.h | 1 -
>  include/qemu/typedefs.h     | 1 +
>  include/qom/cpu.h           | 4 ++--
>  target/alpha/cpu.h          | 2 +-
>  target/arm/cpu.h            | 2 +-
>  target/cris/cpu.h           | 2 +-
>  target/hppa/cpu.h           | 2 +-
>  target/i386/cpu.h           | 2 +-
>  target/lm32/cpu.h           | 2 +-
>  target/mips/internal.h      | 2 +-
>  target/openrisc/cpu.h       | 2 +-
>  target/ppc/cpu-qom.h        | 2 +-
>  target/ppc/cpu.h            | 2 +-
>  target/s390x/cpu.h          | 2 +-
>  target/sparc/cpu.h          | 2 +-
>  16 files changed, 17 insertions(+), 19 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

