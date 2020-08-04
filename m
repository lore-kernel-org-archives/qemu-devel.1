Return-Path: <SRS0=UEgn=BO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C12DC433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 06:46:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 909B620781
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 06:46:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RSKlLfE8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 909B620781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42094 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2qi2-0000wh-Np
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 02:46:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59072)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1k2qgC-0007qw-Vl
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 02:44:08 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:51793
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1k2qgB-0004RW-6K
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 02:44:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596523445;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=VRKQjNycTLk6MRq069WMAUC3CntBZ2yQ+4uXvNElRig=;
 b=RSKlLfE8hlyh9hMVauF3rsEf7cOykJ6A91ElhCxSThA6DoR8HBorlBk01LeGE6Qbz9pWhl
 JXgNED+hstwD85sgv5KQvPgOZlhoGes8hd7c8j67s/pay0fUv8zt+HJRkviB464mlaX4bb
 bWbVpJ4m0ou9eevLiOesPNi+RZaRxp8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-461-0EKjGjCyOeiCItar_gD5ew-1; Tue, 04 Aug 2020 02:44:04 -0400
X-MC-Unique: 0EKjGjCyOeiCItar_gD5ew-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7BA201005504;
 Tue,  4 Aug 2020 06:44:02 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-162.ams2.redhat.com [10.36.112.162])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3E4C87176B;
 Tue,  4 Aug 2020 06:43:58 +0000 (UTC)
Subject: Re: [PATCH v2 0/3] testing: Build WHPX enabled binaries
To: Stefan Weil <sw@weilnetz.de>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@redhat.com>, Sunil Muthuswamy <sunilmut@microsoft.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <20190920113329.16787-1-philmd@redhat.com>
 <01f2f0ee-a288-921a-58f4-78aeb4d457e1@redhat.com>
 <BYAPR21MB1208F0D09B3E5CA80F1B7C3BB6880@BYAPR21MB1208.namprd21.prod.outlook.com>
 <2acf854f-c49a-0811-31af-80e1e958f058@redhat.com>
 <324f5002-be0a-563e-b5a6-e08ee5e1ddad@redhat.com>
 <SN4PR2101MB0880AF5A5D752F06DB94A15FC04E0@SN4PR2101MB0880.namprd21.prod.outlook.com>
 <b8afd626-b6ae-d6fa-c8b7-5e5778574c07@redhat.com>
 <82fa39b2-676c-e8c5-72c6-53123983dcda@weilnetz.de>
 <55002560-9741-1e71-85f9-e75d9f0f3bfc@weilnetz.de>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <fde8dd22-679a-be5e-b36e-d8aeb7e955cc@redhat.com>
Date: Tue, 4 Aug 2020 08:43:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <55002560-9741-1e71-85f9-e75d9f0f3bfc@weilnetz.de>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/04 01:01:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "1879672@bugs.launchpad.net" <1879672@bugs.launchpad.net>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 03/08/2020 22.25, Stefan Weil wrote:
> Am 03.08.20 um 13:28 schrieb Stefan Weil:
> 
>> Am 03.08.20 um 12:51 schrieb Philippe Mathieu-Daudé:
>>
>>> Hi Sunil,
>>>
>>> On 8/1/20 1:31 AM, Sunil Muthuswamy wrote:
>>>> The ask generally sounds reasonable. But, can you help me understand the full
>>>> scope of the ask. Few questions:
>>>> 1. Stefan has a CI pipeline to build WHPX.
>>> Great! I didn't know Stefan already did it :)
>>> Can you share the URL please, so we can integrate it with mainstream CI?
>>
>> I am sorry, but I don't have such a CI pipeline.
>>
>> Stefan
> 
> 
> We can add a CI pipeline on Microsoft infrastructure by using a GitHub
> action.

Sorry for being ignorant, but how does that solve the legal questions
just because it is running on GitHub instead of a different CI?

 Thomas


