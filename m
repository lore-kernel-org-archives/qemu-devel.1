Return-Path: <SRS0=pVGd=WM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D87AC3A59C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 10:12:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC9CC206C1
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 10:12:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TKdLLylP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC9CC206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53036 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyZDy-0002J6-6U
	for qemu-devel@archiver.kernel.org; Fri, 16 Aug 2019 06:12:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36165)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1hyZCL-0001jk-Qo
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 06:11:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hyZCH-00068A-EM
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 06:11:04 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:46088)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hyZBu-0005so-7F
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 06:11:01 -0400
Received: by mail-ot1-x344.google.com with SMTP id z17so9037381otk.13
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2019 03:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=WZOuzxIPuGKgmQ1Cqem1IhGBxpDDQWDYZQEARSEti/0=;
 b=TKdLLylPDYQucd5HTLyozHpce//roKXcJkuSsGH0/oFPwv1n3AL1ynS65XqE0N/cl5
 UM40T73bREiSP4Pc36Sez1L08q9y3DzSnrqOdbYIjHLTGlxj8k5PpoAGCb1O/zdlvWge
 OCObn1T/4jqCmSi1uo/GkSQHo+q4AJOSNm/+QouATTDqVPe6zyNtV4fkIR69z/APWjpI
 mOBRHIA+QhawXQ0fgfqgohxg0pEthEbpFNoGD08dsx5cAt9sA7yeaEFOk0hwYayDGNdF
 g9+bGz4Di27gxCpL6+pHp8vSN3KLaHpi+ny4JKEMKhU5nTozOAfxUudgWy3eHN+lvVSs
 rQ+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=WZOuzxIPuGKgmQ1Cqem1IhGBxpDDQWDYZQEARSEti/0=;
 b=CXdLKCM15Nrzt+pRC5e5d3dAXZH5ANCVwZ9SoaePWeZLN/4luUsnvNkkAoLImyPvCR
 EcnGOeVoqS1uNOEDb9Dm1F4297W/+l+pbqjwYqJS/LSTI3/4yPkWMsl3r/WA/OepbZXq
 EbylTQXK6xOanQd5YshB4US7EVlWGMfqYw9JdWz9mXyxOarC+Zd2YL+sPdduZGypjF1B
 aldVc68DhsbKSw/JBpWG/QwdaQ3RT5ooRbJzNNcvLjrWjFgH6NEbcltZTRLWDGraZe3M
 zHhvANfw033Mqhql1elfAjaWi/Ku9lmzyLeZMPmg82EgUEZDQN9xytN5rBNHTXN3eOfT
 un9A==
X-Gm-Message-State: APjAAAXzpsBHWN0/Wn7qcIN1r4SzZhyEmz8cQdvMKtkOa91+TJc4yqqk
 Vkb3r4Vcl/2r1cmWUqvNrL9sK/soJ9qTW/pCWxNHiQ==
X-Google-Smtp-Source: APXvYqyw0PJ1nXaDH1bKW+7ST5aG76k+NcDIS4IR/ivFhkXSpZTXUP6qvn6jb6L8OLPQiL8UoTcP1lETEKJRByF/RDk=
X-Received: by 2002:a05:6830:2103:: with SMTP id
 i3mr7104701otc.135.1565950236931; 
 Fri, 16 Aug 2019 03:10:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190813111809.3141-1-kraxel@redhat.com>
In-Reply-To: <20190813111809.3141-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 16 Aug 2019 11:10:26 +0100
Message-ID: <CAFEAcA-aSFFQtBEvq2xv=OVtSQS8No-oU7Lrn=FWJwdDeUurgw@mail.gmail.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
Subject: Re: [Qemu-devel] [PULL 00/15] Audio 20190813 patches
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
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Michael Walle <michael@walle.cc>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 13 Aug 2019 at 12:20, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> The following changes since commit 5e7bcdcfe69ce0fad66012b2cfb2035003c37eef:
>
>   display/bochs: fix pcie support (2019-08-12 16:36:41 +0100)
>
> are available in the Git repository at:
>
>   git://git.kraxel.org/qemu tags/audio-20190813-pull-request
>
> for you to fetch changes up to 7f6f83e89de6967db66a87f7ceb7be3c02a24d56:
>
>   audio: Add missing fall through comments (2019-08-13 12:17:57 +0200)
>
> ----------------------------------------------------------------
> audio: second batch of -audiodev support, adding support for multiple backends.
>
> ----------------------------------------------------------------


Hi; this fails the Windows build:

/home/petmay01/qemu-for-merges/audio/dsoundaudio.c: In function
'dsound_run_out':
/home/petmay01/qemu-for-merges/audio/dsoundaudio.c:537:33: error:
comparison of unsigned expression < 0 is always false
[-Werror=type-limits]
     if (audio_bug(__func__, len < 0 || len > bufsize)) {
                                 ^
In file included from /home/petmay01/qemu-for-merges/audio/dsoundaudio.c:33:0:
/home/petmay01/qemu-for-merges/audio/dsoundaudio.c:538:16: error:
format '%d' expects argument of type 'int', but argument 3 has type
'size_t {aka long long unsigned int}' [-Werror=format=]
         dolog ("len=%d bufsize=%d old_pos=%ld ppos=%ld\n",
                ^
/home/petmay01/qemu-for-merges/audio/audio_int.h:232:44: note: in
definition of macro 'dolog'
 #define dolog(fmt, ...) AUD_log(AUDIO_CAP, fmt, ## __VA_ARGS__)
                                            ^
/home/petmay01/qemu-for-merges/audio/dsoundaudio.c:538:16: error:
format '%d' expects argument of type 'int', but argument 4 has type
'size_t {aka long long unsigned int}' [-Werror=format=]
         dolog ("len=%d bufsize=%d old_pos=%ld ppos=%ld\n",
                ^
/home/petmay01/qemu-for-merges/audio/audio_int.h:232:44: note: in
definition of macro 'dolog'
 #define dolog(fmt, ...) AUD_log(AUDIO_CAP, fmt, ## __VA_ARGS__)
                                            ^
cc1: all warnings being treated as errors
/home/petmay01/qemu-for-merges/rules.mak:69: recipe for target
'audio/dsoundaudio.o' failed

thanks
-- PMM

