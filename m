Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1895FC432C0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 13:27:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA1882073B
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 13:27:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ckn29b1s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA1882073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53540 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ic8Cs-00056x-3J
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 08:27:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59234)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1ic86l-0001f5-Ce
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 08:20:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1ic86e-0005vW-Pm
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 08:20:46 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53206
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ic86c-0005qP-PM
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 08:20:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575379240;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=lbjTV0DnRk1clJ6fkW/fqgcEnshrujqss2ZXCafQ7C4=;
 b=Ckn29b1snDpog5t3Fzz66+8NywhRXHsmybz3qIH5rCafSpADZ7jTzB5lMmMbVE2zZlTQBd
 cFYNdsy64n+D6sNVp9q86RvVLs6e3RCDYRaFxE5BaIJuu0fjSQeNgNktRRkYcda0HRwqQZ
 p3gUmIj3dk6GhyXtlGaWVPXvoYpXH/4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-68-4kKujdeBPyyW8JqHc-ISTQ-1; Tue, 03 Dec 2019 08:20:37 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 206B18024C8;
 Tue,  3 Dec 2019 13:20:36 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-176.ams2.redhat.com [10.36.116.176])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BCDA05D6AE;
 Tue,  3 Dec 2019 13:20:31 +0000 (UTC)
Subject: Re: [PATCH v2 2/2] travis.yml: Run tcg tests with tci
To: Stefan Weil <sw@weilnetz.de>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, qemu-devel@nongnu.org
References: <20191128153525.2646-1-thuth@redhat.com>
 <20191128153525.2646-3-thuth@redhat.com>
 <672f7c1a-71d6-5dfa-101a-ed3070be0b05@weilnetz.de>
 <bf0e3625-b719-6baf-9148-c9a864ac499f@weilnetz.de>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <d1cd763a-22ea-bdc8-ddf2-597c234a52d0@redhat.com>
Date: Tue, 3 Dec 2019 14:20:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <bf0e3625-b719-6baf-9148-c9a864ac499f@weilnetz.de>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: 4kKujdeBPyyW8JqHc-ISTQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 28/11/2019 22.33, Stefan Weil wrote:
> Am 28.11.19 um 22:06 schrieb Stefan Weil:
> 
>> Am 28.11.19 um 16:35 schrieb Thomas Huth:
>>
>>> So far we only have compile coverage for tci. But since commit
>>> 2f160e0f9797c7522bfd0d09218d0c9340a5137c ("tci: Add implementation
>>> for INDEX_op_ld16u_i64") has been included now, we can also run the
>>> "tcg" and "qtest" tests with tci, so let's enable them in Travis now.
>>> Since we don't gain much additional test coverage by compiling all
>>> targets, and TCI is broken e.g. with the Sparc targets, we also limit
>>
>> As far as I know it is broken with Sparc hosts (not Sparc targets).
>>
>> I tested without limiting the target list on an x86_64 host, and the
>> tests passed.
> 
> 
> Sorry, I have to correct myself: check-qtest-sparc64 fails. I'll examine
> that.

The 32-bit sparc target fails, too - when doing the prom-env-test:

https://travis-ci.com/huth/qemu/jobs/262572937#L7690

 Thomas


