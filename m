Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79B3CC433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 17:48:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 490BA2053B
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 17:48:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MeeCjkui"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 490BA2053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56816 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsVDt-00057T-I0
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 13:48:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44746)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leobras.c@gmail.com>)
 id 1jsVDF-0004bj-QO; Mon, 06 Jul 2020 13:47:29 -0400
Received: from mail-qk1-x741.google.com ([2607:f8b0:4864:20::741]:37994)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <leobras.c@gmail.com>)
 id 1jsVDE-0006XL-7b; Mon, 06 Jul 2020 13:47:29 -0400
Received: by mail-qk1-x741.google.com with SMTP id e13so35619348qkg.5;
 Mon, 06 Jul 2020 10:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=message-id:subject:from:to:cc:in-reply-to:references:organization
 :mime-version:date:user-agent:content-transfer-encoding;
 bh=QqyagR0cCLEnmduIUcuxSmnmTikYnG6rB5q0IMBXseI=;
 b=MeeCjkuiWYTVUMY9AgU3mCo9gUKQ2tsowGVaqrgB+N9MuFCRrzAYVWlilau08lcIC4
 +16h2QtfTWiNN5n5FbHTszeAUdi7x07kiF5+ddtsZuAF80fV/sPSlcMt/w2VOJuBJo6p
 wq4Su/pQ31HMNbrmtV8BdXpdD1XTlv6BvapEFi/df34YrcHgAE1pIRt9vrRYiMA87SOq
 JucLPgrrVbh8JrGWp6zbNBJdCnc5uOEqU51pmdk0H3rplBY0Czw5XEKezjkZPrrWT4Rq
 GN1hTE7WKcBUJwEjkPLcskyG8grJpgVgPUWqxhUTqbgidCdYokdB5a3stXB5RknN/LuE
 yyrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:in-reply-to
 :references:organization:mime-version:date:user-agent
 :content-transfer-encoding;
 bh=QqyagR0cCLEnmduIUcuxSmnmTikYnG6rB5q0IMBXseI=;
 b=EM5i755aR3/3V4gumJS8ah4TqWg3G5QyXVbOQZ0BuJiWZsbAzbzkc65f2cEZB6WN76
 wBqwv3tzjQv6c4rnNCK93YSPX4aUuU9ZJ4zWBMbKEQpIBPOhliUIsH6/kJJgfBX7u7R+
 MkWCZ+giV3rmBDA3xUojwmF6vCXriPCgwarZ46pzYHqPKpyqgefJZ4JiQM6ZOsC7g2rA
 5c2Rp2ddzNzDm/8kqtDVc3kmksPpL5tjQNrE4wHlNdDQ2ZZnYFZBIqdsvrrf1XppXxhI
 iXZ+R/ls/kkKmZv6A0VCDydhZOl6+bict0Lezf1mABNlD7HunbbKzJsTAG6bmI4h4lue
 oLGw==
X-Gm-Message-State: AOAM531leioN7AQ71HRqYj7Bz7mKrMY0c+esCB3YgtHelNjFJxST0fb4
 1+VEjwUbvYMwg+MB7dwFnM0=
X-Google-Smtp-Source: ABdhPJxMeWhn+ZA8Ws4seyby5qITkiTtf/4EMU9+6idJG26GJ0wHAEdlJSYhgND2SXevMZYos1AG9g==
X-Received: by 2002:a05:620a:205e:: with SMTP id
 d30mr49532395qka.450.1594057646125; 
 Mon, 06 Jul 2020 10:47:26 -0700 (PDT)
Received: from LeoBras (179-125-148-98.dynamic.desktop.com.br.
 [179.125.148.98])
 by smtp.gmail.com with ESMTPSA id d135sm19443874qkg.117.2020.07.06.10.47.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2020 10:47:25 -0700 (PDT)
Message-ID: <29a2bce461f47a52beb0377640216b3362f8026e.camel@gmail.com>
Subject: Re: [RESEND PATCH v3 1/1] ppc/spapr: Add hotremovable flag on DIMM
 LMBs on drmem_v2
From: Leonardo Bras <leobras.c@gmail.com>
To: David Gibson <david@gibson.dropbear.id.au>, Bharata B Rao
 <bharata.rao@in.ibm.com>
In-Reply-To: <20200511200201.58537-1-leobras.c@gmail.com>
References: <20200511200201.58537-1-leobras.c@gmail.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Date: Mon, 06 Jul 2020 14:45:55 -0300
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::741;
 envelope-from=leobras.c@gmail.com; helo=mail-qk1-x741.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 Bharata B Rao <bharata@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 2020-05-11 at 17:02 -0300, Leonardo Bras wrote:
> The new SPAPR_LMB_FLAGS_HOTREMOVABLE flag helps Linux to put this memory in
> the correct memory zone, so no unmovable allocations are made there,
> allowing the object to be easily hot-removed by device_del and
> object_del.
> 
> This new flag was accepted in Power Architecture documentation.


FYI: LoPAR released for public review. 
https://openpowerfoundation.org/?resource_lib=linux-on-power-architecture-reference-a-papr-linux-subset-review-draft

It contains the new flag implemented by this patch.


