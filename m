Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD44FC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 10:07:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7129206B7
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 10:07:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MMZ6I5lI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7129206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joOn3-0003LY-V7
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 06:07:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59490)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1joOmL-0002UB-1E
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 06:06:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25467
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1joOmI-0002FT-LM
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 06:06:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593079601;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cPM8hmQFimJ3RIWgoZeGaQYHU2Bgjbg+ZoiuxRT969A=;
 b=MMZ6I5lIGMmJUZbOdzJI12LJe4v1loEdZLgNuDSWO/hbMg76f7i2R2EXzrn+vzgXTW946F
 WY3sLvRzKl4L1+bdutASUqV1tY8J7QLgjA1Bq8sGcy2Kwg/FFNXY8LvlmECoIwVb87yn1y
 v1Ls4wdNjF1hREqxCL8uBdBwxzhT3Hk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-158-5SuLjG8aNzihclL0Obnuxg-1; Thu, 25 Jun 2020 06:06:38 -0400
X-MC-Unique: 5SuLjG8aNzihclL0Obnuxg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9ECEF1800D4A;
 Thu, 25 Jun 2020 10:06:36 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-150.ams2.redhat.com [10.36.112.150])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7C10D5BACC;
 Thu, 25 Jun 2020 10:06:31 +0000 (UTC)
Subject: Re: [PULL 07/15] hw/timer: RX62N 8-Bit timer (TMR)
To: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
References: <20200621124807.17226-1-f4bug@amsat.org>
 <20200621124807.17226-8-f4bug@amsat.org>
 <CAFEAcA8c2dywr=Zxz1ExAV-48JwFU5vbBDDfA=_KE98XamnXiA@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <b0ed03f2-55b9-43a9-32fb-acd6637114cd@redhat.com>
Date: Thu, 25 Jun 2020 12:06:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8c2dywr=Zxz1ExAV-48JwFU5vbBDDfA=_KE98XamnXiA@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 00:45:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>,
 Richard Henderson <richard.henderson@linaro.org>,
 Magnus Damm <magnus.damm@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 25/06/2020 11.25, Peter Maydell wrote:
[...]
>> +static uint64_t tmr_read(void *opaque, hwaddr addr, unsigned size)
>> +{
> 
> In this function Coverity reports a missing "break" (CID 1429977):
> 
>> +    case A_TCORA:
>> +        if (size == 1) {
>> +            return tmr->tcora[ch];
>> +        } else if (ch == 0) {
>> +            return concat_reg(tmr->tcora);
>> +        }
> 
> Here execution can fall through but there is no 'break' or '/* fallthrough */'.

Should we maybe start compiling with -Wimplicit-fallthrough if the 
compiler supports it, so that we do not always catch these problems 
after they have been merged?

  Thomas


