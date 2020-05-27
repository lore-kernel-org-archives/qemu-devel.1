Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 041A5C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 21:55:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7F9A207CB
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 21:55:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kq1TsjJ4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7F9A207CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53328 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1je41Z-0004Xk-Tu
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 17:55:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48292)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1je40a-0003j4-JY
 for qemu-devel@nongnu.org; Wed, 27 May 2020 17:54:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45775
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1je40Y-0001sa-O0
 for qemu-devel@nongnu.org; Wed, 27 May 2020 17:54:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590616478;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8LIG6MeffebLl7tbw7y3dbZeMD4wr/6DOPFSIdE4Etc=;
 b=Kq1TsjJ4I83Olg4kj6Qrc0EcEKsY/cWdM4OwCSk5C5mT5wA0aHhOQy0Gp3S7UrFNP+uoFi
 p/6Azeg2La4ry9MCHABfzqvYZ2wsLyr4J2suQOFiSP/50ajod8hBe0Q+JOucTMxh93cfyF
 5yhIXvdK7cxC+i0eiIG2akCaJj0ga8E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-196-B72HsHzrPAavzwn0nuZxaw-1; Wed, 27 May 2020 17:54:33 -0400
X-MC-Unique: B72HsHzrPAavzwn0nuZxaw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DB6C71009616;
 Wed, 27 May 2020 21:54:32 +0000 (UTC)
Received: from [10.3.112.88] (ovpn-112-88.phx2.redhat.com [10.3.112.88])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 979C7620AF;
 Wed, 27 May 2020 21:54:32 +0000 (UTC)
Subject: Re: [Bug 1881004] [NEW] fpu/softfloat.c: error: bitwise negation of a
 boolean expression
To: Peter Maydell <peter.maydell@linaro.org>,
 Bug 1881004 <1881004@bugs.launchpad.net>
References: <159060681483.5838.13632051970488338647.malonedeb@wampee.canonical.com>
 <CAFEAcA_NTEUoWfqpG9uhPY0pE697F-_MDLNexq75k0tYdEuuYg@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <ee41069e-5e6f-d4f5-22ed-795deb4b7ba5@redhat.com>
Date: Wed, 27 May 2020 16:54:31 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_NTEUoWfqpG9uhPY0pE697F-_MDLNexq75k0tYdEuuYg@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/27 00:49:35
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

On 5/27/20 4:40 PM, Peter Maydell wrote:
> On Wed, 27 May 2020 at 20:21, Philippe Mathieu-Daudé
> <1881004@bugs.launchpad.net> wrote:
>>
>> Public bug reported:
>>
>> Last time I built QEMU was on commit d5c75ec500d96f1d93447f990cd5a4ef5ba27fae,
>> I just pulled to fea8f3ed739536fca027cf56af7f5576f37ef9cd and now get:
>>
>>    CC      lm32-softmmu/fpu/softfloat.o
>> fpu/softfloat.c:3365:13: error: bitwise negation of a boolean expression; did you mean logical negation? [-Werror,-Wbool-operation]
>>      absZ &= ~ ( ( ( roundBits ^ 0x40 ) == 0 ) & roundNearestEven );
>>              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>              !
> 
> 
> "(x & y)" is not a boolean expression, so we should report this to clang
> as a bug (I assume what they actually are trying to complain about is
> bitwise AND with a boolean expression).

We have:

uint64_t &= ~ ( ( ( int8_t ^ int ) == int ) & bool )

which is

uint64_t &= ~ ( bool & bool )

which is then

uint64_t &= ~ ( int )

resulting in one of:

uint64_t &= 0xffffffffffffffff
uint64_t &= 0xfffffffffffffffe

It is a very odd way of stating that 'if this condition is true, mask 
out the least-significant-bit'.  In general, 'bool & bool' is used where 
the side-effect-skipping 'bool && bool' is inappropriate; I'm a bit 
surprised that clang is not questioning whether we meant '&&' instead of 
'&' (the two operators give the same effect in this case).

You are right that clang is fishy for calling it logical negation of a 
bool, when it is really logical negation of an int, but we are also 
fishy in that we are using bitwise AND of two bools as an int in the 
first place.

Regardless of whether clang changes, would it be better to write the 
code as:

if (((roundBits ^ 0x40) == 0) && roundNearestEven) {
     absZ &= ~1;
}

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


