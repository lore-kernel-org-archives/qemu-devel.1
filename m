Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 141D1C35247
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 14:44:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D34CC2082E
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 14:44:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hUN8dQzv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D34CC2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42184 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iycxn-0004nc-3l
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 09:44:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43097)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iycxB-0004Fu-Iw
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 09:43:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iycxA-0005bP-4U
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 09:43:57 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48293
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iycx9-0005Yx-Ti
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 09:43:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580741034;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=zVF5nhhw+MJ52Vw0/wPh4ugRWMlbbZxf/gpyn+Rpph4=;
 b=hUN8dQzvKniwz5BoiG6NB9VDefiRO6pQe2Kp4Byowf9rK2UWZeaqjWkvXs9MHAPOT8s9Tl
 rJGRDL9dOeq1hS+Jd/Y6bwMRxXA+xcEmusR8XLfd11y7RqAdc3KqEFkly8TjGkiAvvKL0F
 gwlicSbQ9uRtxkmuk10LrdpBRJ+M+g8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-372-20kEA4FeMAKqIKx1B3xv8Q-1; Mon, 03 Feb 2020 09:43:51 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 51BB31B18BC2;
 Mon,  3 Feb 2020 14:43:50 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-129.ams2.redhat.com [10.36.116.129])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AF7915C1D8;
 Mon,  3 Feb 2020 14:43:49 +0000 (UTC)
Subject: Re: [PULL 00/13] qtests, kconfig and misc patches
From: Thomas Huth <thuth@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200203123811.8651-1-thuth@redhat.com>
 <CAFEAcA_1KYRA=87k34zCRLqCf1tWHrULGZPcHeKwJZhDUx0=kw@mail.gmail.com>
 <2fd63018-b9f9-ab88-2d65-009c54bb6cf2@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <f108b6c1-9ecd-408a-3248-66d4aad48a71@redhat.com>
Date: Mon, 3 Feb 2020 15:43:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <2fd63018-b9f9-ab88-2d65-009c54bb6cf2@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: 20kEA4FeMAKqIKx1B3xv8Q-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 03/02/2020 15.30, Thomas Huth wrote:
> On 03/02/2020 15.04, Peter Maydell wrote:
>> On Mon, 3 Feb 2020 at 12:38, Thomas Huth <thuth@redhat.com> wrote:
>>>
>>>  Hi Peter,
>>>
>>> the following changes since commit 28db64fce555a03b4ca256d5b6f4290abdfbd9e8:
>>>
>>>   Merge remote-tracking branch 'remotes/stefanha/tags/tracing-pull-request' into staging (2020-01-31 17:37:00 +0000)
>>>
>>> are available in the Git repository at:
>>>
>>>   https://gitlab.com/huth/qemu.git tags/pull-request-2020-02-03
>>>
>>> for you to fetch changes up to 585c138628bbf22ea8e740b2f4f1a3ed0274ebe8:
>>>
>>>   trivial: Remove xenfb_enabled from sysemu.h (2020-02-03 10:33:57 +0100)
>>>
>>> ----------------------------------------------------------------
>>> * Current qtests queue
>>> * Some Kconfig updates
>>> * Some trivial clean-ups here and there
>>> ----------------------------------------------------------------
>>
>> All the incremental rebuilds failed:
>>
>> Linux cam-vm-266 4.15.0-70-generic x86_64
>> From git://git-us.linaro.org/people/pmaydell/qemu-arm
>>    f31160c7d1..f9e931a1d9  staging    -> pmaydell/staging
>> make: Entering directory '/home/petmay01/qemu-for-merges/build/w64'
>> make[1]: Entering directory '/home/petmay01/qemu-for-merges/slirp'
>> make[1]: Nothing to be done for 'all'.
>> make[1]: Leaving directory '/home/petmay01/qemu-for-merges/slirp'
>>   CC      qga/main.o
>>   CC      stubs/machine-init-done.o
>>   CC      stubs/replay-user.o
>>   CC      stubs/semihost.o
>>   CC      qemu-img.o
>>   CC      qemu-io.o
>>   CC      chardev/char.o
>> make: *** No rule to make target
>> '/home/petmay01/qemu-for-merges/hw/bt/Kconfig', needed by
>> 'aarch64-softmmu/config-devices.mak'.  Stop.
>> make: *** Waiting for unfinished jobs....
>>   CC      chardev/char-mux.o
>> make: Leaving directory '/home/petmay01/qemu-for-merges/build/w64'
> 
> Oh, they are still failing??? Why are there still references to
> hw/bt/Kconfig in these config-devices.mak files, I'd expect that they
> would have been regenerated at least once during the past week?

What timestamp do the */config-devices.mak files have on your system?

Could you please also execute a "grep -r bt/Kconfig *" to see whether
there is still anything else stale around?

 Thomas


