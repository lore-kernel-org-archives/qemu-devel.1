Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEC8DC4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 22:22:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B982C208CB
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 22:22:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hyurL5s7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B982C208CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgzGR-0006Hh-Vy
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 18:22:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40538)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alistair23@gmail.com>) id 1hgzEv-00054i-E3
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 18:21:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1hgzEu-0007iE-K6
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 18:21:05 -0400
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142]:40386)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1hgzEu-0007hK-B4
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 18:21:04 -0400
Received: by mail-lf1-x142.google.com with SMTP id a9so4942874lff.7
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2019 15:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=EmCUb7Sd5K47U8QRJi5Fjh3KdfOROof6Rd4uyxWUqbU=;
 b=hyurL5s7XT8Rumy4rSl7UbpXRe64f+gNmmzamqKgBp5DNGhzPBP800N0K8BuwCTZr7
 w3wnpXdo98nc97L9fATR8KGdogvz/efEjf4bwFbgn9Y0mvA0uwb71Ax7kW/QdD7VE+Ab
 ljYVahV/6xiLmZwABsyvzmF5CWGyg8yTbyj7koZdUB1H8AnqknMqHjGHLK5llreKCh7V
 xgduJFPHVkT+avx6gJTu/ZDCS3K1pcYBrEwG+/GPQXPYPATBx0QNkkzV84ZzIzXx7no4
 fnXiQmNkMl6DnNvJ1amw8T0A/DRCCEQUmhi9H7WHMtxXw7Q2WChoBJ4gi7x4YTb0XAWG
 /2ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=EmCUb7Sd5K47U8QRJi5Fjh3KdfOROof6Rd4uyxWUqbU=;
 b=KkOc2vvKTStrYOEnLqJn+RuiDGOsEB8t/kIaXY1Mu0sb/aFRrl20QkdZZTAYan4YGl
 FH4ILdh+v2rzEzI3cqHsATff5efIUSeQ6jbulpsG9SsuIdtsjVTkDlodpZ9Uu7MbpdB1
 BQ30R+jFQcb6xfX5UuNphod289OsXwAuhuUtdO+qJnLMnzMe9borKHlPG0LbMd6QY+S7
 gzr1zgAa18O9x7UQh9xoCsKA6NGL+DV6V5o+9OV5CoUwXBy6/Y9eZgpH7eg8PMDI5z7A
 rmbG/84VvpfATSLh2WHy0n3eD3WDUZNa2JynTQot+NLZxans0GuOkawwY56e01yDN/aU
 JI1w==
X-Gm-Message-State: APjAAAUv/IiYswzKGJCGg1Z9N3ep6OMcT7FMZohRCKe0cvDBMnftrY3Q
 yDJPpNeGsL9vzZUdyQhSSP6V2XgLcLUVSYn36fo=
X-Google-Smtp-Source: APXvYqwmWfHehE+/s9sUWOyK5jBRK+AS+CvrNoN0xddify5wwMRSDlnm9RgK8dduUvoO3Zbann48fF8c1DMgEzGeH3k=
X-Received: by 2002:ac2:4990:: with SMTP id f16mr5941350lfl.93.1561760462846; 
 Fri, 28 Jun 2019 15:21:02 -0700 (PDT)
MIME-Version: 1.0
References: <97104495f5c945d25315aff1bd618e1a7bacf34c.1561589072.git.alistair.francis@wdc.com>
 <1bd3ffcd-3f91-ecb9-2315-da7125f1dcdd@redhat.com>
 <CAKmqyKPeo4XXVy3onoM4W14N5Nj7CFWX=JpDT-JQQRUPw5CQ3Q@mail.gmail.com>
 <4428dc80-9ace-3bb0-a497-e3d416199bfd@redhat.com>
In-Reply-To: <4428dc80-9ace-3bb0-a497-e3d416199bfd@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 28 Jun 2019 15:18:02 -0700
Message-ID: <CAKmqyKMRSJTMxZ5c-yyuownYF8vJLYrzr92cE4rkiTdP7tmUzg@mail.gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::142
Subject: Re: [Qemu-devel] [PATCH v1 1/1] hw/scsi: Report errors and sense to
 guests through scsi-block
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
Cc: fam@euphon.net, shinichiro.kawasaki@wdc.com,
 Alistair Francis <alistair.francis@wdc.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jun 28, 2019 at 3:14 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 28/06/19 23:57, Alistair Francis wrote:
> >
> > I tried to run my VM with option "-drive
> > ...,rerror=report,werror=report" as he noted, but the eternal loop
> > symptom still happens when host block-scsi device returns EIO. Then I
> > believe EIO should be added to the report target error list.
>
> What is the sense data he's seeing?  EIO is a catch-all return value
> for scsi_sense_buf_to_errno so I'd rather be more specific.

I'm not sure, he is CCed to this email so he should respond with more
information.

Alistair

>
> Thanks,
>
> Paolo

