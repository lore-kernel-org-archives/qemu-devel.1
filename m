Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A8ACC433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 16:40:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2431920737
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 16:40:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KXGxiSoW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2431920737
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38704 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jihId-00045w-Ah
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 12:40:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48368)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hskinnemoen@google.com>)
 id 1jihEk-0007TX-43
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 12:36:30 -0400
Received: from mail-vk1-xa43.google.com ([2607:f8b0:4864:20::a43]:40411)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hskinnemoen@google.com>)
 id 1jihEi-0002R4-QH
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 12:36:29 -0400
Received: by mail-vk1-xa43.google.com with SMTP id n22so5038432vkm.7
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 09:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=FoNMkAIk8t3qqx4O79gujhahy6TuXxWimzCUkwPAVzc=;
 b=KXGxiSoW5WkLQCjdaMu5wq2EUhK7e6UEDOYxw+oEU02Br07NGIkCJ7Cly6k0U5Mllx
 iq71MrQa8NHXO2A0KcN9IAsVgJHAgoPFADDwQCYvuCfLN8SgZ7sz6rPZdcq8LUnuQ188
 DRal8aCCPxVP33fXp8vdhiqV8HMbwMNPQ4QS5R2C0II/3HFppqMtUbNWgNhfygp4+pNn
 rvhirLmZsUKYm3K26/WPjS16ByzdLqenqVM7NZYlGAJM2kBZQ9om5+6u6EscNvFFRDiN
 M/LTeN8uobZBhFnlC1w8DdOjXSBugd4yNZo1Y0O4lsqyeTiGrG5aRlBX3hwr72iUnJE3
 CZkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=FoNMkAIk8t3qqx4O79gujhahy6TuXxWimzCUkwPAVzc=;
 b=dSO9oCE3fYRMsaDNiOeaiH2R4/hli8+RqyM2N/PNizMCQZqP/85PptApv3Zdx9mRQJ
 25QbIqkS0DNk8oFMwbyo1Qw2hk28wSkI1o/jljseUgWbmGtSclazdot3XjegEAwq8smn
 DJi4097ipBDbAWXaF467MYS2lrnrk3NxDjNg1sA7d/n8zCe/x+7J5X9dXUFQqc8ERPlG
 89GL36U93qtZskBFY6b/HZmA+y7L4DG1ERimHXHxqhaQPcwv4q4APeZyNc0ZzD3RKkVb
 Bp9FPUGbg9eXATWQBbFXu2b+ZouKqLsO9E84ViEGMC2khg0ndgrdk9VLr5pFEo6c1lN3
 6ToQ==
X-Gm-Message-State: AOAM531RIb81wYgUS+e/gVFTrdffkk9e0w3TeUGBzz4WlmX7ohCark+c
 RdrHRxsNyz/jGX9zgo7JgHoko965ElzCHoY5ow5V2Q==
X-Google-Smtp-Source: ABdhPJxZrKf8DgJ2xH7xVODrffqP18PUEqziT4DNoUg3uenDi3VkGzxzTNbMj+4AqTFiKvOclq8268+VrsArpAYKbLk=
X-Received: by 2002:a05:6122:130b:: with SMTP id
 e11mr4392441vkp.20.1591720587331; 
 Tue, 09 Jun 2020 09:36:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200521192133.127559-1-hskinnemoen@google.com>
 <CAFQmdRYYhoWu7q350n0vNOE+pesp-UG975v1f1Yjwf9Ao0mjcg@mail.gmail.com>
 <CACPK8XfOtLSVR2u12qEYxB=ggKLD-NeK8BYMW3_uRo8ExnM6Ww@mail.gmail.com>
In-Reply-To: <CACPK8XfOtLSVR2u12qEYxB=ggKLD-NeK8BYMW3_uRo8ExnM6Ww@mail.gmail.com>
From: Havard Skinnemoen <hskinnemoen@google.com>
Date: Tue, 9 Jun 2020 09:36:16 -0700
Message-ID: <CAFQmdRZoc3VDqKdkwsPzSjt_Pc5vGM+YQFN4y8jAu5VF36S6SQ@mail.gmail.com>
Subject: Re: [PATCH 0/6] Add Nuvoton NPCM730/NPCM750 SoCs and two BMC machines
To: Joel Stanley <joel@jms.id.au>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>, 
 QEMU Developers <qemu-devel@nongnu.org>,
 IS20 Avi Fishman <Avi.Fishman@nuvoton.com>, 
 CS20 KFTing <kfting@nuvoton.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Type: multipart/alternative; boundary="0000000000003111c905a7a95405"
Received-SPF: pass client-ip=2607:f8b0:4864:20::a43;
 envelope-from=hskinnemoen@google.com; helo=mail-vk1-xa43.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001, USER_IN_DEF_DKIM_WL=-7.5,
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

--0000000000003111c905a7a95405
Content-Type: text/plain; charset="UTF-8"

On Mon, Jun 8, 2020 at 6:39 PM Joel Stanley <joel@jms.id.au> wrote:

> I had a look and they appear good to me. Note that I'm less in to the
> gory details of Qemu than some of our other reviewers, so you should
> seek  a more detailed review from someone else.
>
> I look forward further support so I can test the OpenBMC kernel
> against Nuvoton boards in the same way as the Aspeed ones.
>

Great to hear that, and thanks for your review. I hope to post an updated
patchset soon.

Havard

--0000000000003111c905a7a95405
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">On Mon, Jun 8, 2020 at 6:39 PM Joel Stanl=
ey &lt;<a href=3D"mailto:joel@jms.id.au" target=3D"_blank" class=3D"cremed"=
>joel@jms.id.au</a>&gt; wrote:</div><div class=3D"gmail_quote"><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px sol=
id rgb(204,204,204);padding-left:1ex">
I had a look and they appear good to me. Note that I&#39;m less in to the<b=
r>
gory details of Qemu than some of our other reviewers, so you should<br>
seek=C2=A0 a more detailed review from someone else.<br>
<br>
I look forward further support so I can test the OpenBMC kernel<br>
against Nuvoton boards in the same way as the Aspeed ones.<br></blockquote>=
<div><br></div><div>Great to hear that, and thanks for your review. I hope =
to post an updated patchset soon.</div><div><br></div><div>Havard</div></di=
v></div>

--0000000000003111c905a7a95405--

