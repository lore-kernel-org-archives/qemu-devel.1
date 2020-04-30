Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EED35C8300A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 10:41:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 973342137B
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 10:41:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UsnySsYf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 973342137B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU6cm-0004dV-RF
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 06:41:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53608)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jU6Rm-0006MI-2B
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 06:29:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jU6Rk-0004e9-OK
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 06:29:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30619
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jU6Rk-0004dx-8x
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 06:29:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588242574;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=arCIrhCYDvqzr/v6WXqZyE25XRcvC10QNtbGOdudylQ=;
 b=UsnySsYfMoFlfYruzArWZlOK2PXQrAcZd9qogbMndO+JTb9x8CuMH5BG0B8ebrrxA59CPr
 V7BTrKHKYM7EEioezoMIPSFY8jymJoN8w8vVrZcbIvQ0UXle10wM5Jn0s6u1K9LX7YvtPQ
 +fw7Xhp9C0VrM7X74sejQTyQIpl17Vw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-436-Q_A9lU7HM3WxVsBpjEJYbQ-1; Thu, 30 Apr 2020 06:29:31 -0400
X-MC-Unique: Q_A9lU7HM3WxVsBpjEJYbQ-1
Received: by mail-wr1-f71.google.com with SMTP id p16so3637539wro.16
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 03:29:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=cjs3pWbD1k2uTehUtz3PCVLtt1L1phobiR8XBGlCO8w=;
 b=LZG9UwSpRQwvCqUHsBSv7yj6Q+GVS84MMecGeE4jsjQ6XI6kCAE2py2PHr/Hqr75lU
 sx4L855uv6VnheYIAVMpmWRrPvdmRqFS5lGaktiOHJnCl8FLnor2i9V05Z/nAP2ai+F9
 XlrfLuYKZfaBgfCq+9KcROGCYWOkE2ljTix3pBwky06vshaz1ZUvMYA+/wGm3kkdr8sb
 M8y+poXZLMX8j9X6+UeEshFD8fPQFPeoBSWwIpFf5By1A9JgpwMPghcfIbM/2c7yy5r/
 pPSq43d0XupkSwK1kALM4Z2MgcE4a477WRtWntqXbeNFtYrhb1AVFYMBgxz+XpAFFCny
 fMlw==
X-Gm-Message-State: AGi0Pub9nQTmtMNZVQ7mmyu8KW/7AMjs6j8WfhTXsHYkhob5bXbCrhOb
 eXoo3N3H7OZNVueRCu4uEPWywMtTS6Bcue3LtyPSvjZD/7KSmW50kxp/X7/QakkrdJRkosgl4AE
 LN0doE6hFluuDoeA=
X-Received: by 2002:a1c:9e51:: with SMTP id h78mr2350060wme.177.1588242570023; 
 Thu, 30 Apr 2020 03:29:30 -0700 (PDT)
X-Google-Smtp-Source: APiQypKR1F4w/CLKLyrfd9HYQIV3Glu9SZxbSW+/TPt4tZXt0SrquSEZv01O3KJsU6xXdz4aQ4oqAw==
X-Received: by 2002:a1c:9e51:: with SMTP id h78mr2350048wme.177.1588242569801; 
 Thu, 30 Apr 2020 03:29:29 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:ac19:d1fb:3f5f:d54f?
 ([2001:b07:6468:f312:ac19:d1fb:3f5f:d54f])
 by smtp.gmail.com with ESMTPSA id a1sm3285104wrn.80.2020.04.30.03.29.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Apr 2020 03:29:29 -0700 (PDT)
Subject: Re: [PATCH] tests: add a "check-flake8" test for validating python
 code style
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
References: <20200429153621.1694266-1-berrange@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9f000680-d32a-5e43-d45b-58391063b7fc@redhat.com>
Date: Thu, 30 Apr 2020 12:29:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200429153621.1694266-1-berrange@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/30 01:24:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 29/04/20 17:36, Daniel P. Berrang=C3=A9 wrote:
> The flake8 program is a standard tool used by Python projects for
> validating many commonly recommended style rules. It would be desirable
> for QEMU to come into alignment with normal Python coding style best
> practices.
>=20
> QEMU currently violates a huge number of the style rules, so we can't
> blindly turn it on. Instead this patch introduces use of flake8 with
> a huge ignore list to turn off everything that is currently violated.
>=20
> The following descriptions are mostly taken from:
>=20
>   https://www.flake8rules.com/

I suggest instead using "black" and just reformat everything in a huge
patch; that's what we're using for Patchew.

It's not perfect, and especially one needs to get used to the double
quotes instead of single quotes for strings.  However overall it is
pretty good, and I've never seen it do something clearly "wrong".

> On its own this patch doesn't really do much of use except try to stop th=
e
> situation getting worse. To be valuable some motivated contributor(s)
> would need to go through fixing the code, and re-enabling each excluded
> warning category one at a time.
>=20
> I'm mostly proposing this patch as a starting point for discussion, to
> see if anyone is indeed motivated to take on the code cleanup challenge,
> and feed the fixes in through the various maintainers trees.

If we go with "black" I suggest just doing a big patch for everything,
since it's easy for maintainers to rebase by running black at each step.
 Overall our usage of Python is small enough that it should not be a big
deal.

Paolo


