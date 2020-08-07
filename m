Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 305E3C433E1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 09:21:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0CCB20855
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 09:21:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M6npGU8C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0CCB20855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3yYq-00034V-60
	for qemu-devel@archiver.kernel.org; Fri, 07 Aug 2020 05:21:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59312)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k3yY9-0002DI-DE
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 05:20:29 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:46485)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k3yY7-0001gA-LP
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 05:20:29 -0400
Received: by mail-ot1-x341.google.com with SMTP id v6so1065437ota.13
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2020 02:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=KdAqU4t4XjsA7zwTe3EtDEtro5erkoUOZ+S7Is81UnA=;
 b=M6npGU8CzUoNsqmSrwBZg4tBk1FqtCyLqPWvvKWnYSaqjxsaA7fxMkzuKsPXTo4vih
 Rz3woHBlaDb4ir/bKM7hJhN0hMj0n/Kukdrz3S+UFiydLJ7R8Vr3hLxhfzzz6x/FjmD2
 mOBjEyQWfpPZM64Su8G0bCSB2X4QfyKmK6uwGWd/Vd+pma39HifQsFqo96sTxFyV5Phd
 4ywNeaxj70vlE/BnQ/xA8JVZMd4ousrNjLemNnnqiQuXFyO1QfQlbiC1ZKbhDdWo5OzO
 cY/xUe/oNKHLq+9C3kvuGKhXxtjtVOuOzY4sSYK/AV1s8NefLcXM7F0EeZGABxG8C4m+
 +sqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=KdAqU4t4XjsA7zwTe3EtDEtro5erkoUOZ+S7Is81UnA=;
 b=fpKZsYPlvKC+WaGyeJbMX90blwqxmZq6P30dKEDILHqQMUsRQDtweplqBqyay/PJZi
 h4UWL+8wUq/EVKjB1/8qQ2rrnwiEklhZqtGktVEncSHbOJX5bmMuF8wdkDR66ebhYe/n
 RHCpfOMe/+PKetJmPPvXi+5ErebA+/cSsGrrO95D6O5nn5qOuiM3iwDcVownAY9Gp+5B
 MVlNSZUt1f0119a2EaRyMrEpE1leMOKY+Db1XiemTl0JKqYu/zAs/L+4OQY1hottAILT
 xAviuwviJ5We8eWmslqz1yLgJtlQQRvZSwdaRcKUEOTwdGOQMRtBYMQd0fLZi//vJHeh
 VZeA==
X-Gm-Message-State: AOAM533MXr9kodAJuDMR8ZVbGMlEBTMSF6vxy6V/H0zD0mHUN5BmPG/m
 X4JL3e11M/7ZZTgn0AeOzhE6NioOIF0ysDduvLMjIA==
X-Google-Smtp-Source: ABdhPJwbsiMXVZSo3rRk92Exi0iR0e+gUpbgLOr8+5Gpc0d/qb3eCXiXDnh8BE2hU42fUdkgQV3+PZBfGawD0LzseaE=
X-Received: by 2002:a9d:6f8f:: with SMTP id h15mr4639007otq.221.1596792026398; 
 Fri, 07 Aug 2020 02:20:26 -0700 (PDT)
MIME-Version: 1.0
References: <1596741379-12902-1-git-send-email-pbonzini@redhat.com>
 <87364y28jp.fsf@dusky.pond.sub.org> <20200807082206.GC120942@redhat.com>
In-Reply-To: <20200807082206.GC120942@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 7 Aug 2020 10:20:15 +0100
Message-ID: <CAFEAcA8U=Wxx8Z7E2gcwYEhyV_EiCBX3o+FxdxTa9-bvS7rM-Q@mail.gmail.com>
Subject: Re: [DRAFT PATCH 000/143] Meson integration for 5.2
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::341;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x341.google.com
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
Cc: John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 7 Aug 2020 at 09:22, Daniel P. Berrang=C3=A9 <berrange@redhat.com> =
wrote:
> In terms of testing I'd suggest the minimium bar is likely the GitLab CI
> and Peter's merge scripts.

I tried running it through a build test. Fails to build, all hosts:

make: Entering directory '/home/petmay01/linaro/qemu-for-merges/build/alldb=
g'
config-host.mak is out-of-date, running configure

ERROR: Meson not found. Use --meson=3D/path/to/meson|git|internal

make: Leaving directory '/home/petmay01/linaro/qemu-for-merges/build/alldbg=
'
make: *** No rule to make target 'config-host.mak', needed by
'meson-private/coredata.dat'. Stop.


Can we make this Just Work ?

thanks
-- PMM

