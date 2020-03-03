Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 832D2C3F2D7
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 17:45:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EF1A2187F
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 17:45:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L4A5jXdc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EF1A2187F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51116 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9BcA-0006M2-FF
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 12:45:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40573)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1j9Bb8-0005nh-TZ
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 12:44:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1j9Bb7-0004fV-6V
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 12:44:50 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:23973
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1j9Bb7-0004fD-0W
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 12:44:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583257487;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hU4ADZF0ER4FKUJxWZj/mpz6FjsuJgB2RuuaYEdRvMM=;
 b=L4A5jXdc0iZBmBppHbZPx8ggwrrJCt/oD4mbdcDLsE/NehvCyUGzSdxVnuT2rTs+VP5ocW
 rIQOi4DTl9ptcSBFRC0p/dl6H2MJP0ry8Au+hR/A3zItrALWSzAgSs8rOFAV3fYkun2HYS
 rx85fyuFx6tm2Rmk/6HJJObuZko5uGM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-393-9N1p5qQnOaOZMd1QDHCzFg-1; Tue, 03 Mar 2020 12:44:46 -0500
X-MC-Unique: 9N1p5qQnOaOZMd1QDHCzFg-1
Received: by mail-wr1-f71.google.com with SMTP id y28so1538562wrd.23
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2020 09:44:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=hU4ADZF0ER4FKUJxWZj/mpz6FjsuJgB2RuuaYEdRvMM=;
 b=BMHtBn8YRK0UwE43iluAbkqWQtT3Sa1F7O34wGvQkGtdr9dvrn3qXwFeFAucM/NfRf
 os75QrXW7kVoPqqEp25v4AJtju/zZMsLhppJ4QySywGuM2b45a9S4KUcFXjDi3yNvB/z
 nmvqYjXlhY3OlOu5MyVOYlNaPqqPZj1CVPZ87lRwUuluItxZjC8QEwu0hsti6i91dvbg
 f8Vp5lYZnXvJ42flCsizpoN5T6ul6I24PStOo5mhGbE0t+TmrTUW9DK3sHNX19FIbrQu
 +s9yKgpp615nAmfDTPxIHen2Xg9QHVipRWH3mayNFVwRpluvueLshiYWGvPHH5AaUrv/
 d06A==
X-Gm-Message-State: ANhLgQ1T31bGHpQauynTlCVmpEUrs1DPjfPTb62YKY9feE0k257PLjNd
 NzbLaYK7p1hDcKvy+qnuw66stTZLAiYD5zURX+8Qcn+G/g/+93q5VxIPNSJNCNi6MEUqfCBWpQZ
 NVSrbLVrrdNLZ7Ks=
X-Received: by 2002:a1c:66d4:: with SMTP id a203mr5287161wmc.188.1583257485020; 
 Tue, 03 Mar 2020 09:44:45 -0800 (PST)
X-Google-Smtp-Source: ADFU+vstNLiOtKACw2UUZ4wriOcK9Acqi6W6D3SsyQJSwSRptjI+C/SWAc0FY9gqi3W9SXlgy/SjWw==
X-Received: by 2002:a1c:66d4:: with SMTP id a203mr5287147wmc.188.1583257484737; 
 Tue, 03 Mar 2020 09:44:44 -0800 (PST)
Received: from [192.168.178.40] ([151.20.254.94])
 by smtp.gmail.com with ESMTPSA id z131sm4794482wmg.25.2020.03.03.09.44.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Mar 2020 09:44:44 -0800 (PST)
Subject: Re: [PATCH v3 00/33] Convert qemu-doc to rST
To: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
References: <20200228153619.9906-1-peter.maydell@linaro.org>
 <CAFEAcA8vbqA_4K7dkyOrU_8HDrRo8h5eYESLgNnOzvrp0tVUpQ@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c7722aa6-5a51-e520-a910-33dc588ebd86@redhat.com>
Date: Tue, 3 Mar 2020 18:44:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8vbqA_4K7dkyOrU_8HDrRo8h5eYESLgNnOzvrp0tVUpQ@mail.gmail.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
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
Cc: Kashyap Chamarthy <kchamart@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 03/03/20 18:35, Peter Maydell wrote:
> Advance notice: I would like to put these into a pull
> request at the end of this week. This is your opportunity
> to say "that would be a bad idea", "I need X more time
> to review it", etc :-)
> 

On the contrary, it's a great idea. :)

Paolo


