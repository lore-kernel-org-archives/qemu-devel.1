Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 311A0C10F14
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 13:06:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F03A2206BB
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 13:06:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GAk70vVh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F03A2206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55436 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHpBt-0001Qi-4Y
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 09:06:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37710)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iHpAj-0000X3-No
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 09:05:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iHpAh-0000w6-5J
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 09:05:00 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:55190
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iHpAg-0000uJ-PU
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 09:04:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1570539897;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3ur/JgeUo8SUJchNzAduEPYZ0yBhjDk8b4ItfgYiapk=;
 b=GAk70vVheOE0WzMlg9sxeVfub7A948Kqd+KFqT8/ttO/F+CSlyMl9Mm8e70Y+ft3wntgn7
 jJgscrizzLW7dntZ+Kvjx0mKlUwvGWlQKsdRIl4k9dkhAkk1ERfulm0EoC0EB7riY5kqCj
 LCn5sBcTUUOeWYVk86+vzwYKoQjx+jU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-111-VKzm5t0qM7OOGA93IkC5dQ-1; Tue, 08 Oct 2019 09:04:55 -0400
Received: by mail-wr1-f70.google.com with SMTP id i14so7230298wro.19
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2019 06:04:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=TcxMzLcbsOMC7x38x8/+P25nk3rjRmmupRSZyyF1VMA=;
 b=R4RFOqahphPXTliJWAbH5DCYhPcL2ExT9yP4pqdTwlAWw0QKKG/tTLZfqIKnnElytt
 9xUuGhk4GR3T3RQg2/Xy183ouQFSHEsByv+Cc2lTxPSWUTALbg3g7eYBzqwhlKYOHUta
 qtdr9gp3sXOFN0ewNXbk7zKS89kkBHwwFurORNPZ9J0+KmyHQtE/LmG74l7BEWVuo1ci
 BgvzAb2MTWG+XU5RVaeuwvvVPx0XVfFJC/4WglKhhNX9CEKjnq5q7WOPmksUChWPdYkT
 mPdvpWB2tC6SI0i5XnnUAiGPpsOEH5fWwTbr/+f+nlIwBBD5xemOGrtGPtjxjNdaxNQC
 orFg==
X-Gm-Message-State: APjAAAXbMwETYp4vHZAWDM2do1eYSAMUHF1DWgs1QdjiKeBxgbe9DQ3T
 9dJZC3VQ2TNPAIQm4Jkci5608VnIkwRu7DKxP/XpIXNGPZbagG15z9aDHFYpqAw0q/tqYmQ+nz6
 aQJGSSw3dze9Nbi8=
X-Received: by 2002:a7b:c041:: with SMTP id u1mr3663311wmc.88.1570539894090;
 Tue, 08 Oct 2019 06:04:54 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxykTHkjNCNTKC4Cz+kH5hsUVEjVEJS2Au7ntkFulmeEBPMXHruJNN/ywHahUZ6AZRiWvvXqg==
X-Received: by 2002:a7b:c041:: with SMTP id u1mr3663288wmc.88.1570539893841;
 Tue, 08 Oct 2019 06:04:53 -0700 (PDT)
Received: from [192.168.1.35] (46.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.46])
 by smtp.gmail.com with ESMTPSA id w22sm2498885wmc.16.2019.10.08.06.04.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Oct 2019 06:04:53 -0700 (PDT)
Subject: Re: [PATCH 00/97] Patch Round-up for stable 4.0.1, freeze on
 2019-10-10
To: Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org
References: <20191001234616.7825-1-mdroth@linux.vnet.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <78c46a05-76eb-ccec-df4d-103bee7c2760@redhat.com>
Date: Tue, 8 Oct 2019 15:04:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191001234616.7825-1-mdroth@linux.vnet.ibm.com>
Content-Language: en-US
X-MC-Unique: VKzm5t0qM7OOGA93IkC5dQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Michael,

On 10/2/19 1:44 AM, Michael Roth wrote:
> Hi everyone,
>=20
> The following new patches are queued for QEMU stable v4.0.1:
>=20
>    https://github.com/mdroth/qemu/commits/stable-4.0-staging
>=20
> The release is planned for 2019-10-17:
>=20
>    https://wiki.qemu.org/Planning/4.0
>=20
> Please respond here or CC qemu-stable@nongnu.org on any patches you
> think should be included in the release.

Since it is a "release", these probably fit:

commit 45c61c6c23918e3b05ed9ecac5b2328ebae5f774
Author: Michael Roth <mdroth@linux.vnet.ibm.com>
Date:   Thu Sep 12 18:12:01 2019 -0500

     make-release: pull in edk2 submodules so we can build it from tarballs

commit f3e330e3c319160ac04954399b5a10afc965098c
Author: Michael Roth <mdroth@linux.vnet.ibm.com>
Date:   Thu Sep 12 18:12:02 2019 -0500

     roms/Makefile.edk2: don't pull in submodules when building from tarbal=
l

When is the next qemu-stable release scheduled? Do we care about Python2=20
use for this one?


