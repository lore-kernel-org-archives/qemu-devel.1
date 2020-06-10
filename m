Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57856C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 11:18:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2184B2072E
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 11:18:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JA4TsMLV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2184B2072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiykM-0004ci-Cd
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 07:18:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36988)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jiyjB-000443-C6
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 07:17:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22825
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jiyj9-0003Ho-Dq
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 07:17:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591787822;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=ys+PWd2yjACemWlK/1sgYBE5TeJe7QO3+VKV0SkagRk=;
 b=JA4TsMLVadoNjDb3yNuiB1nIvqq9dU7WnKdDsjJFeG4zLzWTLFEPqO/LCOqq4YrXtxI9m0
 iq81u6dICLAsW9HEF0M98gheYw0tIv+pqpZFrs7pXoUOjgWj3+/ceAUnIITJAoVjBcL6Pz
 qXjW53e9m28oTdyZCgXwMo07uOUDe6c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-386-N9KIN_PVPgW2CeYqwK2foA-1; Wed, 10 Jun 2020 07:16:57 -0400
X-MC-Unique: N9KIN_PVPgW2CeYqwK2foA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6E744107B000;
 Wed, 10 Jun 2020 11:16:55 +0000 (UTC)
Received: from thuth.remote.csb (unknown [10.40.192.19])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 76AF45D9D3;
 Wed, 10 Jun 2020 11:16:49 +0000 (UTC)
Subject: Re: [PATCH v2 1/8] MAINTAINERS: Mark SH4 hardware orphan
To: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
References: <20200608090142.6793-1-f4bug@amsat.org>
 <20200608090142.6793-2-f4bug@amsat.org>
 <CAHiYmc5UUaSKB6Ee0ds_hj0FBTzt0iLxzNWySt0mcZ9dvtZNyA@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <5712d31d-93b1-4254-893a-93c2fc7e6502@redhat.com>
Date: Wed, 10 Jun 2020 13:16:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAHiYmc5UUaSKB6Ee0ds_hj0FBTzt0iLxzNWySt0mcZ9dvtZNyA@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 23:51:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Fam Zheng <fam@euphon.net>, Yoshinori Sato <ysato@users.sourceforge.jp>,
 qemu-trivial@nongnu.org, Magnus Damm <magnus.damm@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>, QEMU Developers <qemu-devel@nongnu.org>,
 Laurent Vivier <laurent@vivier.eu>, Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/06/2020 13.08, Aleksandar Markovic wrote:
> пон, 8. јун 2020. у 11:05 Philippe Mathieu-Daudé <f4bug@amsat.org> је
> написао/ла:
>>
>> Aurelien Jarno expressed his desire to orphan the SH4 hardware [*]:
>>
>>   I don't mind being [...] removed from there.
>>   I do not really have time to work on that.
>>
>> Mark the SH4 emulated hardware orphan.
>>
>> Many thanks to Aurelien for his substantial contributions to QEMU,
>> and for maintaining the SH4 hardware for various years!
>>
>> [*] https://www.mail-archive.com/qemu-devel@nongnu.org/msg708400.html
>>
>> Message-Id: <20200601214125.GA1924990@aurel32.net>
>> Acked-by: Aurelien Jarno <aurelien@aurel32.net>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
> 
> The basic idea of the patch (as read from the title and the commit
> message) is good and positive.
> 
> The problem is that the patch does something different than the commit
> message says - pretending that it just orphans something. Which is not
> good. Actually, very clumsy and bad.

Aleksandar, could you please stop being so negative? If you've got
issues with a patch, that's fair, but you can then also simply express
your opinion in a professional and constructive way. Calling the work of
someone else "clumsy" is really not something that I want to read on the
qemu-devel mailing list.

 Thanks,
  Thomas


