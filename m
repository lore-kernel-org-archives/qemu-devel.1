Return-Path: <SRS0=E5X6=CV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49E96C43461
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2020 07:04:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EA432074B
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2020 07:04:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z7YMnBNw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EA432074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33212 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGza1-00075l-HM
	for qemu-devel@archiver.kernel.org; Sat, 12 Sep 2020 03:04:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59686)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kGzZM-0006ev-TF
 for qemu-devel@nongnu.org; Sat, 12 Sep 2020 03:03:33 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:24816
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kGzZK-0000GB-JD
 for qemu-devel@nongnu.org; Sat, 12 Sep 2020 03:03:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599894209;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JWbkKFRK90lTTYBDovaHmgK85HS5xnGkkXwtvr7nHJ0=;
 b=Z7YMnBNwUtWnYzzUdUdWNKPfl4yC5JaoJswbQW5PKj22yXhAjB6S7Sd6KZjo8pEhRg/4ID
 /ZoW8fGKo36cyTOXlz7WE9vNIpHt2Ue3P526c4osgGy6ExVZvaLuqxwZZAr+xFPiDmbbgD
 zlrlPycL+ehAZueJAkSqN+dv/qrO63s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-388-bKGkRTI1MOCArHLmjO5p7g-1; Sat, 12 Sep 2020 03:03:27 -0400
X-MC-Unique: bKGkRTI1MOCArHLmjO5p7g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1E70B8030A3;
 Sat, 12 Sep 2020 07:03:26 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-6.ams2.redhat.com [10.36.112.6])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 68BDC7A414;
 Sat, 12 Sep 2020 07:03:25 +0000 (UTC)
Subject: Re: qemu disassembler status
To: Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel <qemu-devel@nongnu.org>
References: <CAFEAcA8yfPdJLmek=+1VOWY4DQGP0yhmbtTiARw+qMuENKet+w@mail.gmail.com>
 <bb48e978-71e3-8ea8-44da-36c7d540ec1b@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <952fa7ef-a4b8-3945-dfe7-803cbdc35834@redhat.com>
Date: Sat, 12 Sep 2020 09:03:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <bb48e978-71e3-8ea8-44da-36c7d540ec1b@linaro.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=205.139.110.61; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/12 02:25:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.469, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/09/2020 23.50, Richard Henderson wrote:
> Taking this to the mailing list, since there are others who have expressed
> interest in the topic.
> 
> 
> On 9/7/20 11:36 AM, Peter Maydell wrote:
>> Hi; I have a feeling we've discussed this on irc at some point
>> in the past, but I've forgotten the details, so I figured if I
>> wrote an email I might be able to find it again later...
>>
>> So, currently we have:
>>  * some disassemblers in the tree (old binutils, and some other
>>    things)
>>  * in particular one of those is the aarch64 libvixl, which is
>>    3rd-party code that we occasionally manually import/update
>>  * capstone, which is a submodule
>>
>> Am I right in thinking that you've suggested that ideally we should
>> use libllvm directly as our disassembler (with the hope that that
>> will have better coverage of different architectures and be more
>> up-to-date than capstone)?
> 
> I've spent a couple of days poking at the llvm disassembler.
> 
> As a general-purpose disassembler, it's less than ideal.
> 
> (1) The disassembler is not "inclusive".  You present it with
>     a specific cpu configuration, and anything that cpu does
>     not support is considered invalid.  There is no "maximum"
>     configuration that attempts to decode any insn in the ISA.
> 
> (2) All configuration is done via strings, so you can't
>     programatically tell what's supported.  I think they're
>     expecting all of these strings to come from the
>     command line.
> 
> (3) If you include a unrecognized cpu feature, an error is
>     printed to stderr.  Which suggests that we would easily
>     wind up with problems between llvm versions.
> 
> (4) "Probing" what is supported with a particular version is
>     done via "+help", which prints what is supported to stdout.

Ouch, that sounds ugly, indeed.

> In the short-term, I guess I'll look into updating our capstone branch.  And
> possibly reject using the system version -- either use the git submodule or
> nothing.

Sounds like the best option right now.

Is capstone good enough already to replace libvixl?

And what about the other old disassemblers that we have in disasm/ ?
Could some of them be replaced by capstone, too?
Or shall we try to pursue the idea of adding a GPLv3 helper program that
could link against recent versions of libopcode?

And what about new disassembler files like the Loongson 2F disassembler
that has been proposed two months ago? Shall we enforce that people try
to add such stuff to capstone first?

 Thomas


