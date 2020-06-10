Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD1D6C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 11:53:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B4CF2072E
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 11:53:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lY29rp3O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B4CF2072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59554 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jizIb-0000Pm-La
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 07:53:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42748)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sameid@google.com>) id 1jizHL-0007mY-U0
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 07:52:23 -0400
Received: from mail-qk1-x732.google.com ([2607:f8b0:4864:20::732]:35178)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sameid@google.com>) id 1jizHL-0001dz-2c
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 07:52:23 -0400
Received: by mail-qk1-x732.google.com with SMTP id n141so1681782qke.2
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2020 04:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=AsWJni585rbu9oO+RUeCjCor3O4RG4aDJfjlz9EI6E8=;
 b=lY29rp3OxJUZDjsiIp5aSoAdrZlKBY4+jfs2dJTxdq/RDUqcgxD0vw0Mhym3wXDNsr
 U2/1nRbqHCFN5XxNo0+to4YWtED4LEBWe3mHh3BdCcyO14nqlQfOW2/lYg3UZ/JKCjJI
 ZrLNvxv3DPZwaaBhkQkCoV90rkha5KU+V7oy6bblPmA7yjRvlczjd9eQhKIxZjP8ObqP
 aTeLbWaMkzTWv5BTUCC1pN6IK2Ob8rrM+WaKipXtDENBhYaaVrKMP/diwjDVquvQvHNA
 5whMbT0VNV5S/BRDPufk1gU+DZM4n9F6uUodeNACSL+BMqGsTvwPY9WWNpUtAFufzyXc
 ibvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=AsWJni585rbu9oO+RUeCjCor3O4RG4aDJfjlz9EI6E8=;
 b=SDXwu+yB789bUA6MEAnWtOmUnTkbOvL6wbfn6jg3UEL4IAEqHH6HQSFzmprTeFXlWu
 KbypMjJDHpoe8yQGNpAhYWqZkMJ69bCyuDbQH+yFfUe8YxMfvmNOUs5h10kFkmXX/4+q
 SOp5ambvjblVqI96NTdQN42U6RVY0pJfi2+VSHNCkYtwDOCctlGQXL/Ez8AJaeV0mC8f
 S0/CFFbOPUEd3jVnAUr4tkqrYuA4dk1p7TaS7i/6OPY8rEpF1fs0jMk/l6zMvli732OH
 9s8LWqKDVUJ4tJQaiImUB2BJRVTuNY5qDrgJuRpJNi62nOGiBczZVEf4kBMI0Ugv87Ge
 qgfQ==
X-Gm-Message-State: AOAM5339TJfQi/j28da4bdbhKb1vrfgFcCcyHDWeF+x1VK+yfS4jAVhE
 +rjOJZep+A8XptM+kz6elXvANu/xOyukJd66DUaPaQ==
X-Google-Smtp-Source: ABdhPJxtMjUNjfRlmBBnRy4ETH1Sc217BvETLzexmvxH19uM9hAEme5QAx214h+RHXzPmcmND9KTTOEx/jmB9B2Cc2g=
X-Received: by 2002:a37:9a4c:: with SMTP id c73mr2627428qke.450.1591789936586; 
 Wed, 10 Jun 2020 04:52:16 -0700 (PDT)
MIME-Version: 1.0
References: <CAFr6bU=LjeW5_eGtwL38cher2TM52skohuANNXN9EpO+mA-z8Q@mail.gmail.com>
 <f93b4d9a-4963-74e9-4f52-f95a187f6055@virtuozzo.com>
 <CAFr6bU=tzuQNQSm4AAdYHanmTDx6fpK64OvXST2MZ5s8LqhGMA@mail.gmail.com>
 <20200610113742.GC6947@linux.fritz.box>
In-Reply-To: <20200610113742.GC6947@linux.fritz.box>
From: Sam Eiderman <sameid@google.com>
Date: Wed, 10 Jun 2020 14:52:05 +0300
Message-ID: <CAFr6bUmxHQ6VHpd3NWDXhgGLoT4EG_LJrv9bjc0dxDE-ZQ8YqQ@mail.gmail.com>
Subject: Re: Clarification regarding new qemu-img convert --target-is-zero flag
To: Kevin Wolf <kwolf@redhat.com>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, 
 david.edmondson@oracle.com, eblake@redhat.com, Max Reitz <mreitz@redhat.com>, 
 Tony Zhang <tzz@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::732;
 envelope-from=sameid@google.com; helo=mail-qk1-x732.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -185
X-Spam_score: -18.6
X-Spam_bar: ------------------
X-Spam_report: (-18.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I see,

I thought qemu-img (by default) checks the virtual size of the disk
before starting to copy allocated data, zeroes out all of the virtual
size (slowly) and then writes all the allocated data except for
zeroes.

But from what I understand now, qemu-img finds that the target is raw
and can not be efficiently zeroed, so it just writes all the allocated
data, including zeroes, leaving unallocated gaps in the virtual size
unwritten.

I have an image of 800MB VMDK with virtual size of 24GB

So if the following:
qemu-img convert "${IMAGE_PATH}" -p -O raw -S 512b /dev/sdc 2>&1
Takes roughly 3 minutes and 40 seconds (qemu 3.1.0)

And:
qemu-img convert "${IMAGE_PATH}" -n --target-is-zero -p -O raw /dev/sdc 2>&1
Takes roughly 2 seconds (qemu 5.0.0)

This means that probably there are ~23GB of zeroes *allocated* in this VMDK,
I'll check that.

Sam


On Wed, Jun 10, 2020 at 2:37 PM Kevin Wolf <kwolf@redhat.com> wrote:
>
> Am 10.06.2020 um 08:28 hat Sam Eiderman geschrieben:
> > Hi,
> >
> > My target format is a Persistent Disk on GCP.
> > https://cloud.google.com/persistent-disk
> >
> > And my use case is converting VMDKs to PDs so I'm just using qemu-img
> > for the conversion (not using qemu as a hypervisor).
> >
> > Luckily PDs are zeroed out when allocated but I was asking to
> > understand the restrictions of qemu-img convert.
> >
> > It could be useful for qemu-img convert to not zero out the disk, but
> > do write allocated zeroes, I'm imagining cloud scenarios where instead
> > of virtual disks the customer receives an attached physical SSD device
> > that is not zeroed out beforehand (only encryption key changed, for
> > privacy/security sake) so reads will return garbage.
>
> But that's the default mode? Zeroing out the whole disk upfront is an
> optimisation that we do if efficient zeroing is possible, but if we
> can't, we just write explicit zeros where needed.
>
> --target-is-zero means that you promise that the target is already
> pre-zeroed so qemu-img can further optimise things. If you specify it
> and the target doesn't contain zeros, but random data, you get garbage.
>
> Kevin
>

