Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97576C47404
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 12:50:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D7B520830
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 12:50:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D7B520830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8OYR-0000C7-Ko
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 08:50:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55011)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1i8OU0-000585-TT
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 08:45:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1i8OTz-0001qM-UJ
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 08:45:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34502)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1i8OTz-0001q2-Oq
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 08:45:55 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E4E3EC051688
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2019 12:45:54 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id 32so7490019wrk.15
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2019 05:45:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=g44nFJ1SsY0lbUC3G+Qx38pKnVFzdqT6LtVvkp8TZIk=;
 b=oa2LWSt2dgZcpJwmSjve3hyd2SNE3+YXIcfsXkMx5RONIAI+rHnJtsAcXZtunS97nf
 dS8ux6ahZZ353DhWtY46Yee+Zj7TQmzQfbFly5NzJyNXPNqXk37uTJfT1ETEnC79mOdf
 ctrWirV1p94kyn2twcNAVu6LDB+mEx0aXcP67NjPYfUAG9+Ula9AxbRcNRnaVFx9HWcE
 YzzcNhDB1ZMhAtTRqDd4F2eG/0dj1AU0TdBqNKdgoNrnt9wiZ6ZEOss8/hvPw+fSseZA
 UKV2m2+VqvmdsU+8/I+iym8k8bZIql+TphDifaRkLUgzkqGAulO4TSGXTovMbihOWdis
 hqcg==
X-Gm-Message-State: APjAAAVmKm2D7p2iJi5gRtfX0DRi/KPUtYojz4dF3NewD90f7gTKyK8p
 80zmAXElviXavWivuBefNwhBBEbUe1TluB4M6ChDCaOdQut0VL+WrQ9/cq9HNCCL93hpYfHfGyV
 gd1MQIgzD+chrkRI=
X-Received: by 2002:a5d:46cb:: with SMTP id g11mr33351182wrs.268.1568292353371; 
 Thu, 12 Sep 2019 05:45:53 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzOpLihkVwBXjwIo8kdJU/L7rmD19r7M6bc0LT+xivkle6qi4qtmor/3awiHDVwIrZZOdx9ZA==
X-Received: by 2002:a5d:46cb:: with SMTP id g11mr33351167wrs.268.1568292353117; 
 Thu, 12 Sep 2019 05:45:53 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id o14sm15882462wrw.11.2019.09.12.05.45.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Sep 2019 05:45:52 -0700 (PDT)
To: dovgaluk <dovgaluk@ispras.ru>, pavel.dovgaluk@ispras.ru
References: <1566284395-30287-1-git-send-email-pbonzini@redhat.com>
 <1566284395-30287-16-git-send-email-pbonzini@redhat.com>
 <46af8966edd45c163d7d0bd974f557cd@ispras.ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <0b8ff49d-3df0-021f-eeb8-b4e0c51e8bd1@redhat.com>
Date: Thu, 12 Sep 2019 14:45:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <46af8966edd45c163d7d0bd974f557cd@ispras.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PULL 15/36] memory: fix race between TCG and
 accesses to dirty bitmap
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
Cc: Qemu-devel <qemu-devel-bounces+importer=patchew.org@nongnu.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 26/08/19 14:19, dovgaluk wrote:
> This patch breaks the execution recording.
> While vCPU tries to lock replay mutex in main while loop,
> vga causes dirty memory sync and do_run_on_cpu call.
> This call waits for vCPU to process the work queue.

IIUC there is a deadlock because VGA (from the I/O thread) is holding
the replay mutex.  Next time, please include a quick description of who
waits for whom. :)

I think it should be enough to wrap the do_run_on_cpu on replay_mode ==
REPLAY_MODE_NONE, since the I/O and vCPU thread are anyway running in
lockstep when rr is active.  (This reasoning should also be in a comment).

Paolo

