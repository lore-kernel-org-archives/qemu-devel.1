Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2BC2C38A30
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 06:59:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA66C206CD
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 06:59:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B0jIPwC+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA66C206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45116 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jR9MC-0005h3-Rh
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 02:59:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32918)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jR9LF-0004G9-7b
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 02:58:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jR9LE-0004gi-JD
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 02:58:41 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:48593
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jR9LE-0004gE-74
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 02:58:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587538719;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hFYbiQ5L/SH7Njt9bWYLCjD+5eQBCYeOi1syYvcfuXI=;
 b=B0jIPwC+bTCOlQVPw4eecQilXjDiLoaUtPSG04NxTwFngBnzGwY/I7UqwCNosr9v/yPfJC
 6KmlLPt4npcYeW14R33EkfW7oKCN+tdw7QgcI5x06Oqu2jykv4XTNZVbCBqw/14EiRymRP
 Q+bJRJ+SFO0mL+nBE+NHAqViY3oWxkQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-336-o3u1cHeHPPSXsM9SNdE5GQ-1; Wed, 22 Apr 2020 02:58:38 -0400
X-MC-Unique: o3u1cHeHPPSXsM9SNdE5GQ-1
Received: by mail-wm1-f71.google.com with SMTP id j5so438155wmi.4
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2020 23:58:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=f/3TwOTQCSnbkIKSE4Jn0yjpvFJq/W4VDJUOm/m0kQ0=;
 b=cA92sa3AnDGLa8cfqroqMVgkf2FIGI3stmEY0iSUN/RWpcQgAO9zJujuGnGXnsPKxn
 v/s6FHLRkfemqvig/hdOieJqcUrj3HHOCZINf9A0t0sjn4zUycKvH60RtgszkrHde4uY
 uveuG+MFcDdeA6jN02fQnPUCLJAMoykWKsd1YiK04c+MY4R3RtegTMoQtDv7UEl05QJ4
 3Rqd9gVusFw8rEfP0MYN2sW25+4l/cXR6IbprGOUbCYpGiMrybzmTKQqbrkmu+XKNSxx
 XnCPC/uXULsFkYsCsk/cB1Iuf9FZBh7G1NEgMRKPAHovr04bjKG3QtDQNxfB8LwYTiJP
 cDdw==
X-Gm-Message-State: AGi0PubumsbZcTqJnOBhgYq8ZrF66AYgTraLQwlf2V9SSxvgGKTKy6ss
 Ze5cjhtMi9ZcoQa2NZY9nxX/fECuvNiApszhx6Dp+2mbKhXbXhpDhx3GdXvmw5IY8nnewfTb1UH
 KDc3vYL07EDJtYGg=
X-Received: by 2002:a05:600c:2157:: with SMTP id
 v23mr8242783wml.149.1587538715980; 
 Tue, 21 Apr 2020 23:58:35 -0700 (PDT)
X-Google-Smtp-Source: APiQypL4dnrZWpSkpr0WUaHXjuyAb1CaJR7nRJRyQgJQw+QACLWsGd39kQm6fQ1hSC+BRqyx3ovO1w==
X-Received: by 2002:a05:600c:2157:: with SMTP id
 v23mr8242767wml.149.1587538715776; 
 Tue, 21 Apr 2020 23:58:35 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id q143sm6804308wme.31.2020.04.21.23.58.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Apr 2020 23:58:35 -0700 (PDT)
Subject: Re: [PATCH 6/6] target/arm: Restrict TCG cpus to TCG accel
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20200421131926.12116-1-philmd@redhat.com>
 <20200421131926.12116-7-philmd@redhat.com>
 <e2864e76-90a7-03f6-7bf0-e409980a2900@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <54a52306-1e7a-768f-637d-dd29f48196ce@redhat.com>
Date: Wed, 22 Apr 2020 08:58:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <e2864e76-90a7-03f6-7bf0-e409980a2900@linaro.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/22 02:57:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/22/20 6:24 AM, Richard Henderson wrote:
> On 4/21/20 6:19 AM, Philippe Mathieu-Daud=C3=A9 wrote:
>> A KVM-only build won't be able to run TCG cpus.
>>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> ---
>> This patch review is funnier using:
>> 'git-diff --color-moved=3Ddimmed-zebra'
>> ---
>>   target/arm/cpu.c         | 634 -------------------------------------
>>   target/arm/cpu_tcg.c     | 663 +++++++++++++++++++++++++++++++++++++++
>>   target/arm/Makefile.objs |   1 +
>>   3 files changed, 664 insertions(+), 634 deletions(-)
>>   create mode 100644 target/arm/cpu_tcg.c
>=20
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Thank you Richard for reviewing 6 different time the same code movement...!


