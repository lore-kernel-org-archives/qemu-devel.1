Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A0D9C06510
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 10:34:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 711A320836
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 10:34:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 711A320836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51488 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiG7h-0000Hl-QG
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 06:34:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48583)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hiG5c-0007A5-ER
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 06:32:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hiG5X-00070r-DU
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 06:32:42 -0400
Received: from mail-wm1-f52.google.com ([209.85.128.52]:54262)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hiG5T-0006su-NG
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 06:32:37 -0400
Received: by mail-wm1-f52.google.com with SMTP id x15so333045wmj.3
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2019 03:32:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Yjn5fIAjsuTiAkzRM9YhZGZLVS1yAVdOnuz6kuPBWQY=;
 b=SFDA8x4LPVho6f4kRY12+N7mt55xyJ3M8R55UzOd8c0KxjZb19SeGs9L4eezXsS1BT
 QdYdtl6NOHphGD7rdbbIJg0FR+iDX058dmqlkE8sh/NWAmXw/HsupHhUjsypoFkJIop4
 YuqHxVuMonVo9hx/cCZ2RbfCfwuFyQiCjndYqxg8DFSr1BOZjUYSKM8MPAnOfMHDOnZT
 NYTdMBOlDg0DI9YW6DhMntWgBGv20NBJhqa9sud501m5M4TX8emORpZ08vWL9fmUgsiZ
 S2DYQY4xki9Oc5pZNb/fIUcVUWOhmZmTupoPK5PkAjlrK+um6OrWJxPqCD0pT0dB6+Gy
 vFSQ==
X-Gm-Message-State: APjAAAXLnaFPVhosk3kIm1XN9PE7oIF+8aHTEP0UM57lG3wyKoeJc9oP
 pKjIDqt3mTltKP3l35mt6J12/A==
X-Google-Smtp-Source: APXvYqyoS2q3CVHOHTcU/rAU+Q+Kx2F55SmRYS2gFUNQT467SuoCzplNSG7CukYyAai/E1WFDQFBFg==
X-Received: by 2002:a7b:cbcb:: with SMTP id n11mr2921393wmi.146.1562063548849; 
 Tue, 02 Jul 2019 03:32:28 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:68f6:70ea:5bb4:f73?
 ([2001:b07:6468:f312:68f6:70ea:5bb4:f73])
 by smtp.gmail.com with ESMTPSA id x8sm2484773wmc.5.2019.07.02.03.32.27
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Tue, 02 Jul 2019 03:32:28 -0700 (PDT)
To: Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20190627152011.18686-1-palmer@sifive.com>
 <20190627152011.18686-34-palmer@sifive.com>
 <CAFEAcA8sscJQ2GCwL1gM+EcRtfHQb1v0BwORt6ncH54x51TCVg@mail.gmail.com>
 <5896113812cd914308e5b617377f8e8205224cfe.camel@wdc.com>
 <CAFEAcA_-h6b_f1fuWh7NkGo+FT0xSyCDXgd3b4pwEvNDN8HcJw@mail.gmail.com>
 <87a7dxqdl5.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d5fb05ba-e313-b9db-9cfa-2c6f7c1b90f8@redhat.com>
Date: Tue, 2 Jul 2019 12:32:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <87a7dxqdl5.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.52
Subject: Re: [Qemu-devel] [PULL 33/34] roms: Add OpenSBI version 0.3
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
Cc: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 Jeff Cody <codyprime@gmail.com>, "palmer@sifive.com" <palmer@sifive.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "bmeng.cn@gmail.com" <bmeng.cn@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 02/07/19 06:12, Markus Armbruster wrote:
>> Yeah, if we're not building the apache-2.0 parts then I think
>> we're OK, and as you say there's the question of whether QEMU's
>> GPL affects what we ship as mere bios blobs to run as guest
>> code anyway. But it's sufficiently not a "really obviously ok"
>> that I'd like a second opinion; cc'd some people who might have
>> second opinions.
> 
> You need an expert opinion.
> 
> My non-expert opinion: we can't distribute anything that's not
> compatible with GPLv2

Guest code is not part of QEMU.  We don't say that SeaBIOS, SLOF, etc. 
are part of QEMU; it constitutes mere aggregation with the GPLv2 QEMU 
sources, so it _is_ possible to distribute APSL2 guest code with QEMU.  
IANAL, but I'm fairly sure about this.

However I agree that LICENSE needs to be updated, something like this:

diff --git a/LICENSE b/LICENSE
index 0e0b4b9553..81b9b3572d 100644
--- a/LICENSE
+++ b/LICENSE
@@ -1,13 +1,18 @@
-The following points clarify the QEMU license:
+The QEMU distribution includes both the QEMU emulator and
+various firmware files.  These are separate programs that are
+distributed together for our users' convenience, and they have
+separate license.
 
-1) QEMU as a whole is released under the GNU General Public License,
-version 2.
+The following points clarify the license of the QEMU emulator:
 
-2) Parts of QEMU have specific licenses which are compatible with the
-GNU General Public License, version 2. Hence each source file contains
-its own licensing information.  Source files with no licensing information
-are released under the GNU General Public License, version 2 or (at your
-option) any later version.
+1) The QEMU emulator as a whole is released under the GNU General
+Public License, version 2.
+
+2) Parts of the QEMU emulator have specific licenses which are compatible
+with the GNU General Public License, version 2. Hence each source file
+contains its own licensing information.  Source files with no licensing
+information are released under the GNU General Public License, version
+2 or (at your option) any later version.
 
 As of July 2013, contributions under version 2 of the GNU General Public
 License (and no later version) are only accepted for the following files

Paolo

