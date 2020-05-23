Return-Path: <SRS0=y3lU=7F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4568AC433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 23 May 2020 17:19:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 163C120723
	for <qemu-devel@archiver.kernel.org>; Sat, 23 May 2020 17:19:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=braap-org.20150623.gappssmtp.com header.i=@braap-org.20150623.gappssmtp.com header.b="SQilyH2p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 163C120723
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=braap.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jcXnh-0003c9-5x
	for qemu-devel@archiver.kernel.org; Sat, 23 May 2020 13:19:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46284)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cota@braap.org>) id 1jcXms-0003Bs-BL
 for qemu-devel@nongnu.org; Sat, 23 May 2020 13:18:18 -0400
Received: from mail-qk1-x743.google.com ([2607:f8b0:4864:20::743]:40988)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cota@braap.org>) id 1jcXmr-0005wh-4F
 for qemu-devel@nongnu.org; Sat, 23 May 2020 13:18:18 -0400
Received: by mail-qk1-x743.google.com with SMTP id n11so8438024qkn.8
 for <qemu-devel@nongnu.org>; Sat, 23 May 2020 10:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=braap-org.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=4tywWfHudHq34bR3X8tdUEUxGoFslvLX2pP6kbQjo4Q=;
 b=SQilyH2pVyqwOoHExjbaf8Fr2QIb6f8oSvQfmoejraZwcaGeF8JDr4UomfoR7OezMP
 J+tnXzQIui+5qZpnTtTGXYU2g/fWIYxJWb7zJULXHnOduHjHJaycL4B8jJMQZR7KqRm1
 T39iVtLP3GWJ4FB4blh4JI83VglIpnXfparPQtEu3J5f3YjEilBtPVi9QdFLUqQSuQO6
 8nRKFvcztF+MhO4TUXGH7Ny9yKC3TxyPblp3dp6xUHMuv/oBz+XAyG6PdQQgd7IZrwOU
 llJMc+DK3bdHDyUfB1UnxirsMSo5xJNsKJ3U71b70QEvgXOBjJtoZZP/7YPjWhbyePRu
 vJzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=4tywWfHudHq34bR3X8tdUEUxGoFslvLX2pP6kbQjo4Q=;
 b=IzV+4ZT2LVl8hyhLoKCXv3lCy0ihIuiUGr0rVsGCwla8J00QjugycpN8yFmPN5f9lZ
 ut34jUCshoQ5S7Ty6UIt7PqL+0a3bvDkdbG+DRaUabyjh9zuv48S5LH9f75XXkizi1Zp
 F1vKy69Th26dvZ/bZgXTsV7ls9yOpkRSbe1mlojzhF/0Bf/rZw1ae6DszyJOWt37K8qE
 yZTWxIl0pGRh30hx836RyM70nD0QNmKPkyIdcBkNNWAS1Td7iPYzGkAQWtY0DRzy14qZ
 FH8zJVFnjKV3LxKHl6/gn+iIxdXNS+Sdf6cNMYkDCqw33osaYq5YPABJdVGLFPRcLJFn
 faYw==
X-Gm-Message-State: AOAM530OmKe4vooN0Xli0jVaC02SNHCrDD8ny8xiliXkl3nGvC5ZwNS0
 kHszZX75xaRqf2BRj2NhhUApVd+zsXk=
X-Google-Smtp-Source: ABdhPJwHB236W3RYimt0l8T9mSZnpCiuF7fD2VoHt5N2DsA2OyGr5wnvNMQ9MvRcQML9bKYPgrXbXg==
X-Received: by 2002:a05:620a:2019:: with SMTP id
 c25mr19982291qka.320.1590254295373; 
 Sat, 23 May 2020 10:18:15 -0700 (PDT)
Received: from localhost ([70.19.54.161])
 by smtp.gmail.com with ESMTPSA id w14sm11042974qtt.82.2020.05.23.10.18.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 May 2020 10:18:14 -0700 (PDT)
Date: Sat, 23 May 2020 13:18:14 -0400
From: "Emilio G. Cota" <cota@braap.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 18/19] target/arm: Fix tsan warning in cpu.c
Message-ID: <20200523171814.GA382220@sff>
References: <20200522160755.886-1-robert.foley@linaro.org>
 <20200522160755.886-19-robert.foley@linaro.org>
 <CAFEAcA8gqM1vn4eV5XK-2qOQ47ugO9OsFWA_+MgRpO4Vb5JFOQ@mail.gmail.com>
 <CAEyhzFsS3g-OQ0JzcDVfaaKAt9632XmKfzC0tfy0VmF_RRB2Og@mail.gmail.com>
 <CAFEAcA-u_vAGtn7htspqkN56Xhb-WH_x8dF7GYs46zWaBLMEvA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA-u_vAGtn7htspqkN56Xhb-WH_x8dF7GYs46zWaBLMEvA@mail.gmail.com>
Received-SPF: softfail client-ip=2607:f8b0:4864:20::743;
 envelope-from=cota@braap.org; helo=mail-qk1-x743.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_SOFTFAIL=0.665,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Peter Puhov <peter.puhov@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Robert Foley <robert.foley@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, May 22, 2020 at 23:36:18 +0100, Peter Maydell wrote:
> So is this:
>  (a) a TSan false positive, because we've analysed the use
>      of this struct field and know it's not a race because
>      [details], but which we're choosing to silence in this way
>  (b) an actual race for which the correct fix is to make the
>      accesses atomic because [details]
> 
> ?

It is (b), as shown in the per-cpu lock series. In particular,
see these two patches:
- [PATCH v9 33/74] cpu: define cpu_interrupt_request helpers
https://lists.nongnu.org/archive/html/qemu-devel/2020-05/msg06322.html
- [PATCH v9 39/74] arm: convert to cpu_interrupt_request
https://lists.nongnu.org/archive/html/qemu-devel/2020-05/msg06328.html

Since a more thorough fix is included in that other series, I think this
patch should be dropped from this series -- I'll post a reply to patch
00/19 with more details.

Thanks,

		Emilio

