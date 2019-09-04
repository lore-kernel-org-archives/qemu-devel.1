Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25D2AC3A5A2
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 02:17:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F02C1206BB
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 02:17:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F02C1206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52728 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5Krt-0007T9-00
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 22:17:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40552)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1i5KqU-0006O1-Ay
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 22:16:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1i5KqO-00089I-LF
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 22:16:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45888)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1i5KqI-00085Z-6n
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 22:16:21 -0400
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 364DE8553A
 for <qemu-devel@nongnu.org>; Wed,  4 Sep 2019 02:16:16 +0000 (UTC)
Received: by mail-pf1-f197.google.com with SMTP id t24so5264737pfe.23
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2019 19:16:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=LczehYJriNMVPyBcXcSRQNzVxF3xXTD0Ti3R2yiPpDY=;
 b=JLYPsuhyvmwi9dqCSpAviww8zPPFtWJf8t5VXEPS/LgzybTUXqta5Cd+HEIvcs9BpT
 7sjCLZgGX7X02R92vDOREwtAv2Nu/b5VD6kSf7uuBRRcDcYdH7CeGl3oW+7Ldy+Pi/3B
 fAaj7gflFXFsGt31mAIMBOtLB+/+e2ZCHdXItAKFQrX3VV+6p9UqaYdkF0Qr5bq3mRLA
 H5M78Q3XERkeJGzP8BxXok5X7Om9T2GwrKwSsdgCBlUCzUmcAtXkOCqrZ695V8xsJH3+
 2n1z/PNCgZifhcyqoEwQb8eepZZH8C+mUhRfs5dg23aST8cyw/QvQc1CJPccT50waTQh
 IEZA==
X-Gm-Message-State: APjAAAVDfhSbYe26GHd7jaFpqNbYtygJqyqu5Wnp3Z8Q1DaWZoboN6C8
 7Fw+JuovUT1wbgesVAdBSNMbkJAjlEdWl1vF33/Pj+VfbvuNGjZdXQ2U00UhlmM0Wf8IEaoRxnY
 PQL+U84vRD2nsCeU=
X-Received: by 2002:a17:90a:c386:: with SMTP id
 h6mr2490053pjt.122.1567563375574; 
 Tue, 03 Sep 2019 19:16:15 -0700 (PDT)
X-Google-Smtp-Source: APXvYqw4+b2xmgNn8cn709RXMhSigvaxqkBQWmtcSVTB48MZEdD9fyVEhF7/8oAnKdBrZYv1Bk4zVQ==
X-Received: by 2002:a17:90a:c386:: with SMTP id
 h6mr2490040pjt.122.1567563375370; 
 Tue, 03 Sep 2019 19:16:15 -0700 (PDT)
Received: from xz-x1 ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id f27sm16778884pgm.60.2019.09.03.19.16.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2019 19:16:14 -0700 (PDT)
Date: Wed, 4 Sep 2019 10:16:03 +0800
From: Peter Xu <peterx@redhat.com>
To: John Snow <jsnow@redhat.com>
Message-ID: <20190904021603.GD30402@xz-x1>
References: <20190903120555.7551-1-philmd@redhat.com>
 <6aca73a4-1567-4952-14eb-ecd3c115acad@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6aca73a4-1567-4952-14eb-ecd3c115acad@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] cutils: Move size_to_str()
 from "qemu-common.h" to "qemu/cutils.h"
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
Cc: Kevin Wolf <kwolf@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 qemu-block@nongnu.org, qemu-trivial@nongnu.org, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 03, 2019 at 02:57:31PM -0400, John Snow wrote:

[...]

> Seems proper. It must be an oversight to begin with that we declared it
> in qemu-common but defined it in cutils.

Porbably true..

> 
> Reviewed-by: John Snow <jsnow@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

Thanks,

-- 
Peter Xu

