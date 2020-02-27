Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2093C4BA3B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 09:55:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89A0E222C2
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 09:55:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V56JkAjd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89A0E222C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7Fsk-0004TQ-Pc
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 04:55:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59754)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <coiby.xu@gmail.com>) id 1j7Fro-0003xD-7G
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 04:54:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <coiby.xu@gmail.com>) id 1j7Frm-0004M9-5J
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 04:54:03 -0500
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:41769)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <coiby.xu@gmail.com>) id 1j7Frl-0004K9-Ts
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 04:54:02 -0500
Received: by mail-lj1-x244.google.com with SMTP id h23so2623268ljc.8
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2020 01:53:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=BPPAVo0yei11nR6u0xm5IXe3/wO4mFL3saI2KY0Qof4=;
 b=V56JkAjdcEmdvrRlxqDbNYlEo/hVbw0q7Ke94Dn3AD1jjhSINbZmonh7Xmcxr4sSwG
 b6VICDiBWXrqQB2PLEnoW68sabirQIGBjp2+1ZmwG4qPLsq8SdSCRuVsy4ckjZR+abPs
 o//L81dMWsQoLSgb8jvs6fy53IMMB/rpi16mjUbJtm59AH8deULtGtazO0bk3KydE60Y
 UL3ArW7T1dvDIz/nk4uzW4gUUv2eby16WJSqAUMhjj4x/itd+yCjTViuHG1JoectHjEK
 1MOVCrxx4WZXzOzNPawcvlK99znTbi3J/jZjscE68pWh5frtXKWkaVVg9ht/nAvRV4pE
 +p1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=BPPAVo0yei11nR6u0xm5IXe3/wO4mFL3saI2KY0Qof4=;
 b=mzl68cbIDwthvsjOfi6m8MlPXqk4W5eHJ0y96JRuoROUeJgAFdI0GO5i6yDrwd0Of5
 MBBeZ/uwzRPUR1SEkKQMayU94lnt071bcPhOEdxtGts/8DQgBW8jy29tpL0MdBwUZ3u6
 H+mw3Slm5v/kpZdmTNG8AEaF5GAkGMOg9gkOwPpVx0kWasG/ueLReUwW+RawAIijTTqZ
 94LYcAdNxFS+B6LyfEdQSdk2AQjOOOCysFvOzKdgGGL458wMEG/A88VSJTponedJWBDZ
 P0pBB5bJowfVDDoxyF68HAt3luD10R5PUIsAAJDSYAmQjklZnNLnFUSN/fZpX3pb6HeX
 GroA==
X-Gm-Message-State: ANhLgQ0GD2hSmmAXFYnrc2rMNamRcKurcXKGIM/MsJaWHAkoyImSP7nz
 KepEnExFz4phErWxu8IK+glfa/AD1ElblrEEVIQ=
X-Google-Smtp-Source: ADFU+vt98kPriNQOB7clBldiHqx2LmdecUER8ALoLl2mhGzZCJKTW2ppC+8e2LMuJhhrPcdSKo/5KNBFdXQjqMfoQ58=
X-Received: by 2002:a2e:9955:: with SMTP id r21mr2242036ljj.283.1582797231569; 
 Thu, 27 Feb 2020 01:53:51 -0800 (PST)
MIME-Version: 1.0
References: <20200218050711.8133-1-coiby.xu@gmail.com>
 <20200219163815.GD1085125@stefanha-x1.localdomain>
 <CAJAkqrXaqmT2pR4K1x06AeQZHvUWp-fcqnbKZq_45czO96v5PA@mail.gmail.com>
 <20200227074114.GB83512@stefanha-x1.localdomain>
In-Reply-To: <20200227074114.GB83512@stefanha-x1.localdomain>
From: Coiby Xu <coiby.xu@gmail.com>
Date: Thu, 27 Feb 2020 17:53:15 +0800
Message-ID: <CAJAkqrWUJWLdT+6b_XmHFwnzhhbYei2SakCKVW0Rf92HJgoZDw@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] vhost-user block device backend implementation
To: Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::244
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
Cc: kwolf@redhat.com, bharatlkmlkvm@gmail.com, qemu-devel@nongnu.org,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Thank you for reminding me of this socket short read issue! It seems
we still need customized vu_message_read because libvhost-user assumes
we will always get a full-size VhostUserMsg and hasn't taken care of
this short read case. I will improve libvhost-user's vu_message_read
by making it keep reading from socket util getting enough bytes. I
assume short read is a rare case thus introduced performance penalty
would be negligible.


On Thu, Feb 27, 2020 at 3:41 PM Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> On Wed, Feb 26, 2020 at 11:18:41PM +0800, Coiby Xu wrote:
> > Hi Stefan,
> >
> > Thank you for reviewing my code!
> >
> > I tried to reach you on IRC. But somehow either you missed my message
> > or I missed your reply. So I will reply by email instead.
> >
> > If we use qio_channel_set_aio_fd_handler to monitor G_IO_IN event,
> > i.e. use vu_dispatch as the read handler, then we can re-use
> > vu_message_read. And "removing the blocking recv from libvhost-user"
> > isn't necessary because "the operation of poll() and ppoll() is not
> > affected by the O_NONBLOCK flag" despite that we use
> > qio_channel_set_blocking before calling qio_channel_set_aio_fd_handler
> > to make recv non-blocking.
>
> I'm not sure I understand.  poll() just says whether the file descriptor
> is readable.  It does not say whether enough bytes are readable :).  So
> our callback will be invoked if there is 1 byte ready, but when we try
> to read 20 bytes either it will block (without O_NONBLOCK) or return
> only 1 byte (with O_NONBLOCK).  Neither case is okay, so I expect that
> code changes will be necessary.
>
> But please go ahead and send the next revision and I'll take a look.
>
> Stefan



--
Best regards,
Coiby

