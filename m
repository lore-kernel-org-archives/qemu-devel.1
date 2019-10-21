Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E206CA9EA3
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 04:20:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E72121835
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 04:02:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pMLuqL6G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E72121835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59068 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMOtb-0003nh-D5
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 00:02:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57783)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <elohimes@gmail.com>) id 1iMOst-0003NM-Ev
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 00:01:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <elohimes@gmail.com>) id 1iMOss-0008FN-Gz
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 00:01:31 -0400
Received: from mail-qt1-x842.google.com ([2607:f8b0:4864:20::842]:46891)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <elohimes@gmail.com>) id 1iMOss-0008Ep-Bm
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 00:01:30 -0400
Received: by mail-qt1-x842.google.com with SMTP id u22so18868311qtq.13
 for <qemu-devel@nongnu.org>; Sun, 20 Oct 2019 21:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=FyAc8Ndkd7oVBgiWZnLdkDcRVwcOcHsdir9xiOsjmwE=;
 b=pMLuqL6GmAeyt9DJMeHE48Q+433X2fscFSxikloLMHk1WvFQNlcm03K06xos7rwckk
 3paGeEyB9n90z/kmPNXmanSRHNTt20hmeKsGXCllcHGChel0U0usvyVwFmhhQvZ5Wl0S
 yPWF2S6jaftizM6iGWFSd+G2YEeYPK36U07teD5+3Qy/zf2H/PdFr49wDnZsLWsra+Qu
 rBiCEZoiCtxLd1o1w8yV4kYM1yHxMtANK3dfD4hhWrLrj1SkhUL41GI3JtJQddt4to9V
 ynx3GE+UhMhXlrNNm7drqp4Xx4Ojb1XxfEGzfvNoJ8BxX506oo2nxRd1GmH6ozLZfzQa
 NVoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=FyAc8Ndkd7oVBgiWZnLdkDcRVwcOcHsdir9xiOsjmwE=;
 b=CszNr57ZGnOa+jPowdLEMiDllwyhFenubWshrTseHkYHRejdj2mMJ8nNkGA+Ble520
 Maz8NTOrE1WOsXizRh56DF5QShTp2i9wVqpJVif/o9d4jEqy4Pb0LR1/pcdFhnT165E2
 Q8K8lY2Kb9jy0xoX57v6bmghYwiVc+xAfKjA8NhFAZtDTLmQgJqf/BoKHoZHoU/oxY1j
 MJIuOP/nczJ9/lQ/CbY4ovwRCdxbIaJ3SMQpev2jgCmSrohpEadwDK2ur15m+GwUWxUP
 oxhlKWJe3cwhf/p0N3OCUO4wdC02IwcyzkPVwBF90xFHbqqAUl2sz7e4B/M4S7hJn5/3
 kLqg==
X-Gm-Message-State: APjAAAXowMtx48hXne5kQuDt9E0GqRTG/PJJAdJJ2KZmAaMEfw4iy9k4
 FpyYbI87OnxT8Pn525eMIVrRidEUO3CYWXyIbGI=
X-Google-Smtp-Source: APXvYqxURG79Bl9Whe6dMGx/1aaPgWk6Jlu8VagG49t1uAftjHRlFbnXEka/E5XX7SAadv7AwdmzX3BlJ7qosQ59C3Q=
X-Received: by 2002:ac8:6686:: with SMTP id d6mr22908730qtp.298.1571630488878; 
 Sun, 20 Oct 2019 21:01:28 -0700 (PDT)
MIME-Version: 1.0
References: <20191017163859.23184-1-felipe@nutanix.com>
 <CAONzpcbR+OjcrfavTnFXVopG-YsTdnFCT=no0eFei4oanfmj1Q@mail.gmail.com>
 <17B5A7A6-F790-4D10-8921-06A83DA18077@nutanix.com>
In-Reply-To: <17B5A7A6-F790-4D10-8921-06A83DA18077@nutanix.com>
From: Yongji Xie <elohimes@gmail.com>
Date: Mon, 21 Oct 2019 12:01:17 +0800
Message-ID: <CAONzpcYDDUde0PLVtGYuwGm79RvU-VubXqDs=4F_8yp+-pz-Zg@mail.gmail.com>
Subject: Re: [PATCH] vhost-user-scsi: implement handle_output
To: Felipe Franciosi <felipe@nutanix.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::842
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
Cc: Alex Williamson <alex.williamson@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 18 Oct 2019 at 19:14, Felipe Franciosi <felipe@nutanix.com> wrote:
>
>
>
> > On Oct 18, 2019, at 3:59 AM, Yongji Xie <elohimes@gmail.com> wrote:
> >
> > On Fri, 18 Oct 2019 at 01:17, Felipe Franciosi <felipe@nutanix.com> wrote:
> >>
> >> Originally, vhost-user-scsi did not implement a handle_output callback
> >> as that didn't seem necessary. Turns out it is.
> >>
> >> Depending on which other devices are presented to a VM, SeaBIOS may
> >> decide to map vhost-user-scsi devices on the 64-bit range of the address
> >> space. As a result, SeaBIOS will kick VQs via the config space. Those
> >> land on Qemu (not the vhost backend) and are missed, causing the VM not
> >> to boot. This fixes the issue by getting Qemu to post the notification.
> >>
> > Should we fix this in vhost-user-blk too?
>
> I'm not sure vhost-user-blk suffers from the same problem. Certainly

Actually I found vhost-user-blk has the same problem in a mutilple
GPUs passthough environment.

Thanks,
Yongji

