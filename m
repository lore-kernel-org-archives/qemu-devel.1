Return-Path: <SRS0=3HrQ=6A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E50DC2BA2B
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 06:03:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 361C52076A
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 06:03:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cXkS9udN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 361C52076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58278 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOxc7-000835-Ar
	for qemu-devel@archiver.kernel.org; Thu, 16 Apr 2020 02:03:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58468)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jOxbH-0007eP-8T
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 02:02:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jOxbF-00070K-LM
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 02:02:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39784
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jOxbF-0006zy-GH
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 02:02:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587016928;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F/BjKC86tsNzNHDTmESEATuN+k7RfauBGEt/Tk+4JWs=;
 b=cXkS9udNghwsLCIklkggnlLIsVVKq6MsZWCAzy8J97fXcgPUMVcAF/kIcMZ7xxg8QZQ6nP
 0YtkQTNp/xK1QS9q0pr9IaMglOrfjxzM3VkCIj2Y+pI85/3gBjP3xJsgRPHWisZ9t7GEPc
 ee+MRLAUPpvBLuXEb8Cp5CmMaPyPbQU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-140-nbyCwygOM2KceQS5DR4aJg-1; Thu, 16 Apr 2020 02:02:04 -0400
X-MC-Unique: nbyCwygOM2KceQS5DR4aJg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 997D08024E9;
 Thu, 16 Apr 2020 06:02:03 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-20.ams2.redhat.com
 [10.36.113.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 32E6F2719A;
 Thu, 16 Apr 2020 06:02:03 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A169111385C8; Thu, 16 Apr 2020 08:02:01 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: Supported Build Platforms (Again) (Was Re: Supported Sphinx
 Versions)
References: <20200411182934.28678-1-peter.maydell@linaro.org>
 <4873c74c-f590-62bf-bd64-dd5ab391c252@redhat.com>
 <CAFEAcA-Nuk8hnbtTrhtmSDroZugoEWheyh1N9E4jcAPikpPx9g@mail.gmail.com>
 <0519cb85-5c86-d202-7649-7928b4696644@redhat.com>
 <87a73ezeni.fsf@dusky.pond.sub.org>
 <30779c3c-f887-6b13-6f08-17f085da4874@redhat.com>
Date: Thu, 16 Apr 2020 08:02:01 +0200
In-Reply-To: <30779c3c-f887-6b13-6f08-17f085da4874@redhat.com> (John Snow's
 message of "Wed, 15 Apr 2020 12:43:01 -0400")
Message-ID: <87lfmwc6jq.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-?= =?utf-8?Q?Daud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

John Snow <jsnow@redhat.com> writes:

> On 4/14/20 3:53 AM, Markus Armbruster wrote:
>> John Snow <jsnow@redhat.com> writes:
>>=20
>
>>> Debian:
>>>     8/Jessie: We don't support this anymore AFAIUI.
>>=20
>> Correct.
>>=20
>> docs/system/build-platforms.rst:
>>=20
>>     For distributions with long-lifetime releases, the project will aim
>>     to support the most recent major version at all times.  Support for
>>     the previous major version will be dropped 2 years after the new
>>     major version is released, or when it reaches "end of life".
>>=20
>> Debian 8 reached end of life in 2018, one year after 9's release.
>>=20
>
> Debian 8 has "long-term support" until 2020-06-30. I only bring this
> point up because we still list "Debian" under the "long-lifetime
> releases" section, but are excluding the version of Debian that has
> "Long-term" in the name.
>
> Pedantic, yes.
>
> Is it worth clarifying that we treat Debian as a "long-lifetime" release
> distro, but we do not count their "long-term" support for purposes of
> calculating EOL?

LTS is a separate project under the Debian umbrella.  Our list of
distributions with long-lifetime releases says "Debian", not "Debian
LTS".  It does say "Ubuntu LTS".  Pedantic?  Yes.  Worth clarifying?
Probably.

Putting Debian under short-lifetime distributions would stretch "short"
to roughly three years.


