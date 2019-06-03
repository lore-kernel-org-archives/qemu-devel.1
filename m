Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8185C04AB6
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 08:48:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F2CE21726
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 08:48:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F2CE21726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59814 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXida-0001Fq-PA
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 04:48:14 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41683)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hXiak-0007kn-BD
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 04:45:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hXiaj-00067g-7k
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 04:45:18 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45867)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hXiaj-00066O-1n
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 04:45:17 -0400
Received: by mail-wr1-f66.google.com with SMTP id b18so11043078wrq.12
	for <qemu-devel@nongnu.org>; Mon, 03 Jun 2019 01:45:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=ep/WPm7oCg/49oelgoJ0r4t96vsxWW8F+9xv1ZVp84o=;
	b=EUedPtsIIHRXDxMtFxL1XMmuOGYb6TiwhDFafmlx0y2W8m74LmpVWPOiiikQEIeu4T
	4a9ZMdc8A9W2Y5sNq2KuH3OZky3FzL1PY/Ss+349X+pKOhwx9ZPUbbRxB02jAFPo4Yv2
	W3YpEAwu+iJ1p37jSwXooFAJLga9PUOh7oKaq7pAZoHeYskIf3SMCpUKuVwsZjZbaw26
	QulXG1ykDalnsFYDajXL+ViuSp3fQcq+wNxPe1XV7DE7likegf8Izv7Uv19qDBBiJAWD
	DpyrxVbKleMG+Uo0Ts4RPsEqaYKmsBwjhoLOy9aN7/mTwWmtINXRd4r2QtDplYGwrFdK
	4b4g==
X-Gm-Message-State: APjAAAWE3rwNMa1ODL8swlieIcIX5a9CGQyojpUjHmxkAVC7HAT5XlHN
	tfe5wbTyTKzPVGGvHd+ie2MmXXn68AM=
X-Google-Smtp-Source: APXvYqwmomLWbYQDO8xTl3v16dDRqXBPTUuWFswHL3ApayjgsoKeF6mcWZOt7raGtG3CQ+Dp2zYG3w==
X-Received: by 2002:adf:f14a:: with SMTP id y10mr1624773wro.183.1559551515788; 
	Mon, 03 Jun 2019 01:45:15 -0700 (PDT)
Received: from [192.168.1.38] (183.red-88-21-202.staticip.rima-tde.net.
	[88.21.202.183])
	by smtp.gmail.com with ESMTPSA id p2sm4205616wrx.90.2019.06.03.01.45.14
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Mon, 03 Jun 2019 01:45:15 -0700 (PDT)
To: Stafford Horne <shorne@gmail.com>, Markus Armbruster <armbru@redhat.com>
References: <20190529150853.9772-1-armbru@redhat.com>
	<20190529150853.9772-3-armbru@redhat.com>
	<20190531033601.GB3379@lianli.shorne-pla.net>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <30db7d52-b304-da2d-f84d-42a57dc28135@redhat.com>
Date: Mon, 3 Jun 2019 10:45:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190531033601.GB3379@lianli.shorne-pla.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.66
Subject: Re: [Qemu-devel] [PATCH 2/3] MAINTAINERS: Improve section headlines
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/31/19 5:36 AM, Stafford Horne wrote:
> On Wed, May 29, 2019 at 05:08:52PM +0200, Markus Armbruster wrote:
>> When scripts/get_maintainer.pl reports something like
>>
>>     John Doe <jdoe@example.org> (maintainer:Overall)
>>
>> the user is left to wonder *which* of our three "Overall" sections
>> applies.  We have three, one each under "Guest CPU cores (TCG)",
>> "Guest CPU Cores (KVM)", and "Overall usermode emulation".
>>
>> Rename sections under
>>
>> * "Guest CPU cores (TCG)" from "FOO" to "FOO CPU cores (TCG)"
>>
>> * "Guest CPU Cores (KVM)" from "FOO" to "FOO CPU cores (KVM)"
>>
>> * "Guest CPU Cores (Xen)" from "FOO" to "FOO CPU cores (Xen)"
>>
>> * "Architecture support" from "FOO" to "FOO general architecture
>>   support"
>>
>> * "Tiny Code Generator (TCG)" from "FOO target" to "FOO TCG target"
>>
>> While there,
>>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  MAINTAINERS | 78 ++++++++++++++++++++++++++---------------------------
>>  1 file changed, 39 insertions(+), 39 deletions(-)
> 
> ... 
> 
>> -OpenRISC
>> +OpenRISC CPU cores (TCG)
>>  M: Stafford Horne <shorne@gmail.com>
>>  S: Odd Fixes
>>  F: target/openrisc/
>>  F: hw/openrisc/
>>  F: tests/tcg/openrisc/
>>  
> 
> As directories listed there I look over both target/ (TCG?) and hw/.
> Would it be better to be 'OpenRISC general architecture'?

There is a historical separation between target/ and hw/ because they
cover different concepts, and have different maintainers/reviewers.

- target/$arch/ is for TCG/KVM
- hw/ is for machines and their devices
  (some devices are reused by multiple archs)

Although the separation is not always clear (some devices are tied to an
architecture, some architecture instruction directly access devices) I'd
prefer we keep 2 distincts MAINTAINERS sections (keeping you maintainer
of both). This will ease developper with specific background/interests
to volunteer to a particular section.

Regards,

Phil.

