Return-Path: <SRS0=q9Vo=YU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71955CA9EAF
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Oct 2019 16:12:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4579A20679
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Oct 2019 16:12:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4579A20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iOl9B-0006wf-9B
	for qemu-devel@archiver.kernel.org; Sun, 27 Oct 2019 12:12:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45417)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iOl8V-0006S7-QB
 for qemu-devel@nongnu.org; Sun, 27 Oct 2019 12:11:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iOl8T-0005ed-Ib
 for qemu-devel@nongnu.org; Sun, 27 Oct 2019 12:11:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59516)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iOl8T-0005eQ-DG
 for qemu-devel@nongnu.org; Sun, 27 Oct 2019 12:11:21 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6DEEA8535D
 for <qemu-devel@nongnu.org>; Sun, 27 Oct 2019 16:11:19 +0000 (UTC)
Received: by mail-wm1-f71.google.com with SMTP id t203so1067474wmt.7
 for <qemu-devel@nongnu.org>; Sun, 27 Oct 2019 09:11:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Xt0RNA+Qt5k15q1dwXMHZh9AABc875Arqpjbv35CIK8=;
 b=esveAWB4rn6CbeCcUwCMbd2woTgFi48Hzvv725XB8j2ZCcePXR5sCz3HEOnL22v20J
 7hiEw65TH34+aOGYANvoV6pmBs3odHYsQdvTeJsWBkRxY8l5xfqCQO/1Xts3RN1SOq0O
 c100P9IHhEjLfM6FViNq5c7XTEj5sbBnZOm1yMx2Xm6S0J2bXyhbMlBRoH7WjliqUZ7J
 o29t/hm/1sDH7EkBbUpCloEtWybaqlKfY+DogvLCHqy8BC3oVS+JkIQH4/AtcDkzT2el
 1DLQ28S0X3bE9FH43j8P4vhFWIwY3VFYgZRRa/Gi1X/RIw5Qt3+nQdgLT8os+pYo50xL
 uEQg==
X-Gm-Message-State: APjAAAXgeqK5tuBX0zvX2lfirkH924opobC6WKOUD/d9tk2f7olPVXJ6
 m0IYih787/7Cya8I9+avpJKTuCPiyHJlph5uoFjPEvdmzxUB4vQjRNHBN22MMxAKzbAaXBpxxGK
 eq3teenb6GkAAlps=
X-Received: by 2002:a1c:5415:: with SMTP id i21mr12513342wmb.120.1572192678066; 
 Sun, 27 Oct 2019 09:11:18 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyADNmwqRwkI0hmNeuWCRaTEelypjlGEnywbkI6M+URG9tQ/3N1ERQWWJDSijmiCO5OjJxq9w==
X-Received: by 2002:a1c:5415:: with SMTP id i21mr12513320wmb.120.1572192677794; 
 Sun, 27 Oct 2019 09:11:17 -0700 (PDT)
Received: from [192.168.42.37] (mob-2-43-145-251.net.vodafone.it.
 [2.43.145.251])
 by smtp.gmail.com with ESMTPSA id f6sm11493529wrm.61.2019.10.27.09.11.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 27 Oct 2019 09:11:17 -0700 (PDT)
Subject: Re: [PATCH 0/5] hw/i386/pc: Extract pc_gsi_create() and
 pc_i8259_create()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Sergio Lopez <slp@redhat.com>
References: <20191018135910.24286-1-philmd@redhat.com>
 <22db5316-648a-9416-87b5-a76772e8539e@redhat.com>
 <aac6bd30-317b-d8a2-6442-6f3d37941785@redhat.com>
 <f5d9b8c9-302e-336d-5737-3fe421d793a1@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <e7a2c2fc-ef93-be2d-c475-e3a89b83d06b@redhat.com>
Date: Sun, 27 Oct 2019 17:11:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <f5d9b8c9-302e-336d-5737-3fe421d793a1@redhat.com>
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
Cc: Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 26/10/19 16:55, Philippe Mathieu-Daud=C3=A9 wrote:
> In the patch 'hw/i386: Introduce the microvm machine type'
> Sergio uses gsi_handler(), so you need to drop 'hw/i386/pc:
> Reduce gsi_handler scope' to keep microvm building.

Indeed, and I also have patches on top to move those out of pc.c
(otherwise you cannot build CONFIG_MICROVM without either i440fx or q35).

Paolo

