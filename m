Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35EFAC3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 18:32:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E49F218BA
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 18:32:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E49F218BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzmS6-0004eg-Te
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 14:32:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57398)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1hzmPZ-0002yF-CU
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 14:29:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hzmPY-0005n6-9J
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 14:29:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40182)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hzmPY-0005mX-1w
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 14:29:44 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 28A267BDB6
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2019 18:29:43 +0000 (UTC)
Received: by mail-wr1-f72.google.com with SMTP id b1so5659329wru.4
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2019 11:29:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=2AWM5QJsOEl26RbrGu9u71/aoBSOJcokey3JtMybmtE=;
 b=H/NASB2OaASaWuXN8C6WV4k6ccvHqe8Zpjo+QlupvMpakc4iwOnpszvtejaq3vcKab
 +sizQOr4W1aUS5WgVwdqMBfNKzJvwtYC2uX7vx6sj1pzv1I6KxIAL0IiXUoUusNHdaf2
 TY4Vo/mK67O1E/e15wtshUUDoy4oomHfWqiDfDScsS34KzFMcM1s0qlnCqjISYCYoXjA
 cRR4e3zOHg//KJX6oyQX4Xxdw2fZ39xQbDGV8OxH2G8xDmcaafHNqfK2mJOxz08Kyz8w
 1qqhgSMsGL66CQ/PhD/o+0insmLaOSxCsnMjql6qENazQSvIcbw3fn1cnPHM2UDDE+bW
 rPFw==
X-Gm-Message-State: APjAAAVk2ZuVk3JrEYgZrOmnow77iuYa9miWMeNqad1G5SLoAaqiaWF6
 tTRRoj8fAn/zEFnzB/rKbe8XzljojcHUOVM+dwfGmrVxlfvAYc/gRRTseybDbUPqZmAw/vEIg4d
 IXrz5XnJGUstx7jA=
X-Received: by 2002:adf:f204:: with SMTP id p4mr30446241wro.317.1566239380855; 
 Mon, 19 Aug 2019 11:29:40 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyg0OqJZAKSnLqhaxokVPXEufs5sg5knDZPQxFk14FkUk+Vv8S0ARXUwV8ldlCH7o+UEsaAaQ==
X-Received: by 2002:adf:f204:: with SMTP id p4mr30446155wro.317.1566239380560; 
 Mon, 19 Aug 2019 11:29:40 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:399c:411e:1ccb:f240?
 ([2001:b07:6468:f312:399c:411e:1ccb:f240])
 by smtp.gmail.com with ESMTPSA id o14sm28083513wrg.64.2019.08.19.11.29.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Aug 2019 11:29:39 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Thomas Huth <thuth@redhat.com>, tony.nguyen@bt.com, qemu-devel@nongnu.org
References: <43bc5e07ac614d0e8e740bf6007ff77b@tpw09926dag18e.domain1.systemhost.net>
 <1565941032362.60179@bt.com>
 <1b5f5a92-1b75-f0d9-d7bc-4605094ad8e7@redhat.com>
 <8d8b37c9-3daf-d241-df92-1a5467bca451@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <3b983f77-8503-3fcd-7c42-45d0121845e6@redhat.com>
Date: Mon, 19 Aug 2019 20:29:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <8d8b37c9-3daf-d241-df92-1a5467bca451@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v7 33/42] exec: Replace
 device_endian with MemOp
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
Cc: frederic.konrad@adacore.com, berto@igalia.com, qemu-block@nongnu.org,
 arikalo@wavecomp.com, pasic@linux.ibm.com, hpoussin@reactos.org,
 anthony.perard@citrix.com, xen-devel@lists.xenproject.org, philmd@redhat.com,
 green@moxielogic.com, jiri@resnulli.us, ehabkost@redhat.com,
 b.galvani@gmail.com, eric.auger@redhat.com, alex.williamson@redhat.com,
 stefanha@redhat.com, jsnow@redhat.com, rth@twiddle.net, kwolf@redhat.com,
 andrew@aj.id.au, claudio.fontana@suse.com, crwulff@gmail.com,
 laurent@vivier.eu, sundeep.lkml@gmail.com, michael@walle.cc,
 qemu-ppc@nongnu.org, kbastian@mail.uni-paderborn.de, imammedo@redhat.com,
 fam@euphon.net, peter.maydell@linaro.org, david@redhat.com, palmer@sifive.com,
 keith.busch@intel.com, jcmvbkbc@gmail.com, hare@suse.com,
 sstabellini@kernel.org, andrew.smirnov@gmail.com, deller@gmx.de,
 magnus.damm@gmail.com, atar4qemu@gmail.com, minyard@acm.org, sw@weilnetz.de,
 yuval.shaia@oracle.com, qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 peter.chubb@nicta.com.au, clg@kaod.org, shorne@gmail.com,
 qemu-riscv@nongnu.org, i.mitsyanko@gmail.com, cohuck@redhat.com,
 amarkovic@wavecomp.com, jan.kiszka@web.de, aurelien@aurel32.net,
 pburton@wavecomp.com, sagark@eecs.berkeley.edu, jasowang@redhat.com,
 kraxel@redhat.com, edgar.iglesias@gmail.com, gxt@mprc.pku.edu.cn,
 robh@kernel.org, lersek@redhat.com, borntraeger@de.ibm.com, joel@jms.id.au,
 antonynpavlov@gmail.com, chouteau@adacore.com, Andrew.Baumann@microsoft.com,
 mreitz@redhat.com, walling@linux.ibm.com, dmitry.fleytman@gmail.com,
 mst@redhat.com, mark.cave-ayland@ilande.co.uk, jslaby@suse.cz, marex@denx.de,
 proljc@gmail.com, marcandre.lureau@redhat.com, alistair@alistair23.me,
 paul.durrant@citrix.com, david@gibson.dropbear.id.au,
 xiaoguangrong.eric@gmail.com, huth@tuxfamily.org, jcd@tribudubois.net,
 stefanb@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 19/08/19 20:28, Paolo Bonzini wrote:
> On 16/08/19 12:12, Thomas Huth wrote:
>> This patch is *huge*, more than 800kB. It keeps being stuck in the the
>> filter of the qemu-s390x list each time you send it. Please:
>>
>> 1) Try to break it up in more digestible pieces, e.g. change only one
>> subsystem at a time (this is also better reviewable by people who are
>> interested in one area)
> 
> This is not really possible, since the patch is basically a
> search-and-replace.  You could perhaps use some magic
> ("DEVICE_MEMOP_ENDIAN" or something like that) to allow a split, but it
> would introduce more complication than anything else.

I'm stupid, at this point of the series it _would_ be possible to split
the patch by subsystem.  Still not sure it would be actually an advantage.

Paolo

> Agreed on the HTML though. :)
> 
> Paolo
> 


