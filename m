Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD913C33C8C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 12:49:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77A2F207E0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 12:49:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O7DDfvSd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77A2F207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48042 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iooIU-0006j8-Kf
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 07:49:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40635)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1ion21-0002Dz-D0
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 06:28:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1ion20-0000It-6i
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 06:28:17 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24932
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ion1z-0000IM-Pv
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 06:28:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578396495;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+y6i5AYw6RS9XpoinVNgjpsvTj3TWUAm3c53u+JDcmo=;
 b=O7DDfvSdqRhOG4MCBcb/IPT3SJLb5rcobJCbZsBnOrFIrR4v8cIU4hvhQCR1dOGGipEHBZ
 9ASI3ZX3QIEtSIUv2lPfKB+bSVzIJ6TtPV9bOF/19/ngW+c10p48WF2O1oitA9R0wNMAFs
 7P/2AF/4yQypo6/ScCVptZuqBKsBCMA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-408-y1H0QhwkPJe5qPPUsjsKDg-1; Tue, 07 Jan 2020 06:28:14 -0500
Received: by mail-wr1-f69.google.com with SMTP id f15so14230467wrr.2
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 03:28:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=PDlKY2A96jLPYyFYV3vpu9cDCLSBAsuRtKPc321C/6c=;
 b=I26t+3Mspo0oSlRlLz6jzDP8wTfv9pz2XrKn8cD0HTUAT2oisLOYt//d8DIiLVx5LM
 Ium5OhSzFZjT6plQAQiSvD/iflUeSzshtXvbrR2sAUvXOn+cKD35g4JSaw6GE1Yd31P7
 Mlew28UGm79P6n53exZnYYkHDfCxoA8ZPhkx94HNGD0hl1/5fXBHYkEDFFz9AIJgac8U
 4C1JuWD5UNck0Bzuq5vqYlnmoJy0o0FkLlz0l9LgPvdJYm6O1KpxG/fMn0ywL/68fpUr
 4Cuk9vJCE0VCFuLyjmvJZFvMTZFXS51aIUkIbIwP0w8udpJlGpTTgnHTei9KHdsGW3j3
 81VQ==
X-Gm-Message-State: APjAAAWGp5o40SszVjCfxVDeWkarxnrrnGmV7aKDHrwqXEPtw/5TeJAY
 dpUG8usze5ZBp5qPcZ3VFxfjdWZuN1r/DjrfIThOiXdSiOeOQSEN4kIB8SaghNgbuGkgPYrBYEU
 +Xd30i2IafeNBzlk=
X-Received: by 2002:adf:df03:: with SMTP id y3mr117148720wrl.260.1578396492721; 
 Tue, 07 Jan 2020 03:28:12 -0800 (PST)
X-Google-Smtp-Source: APXvYqwC2EatpWNXPFhuDBIkonyxeTKhnZpRF+S8PbDW5w4yCACI8IaNEhjw/8FWk5CtXnYXhesZ1Q==
X-Received: by 2002:adf:df03:: with SMTP id y3mr117148694wrl.260.1578396492534; 
 Tue, 07 Jan 2020 03:28:12 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c6d:4079:b74c:e329?
 ([2001:b07:6468:f312:c6d:4079:b74c:e329])
 by smtp.gmail.com with ESMTPSA id w8sm26749313wmm.0.2020.01.07.03.28.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jan 2020 03:28:11 -0800 (PST)
Subject: Re: [PATCH 032/132] meson: uncompress edk2 bios
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
 <1576155176-2464-33-git-send-email-pbonzini@redhat.com>
 <3301602d-5543-a03f-ec5a-d49782d5296b@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2707a2d2-6267-a097-9dc4-b536b20919e9@redhat.com>
Date: Tue, 7 Jan 2020 12:28:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <3301602d-5543-a03f-ec5a-d49782d5296b@redhat.com>
Content-Language: en-US
X-MC-Unique: y1H0QhwkPJe5qPPUsjsKDg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 03/01/20 11:52, Philippe Mathieu-Daud=C3=A9 wrote:
> > +foreach f : fds=20
> Can strip space between f/column.

Could, but it seems like other meson.build files usually leave a space in.

Paolo


