Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB329C5DF60
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 12:48:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0A7C2178F
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 12:48:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0A7C2178F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iShDV-0004gC-QL
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 07:48:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60085)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iShCn-0004Go-1G
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 07:48:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iShCk-0000qX-KD
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 07:48:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45176)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iShCk-0000q1-F3
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 07:48:02 -0500
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 19EB2C05683F
 for <qemu-devel@nongnu.org>; Thu,  7 Nov 2019 12:48:01 +0000 (UTC)
Received: by mail-wr1-f72.google.com with SMTP id f8so922562wrq.6
 for <qemu-devel@nongnu.org>; Thu, 07 Nov 2019 04:48:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=byxXFeWkfVk4mWlvFull2sSGobYsxB9rDRxaq4YZ+fQ=;
 b=bZ1pM27DoJiiFmU293vFINuVN3u9HYPxoq4TovVSLycmzg0QXSxs1Pza3A3sZfshM3
 MOfeQYt6r+8DTSAL9nvfmtuiTMFSmqllt1jYf7mrm0E5RmZ8iRNJz7F4rF9Hf6SEJPnL
 XNia5+Ey5Ejn1eGDC06kNjNgriLtdwnzS/uSxUeuW3N8vApB5ZUDsWKmbcNaZWuGTvzo
 lC1Ut4yX+Q36oulIKHe8rCeEWIUCd6Y2zFTXvCZ9Y8sYds/Su5R8Iz9RrsfIMSBcvpDm
 LNPwoAvnK7wUBeiF60KCjGUtnRmUrrzTsUst2gXiWnoHpXc6YjnccKoArn2ZOnm/q+6K
 CSbA==
X-Gm-Message-State: APjAAAXzAFW2DhaiE5aoj3znf0AxO7ePyUbKa42CS8blo0V38RKzWjR/
 MO9b81Om7rdTHY4/MDbfEzTM3SSwQZDre3kYwBo90S3p7NL4koSHnc31nbqfmUnmriHRNbXruFl
 TfsPQYnEeg9o90Ik=
X-Received: by 2002:a5d:4645:: with SMTP id j5mr2865607wrs.329.1573130879640; 
 Thu, 07 Nov 2019 04:47:59 -0800 (PST)
X-Google-Smtp-Source: APXvYqxZtIPcWat+hDSn2jGpkpLK5dECPYqUBx/x25eL8YnF5ANv8/lFjyEMpLm2Z0W5PrDQvsNAjA==
X-Received: by 2002:a5d:4645:: with SMTP id j5mr2865580wrs.329.1573130879317; 
 Thu, 07 Nov 2019 04:47:59 -0800 (PST)
Received: from [10.201.49.199] (nat-pool-mxp-u.redhat.com. [149.6.153.187])
 by smtp.gmail.com with ESMTPSA id c9sm1243993wmb.42.2019.11.07.04.47.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Nov 2019 04:47:58 -0800 (PST)
Subject: Re: privileged entropy sources in QEMU/KVM guests
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>
References: <03e769cf-a5ad-99ce-cd28-690e0a72a310@redhat.com>
 <20191107115203.GD120292@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <31917972-da28-8e0d-432d-1cb7607ff3e7@redhat.com>
Date: Thu, 7 Nov 2019 13:47:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191107115203.GD120292@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Jian J Wang <jian.j.wang@intel.com>,
 edk2-devel-groups-io <devel@edk2.groups.io>,
 Bret Barkelew <Bret.Barkelew@microsoft.com>,
 qemu devel list <qemu-devel@nongnu.org>, Erik Bjorge <erik.c.bjorge@intel.com>,
 Sean Brogan <sean.brogan@microsoft.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/11/19 12:52, Daniel P. Berrang=C3=A9 wrote:
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?id=3Dbb5530e4082446aac3a3d69780cd4dbfa4520013
>=20
> Is it practical to provide a jitter entropy source for EDK2
> too ?

The hard part is not collecting jitter (though the firmware might be too
deterministic for that), but rather turning it into a random number seed
(mixing data from various sources, crediting entropy, etc.).

Paolo

