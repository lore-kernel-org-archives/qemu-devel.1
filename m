Return-Path: <SRS0=XKWp=7H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65FA0C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 18:40:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 367972071C
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 18:40:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qY7R/v6e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 367972071C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50876 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdI1J-0003it-C7
	for qemu-devel@archiver.kernel.org; Mon, 25 May 2020 14:40:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49124)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jdI0m-0003Dq-0f
 for qemu-devel@nongnu.org; Mon, 25 May 2020 14:39:44 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:56295)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jdI0l-0005qF-8j
 for qemu-devel@nongnu.org; Mon, 25 May 2020 14:39:43 -0400
Received: by mail-wm1-x343.google.com with SMTP id c71so785434wmd.5
 for <qemu-devel@nongnu.org>; Mon, 25 May 2020 11:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=vc8C30teLAV9/YfwOKHmHG856DJJps8CQMTIYx+esKY=;
 b=qY7R/v6eukJ3ynR6yVU/jOM82HnvZnKwqNhSEEm1HncYht/gI32QwgY+erhMTixJF7
 SNfc5VIX79c2pSpgWB7lrodPgzeR3Rq+vAxa5TCqf++g++qaptsOplyarfrCUiZ4GWnI
 JuMqKi9wCHVy5YAFIMjov8PWl8aZzSipsoIl1dwviekKSU0Opwy2pTNO6JUkSJVR1Irb
 mE0b0oJSd1Ej90IR23/BtAMKet3CF7c/YT4NzJ68SqhLRQuHjjM6jlLMedSfukr2qxnz
 k4TFutojU3ie0UKwWB5kdPQaK2z3ySfTvaCsM7En7AvzOplTAM1ef7JH6Ff+xTW073po
 870g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=vc8C30teLAV9/YfwOKHmHG856DJJps8CQMTIYx+esKY=;
 b=In7iwrSsv5z3hWFswSyO4HmP1e8CBzgcyI2K7kIYOoFzynQuPF1YUi7mxu5W1B/Ry0
 1VPN9nOGmz9ss282mDO9z6luXEK2hSWtsQ1SshLNgOdOFSheRD6hSNEaavjufDwUMPfC
 1aqG9VXWr2H1b1XD7beAc/2cj1+kiunkAEnuJCtMlVSjBYgrl2iDbwnzz6mh2zpl9uLu
 cd5FF9/cMs1rciVJ+ojFGQqO2VfQ1nQ3UH3SbaV7OEE7p5JM5JbJDlaT5KdOELHLUqAw
 n/eJZ1p3HD+J8vUDt8Xi/4I8WXlelR5xrG13x3624p4cJH7H2HafZ7GS+J0W/NQ3r4SH
 Vc9g==
X-Gm-Message-State: AOAM530+j4ychq3dn2BC+UMpJ4eO1etSN1EG35oSBOOfvm2hUPi7pdzU
 icOF/WvnbcTiqLjDL9f91DAO+65RBLaSNwpzpVg=
X-Google-Smtp-Source: ABdhPJxOd0SJWUVFtzbdnHUt8Ss48OWeFGH92zfeOzLBKIGuvY9UJN3snzECFWFMWlNtQ/56387yjUIKziVUHcCqMAY=
X-Received: by 2002:a1c:2dc7:: with SMTP id
 t190mr25130039wmt.129.1590431978500; 
 Mon, 25 May 2020 11:39:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200519162144.10831-1-ahmedkhaledkaraman@gmail.com>
 <a0f3967f-e125-d888-bc6d-44414edbfd5b@linaro.org>
 <CALTWKrVGqVb1mjsaoxYm4Y1iQoXYwz7ToC7T6r2EDPp-_LO=LQ@mail.gmail.com>
 <4e78400c-42be-08c6-492d-dc5596551efd@linaro.org>
In-Reply-To: <4e78400c-42be-08c6-492d-dc5596551efd@linaro.org>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Mon, 25 May 2020 20:39:25 +0200
Message-ID: <CAHiYmc6zKmxgyKHzT4gazvJvPsX3SQYLjSXwK50_2eURkR3_NA@mail.gmail.com>
Subject: Re: [PATCH 0/2] Update use_goto_tb() in hppa and rx targets
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
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
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>,
 QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <laurent@vivier.eu>,
 Ahmed Karaman <ahmedkhaledkaraman@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

=D0=BF=D0=B5=D1=82, 22. =D0=BC=D0=B0=D1=98 2020. =D1=83 05:12 Richard Hende=
rson
<richard.henderson@linaro.org> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=
=D0=B0=D0=BE/=D0=BB=D0=B0:
>
> On 5/21/20 4:32 AM, Ahmed Karaman wrote:
> > Does this mean that there is a bug
> > in this function for the other targets?
>
> Yes, I think so.
>
> > That we have to do the page crossings check in both modes to avoid the
> > user-mode failures that you have mentioned above?
>
> Well, that or we need to fix linux-user/mmap.c to do all the invalidation=
s
> required.
>

Hi, Mr. Richard, :)

Many thanks for diagnosis, and, more than this, presenting two
alternatives for resolution!

That mmap()... It has been giving us the hardest time since forever,
and it looks it continues to torture us.

It looks we are now between a rock and a hard place. I slightly prefer
the later (fixing mmap.c) alternative, just from the gut feeling that
it is better to fix the problem at its source, rather than to apply
(easy, but possibly performance-wise costly) band-aid to some later
consequence.

But it seem to me that this is as if I say I choose Charybdis, between
Scylla and Charybdis. We also risk jumping out of the frying pan into
the fire.

Adding Laurent, since this is, in essence, a linux-user issue.

If nobody objects, I will instruct Ahmed to file a bug in QEMU Bugzilla.

Wishing to improve the performance, we found the hard bug... eh...

Thanks again to Richard,

Aleksandar

>
> r~
>

