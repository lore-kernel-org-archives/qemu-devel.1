Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6227AC3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 18:29:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A434218BA
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 18:29:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A434218BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzmPL-0002dD-EE
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 14:29:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57136)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1hzmOf-0001zv-4o
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 14:28:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hzmOe-0005Ls-2l
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 14:28:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56906)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hzmOd-0005L3-QM
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 14:28:48 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D74F4811D8
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2019 18:28:46 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id o13so5624174wrx.20
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2019 11:28:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=V4/aFq6DDEPmRVpJY8yCxsJYN8Z3oDBG76SrumSRDN4=;
 b=MvY+jEL5FRbRW9ENdpSsnnyhIlDWa+9jAcj9jfYrn/qDXXRpxbUkRdEUTh/smh8ae0
 KD3TIWcDUf9agfKnKtkjcBmKsUHJaUipUCzGS1meTNeyqog9A2SvNqTQucQJyGThaQU4
 DboFHuDmHkLmSOp0nplEh9Pk6dTINmd+1kK3mXnC77uD2UJl6ZEKuPJojOTgF199tQrg
 qjeXD/VGjYUBF2H0Ik+9jcpslQpOZY/BVhJjr4B5uYx0VoSy4lFIkUdcWMUUjtNoFuyx
 4nY9VYdAKD53e/EHqIaT5Sw4NdZxgTjplaN2JzwDcAIhSugSB6vJO1L1h8mgB8GRUili
 UU0A==
X-Gm-Message-State: APjAAAWhkTvNcu1pEYeCwZ0hLZfPUQZ+hTD4I2bh5q+BX3kTCEgWpILi
 qMSbwjqS8BvLn0FntLnWUduAmSmOg8S7XLuVVqOY3BWHnLCCkfFo5J2uV+Rko0sD8nUVbYKp241
 CkIjWZeNpjKbM/Ko=
X-Received: by 2002:adf:8364:: with SMTP id 91mr29003165wrd.13.1566239325377; 
 Mon, 19 Aug 2019 11:28:45 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxUtjtGjGnkBVkOZjVo/50Uby5R91gtIkNP9G8lQQx5CBDC3ajHH42W8ebY9hYyiOtnQTbC1A==
X-Received: by 2002:adf:8364:: with SMTP id 91mr29003101wrd.13.1566239325062; 
 Mon, 19 Aug 2019 11:28:45 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:399c:411e:1ccb:f240?
 ([2001:b07:6468:f312:399c:411e:1ccb:f240])
 by smtp.gmail.com with ESMTPSA id f7sm21779124wrf.8.2019.08.19.11.28.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Aug 2019 11:28:44 -0700 (PDT)
To: Thomas Huth <thuth@redhat.com>, tony.nguyen@bt.com, qemu-devel@nongnu.org
References: <43bc5e07ac614d0e8e740bf6007ff77b@tpw09926dag18e.domain1.systemhost.net>
 <1565941032362.60179@bt.com>
 <1b5f5a92-1b75-f0d9-d7bc-4605094ad8e7@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <8d8b37c9-3daf-d241-df92-1a5467bca451@redhat.com>
Date: Mon, 19 Aug 2019 20:28:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1b5f5a92-1b75-f0d9-d7bc-4605094ad8e7@redhat.com>
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

On 16/08/19 12:12, Thomas Huth wrote:
> This patch is *huge*, more than 800kB. It keeps being stuck in the the
> filter of the qemu-s390x list each time you send it. Please:
> 
> 1) Try to break it up in more digestible pieces, e.g. change only one
> subsystem at a time (this is also better reviewable by people who are
> interested in one area)

This is not really possible, since the patch is basically a
search-and-replace.  You could perhaps use some magic
("DEVICE_MEMOP_ENDIAN" or something like that) to allow a split, but it
would introduce more complication than anything else.

Agreed on the HTML though. :)

Paolo

