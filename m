Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 795B9C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 06:21:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41B1C20657
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 06:21:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QVS2b0tW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41B1C20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeBuq-00044X-FF
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 02:21:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40708)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jeBuJ-0003e9-AC
 for qemu-devel@nongnu.org; Thu, 28 May 2020 02:20:47 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25248
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jeBuH-00012w-QA
 for qemu-devel@nongnu.org; Thu, 28 May 2020 02:20:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590646844;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=BPPV6MVIo09CHS7kyDnrg+Nqfof+BQqAMX0ZioVQWG4=;
 b=QVS2b0tWaZwe6KGi6dcs9Vr6kUYkBCavI6/nGIvFiroURf70k2Xuh5YJXHR+a9leE38R0P
 83XFdRWEpnG9epGu5CildWc1UC+47LHcZ+uXx4Ew2hJvdGDo1Dan9dX1agVFNJDsNGhxTl
 xmIYrJ8x0e/zFwCPGoP6a/PaKkWktV4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-426-XYWRNkyTOK6twNI2YQ4ElA-1; Thu, 28 May 2020 02:20:40 -0400
X-MC-Unique: XYWRNkyTOK6twNI2YQ4ElA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9BC1080572F;
 Thu, 28 May 2020 06:20:39 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-213.ams2.redhat.com [10.36.112.213])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B84CC60C81;
 Thu, 28 May 2020 06:20:37 +0000 (UTC)
Subject: Re: [Bug 1881004] [NEW] fpu/softfloat.c: error: bitwise negation of a
 boolean expression
To: Eric Blake <eblake@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Bug 1881004 <1881004@bugs.launchpad.net>
References: <159060681483.5838.13632051970488338647.malonedeb@wampee.canonical.com>
 <CAFEAcA_NTEUoWfqpG9uhPY0pE697F-_MDLNexq75k0tYdEuuYg@mail.gmail.com>
 <ee41069e-5e6f-d4f5-22ed-795deb4b7ba5@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <f660e0fc-d33a-e09e-4101-c5d112f889ef@redhat.com>
Date: Thu, 28 May 2020 08:20:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <ee41069e-5e6f-d4f5-22ed-795deb4b7ba5@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 01:51:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 27/05/2020 23.54, Eric Blake wrote:
> On 5/27/20 4:40 PM, Peter Maydell wrote:
>> On Wed, 27 May 2020 at 20:21, Philippe Mathieu-Daudé
>> <1881004@bugs.launchpad.net> wrote:
>>>
>>> Public bug reported:
>>>
>>> Last time I built QEMU was on commit
>>> d5c75ec500d96f1d93447f990cd5a4ef5ba27fae,
>>> I just pulled to fea8f3ed739536fca027cf56af7f5576f37ef9cd and now get:
>>>
>>>    CC      lm32-softmmu/fpu/softfloat.o
>>> fpu/softfloat.c:3365:13: error: bitwise negation of a boolean
>>> expression; did you mean logical negation? [-Werror,-Wbool-operation]
>>>      absZ &= ~ ( ( ( roundBits ^ 0x40 ) == 0 ) & roundNearestEven );
>>>              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>              !
>>
>>
>> "(x & y)" is not a boolean expression, so we should report this to clang
>> as a bug (I assume what they actually are trying to complain about is
>> bitwise AND with a boolean expression).
> 
> We have:
> 
> uint64_t &= ~ ( ( ( int8_t ^ int ) == int ) & bool )
> 
> which is
> 
> uint64_t &= ~ ( bool & bool )
> 
> which is then
> 
> uint64_t &= ~ ( int )
> 
> resulting in one of:
> 
> uint64_t &= 0xffffffffffffffff
> uint64_t &= 0xfffffffffffffffe
> 
> It is a very odd way of stating that 'if this condition is true, mask
> out the least-significant-bit'.  In general, 'bool & bool' is used where
> the side-effect-skipping 'bool && bool' is inappropriate; I'm a bit
> surprised that clang is not questioning whether we meant '&&' instead of
> '&' (the two operators give the same effect in this case).
> 
> You are right that clang is fishy for calling it logical negation of a
> bool, when it is really logical negation of an int, but we are also
> fishy in that we are using bitwise AND of two bools as an int in the
> first place.
> 
> Regardless of whether clang changes, would it be better to write the
> code as:
> 
> if (((roundBits ^ 0x40) == 0) && roundNearestEven) {
>     absZ &= ~1;
> }

I agree, that's also much better to read.
And FWIW, WinUAE fixed a similar problem in the same way recently:

 https://github.com/tonioni/WinUAE/commit/51f5e7bfc39cf37daf7283

So I think this is the right way to go. Could you send your suggestion
as a proper patch?

 Thanks,
  Thomas


