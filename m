Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E637C433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 13:33:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCC8722288
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 13:33:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DFNJz+1g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCC8722288
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIXYy-0003U8-Nk
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 09:33:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54806)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1kIXXh-0001q0-A7
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 09:32:13 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:34775
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1kIXXa-0005So-MC
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 09:32:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600263122;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cJ2OqQx5YOP46/GmtnKKU9cO/H0HFH0OSHjkngn66nM=;
 b=DFNJz+1g7zMOgcMt7RrQubKXYpH33sxWMntUKJv7BQxEfD119mKNxS2ulL379E54x+PaKJ
 2T8wOtg+aPZcI6H1rlVVYklL9dCgGPSiX8i+IrL2iFuCPSdtBrxEokqj6ES8huchIkR0jv
 2/h2NlvLerW3DaW5sojA7M9nDPnS8dg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-168-9gW5xU3cPnWJuG8tQLQLYg-1; Wed, 16 Sep 2020 09:31:58 -0400
X-MC-Unique: 9gW5xU3cPnWJuG8tQLQLYg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1F0161800D4A;
 Wed, 16 Sep 2020 13:31:57 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-113-213.ams2.redhat.com
 [10.36.113.213])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D56515C22D;
 Wed, 16 Sep 2020 13:31:55 +0000 (UTC)
Subject: Re: [PATCH RESEND] manual: escape backslashes in "parsed-literal"
 blocks
To: Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu devel list <qemu-devel@nongnu.org>
References: <20200908172111.19072-1-lersek@redhat.com>
 <0bcfea31-36eb-08ba-c450-a7d01910d837@redhat.com>
 <1f8188ed-68b0-3561-462f-0d903a815f38@redhat.com>
 <b631614e-dd4a-1c25-257a-3f28f952fda4@vivier.eu>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <c57984a5-04ee-f836-edcd-ae82fee9c9e6@redhat.com>
Date: Wed, 16 Sep 2020 15:31:54 +0200
MIME-Version: 1.0
In-Reply-To: <b631614e-dd4a-1c25-257a-3f28f952fda4@vivier.eu>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=lersek@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=205.139.110.61; envelope-from=lersek@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 00:53:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09/16/20 10:53, Laurent Vivier wrote:
> Le 15/09/2020 à 09:57, Laszlo Ersek a écrit :
>> On 09/10/20 12:23, Philippe Mathieu-Daudé wrote:
>>> Cc'ing qemu-trivial@
>>
>> Thanks!
>>
>> The patch was posted a week ago (and reviewed as well, by you, thanks!)
>> -- is there something I need to do for getting this merged?
> 
> Applied to my trivial-patches branch.

Awesome, thanks!
Laszlo


