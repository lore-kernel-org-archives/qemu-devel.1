Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D261C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 15:03:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5638120767
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 15:03:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KsK2QX6f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5638120767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50534 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtuZ8-0008CV-M8
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 11:03:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51078)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jtuYL-0007kC-T9
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 11:03:05 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:46720
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jtuYI-0001Ls-Rc
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 11:03:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594393381;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=+OQPw2ChStzUjSi/mO/qobdEDqc6x66take7ub40Nrw=;
 b=KsK2QX6f7sfqTR457WD8KFB2RF/iPyJAJu8Zw/X5xqDn4CzsjbCciwvaxKGwWV5QDYYBeE
 d6pMrhuWoYuuRcEyQgfwbqS+nrQuZ4t5SyNNHuXHsDu9aUZaaOJmeDA5LHtle1DmFrPquQ
 69HQVJbCfpdDA0GYOigUo2mTaLnOAkc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-48-aM30Mz4gOFqHPFDzQVfxAA-1; Fri, 10 Jul 2020 11:02:59 -0400
X-MC-Unique: aM30Mz4gOFqHPFDzQVfxAA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AD0BE1932484;
 Fri, 10 Jul 2020 15:02:57 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-68.ams2.redhat.com [10.36.112.68])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C50E07EF93;
 Fri, 10 Jul 2020 15:02:37 +0000 (UTC)
Subject: Re: [PULL 00/32] AVR port
To: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
References: <20200707181710.30950-1-f4bug@amsat.org>
 <CAFEAcA85TE+W39fphhm77hNKmAJyEMmaTseDkL1t4gTkzzcbJQ@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <47ca6b92-cedb-a6c4-754b-b7cd5da597e7@redhat.com>
Date: Fri, 10 Jul 2020 17:02:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA85TE+W39fphhm77hNKmAJyEMmaTseDkL1t4gTkzzcbJQ@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/09 22:08:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Laurent Vivier <lvivier@redhat.com>, Sarah Harris <S.E.Harris@kent.ac.uk>,
 Eduardo Habkost <ehabkost@redhat.com>, Thomas Huth <huth@tuxfamily.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Michael Rolnik <mrolnik@gmail.com>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/07/2020 13.41, Peter Maydell wrote:
> On Tue, 7 Jul 2020 at 19:19, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>>
>> Possible false-positives from checkpatch:
>>
>>   WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
>>
>> The following changes since commit 7623b5ba017f61de5d7c2bba12c6feb3d55091b1:
>>
>>   Merge remote-tracking branch 'remotes/vivier2/tags/linux-user-for-5.1-pull-=
>> request' into staging (2020-07-06 11:40:10 +0100)
>>
>> are available in the Git repository at:
>>
>>   https://gitlab.com/philmd/qemu.git tags/avr-port-20200707
>>
>> for you to fetch changes up to 0cdaf2f343491f60dbf7dd2a912cd88b5f9f899c:
>>
>>   target/avr/disas: Fix store instructions display order (2020-07-07 20:14:15=
>>  +0200)
>>
>> ----------------------------------------------------------------
>> 8bit AVR port from Michael Rolnik.
>>
>> Michael started to work on the AVR port few years ago [*] and kept
>> improving the code over various series.
> 
> Hi; I'm afraid this fails "make check" on big-endian hosts (s390x, ppc64):
> 
> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> QTEST_QEMU_BINARY=avr-softmmu/qemu-system-avr QTEST_QEMU_IMG=qemu-img
> tests/qtest/boot-serial-test -m=quick -k --tap < /dev/null |
> ./scripts/tap-driver.pl --test-name="boot-serial-test"
> qemu-system-avr: execution left flash memory
> 
> ** (tests/qtest/boot-serial-test:24048): ERROR **: 11:00:46.466:
> Failed to find expected string. Please check
> '/tmp/qtest-boot-serial-sVGEXHI'
> ERROR - Bail out! FATAL-ERROR: Failed to find expected string. Please
> check '/tmp/qtest-boot-serial-sVGEXHI'

Endianess bug ... this should fix it:

diff --git a/target/avr/helper.c b/target/avr/helper.c
--- a/target/avr/helper.c
+++ b/target/avr/helper.c
@@ -337,6 +337,7 @@ void helper_fullwr(CPUAVRState *env, uint32_t data,
uint32_t addr)
         helper_outb(env, addr - NUMBER_OF_CPU_REGISTERS, data);
     } else {
         /* memory */
-        cpu_physical_memory_write(OFFSET_DATA + addr, &data, 1);
+        uint8_t data8 = data;
+        cpu_physical_memory_write(OFFSET_DATA + addr, &data8, 1);
     }
 }

 Thomas


