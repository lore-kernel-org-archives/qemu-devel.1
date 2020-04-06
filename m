Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23947C2BA19
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 10:21:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E40BE2054F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 10:21:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YOKwLf2v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E40BE2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLOsJ-0005Xw-1u
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 06:21:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50577)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jLOmI-00032O-Ey
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 06:14:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jLOmH-0004pF-Ci
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 06:14:50 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:59917
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jLOmH-0004oG-8w
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 06:14:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586168088;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2SmZfaD8FZztWo3SmUJfLfJx+RKEm5IsODq5F9p69ak=;
 b=YOKwLf2vM25Tv4gx3iDoqZ0B/D4pTXMu0EmYpLh2PxBx5CSBjc6ofvuqPVJ5igtTDvfCIg
 XtRare2lklAiCglhOB0CPnomEpMAV3kcjQc2u5DgtdHX2ukI6j+Q1V6ad2Ueq+cYoXJouX
 Hdxg8HrCA8Xck1GdoCkBXd0La9LtpsY=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-79-fDSAwzXZPOuioq6b8MGImA-1; Mon, 06 Apr 2020 06:14:44 -0400
X-MC-Unique: fDSAwzXZPOuioq6b8MGImA-1
Received: by mail-ed1-f70.google.com with SMTP id q29so11392006edc.1
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2020 03:14:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=2SmZfaD8FZztWo3SmUJfLfJx+RKEm5IsODq5F9p69ak=;
 b=lK0YVd7ZS8Y2czPDBh0CEqlkSuNjW+eWEzejYUjrzwjMZ0UVraaXzC0TLKhTeIhKKU
 EkbJ5hGYuFt1GWsFAj/DRkbvgle0EPaSHtaVoeRew3TM/y16iYA5RMUZeQL0j5ZEpB8q
 6pOVngYoWe8Ezkt/O+WtprxktC1gtq2mLBgv57hpY3HAYIHZ0kSlh9x79dE2iSXEbOE2
 iA/VJrfqwo30GR2a/Ts8U4VKJzj1KpSVVE5zdDOF3FHZEdVO9i3pr27Y/kcwbPuclVGH
 mJXTKV9DWZJ58a5PVQD3rv5BtgW1zoa7w58rebvwo836jsi1sIDtjl4KD927/6MKiBO/
 2Big==
X-Gm-Message-State: AGi0PuZzmwa21mo4G5qHT9MjMtIgRmm4BwbZz1VqERwph6XCMZrqdfYF
 TzvZRV2DkmGB/cCnUZwM7c39MBRfoUXaheH6EzwqPWTzgICX3Wv1NjZsXVjR1xWhowxONlKX9HJ
 4W53SCeMzCfKWKOU=
X-Received: by 2002:a50:ab5a:: with SMTP id t26mr18684371edc.380.1586168083500; 
 Mon, 06 Apr 2020 03:14:43 -0700 (PDT)
X-Google-Smtp-Source: APiQypLh7Sh6ESyjp3ka8swU+vPytczudxSeQnAN7T2J+eL6xu8FPPpymGersJH5F1oRzBil954gOw==
X-Received: by 2002:a50:ab5a:: with SMTP id t26mr18684357edc.380.1586168083323; 
 Mon, 06 Apr 2020 03:14:43 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id oe24sm2216118ejb.47.2020.04.06.03.14.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Apr 2020 03:14:42 -0700 (PDT)
Subject: Re: stm32f429 flash writing
To: Mohannad Maklad <msala.work@gmail.com>, qemu-discuss@nongnu.org,
 qemu-devel <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>
References: <CADxp151=4QduaHYugXGD+gcKffUUdkxfzWNvk5xXAqMWRKEQGw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <e415fc55-359b-509b-15dc-79181b0a53d7@redhat.com>
Date: Mon, 6 Apr 2020 12:14:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CADxp151=4QduaHYugXGD+gcKffUUdkxfzWNvk5xXAqMWRKEQGw@mail.gmail.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/5/20 3:41 PM, Mohannad Maklad wrote:
> Hello all,
> 
> I'm trying to write to stm32f429 discovery board on flash but it doesn't 
> seem to work. Can I share the code with you?

You can certainly share your code/use case!

Note that the stm32f429 is not modeled in mainstream QEMU, only the 
stm32f405.

Please also include the following emails:
- qemu-devel@nongnu.org
- qemu-arm@nongnu.org

If you want to share/attach example files, you can also fill a 
bug/feature request here:
https://bugs.launchpad.net/qemu/+filebug

Regards,

Phil.


