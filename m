Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A6E9C2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 11:10:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07AFE212F5
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 11:10:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XdkRpale"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07AFE212F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48452 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZClu-0007wf-Ab
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 07:10:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56667)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hZBd2-0005sP-D2
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:57:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hZBd1-0001Gl-2S
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:57:44 -0400
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e]:39746)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hZBd0-0001Dk-Qk
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:57:42 -0400
Received: by mail-ot1-x32e.google.com with SMTP id r21so1305357otq.6
 for <qemu-devel@nongnu.org>; Fri, 07 Jun 2019 02:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=oAtbI+rPI68kFubeDAVhuMcAqpzefisJEhDu9zkuloo=;
 b=XdkRpaleqAPwt57RJU6Q5E+QtmOj59520qoE1Anp2ofEJXu4D0N4HYGpPpbquudnmU
 z+GCUmj1a5XIuDv56p8jXyw9hnjK+YtcMPtyY996sBLC5DAYYtmLlzxfAxD1mzVJB7ve
 7jAamcEJORamTgKEfqGU/Q+1geHcNtPtfmcow9gTQwMbAiQVddFaDqGodN4YT/DOzJEN
 RRkmq2Z3Av75Cei8eLxQTYyeMm/wRRcyMwd9jSy7EvTNfGOchjhYFEK7Z9BdrkdpjqSR
 aSU1NA6YevJO4925FSHEITeNCaVTaq62+Y9WE0HfkoS5UdPoD7NXnDDIWyXKIFu1O9Sn
 EYLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=oAtbI+rPI68kFubeDAVhuMcAqpzefisJEhDu9zkuloo=;
 b=TCYHoEQIU1Ny7fbUZYRxJkWQRRlpHnGaqdXqfjHBy5XhyoHFCdSHMQZNNRiuGE5Wfh
 TpWXepzCVh4Q9L9g6VMIiIO0YmSqBkIFkj1bs5u34eGzrFxbakmRQgwKRhCzuO8U0UYt
 RmmCTtn6buMbnEbrS87ejphDGPNXdaU1wm7qwjbqmH8c0BP6VEfrTiHHY+9i3OkWdh9F
 0WPXboV6MVKScyzLXs46PAqHrHYRERSTONbfbQ/GigsUlc8emr3VUrs3Fthg5dS400Cg
 pxJxMrPuBuT+3Tx4oRBon6PuppMjqrZxpdasSKy1p+e3vAMguOWX6eHi++QXSWqfCLcz
 Ryjg==
X-Gm-Message-State: APjAAAWDgAuBeFQVLQiVE6W0+LiQH0iN6zAxMdO2szaW0bU/wWHc7H1m
 3Spe+d5ZckR9fIguDF8m/yZqT4+SWC33nuJ2I7Z/Wg==
X-Google-Smtp-Source: APXvYqz+ahkOR0wNpufo08CdLSOek4KUnhVRSR0Fbdv10C7i1Cn5/G8INDADABC/1sHJHaYxSKxP0H6khWJQO0Yy0TQ=
X-Received: by 2002:a9d:d17:: with SMTP id 23mr18277899oti.221.1559901461607; 
 Fri, 07 Jun 2019 02:57:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190607095237.11364-1-cohuck@redhat.com>
In-Reply-To: <20190607095237.11364-1-cohuck@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 7 Jun 2019 10:57:30 +0100
Message-ID: <CAFEAcA8FXh-jPMwpGN-4ES4v=nE4ZOSNB8+rkdB03E=BBDh-jw@mail.gmail.com>
To: Cornelia Huck <cohuck@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32e
Subject: Re: [Qemu-devel] [PULL 00/35] s390x updates
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
Cc: qemu-s390x <qemu-s390x@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 7 Jun 2019 at 10:52, Cornelia Huck <cohuck@redhat.com> wrote:
>
> The following changes since commit 47fbad45d47af8af784bb12a5719489edcd89b4c:
>
>   Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' into staging (2019-06-04 17:22:42 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/cohuck/qemu tags/s390x-20190607-1
>
> for you to fetch changes up to 39f04d18406862bd98d6bef5415dbe7360c652de:
>
>   Merge tag 's390x-tcg-2019-06-05' into s390-next-staging (2019-06-07 11:38:42 +0200)
>
> ----------------------------------------------------------------
> s390x updates:
> - tcg: finalize implementation for the vector facility and
>   add it to the 'qemu' cpu model
> - linux-user: properly generate ELF_HWCAP
> - vfio-ccw: support async command subregion (for halt/clear
>   subchannel handling)
>
> ----------------------------------------------------------------

Hi -- this fails to link on the windows build for me:
  LINK    s390x-softmmu/qemu-system-s390xw.exe
hw/s390x/css.o: In function `sch_handle_halt_func_passthrough':
/home/petmay01/qemu-for-merges/hw/s390x/css.c:1213: undefined
reference to `vfio_ccw_handle_halt'
hw/s390x/css.o: In function `sch_handle_clear_func_passthrough':
/home/petmay01/qemu-for-merges/hw/s390x/css.c:1223: undefined
reference to `vfio_ccw_handle_clear'
collect2: error: ld returned 1 exit status

thanks
-- PMM

