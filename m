Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3912C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 05:45:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C31C20714
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 05:45:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ygvl/bOi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C31C20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jzvwd-0006Xn-R5
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 01:45:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37932)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jzvvu-000678-Iq
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 01:44:18 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40475
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jzvvs-0006SO-F1
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 01:44:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595828654;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=2tW6KTLisg/9PirvQtxka/z08LF+3mDsqLogCMs+fes=;
 b=Ygvl/bOiAgXJtvWj7okn8YRKGZ/B0sjNZabie97FHdlA+yhPpWasJNqbAVg+5dKlzEwQ2S
 CqAaRkrvnqaeQm70w4xmZv86YyxSChAWtlG+horoEQ5UVUhX88exzBck8hSLKThqiMzq1J
 vNcd4SxUyXVJQ65emOZ5k4BWWbn1Osc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-426-n24MVglhOai1gQauPDGvmw-1; Mon, 27 Jul 2020 01:44:12 -0400
X-MC-Unique: n24MVglhOai1gQauPDGvmw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EE486800468;
 Mon, 27 Jul 2020 05:44:10 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-156.ams2.redhat.com [10.36.112.156])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E1B1476216;
 Mon, 27 Jul 2020 05:44:08 +0000 (UTC)
Subject: Re: [PATCH 2/3] cirrus.yml: Compile macOS and FreeBSD with -Werror
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
References: <20200724143220.32751-1-thuth@redhat.com>
 <20200724143220.32751-3-thuth@redhat.com>
 <20200724144651.GG3146350@redhat.com>
 <506e2579-410e-8553-6cbf-508793bb35a0@redhat.com>
 <20200724164901.GO3146350@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <5257b25f-62e8-4585-15f9-87ab5b99cf2d@redhat.com>
Date: Mon, 27 Jul 2020 07:44:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200724164901.GO3146350@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 01:44:14
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 Christian Schoenebeck <qemu_oss@crudebyte.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 24/07/2020 18.49, Daniel P. Berrangé wrote:
> On Fri, Jul 24, 2020 at 06:46:23PM +0200, Philippe Mathieu-Daudé wrote:
>> On 7/24/20 4:46 PM, Daniel P. Berrangé wrote:
>>> On Fri, Jul 24, 2020 at 04:32:19PM +0200, Thomas Huth wrote:
>>>> Compiler warnings currently go unnoticed in our FreeBSD and macOS builds,
>>>> since -Werror is only enabled for Linux and MinGW builds by default. So
>>>> let's enable them here now, too.
>>>> For macOS, that unfortunately means that we have to disable the vnc-sasl
>>>> feature, since this is marked as deprecated in the macOS headers and thus
>>>> generates a lot of deprecation warnings.
>>>
>>> I wonder if its possible to add
>>>
>>> #pragma GCC diagnostic push
>>> #pragma GCC diagnostic ignored "-Wdeprecated"
>>>
>>> ...
>>>
>>> #pragma GCC diagnostic pop
>>>
>>> to silence just one source file ?
>>
>> 3 years ago Peter said:
>>
>> "The awkward part is
>>  that it has to  be in force at the point where the deprecated
>>  function is used, not where it's declared. So you can't just wrap
>>  the #include of the ssl header in pragmas, you'd have to either
>>  do it at every callsite or else over the whole .c file."
> 
> Nearly all our sasl code is isolated in ui/vnc-auth-sasl.c, so we
> can just do pragma push/pop around that entire file.
> 
> There's then just two remaining cases in ui/vnc.c which are
> easy enough to deal with, or we can move the calls out of vnc.c
> into vnc-auth-sasl.c to fully isolate the code

Sounds like it could be done, indeed. But I wonder whether we really
really want to silence the warnings here? We'd hide the information to
the users that sasl is apparently disliked by Apple and might get
removed on macOS in the future.

Maybe we should rather change the "configure" script to disable sasl by
default on macOS unless the user explicitely specified --enable-vnc-sasl ?

 Thomas


