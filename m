Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49FF0C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 15:02:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79AEB2222E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 15:02:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="DIsiB7mu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79AEB2222E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36980 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kT4lk-0001mg-RK
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 11:02:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43180)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kT4dX-0000ZZ-HV
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 10:53:48 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:44308)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kT4dV-0002DD-Tq
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 10:53:47 -0400
Received: by mail-wr1-x444.google.com with SMTP id t9so3814610wrq.11
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2020 07:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=xkeIIQG0s8LTAZJ25Jr1rcpbzSgx7DGz3el5AiLHREA=;
 b=DIsiB7muMTiGjzAF6gqq559BAykYVvofJXbsQYehd5m0M+zmzAAMj9PKHIkDSNiIQD
 6hhqFOh5AKrN9dMjiKVn54uyHJQo6Z6VPgBQdRQQgbN+2YhUZgUlAWUoQHXgdSBKonrZ
 UM7Q3vk8ZlKyjkTWBYaT45tZLsy59dWvzkr3Uvo+vlysYfsxRD65Z6hcxS1y6mZXGdiy
 eApPlQEdtx3DrtHKaBvILXuKjOHaUbrjfkR6w+72o0w6GvlRyg0nZJlhZ3jHNByi7uv/
 6QgLfl9A/+7a+2GS9WNW/xaGQ1HB43rpWKU3Mmnvzvexga+BFc+eVX34zKbh+3JbUVsH
 b6kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=xkeIIQG0s8LTAZJ25Jr1rcpbzSgx7DGz3el5AiLHREA=;
 b=gfG1dce63i7+cnbt71wrxPzmuvJHWMOG6BizQN9K18kVxk561yk7LBeconQSOuFc1m
 R1tjPc7i3juxvMljw8ouAQ10g/v7qmhqyouppTLO6NOxS2jonIkfWY/rYa5cNnCW1eZx
 JNrz56a9FAbAlcBCfE+L1q12w1ELNuAUdlOP1bM/sRpIcMnXK6wUfS6TDQUbC20pnmbW
 0CEQsHrZvSAnmu2wf9ixyl4Dt3LEq+Mtrs+/5v048unPIJxOUpJloZLRUZXnOncwqS4i
 Z0o9O0tO1pHgqDqaF1RXGvQflMQFTLtuGiMbXsBpDuFcXTcfI+rrMMes2AE5a3x73VWf
 AaRw==
X-Gm-Message-State: AOAM531QHHX4o2OWjWnJ3MHvSWnszX/zjc1oPvpzRF+xbCx/Rko0Tug5
 9WdFeADquj30sO1n5Zbz62wXu09dNB3C0Jh9JB2IRw==
X-Google-Smtp-Source: ABdhPJxnm1LlIeuDVecr1qHVEM1TfPyFZ9vk7UfhrkKRKpubGHIBhD3w+eavKxpoBjU9UV1HseZ4Sy52ungxdoemTVs=
X-Received: by 2002:adf:9f0a:: with SMTP id l10mr4245539wrf.427.1602773624559; 
 Thu, 15 Oct 2020 07:53:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200929142501.1057-1-ani@anisinha.ca>
 <105B94CB-1345-49FB-B296-F5236E448BC3@anisinha.ca>
 <72e35a9d-21f4-095d-1ae9-9ed33842dd24@redhat.com>
 <CAARzgwyJ2Cy286wWoo6G+mMZbGQRVyChxEQV++oLpVY+_MOU+g@mail.gmail.com>
 <ccc5797e-e3d0-6f73-27c2-cdc6c0878320@redhat.com>
In-Reply-To: <ccc5797e-e3d0-6f73-27c2-cdc6c0878320@redhat.com>
From: Ani Sinha <ani@anisinha.ca>
Date: Thu, 15 Oct 2020 20:23:33 +0530
Message-ID: <CAARzgwycG=xuSBvw+HNuBfmhc5Ci-ZfRKPhLPk5egW3_DZyP-w@mail.gmail.com>
Subject: Re: [PATCH v5] Add a comment in bios-tables-test.c to clarify the
 reason behind approach
To: Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: none client-ip=2a00:1450:4864:20::444;
 envelope-from=ani@anisinha.ca; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: Laurent Vivier <lvivier@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Oct 15, 2020 at 7:29 PM Thomas Huth <thuth@redhat.com> wrote:
>
> On 15/10/2020 13.28, Ani Sinha wrote:
> >
> >
> > On Mon, Oct 12, 2020 at 19:43 Thomas Huth <thuth@redhat.com
> > <mailto:thuth@redhat.com>> wrote:
> >
> >     On 12/10/2020 16.07, Ani Sinha wrote:
> >     > Request to queue this patch with the next pull.
> >
> >     I can take it via qtest-next in case Michael / Igor do not plan to send a
> >     pull request any time soon.
> >
> >
> > Michael or Igor, care to comment?
>
> FYI, patch got merged:
>
> https://git.qemu.org/?p=qemu.git;a=commitdiff;h=07f5903c852de10fa7

Thanks!

