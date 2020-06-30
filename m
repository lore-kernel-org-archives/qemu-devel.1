Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5FC6C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 20:21:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B9E8206B6
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 20:21:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DYBbMDjq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B9E8206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60302 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqMkd-000504-QL
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 16:21:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58696)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jqMjs-0004U5-2p
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 16:20:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58865
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jqMjp-0007W5-I6
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 16:20:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593548415;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2vANeyoxKQOcESL4W/943DWDT/9HkfBmmtSx8GYVx50=;
 b=DYBbMDjq9DzlgfptCalQc0hMRspNf5dh7fv/9dLJPPNBMwA3jupxqw2QJHTQuP3S1qPavg
 gV1BBCDGIkHM5vpbzgCdG4eSBz2PMgt2uWMD2aYEZOZC1CgWp53JsFfgsOJglW8thqbsZg
 zY447uno9vqvguuawWmvl+q5s80ucB4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-132-96lLimHyPyG2scepeufolA-1; Tue, 30 Jun 2020 16:20:10 -0400
X-MC-Unique: 96lLimHyPyG2scepeufolA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2082818B5FC8;
 Tue, 30 Jun 2020 20:19:59 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-51.ams2.redhat.com [10.36.112.51])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E40815F7D8;
 Tue, 30 Jun 2020 20:19:55 +0000 (UTC)
Subject: Re: [PATCH v2 0/6] hw/mips/malta: Add the 'malta-strict' machine,
 matching Malta hardware
To: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
References: <20200630145236.27529-1-f4bug@amsat.org>
 <CAHiYmc4=pmzEyhVTHaqxBnCotE8V+vaptMFincyurvAyDHNn6g@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <2d116426-3323-7429-ff41-7f6b9a9f1c55@redhat.com>
Date: Tue, 30 Jun 2020 22:19:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAHiYmc4=pmzEyhVTHaqxBnCotE8V+vaptMFincyurvAyDHNn6g@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 03:55:26
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Yunqiang Su <ysu@wavecomp.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 30/06/2020 17.38, Aleksandar Markovic wrote:
> уто, 30. јун 2020. у 16:52 Philippe Mathieu-Daudé <f4bug@amsat.org> је
> написао/ла:
>>
>> Hi,
>>
>> This series add a new 'malta-strict' machine, that aims to properly
>> model the real hardware (which is not what the current 'malta'
>> machine models).
>>
>> As a bonus for Debian builders, a 'malta-unleashed' machine RFC
>> patch is included. This might start another endless discussion
>> upstream, but this is not the point of, so I still include it
>> for people to test. The rest of the series is candidate for merging
>> in mainstream QEMU.
>>
>> Philippe Mathieu-Daudé (6):
>>    hw/mips/malta: Trivial code movement
>>    hw/mips/malta: Register the machine as a TypeInfo
>>    hw/mips/malta: Introduce MaltaMachineClass::max_ramsize
>>    hw/mips/malta: Introduce the 'malta-strict' machine
>>    hw/mips/malta: Verify malta-strict machine uses correct DIMM sizes
>>    hw/mips/malta: Introduce the 'malta-unleashed' 64-bit machine
>>
>>   hw/mips/malta.c | 125 ++++++++++++++++++++++++++++++++++++++++++------
>>   1 file changed, 111 insertions(+), 14 deletions(-)
>>
>> --
> 
> This whole series is based on idea of emulating physically
> non-existing feature, and as such violates the fundamental principles
> of QEMU.
> 
> As such, not acceptable for upstreaming.

  Hi Aleksandar,

could you please point me to the spot where we declare this "fundamental 
principle" of QEMU? Sorry, but I must have missed this piece of 
information so far. And could you please enlighten me what we should do 
now with virtio, since most of these devices also are physically 
non-existent?

  Thanks,
   Thomas


