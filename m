Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3B77C35247
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 18:19:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9280D2082E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 18:19:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VPv/rf+u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9280D2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35764 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iz2nA-0002uw-Nc
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 13:19:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35717)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iz2mX-0001MG-FY
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 13:18:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iz2mV-0004ea-6p
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 13:18:40 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:32710
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iz2mV-0004dk-3h
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 13:18:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580840318;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Bb+MrzYkp8zwQYZ7w+Va1zs5d4EEH7iYJzbrzjfDhFk=;
 b=VPv/rf+u7dv5hdv0LLn18a22Vj/8M/N5tSmSb8HgRh0L9PURLvCuuUN0AIGB+FH43vVqXx
 /RyCcdYpKjgNNtwn1RIvtm/agycjHZItYOgP5ZmRbIFtYqdFK9r6y/a5nj3lubRLDn/7xl
 +gWiSY4zI3lMN8kuiKbhMKiM7ccG98U=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-240-B68WRvR1MXGWhLJfbchaNQ-1; Tue, 04 Feb 2020 13:18:25 -0500
Received: by mail-wr1-f69.google.com with SMTP id c6so10632537wrm.18
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2020 10:18:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=jt84lhqTrrX2u3Z2SnUITw09qDjXpxbK9/UJYA9IT6w=;
 b=avNt08++Vb4VlRnVZ2d/m4MeAOj8ytirZZZGHOCnyB4Fk4el1LReDgpLT6kHQVrvfu
 MFibrrA1fbb1PhvZWCdNngh0JrSWCt3AtOG7nrlHftTY70Jo980jfQXFMOVQRNPPtYS0
 Xpr/zBL1mLsLsu65fE00QqUOyMjl1DQQhtoWD0b1DJ9rP+JIZtPORl4Oa60w+GPLAb1b
 aA7M0GpLYEoptTeKBpus0ysYDzcTh0XP9v3lcF5CfpMU+UjZL30c9pw1l2livgUzVLPu
 vaiBzP1/N4L/Lp6WjA9CWJixE8/mBQqNLYSOJrrQipZqahV9rnbKgO1ACrdJrXJM98Ow
 nSKg==
X-Gm-Message-State: APjAAAUkR8pvUyVEpB51HckbRBwb8pGxydiHJzkzh9+msk8ZHKonCW1v
 tK606DnZgRBG1F7MwbqxU/F5hk49w9o5FhIk7i1MnNx937U3ebFC2qNm6lwDpGJhX6nGu6Av+Fd
 vh2/DsqH7fqebaRM=
X-Received: by 2002:adf:ce86:: with SMTP id r6mr6395978wrn.327.1580840303348; 
 Tue, 04 Feb 2020 10:18:23 -0800 (PST)
X-Google-Smtp-Source: APXvYqyrtCfeMA+T6yTFRLBAdnGbSh3A4jsiVYnV7FciXaRflDR3coGq6PrPMmiRKbzQznJD+ZnoTQ==
X-Received: by 2002:adf:ce86:: with SMTP id r6mr6395963wrn.327.1580840303169; 
 Tue, 04 Feb 2020 10:18:23 -0800 (PST)
Received: from [192.168.1.35] (162.red-83-52-55.dynamicip.rima-tde.net.
 [83.52.55.162])
 by smtp.gmail.com with ESMTPSA id b10sm31868725wrt.90.2020.02.04.10.18.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Feb 2020 10:18:22 -0800 (PST)
Subject: Re: [PATCH] make all Python scripts executable
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20200204160237.16889-1-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <5284e650-1245-e982-57cd-9cd1971ef7cb@redhat.com>
Date: Tue, 4 Feb 2020 19:18:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200204160237.16889-1-pbonzini@redhat.com>
Content-Language: en-US
X-MC-Unique: B68WRvR1MXGWhLJfbchaNQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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

On 2/4/20 5:02 PM, Paolo Bonzini wrote:
> Scripts that have a Python shebang are meant to be executed directly from=
 the
> shell; give them 755 permissions.

Ah I should have done the chmod in my "Explicit usage of Python 3=20
(scripts with __main__)" patches, but I would have missed=20
scripts/signrom.py and tests/qemu-iotests/222.

Reviewed-by: Philippe Mathieu-Daude <philmd@redhat.com>

> Based-on: <20200204160028.16211-1-pbonzini@redhat.com>
> Cc: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   scripts/minikconf.py   | 0
>   scripts/signrom.py     | 0
>   tests/qemu-iotests/222 | 0
>   tests/qemu-iotests/245 | 0
>   4 files changed, 0 insertions(+), 0 deletions(-)
>   mode change 100644 =3D> 100755 scripts/minikconf.py
>   mode change 100644 =3D> 100755 scripts/signrom.py
>   mode change 100644 =3D> 100755 tests/qemu-iotests/222
>   mode change 100644 =3D> 100755 tests/qemu-iotests/245
>=20
> diff --git a/scripts/minikconf.py b/scripts/minikconf.py
> old mode 100644
> new mode 100755
> diff --git a/scripts/signrom.py b/scripts/signrom.py
> old mode 100644
> new mode 100755
> diff --git a/tests/qemu-iotests/222 b/tests/qemu-iotests/222
> old mode 100644
> new mode 100755
> diff --git a/tests/qemu-iotests/245 b/tests/qemu-iotests/245
> old mode 100644
> new mode 100755
>=20

Thanks, patch applied to my python-next tree:
https://gitlab.com/philmd/qemu/commits/python-next


