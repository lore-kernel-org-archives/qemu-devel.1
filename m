Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB60CC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 09:30:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3934F206B5
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 09:30:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iq+mfoXh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3934F206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3yi1-00043H-8q
	for qemu-devel@archiver.kernel.org; Fri, 07 Aug 2020 05:30:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60892)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1k3ygX-0002yW-U9
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 05:29:09 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033]:39571)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1k3ygW-0002bR-Bc
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 05:29:09 -0400
Received: by mail-pj1-x1033.google.com with SMTP id f9so627190pju.4
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2020 02:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=9S/iwe4jo246z59Z+bamF7xXxjkoltPvGZcy1HMgweQ=;
 b=Iq+mfoXhkkJnf41hteg1qVvMUNIshUjLISiT/jFT2S/+8GaR7/5fx/8C5LOuH61sfB
 0wGyNR0sXia+7OGah7CDN+J/ZrsX7/HuCGyhnByXtg4nK2C2MZPnJ51JvdL0gY35HDN1
 XwaKE4DciYuUaMnwlxQWAp0nXJzD8qyDeGZk+m3feCLf1XrE3aXZKvKnCWi44DBHSbec
 qIDvD9hFijWOSEg/gTbsc/Esu16DgpP46hh05b96XaU21cs5+W8KpLg96GPuHAeDDlj6
 vGUQ1G3Gy5k0jmrfHxJ+RNTj3yRyTMQ7r7farky5AzkTnW2vPODQ3C+M0elJShA5bjgp
 AJhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=9S/iwe4jo246z59Z+bamF7xXxjkoltPvGZcy1HMgweQ=;
 b=ht2UecAtA/LiucEIpkNvskCo5SO1JoJYIQ1WVEJcJuphMp8EKKwgarCyBjwcGqqlha
 D2numGO/2mCkp+9B799tb1AKe0CZWgyDSbn4bPPx6TNdui59rWyu57T4Z6bMJKMXe8/p
 /Q9xu9oznFTPe2Q8XYLp4XSp7Dzmhfjd5oKb2yxsTjAdjRt6B3Y4N61RXDCPb2FyD+O2
 APJsNWiArjWpWG5Fs7k201AOhyaQhuI2AoW8jwN0H37dqs1TT0pqldMvBLhXiYHC7ckf
 3y+oaHxZW+NMZLaWH32NzUFDB+7J8DAFjk1xkcTyeNJDfK9oy5FkZQY7Fa5RI+yWposV
 NC1A==
X-Gm-Message-State: AOAM530j0ek0FgmuPZ7l5E7oP4qv5WmXfu+4weqn+MR453kemI7Z2i80
 H7S2rZHAJPr67BMh4NzjErTq/1xx/XvhjDVK6w4=
X-Google-Smtp-Source: ABdhPJzR1+FqU4PR0mv+PBrtBnfNdC6Qc/NMLrUIJzGRpDf2HCvtWiiC65OOJZmAFUV26/lFZVlkf5BHrl0KhPnEYAA=
X-Received: by 2002:a17:902:c40f:: with SMTP id
 k15mr11840094plk.330.1596792546799; 
 Fri, 07 Aug 2020 02:29:06 -0700 (PDT)
MIME-Version: 1.0
References: <CAJSP0QWF8g7r5VqU_PRbskWZU3ahCq+eobR8GexUcPrAiYoCPQ@mail.gmail.com>
 <20200806110826.GH4159383@redhat.com> <87a6z7lwqm.fsf@linaro.org>
In-Reply-To: <87a6z7lwqm.fsf@linaro.org>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Fri, 7 Aug 2020 10:28:55 +0100
Message-ID: <CAJSP0QX7JbMGe_4QV+M_fnS963hMpCnAtQNZLL5LyRj91Lu92w@mail.gmail.com>
Subject: Re: Why QEMU should move from C to Rust (clickbait alert ;))
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=stefanha@gmail.com; helo=mail-pj1-x1033.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Sergio Lopez <slp@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, "Oleinik, Alexander" <alxndr@bu.edu>,
 Paolo Bonzini <pbonzini@redhat.com>, Dave Gilbert <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Aug 6, 2020 at 2:39 PM Alex Benn=C3=A9e <alex.bennee@linaro.org> wr=
ote:
> So has any vhost-user stuff been prototyped in Rust yet?

Yes, Sergio implemented vhost-user-blk here:
https://github.com/slp/qsd

cloud-hypervisor also vhost-user device backends, like vhost-user-fs.

Stefan

