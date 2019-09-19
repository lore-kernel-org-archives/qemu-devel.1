Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B577BC3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 17:34:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B01521929
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 17:34:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B01521929
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47042 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iB0K6-0004Ue-D2
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 13:34:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50174)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iB071-0008UJ-QI
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 13:21:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iB025-0007jf-8C
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 13:15:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35926)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iB025-0007jH-3m
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 13:15:53 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 575387FDC9
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2019 17:15:52 +0000 (UTC)
Received: by mail-wr1-f72.google.com with SMTP id v18so1303442wro.16
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2019 10:15:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=3b4CNt5+8dtPSM9K8ChuiHIDFKo5h36ioAuOEXlnZ00=;
 b=AAqUiVe/76D1y9tyvQw53LNcH6FnEqbd+DbPzlZxPAG5u4dVZA43rweFfhrGsuy5eG
 hVonMqgrgJO6wTVIU23NONLW1XgIWB832i9iV+NOHBIm6I3xPGkxyjCxULRY2loAL1B1
 zx1gai2uWD2U4Nnb9rrz4L7eS73HUEzwCWbl0+kGwzB2WahDETot+tvFTBeGK6JNT38I
 ubLPIZLemVJdWiJyWEboC3CvcRMYuerZowHY78XB+ms57pcq79S0p3IPtwnEyiRTspcH
 MMmnBKuVEAs7w4aErxQEk0vfbOkxLHXXP0WE1PWz+RhImSsZv5qwdPsFVm+EyVZX+MU0
 oQ/A==
X-Gm-Message-State: APjAAAVxsJowi1tPc2e4QG1NgzSAZpZv4cLlq4hs62uPv90i7SWngKsz
 WvXziNE8SCBy06KgL+Z9QmtcfY6PG09ntlgjB65kGfGPe0wsENZI2srbuDnhSf36vwKcGnGwoWl
 mukbBwigke0gfEDc=
X-Received: by 2002:a1c:9d0b:: with SMTP id g11mr3658231wme.22.1568913350924; 
 Thu, 19 Sep 2019 10:15:50 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyYXJ5DKzj/2N0E82bHapy5b99f3e3a8vfjBUv2XXEXSI8vf4Zo8w0jR8JO5Rd/7ejWylc9/Q==
X-Received: by 2002:a1c:9d0b:: with SMTP id g11mr3658215wme.22.1568913350744; 
 Thu, 19 Sep 2019 10:15:50 -0700 (PDT)
Received: from [192.168.1.115] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id 189sm12532260wma.6.2019.09.19.10.15.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Sep 2019 10:15:50 -0700 (PDT)
Subject: Re: [PATCH v2 0/2] iotests: Require Python 3.6 or later
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20190919162905.21830-1-kwolf@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <d19b2194-4880-94fd-57e5-8bea73dcbc2f@redhat.com>
Date: Thu, 19 Sep 2019 19:15:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190919162905.21830-1-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Cc: qemu-devel@nongnu.org, thuth@redhat.com, jsnow@redhat.com,
 ehabkost@redhat.com, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/19/19 6:29 PM, Kevin Wolf wrote:
> v2:
>=20
> - Provide the right exit code from Python instead of having a
>   potentially confusing negation in the shell script
>=20
> - Raised the minimal version to 3.6. If we're going to use a different
>   version than QEMU as a whole anyway, we can use a version that suits
>   us best. 3.5 would only be for Debian Stretch, and we don't really
>   care that much about running Python test cases on it.
>=20
> - Added a patch to remove Python 2 compatibility code
>=20
> Kevin Wolf (2):
>   iotests: Require Python 3.6 or later
>   iotests: Remove Python 2 compatibility code
>=20
>  tests/qemu-iotests/044                   |  3 ---
>  tests/qemu-iotests/163                   |  3 ---
>  tests/qemu-iotests/check                 | 13 ++++++++++++-
>  tests/qemu-iotests/iotests.py            | 13 +++----------
>  tests/qemu-iotests/nbd-fault-injector.py |  7 +++----
>  5 files changed, 18 insertions(+), 21 deletions(-)

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

