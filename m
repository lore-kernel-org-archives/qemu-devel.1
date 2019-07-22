Return-Path: <SRS0=EA86=VT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00439C76190
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 17:14:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAFEE2190F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 17:14:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAFEE2190F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpbtS-0000bP-5d
	for qemu-devel@archiver.kernel.org; Mon, 22 Jul 2019 13:14:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48050)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hpbtH-0000Cb-Vc
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 13:14:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hpbtF-0004VD-Se
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 13:14:23 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34690)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hpbtE-0004UP-0N
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 13:14:20 -0400
Received: by mail-wm1-f67.google.com with SMTP id w9so29233635wmd.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2019 10:14:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=j7gTr6fdZGqMpuDEjPYlixMkW2ve2LA6ilw4FI+cu08=;
 b=aiUPhWx51brbmlPrApjZugxMU+aGHvsxd81tUWD4PLLMCObD9J8oUx2QA/r8AQQp9g
 bEFZ01jWzqSvadjiL6r50iyY0j14ZLGQPdb+aYrMCO8PohPlpEthUeOFy+ly/aWo3i35
 dkuUDGAmyZMHC6NEdunxoobHbvjnXSOu7uCRxxWJuWA403sCeY0NEYssaPl4YvCZz8OV
 Z1H8j3MGg2qexQsbJRKmuOW5ey7Iw4wGWo6Y3RWJaoFt4/IMRdrJy4V1NWv3VpQ4wDou
 0rtXIVXPjiOx/wL1AP/q3lM54WN71Hl62mQTyzQ2LN0A2oZ8xk6rzejkZg1jzxx2zaPj
 4HBg==
X-Gm-Message-State: APjAAAUaNZWa7zYEJ7S1SV+F1PzWuPm8pdBFDSQos037yL1r9IH0OYdx
 BAuBQgFQgG85/1aITG1q4f8EoSyEbhM=
X-Google-Smtp-Source: APXvYqzQRwMV7/jQdEAGBSN5HQcYZgA6wCS2XkOfF1x9+k9Zhdm1a/9opn7p9uas5/UwP6rdkeyEbw==
X-Received: by 2002:a1c:238d:: with SMTP id j135mr13389149wmj.39.1563815657260; 
 Mon, 22 Jul 2019 10:14:17 -0700 (PDT)
Received: from [192.168.1.38] (62.red-83-42-61.dynamicip.rima-tde.net.
 [83.42.61.62])
 by smtp.gmail.com with ESMTPSA id y12sm18473816wru.30.2019.07.22.10.14.16
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Mon, 22 Jul 2019 10:14:16 -0700 (PDT)
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20190722161657.8188-1-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <de2716e0-06a4-30da-0548-faeed446f4bd@redhat.com>
Date: Mon, 22 Jul 2019 19:14:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190722161657.8188-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.67
Subject: Re: [Qemu-devel] [PULL 0/2] More fixes for QEMU 4.1.0-rc2
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

On 7/22/19 6:16 PM, Paolo Bonzini wrote:
> The following changes since commit 23da9e297b4120ca9702cabec91599a44255fe96:
> 
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20190722' into staging (2019-07-22 15:16:48 +0100)
> 
> are available in the Git repository at:
> 
>   git://github.com/bonzini/qemu.git tags/for-upstream
> 
> for you to fetch changes up to 20b25d239ab7a94bb8bff3d0f13a9527ee75cf10:
> 
>   i386/kvm: Do not sync nested state during runtime (2019-07-22 18:16:05 +0200)
> 
> ----------------------------------------------------------------
> Two more bugfix patches that came in over the weekend.
> 
> ----------------------------------------------------------------
> Jan Kiszka (1):
>       i386/kvm: Do not sync nested state during runtime
> 
> Zhengui li (1):
>       virtio-scsi: fixed virtio_scsi_ctx_check failed when detaching scsi disk
> 
>  hw/scsi/virtio-scsi.c |  6 ++++--
>  target/i386/kvm.c     | 10 +++++-----
>  2 files changed, 9 insertions(+), 7 deletions(-)
> 

Replying to cover for Peter, not sure it is worthwhile another pull
request (if Paolo has the time for...), but some parenthesis got
mojibaked in patch #1.

