Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F37FC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 09:34:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFACE20706
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 09:34:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OUVcOiqB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFACE20706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46732 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAVLV-0007Qp-9g
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 05:34:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44124)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kAVL0-0006zV-4l
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 05:33:54 -0400
Received: from mail-ej1-x644.google.com ([2a00:1450:4864:20::644]:41661)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kAVKx-0007c5-As
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 05:33:53 -0400
Received: by mail-ej1-x644.google.com with SMTP id b17so7357800ejq.8
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 02:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=s+Sd+Stsb37fNw7VzduXNaMSen+ESVb2zhrpl7ocq0U=;
 b=OUVcOiqBmIizySoIzzOi16u2aO23FeqcQMhnCFXcxpFZLjaHqm2x7qmh3z/LmMqdrn
 i/pM82gH5U/pTRZCbmTylOV6W3pFxPVLyMeDJKD6OzPyQLu8rdPAboN+iPyKc/7XfV2d
 KvOppifKpKR21t18Hq1rZNnDdihTSlIfza6PGSvYW4VUfDJSLNXuiE2bxeNIROMllS36
 soNajqOe8VS5R3/Gk8ATeZTOku9+3rM6bKCWQVpKbt3nO1jVy76aZyUvlrUCIgENbGB4
 9RcKcgAK5Vt6+eCdDPG+pNmJqNygdmiv3RGFBw8VqfuhsClRD/rSnjndsKomi41OXLs5
 IFSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=s+Sd+Stsb37fNw7VzduXNaMSen+ESVb2zhrpl7ocq0U=;
 b=R6iIaCOvKpAMBvSQHNUWnk4HW7id7HC06xICC23PvcMkPyArkO8yrxxXgFnS/SRyD9
 MfZ0SniVzrcY3hIYHhzmfEvLMFLpyyW5WzH10Nluz1a2l5BnOCrqb7XIaXYfhYcJgP7Y
 JPcmwEzbEx/GY93/jkNCdVtK4OVHTV/uTOo9jWduPH2UlmWFAIXJ/QTpQCIrO/KZ+CdN
 3w/n9TJZ2SLcLVma7wH9m5LF2xaRO2pHkTePSjqYmvZXT9XS15FVxjVgVkmVAfMyBiqz
 BJlqQfzF69CTMPVtMde+4fSPesmolNBX3nB54i+4tcuLx4uQwkezy3o4kWipMXIW7ZTJ
 JApg==
X-Gm-Message-State: AOAM530S634Cav+d1Z5UZ69S2jyu8S3oeiyYJOM19yoWvfiB672XLfCS
 03Rzy8ODaCSYpjxsrBWXIl6ro9JT+EgzrW/k1j2ORg==
X-Google-Smtp-Source: ABdhPJzeCInZQv0oQAKLwohzthVBcKijvqTigN83Ee2NcjVgjFvAyPjWBB2g7JLMhu/xOuvcSNpAl1CowFNT2GDIB3E=
X-Received: by 2002:a17:906:b814:: with SMTP id
 dv20mr9561599ejb.4.1598348029478; 
 Tue, 25 Aug 2020 02:33:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200821205050.29066-1-jcmvbkbc@gmail.com>
 <8b20adcd-97e9-0f8f-1854-b9809060d6cd@amsat.org>
 <CAMo8BfKnW7oEe76akdszPh46R1GVU2kuGfTg3T7ypVHQnzDzTQ@mail.gmail.com>
 <CAFEAcA8sY720+g9ms4EyrGEfHnZaDK-W81Jb=RS0J+V9kCc68g@mail.gmail.com>
 <CAMo8BfK+LOyc+HSeBWWyJPEJKGzjJSVqAZ9ZE_XmC3bCfN60fA@mail.gmail.com>
In-Reply-To: <CAMo8BfK+LOyc+HSeBWWyJPEJKGzjJSVqAZ9ZE_XmC3bCfN60fA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 25 Aug 2020 10:33:38 +0100
Message-ID: <CAFEAcA9SwjPqucXCudSGWpTicfXCS1YXUKGDU9XC1bg7MaP1AA@mail.gmail.com>
Subject: Re: [PULL v2 00/24] target/xtensa updates for 5.2
To: Max Filippov <jcmvbkbc@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::644;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x644.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Taylor Simpson <tsimpson@quicinc.com>, Richard Henderson <rth@twiddle.net>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 24 Aug 2020 at 22:54, Max Filippov <jcmvbkbc@gmail.com> wrote:
>
> On Mon, Aug 24, 2020 at 2:33 PM Peter Maydell <peter.maydell@linaro.org> =
wrote:
> > On Sat, 22 Aug 2020 at 20:48, Max Filippov <jcmvbkbc@gmail.com> wrote:
> > > On Sat, Aug 22, 2020 at 3:20 AM Philippe Mathieu-Daud=C3=A9 <f4bug@am=
sat.org> wrote:
> > > >
> > > > Where does that come from?
> > >
> > > Generated by xtensa processor generator, as one of many output artifa=
cts.
> >
> > Is there anything different with the source for these cores
> > compared to the ones we already have in the tree, or are
> > these just "more cores, generated the same way as the old ones" ?
>
> They are generated the same way as the old ones, but they have different
> configurations: they support FPU2000 and DFPU opcodes implemented
> earlier in this series. I've added them to enable testing of these opcode=
s.
> de233_fpu is supposed to be a platform for further xtensa gcc development=
.

OK, in that case I don't see any reason why we should keep them
out of the tree. Which isn't to shut down the point Philippe has
raised about generated sources, just that there's not much need
to block this pullreq while we have that conversation since it's
not a change from the status-quo.


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.2
for any user-visible changes.

-- PMM

