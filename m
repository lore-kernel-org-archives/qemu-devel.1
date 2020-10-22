Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0507DC388F7
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 13:12:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6372924178
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 13:12:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bzcqCcBy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6372924178
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43592 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVaNs-0006lc-Cn
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 09:12:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58250)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kVaJY-00087u-GB
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 09:07:32 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:53641)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kVaJP-0001B8-QM
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 09:07:32 -0400
Received: by mail-wm1-x344.google.com with SMTP id d78so2002923wmd.3
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2020 06:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=gVXnh6jzWr8EcyQ4w7GWw0ffnF/hzVsKPQf9uPHgFhw=;
 b=bzcqCcByL+J4nYVh/kZGqkEioMZ1dqtKzdKZmjutk7QrrotWDgYJ5Y/FBKazFzYA59
 hXdMEkRdx8zwponOSDiMGjZgqFt6NNPXYsWNtr3N1rfJR0DcnePEwfMeo/ok7N8jiPu0
 lUf/WWsxau8ioBGAweWml5qfJ4iJK1BT3JN2VIAFbzKwHsyhAZg12fRazjAALCumLg+u
 MxPem2ZeguOcGseJfM5MV2OZjVDi+eCMdrgucD0M9WFM2/vJ8B9zVPdeoyVARbPZuEHR
 hf2EJvhgZ+u7Eea2uRprkyxbeYApLGcmdJQSi1FVTW7Mcf5NmFMV8o7xWbCXJiqYR0ld
 3GlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=gVXnh6jzWr8EcyQ4w7GWw0ffnF/hzVsKPQf9uPHgFhw=;
 b=kZ3bq4vTrTfLPuFuQVhV1GoBv0LCSjE7D29QVQT1J29preCJMTc2f7q2+yqx3UavWG
 R+c0nvXIH2HNsQwPVEJ+dlwoCCdFyaM0Y7RCnNiaYdPImU77ZoK1SbNt9e2zaxeulV/L
 DJ+dyIGQbG4nBVbx0nIAgGAgIjFImpmFc4LABUm39PN/JVEH8cxhj0pVa0Jd1KVYOBX4
 fHPHOBN4Zw1uQJNAJ2b1kHWqcgakgEPndHyy1yBXf29Q28PAbOkMkbvP+VNo/UkkB+iS
 DAVnofdN7AchQXKxNnbIn6HSTv3CBjPIdqStGhUH+mibIDeGOHC/1XiAT0voTeQAYjxh
 df+Q==
X-Gm-Message-State: AOAM5318uE6W1BtiWu8aZyWEuyGyFXc2K6g3pi5PeNCOBPpV7Dq1bK2a
 KoF8F4nXNTP3VEGhUkjX9mg3DQ==
X-Google-Smtp-Source: ABdhPJz3GU73KJoXlQ9q/zWL+GJNTvvYL6WyhfuF+tSbTfMAWxeAn5aemcLOugTUpZ7QteVvvCHITg==
X-Received: by 2002:a1c:2d97:: with SMTP id t145mr2313995wmt.132.1603372041996; 
 Thu, 22 Oct 2020 06:07:21 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id e25sm4268185wra.71.2020.10.22.06.07.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2020 06:07:20 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 0F4271FF7E;
 Thu, 22 Oct 2020 14:07:20 +0100 (BST)
References: <20201021163136.27324-1-alex.bennee@linaro.org>
 <20201021163136.27324-7-alex.bennee@linaro.org>
 <546fc49b-bde8-99f5-8489-295764afe44f@redhat.com>
 <8682564e-6ea1-d8eb-dc12-bf0a926c156b@amsat.org>
User-agent: mu4e 1.5.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: Re: [PATCH v1 6/6] tests/acceptance: pick a random gdb port for
 reverse debugging
In-reply-to: <8682564e-6ea1-d8eb-dc12-bf0a926c156b@amsat.org>
Date: Thu, 22 Oct 2020 14:07:20 +0100
Message-ID: <87a6wev27r.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x344.google.com
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
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Cleber Rosa <crosa@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:

> On 10/22/20 7:20 AM, Thomas Huth wrote:
>> On 21/10/2020 18.31, Alex Benn=C3=A9e wrote:
>>> Currently the test randomly fails if you are using a shared machine
>>> due to contention on the well known port 1234. We can ameliorate this
>>> a bit by picking a random non-ephemeral port although it doesn't
>>> totally avoid the problem. While we could use a totally unique socket
>>> address for debugging it's impossible to probe for gdb support of the
>>> feature which makes this a sub-optimal but less fiddly option.
>>>
>>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>> ---
>>>   tests/acceptance/reverse_debugging.py | 6 ++++--
>>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>=20
>> Certainly better than before!
>
> I'd prefer another chardev that tcp, but as you said this is
> already an improvement, so:

We've supported sockets gdb and softmmu emulation for some time:

  -gdb unix:path=3Dgdb.sock,server

the trouble is detecting if the host installed gdb is going to connect
before we try and fail after launching the VM. I think we might get away
with a version probe:

  > luispm: I want to know ahead of time for my scripts if gdb can do a
      "target remote gdb.sock"
  <luispm> ajb-linaro, I don't think so. My guess is that GDB will
      always attempt to stablish a connection if the socket is valid.
  <luispm> ajb-linaro, Can you check the validity of the file before
      invoking GDB?
  <luispm> ajb-linaro, No concept of "is this particular remote target
      available?".
  > luispm: it's not that - I know the socket will exist but the older
      gdb just bombs out trying to read it.
  <luispm> ajb-linaro, Not good.
  <luispm> ajb-linaro, So is this a matter of an older GDB that doesn't
      support using socket files and a newer one that does?
  > luispm: I thought I might probe "help target remote" text but it's
      unchanged between versions
  > luispm: yes
  <luispm> ajb-linaro, I think the code is probably hidden within the
      "target remote" implementation.
  > luispm: and most distro gdb's don't at the moment
  > luispm: if I could work out the version it was added that might help
  <luispm> ajb-linaro, I see some bits of it were reverted at some
      point.
  <luispm> ajb-linaro, Let me check.
  <luispm> ajb-linaro, It looks like GDB 8.3 was the first stable to get
      it.
  > luispm: thanks - I'll see if I can script that up
  <luispm> ajb-linaro, Looks like they initially went with an explicit
      prefix of "unix:" before the socket. But then dropped that in
      favor of autodetecting the socket file.
  <luispm> ajb-linaro, The only thing I get for a GDB that doesn't
      support socket connections if
      "/run/user/1000/at-spi2-QTZBS0/socket: No such device or address."
  <luispm> *is*
  <luispm> This is 8.1 in Ubuntu 18.04.
  <luispm> master GDB says "Remote communication error.  Target
      disconnected.: Connection reset by peer."

>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>
>>=20
>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>>=20


--=20
Alex Benn=C3=A9e

