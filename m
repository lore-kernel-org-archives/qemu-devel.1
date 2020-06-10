Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CC77C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 06:30:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18FFE20760
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 06:30:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tQ0dOEJs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18FFE20760
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52588 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiuFP-0000Xu-B5
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 02:30:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50056)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sameid@google.com>) id 1jiuEI-0008AV-6w
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 02:28:54 -0400
Received: from mail-qk1-x734.google.com ([2607:f8b0:4864:20::734]:36810)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sameid@google.com>) id 1jiuEG-0006He-1m
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 02:28:53 -0400
Received: by mail-qk1-x734.google.com with SMTP id 205so1054228qkg.3
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 23:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=2n+XE8Tr8pybo2KfrAUvx5idTx7zNnFLAA1T70anWLk=;
 b=tQ0dOEJsCtiYFOCEUgsH1U2wsZXecnNW65ZiSCd6MoylS6F974P1QpuZ3jwQKE0GJv
 1lwOq4uQR+qVPrzJYkVrE0elsmVgwwSlFJ7l+iiM8AiKH1hDivUqDKmRz55iIOY/HuNU
 8X+EWWCXfHF9uLwThqeUB52QRnrjwwanr54d6n+6TMK5w0MfNqvr57qUbQ0iyID36XrC
 8BagbuAVF0yHgsdpx+iEXNkESyI38ZN6ufYNGvD/ySd7AY7vJ9IlXRqskSnbdzp72IN6
 QLYlk/NrEEANSP5OpzmUmEYfifu6peFbpRksh5KRMYTMEhGgxp8WIb25LhZIg+rbO37h
 Q6Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2n+XE8Tr8pybo2KfrAUvx5idTx7zNnFLAA1T70anWLk=;
 b=MhAitNNbJ+cE+oK1wk9kzM3KzdxwpYSJ69rjhMRrxXCw/QuLAk0h7zCYrp1gp/+NOc
 iP0QjgH1CJoCyFt2JVZZzETZV/CjOQ1Gu1pBQaHbt3w0KURYr9ikqjuz4fU9AMno3BQX
 N1bFv3amxIkhB7K34C604/IYIG3Ftojh4bLbWSH7R9og2ov6dEtl3ATmCt+NOtOds6F9
 +9ms7jBuVqdgyWKuatKdtaD7BYzeiLzZWhIqWt+p7wK1RZfv7PFhES/n18tYeWW+OJR2
 IAm64MttAGLdXpVwNMwU6CDwzQkfInSVVjb/iO0JoCEtlae9KpHNj/bq04bny5SPGhrT
 zKng==
X-Gm-Message-State: AOAM530dBDLYvtR9C7AghOAZ9nIOsYnYhbj0ylqdMC5zT5mbW4joksLR
 XQpovLffKr3qwwgcSowzJO8kdhju4aYs31e5Mnzidw==
X-Google-Smtp-Source: ABdhPJxppZqN6Hb36MyeEuXe0u3FJbvNQYEZfFzS1XosewdhXXcmdeWxGwHe4Ex02bjblFzHOr0v9ANJycyoVB2f3XY=
X-Received: by 2002:a37:9a4c:: with SMTP id c73mr1585588qke.450.1591770522618; 
 Tue, 09 Jun 2020 23:28:42 -0700 (PDT)
MIME-Version: 1.0
References: <CAFr6bU=LjeW5_eGtwL38cher2TM52skohuANNXN9EpO+mA-z8Q@mail.gmail.com>
 <f93b4d9a-4963-74e9-4f52-f95a187f6055@virtuozzo.com>
In-Reply-To: <f93b4d9a-4963-74e9-4f52-f95a187f6055@virtuozzo.com>
From: Sam Eiderman <sameid@google.com>
Date: Wed, 10 Jun 2020 09:28:31 +0300
Message-ID: <CAFr6bU=tzuQNQSm4AAdYHanmTDx6fpK64OvXST2MZ5s8LqhGMA@mail.gmail.com>
Subject: Re: Clarification regarding new qemu-img convert --target-is-zero flag
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, david.edmondson@oracle.com, 
 eblake@redhat.com, Max Reitz <mreitz@redhat.com>,
 Tony Zhang <tzz@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::734;
 envelope-from=sameid@google.com; helo=mail-qk1-x734.google.com
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

Hi,

My target format is a Persistent Disk on GCP.
https://cloud.google.com/persistent-disk

And my use case is converting VMDKs to PDs so I'm just using qemu-img
for the conversion (not using qemu as a hypervisor).

Luckily PDs are zeroed out when allocated but I was asking to
understand the restrictions of qemu-img convert.

It could be useful for qemu-img convert to not zero out the disk, but
do write allocated zeroes, I'm imagining cloud scenarios where instead
of virtual disks the customer receives an attached physical SSD device
that is not zeroed out beforehand (only encryption key changed, for
privacy/security sake) so reads will return garbage.

Sam

On Wed, Jun 10, 2020 at 9:16 AM Vladimir Sementsov-Ogievskiy
<vsementsov@virtuozzo.com> wrote:
>
> Hi Sam!
>
> 10.06.2020 08:28, Sam Eiderman wrote:
> > Hi,
> >
> > 168468fe19c8 ("qemu-img: Add --target-is-zero to convert") has added a
> > nice functionality for cloud scenarios:
> >
> > * Create a virtual disk
>
> What is the format of your target?
>
> > * Convert a sparse image (qcow2, vmdk) to the virtual disk using
> > --target-is-zero
> > * Use the virtual disk
> >
> > This saves many unnecessary writes - a qcow2 with 1MB of allocated
> > data but with 100GB virtual size will be converted efficiently.
> >
> > However, does this pose a problem if the virtual disk is not zero initialized?
> >
> > Theoretically - if all unallocated blocks contain garbage - this
> > shouldn't matter, however what about allocated blocks of zero? Will
> > convert skip copying allocated zero blocks in the source image to the
> > target since it assumes that the target is zeroed out first thing?
> >
>
> Yes, the feature is only for really zero-initialized target, it will skip "allocated" zeroes as well.
>
> What you want - copying only allocated blocks of backing-supporting format - looks like "top" mode of
> mirror and backup block jobs. Didn't you considered using qemu itself (in stopped mode, i.e. cpus are
> not running) or new qemu-storage-daemon instead of qemu-img? With this approach you'll have the whole
> power of QMP commands to manage block-layer, including block-jobs.
>
> --
> Best regards,
> Vladimir

