Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97A19C35247
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 15:28:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64C4120659
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 15:28:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KHPHf1GW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64C4120659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50580 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izMav-0000O7-Ji
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 10:28:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50854)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1izMZz-0007ke-2L
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 10:27:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1izMZy-0003pA-3E
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 10:27:02 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31923
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1izMZx-0003j9-VO
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 10:27:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580916421;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0G934c4ezx5PqrNBWltm4RKTNT49Jlg/JBkQmGNu+dY=;
 b=KHPHf1GWLGD03p6NertbcNXlRMRdGDuTLaDS7LJnULJFL2IB93PhZHtarttvVjwO2sPjKv
 n1fh6TWBscM8ASdEKF+q6e2kXei/YRsKeC5yuwHxJ0/6najBr8S76FNjB9RYaGWqN8Q1a0
 iaXsr8gugG0YL9N/FVqzkukHebH7R7s=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-421-p0_BhKzPMXqfakbkceRbiQ-1; Wed, 05 Feb 2020 10:26:54 -0500
Received: by mail-wr1-f70.google.com with SMTP id 50so1361975wrc.2
 for <qemu-devel@nongnu.org>; Wed, 05 Feb 2020 07:26:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=HFSvnF4h3RbLYLc/xxbbhYMLGqdBwO8aieKoCsyDA6E=;
 b=r1Rh3GmctSPk6HCa0NPU9xVwGqYecskKAILdyZOfhzEVplrOWNpUZ+c87ofB5Nl1dD
 Gr8PHretqK/SELSs2wp2IFSH4RNbW0sTvozrCuG2FayACS9LgEoqABiYlEXcsHZcBwq0
 yTRPXgQkizK0uIv9RfdKh0Y8lNAFsp1YEX1jtgJY4XxSNyqmP2ow+bFIOw2V1CkaKLOY
 zYonfp2GCVOEbriCaOnzBhX4m+NvkXDzPNAlanQLaDhROSr03ZpUJQljoU+EYSyizbPF
 7x4XnJV0+GluhE9rp8uk3Hw3AXwf73Jc0i/eByFP1ASVulHkmubMIWS/ZkOXUDjrrQoq
 pD0w==
X-Gm-Message-State: APjAAAVi9qf6iyAzwkfFFhyMPFMOD57Ck+/F1oSQm2WON5+/FLO0gsmI
 mJ/GPvVbxgguHO3ZfNiJX2EPBbNq2/xZijI9J7OR3s4Rd/6kpPGszOelugU1P0fHtiMkvtcR0KT
 W85kxIfSxZucPq44=
X-Received: by 2002:a7b:c1d6:: with SMTP id a22mr6051446wmj.108.1580916412713; 
 Wed, 05 Feb 2020 07:26:52 -0800 (PST)
X-Google-Smtp-Source: APXvYqzCNhle1f2m0Yb5svELIdy6DDTqoM2jUgxwEbTczID2vd6z0xxpn3jjxYQSMloKUucAfgdkYA==
X-Received: by 2002:a7b:c1d6:: with SMTP id a22mr6051416wmj.108.1580916412427; 
 Wed, 05 Feb 2020 07:26:52 -0800 (PST)
Received: from [192.168.10.150] ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id b10sm173148wrt.90.2020.02.05.07.26.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Feb 2020 07:26:51 -0800 (PST)
Subject: Re: [PATCH for-5.0 3/4] Remove the core bluetooth code
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Thomas Huth <thuth@redhat.com>
References: <20191120091014.16883-1-thuth@redhat.com>
 <20191120091014.16883-4-thuth@redhat.com>
 <7a775153-f18d-e766-1d8f-33607f5fa05b@amsat.org>
 <2396dfd4-6c85-d17a-b358-bd058c757f14@redhat.com>
 <CAAdtpL7vPCQ8k91nvBWc_NLrmhu6OPVprUSL8uzi_v6HMiSrnw@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e90fb38e-bf41-c696-6c94-8626ecf69a8b@redhat.com>
Date: Wed, 5 Feb 2020 16:26:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAAdtpL7vPCQ8k91nvBWc_NLrmhu6OPVprUSL8uzi_v6HMiSrnw@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: p0_BhKzPMXqfakbkceRbiQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Peter Maydell <peter.maydell@linaro.org>, libvir-list@redhat.com,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 qemu-arm <qemu-arm@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 01/02/20 19:53, Philippe Mathieu-Daud=C3=A9 wrote:
> I thought about it but this won't fix much, it is too late now.

It would help distros who are already disabling bluez, since they
wouldn't incur a compile-time error.  Not a big deal though.

Paolo


