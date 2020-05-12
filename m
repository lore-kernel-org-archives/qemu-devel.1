Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58C71C54E4B
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 07:06:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2315820733
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 07:06:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dKehuE9w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2315820733
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYOzq-0003Ok-7a
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 03:06:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53346)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jYOvV-0005wf-Ks; Tue, 12 May 2020 03:02:05 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:39341)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jYOvU-0006pE-Us; Tue, 12 May 2020 03:02:05 -0400
Received: by mail-wr1-x441.google.com with SMTP id l18so13911992wrn.6;
 Tue, 12 May 2020 00:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=4qgMT+aw+sFMXRxGuwuad+IpvlzCJ8SZG6oBmd4XXnU=;
 b=dKehuE9wrvEBkq+1wTs+iW62BmiQSxnDNAfm9j38K5wGTNykZi3wgBAu50fpmDnWSj
 vljnEwvKI/UwGE/9GVgnzQ3J0nAT+J/vSa6OeFGICBodccUkvtA8ZfRrJ8swIvnkDqSZ
 oQ/z3Ibs1XVm2FwNUSj23zqZmgOyT93XrQLUztVMtYxUNcl0fJ0UWebZ3NH8PxdniaeQ
 esZNDvbWYwI95wQHVmUfDUFkZITJem96yaMxpZtL2EHhVXo5436i8wNrpmNYIrFzMDrS
 dge7Alh+KNlE7FB/Hp45T4RPB3kkDsvy64bNak7igy9ei2vGheJzkK83CWmsHMfaWMLA
 2jQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=4qgMT+aw+sFMXRxGuwuad+IpvlzCJ8SZG6oBmd4XXnU=;
 b=iQ7OptyUS9dudJG8csfmMQbT7fcZbFU/hOUKoEyCsQI6cn0IRZRTihSDt4+OnjClCW
 f2nenrh/bopoafUd1Hi8+dl273nznsPswEDjoi9ETtRvNMRcIhvxbJXmY6Fkb5A3Oz7M
 14+T0dvSDIr6ZQQf4mK4xj3VU7rwNLVadlDdevdnxIyJ2jaA63oIHqvs4uddP0UV7ybf
 s4qobOVT1yvMBMnogYbpV9ABeJNOt32pz75M6oKq3+a3fvODAm6cVmKfty+JwfnDyoR7
 GiynFfr7DiHaJDo3writMX0He3DquSe1BK0lyNjBP1BzTW2GjwXOgbefFD9g0aBK2r6l
 smRQ==
X-Gm-Message-State: AGi0Pua6deP7VobtkqJFA/KANZrPfW+DmmrXg5vBgkmB+i25qTTzt4jr
 3FDwDaDLNjjHhNgM+nnWn7c=
X-Google-Smtp-Source: APiQypIOLJcd82tu9SJdsaSZI3O6orFEwISrD5ITdiYUCuI3qZfMw+cX9FXLT3ExnXAc6jiwfMXQ8w==
X-Received: by 2002:a5d:522d:: with SMTP id i13mr22785881wra.306.1589266923289; 
 Tue, 12 May 2020 00:02:03 -0700 (PDT)
Received: from [192.168.1.38] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id s11sm30775338wms.5.2020.05.12.00.02.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 May 2020 00:02:02 -0700 (PDT)
Subject: Re: [PATCH v2 0/3] qom: Few trivial patches
To: qemu-devel@nongnu.org
References: <20200504115656.6045-1-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <7a3b93ca-1574-5c44-ca92-161e58d28142@amsat.org>
Date: Tue, 12 May 2020 09:02:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200504115656.6045-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>, Markus Armbruster <armbru@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

ping?

On 5/4/20 1:56 PM, Philippe Mathieu-Daudé wrote:
> Some QOM patches worth salvaging while doing housekeeping.
> 
> Since v1:
> - Fixed test build failure (patchew)
> 
> Philippe Mathieu-Daudé (3):
>    qom/object: Move Object typedef to 'qemu/typedefs.h'
>    io/task: Move 'qom/object.h' header to source
>    qom/object: Make reparenting error more verbose
> 
>   include/io/task.h         | 2 --
>   include/qemu/typedefs.h   | 1 +
>   include/qom/object.h      | 2 --
>   include/qom/qom-qobject.h | 2 --
>   include/sysemu/sysemu.h   | 1 -
>   io/task.c                 | 1 +
>   qom/object.c              | 7 ++++++-
>   tests/test-io-task.c      | 1 +
>   8 files changed, 9 insertions(+), 8 deletions(-)
> 

