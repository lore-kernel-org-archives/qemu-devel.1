Return-Path: <SRS0=Pmsr=VD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13088C0650E
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jul 2019 20:20:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D329B20838
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jul 2019 20:20:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D329B20838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tuxfamily.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjrAI-0006b6-60
	for qemu-devel@archiver.kernel.org; Sat, 06 Jul 2019 16:20:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57405)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <th.huth@gmail.com>) id 1hjr9V-0005zS-5K
 for qemu-devel@nongnu.org; Sat, 06 Jul 2019 16:19:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <th.huth@gmail.com>) id 1hjr9T-0003G2-FE
 for qemu-devel@nongnu.org; Sat, 06 Jul 2019 16:19:21 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34423)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <th.huth@gmail.com>) id 1hjr9R-0003D4-Cv
 for qemu-devel@nongnu.org; Sat, 06 Jul 2019 16:19:19 -0400
Received: by mail-wr1-f68.google.com with SMTP id u18so13106998wru.1
 for <qemu-devel@nongnu.org>; Sat, 06 Jul 2019 13:19:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:subject:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=AhAhKaGNeiS7A/8iY3bCDQibXm1kTlQe67slz9YY50g=;
 b=ZflJMoYkOhqOMxFf3EsuhkWGub4maZCw12TpgEP82vKofFYLTVSZPmnBuCWwYWPvgM
 QfPOgwwW10Gvbbt/jGHaW9nEMU7ACYHvTynQuVdKtppu5XCF7hdLHNTM2Irzz8Plimno
 3Wtfl2yrd4OkPbg5jxOnqUwS4UdsbyE/n39cU6QoIVhw725ax5aYmQq9+0HFKx8Qt5zH
 slsFnH9qKLmf82Z/R78URlyckGfY5txptur5JH71dAZb/txIFad70fdlvm013C9JwTDS
 y6KU0Jw6H/mZrcJd19C1l1GMkYxXJCTKdQ7dSDUL3aLAdkobur7yy44fw336Ku2W/ZP3
 mpxA==
X-Gm-Message-State: APjAAAVv39BXl2LqScB7pHpbLJADfpwgEXG7gbyvAVWDXOcYBjP73Mnf
 N67Zurb9izcwfn4rjIdakKWzh7Yn
X-Google-Smtp-Source: APXvYqy14rinQvNeAzvvFkUmlKAsOnlrcpfM4921sAKH3a3sR7AzKOnDIjNPF65q+CSf0REEHh3rnw==
X-Received: by 2002:adf:f601:: with SMTP id t1mr7153421wrp.337.1562444353501; 
 Sat, 06 Jul 2019 13:19:13 -0700 (PDT)
Received: from thl530.multi.box (pD9E83551.dip0.t-ipconnect.de.
 [217.232.53.81])
 by smtp.gmail.com with ESMTPSA id n125sm18347423wmf.6.2019.07.06.13.19.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Sat, 06 Jul 2019 13:19:12 -0700 (PDT)
Date: Sat, 6 Jul 2019 22:19:09 +0200
From: Thomas Huth <huth@tuxfamily.org>
To: qemu-devel@nongnu.org
Message-ID: <20190706221909.3f1b3d53@thl530.multi.box>
In-Reply-To: <156242845202.4200.11224412072242119697@c4a48874b076>
References: <20190706154308.7280-1-huth@tuxfamily.org>
 <156242845202.4200.11224412072242119697@c4a48874b076>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.68
Subject: Re: [Qemu-devel] [PATCH v3 0/4] m68k: Add basic support for the
 NeXTcube machine
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

Am Sat, 6 Jul 2019 08:54:13 -0700 (PDT)
schrieb no-reply@patchew.org:

> Patchew URL:
> https://patchew.org/QEMU/20190706154308.7280-1-huth@tuxfamily.org/
> 
> Hi,
> 
> This series seems to have some coding style problems. See output
> below for more information:
[...]
> ERROR: space required after that ',' (ctx:VxV)
> #938: FILE: hw/m68k/next-cube.c:903:
> +    memory_region_init_alias(aliasmem, NULL,"next.unknown", mmiomem,
> 0xc0020, ^

Stupid typo - I'll fix of course, and change the name of the region to
"next.alias" or something similar.

 Thomas

