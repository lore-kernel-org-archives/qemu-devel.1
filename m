Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFB36C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 03:18:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA53520809
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 03:18:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PeaYeefC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA53520809
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57536 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0z5N-0005KQ-SA
	for qemu-devel@archiver.kernel.org; Wed, 29 Jul 2020 23:18:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56110)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1k0z4f-0004u6-IB
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 23:17:41 -0400
Received: from mail-il1-x144.google.com ([2607:f8b0:4864:20::144]:36819)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1k0z4d-0007l3-Tz
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 23:17:41 -0400
Received: by mail-il1-x144.google.com with SMTP id z3so11073573ilh.3
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2020 20:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=N5LVw5UVchie848gzodbV6sJN2QWGzfFMkcMmgoXBRg=;
 b=PeaYeefCFOkCs/b4Re3KYdXdqnpU1vS+LpROD9axTLuNPAhaOFtaFzGVw7iNPGhhd+
 XhJHmVRhmyBDjpiO3ju/IjoRXTPJo5hHl7c8bHXXLgv348MHzsyIoG9y+IDZywQpeVLq
 gvftpMIkuIpp4JmMXnlDFjGDNjPuzT6xBUFj8usfSBOOYT2Yj2JyaiAZR1RCOCDiYac0
 LUdgZI0M65Hte8HACz51XTTvkOEaR4YLbpXzD21OS8o3y8/pwvew5IwH9KN5EkhL6Msw
 GOdWfCOAAF1uZqkh1WujmaaBgSuPpFvSjVIVQM2+vf+QPcojDTJzpYTILnafh8Th7vf1
 RyHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=N5LVw5UVchie848gzodbV6sJN2QWGzfFMkcMmgoXBRg=;
 b=WHhecG1+9RxlSupkQpZdHDIPGLdeAnCUNAh+YgxQGzRMzw7wet4Kg6Ml7IsAgNA1G6
 pMdRa8dkyFGfpIUCitAJ4wFfZ0G9tzCjrHbLnHQmCaP1RXAcHpaM8sjeMx8Thfp4ZlgW
 a8BsjPhKxlxzHqCqtqB+RRppnuCXgZPXBwhmKCJ9vGkTTmrlEozpT8zlitVXF5P1uwB6
 DuwDoKzHunElYK55e33Kw3GqUxpUf7wQxWZcRHAQCelxd5/AYy+AfyGNppQmJfSziwwq
 sUD7J0p1bC7rGGnh7UveFLbcCE+0s+6TD6+d9cnB0j2fJl+IPe7EMVW8PL6Qw4tRiM/h
 yjbQ==
X-Gm-Message-State: AOAM532dZIHkirIONW9ljayA5P+Ft8F4R5ovC+JYIeHAYqRRwB1d4MNF
 3JNZgzikXkVidtwatTWRwX+cYze8vaa3LBpQSGI=
X-Google-Smtp-Source: ABdhPJxu8LHp+mNv/0+sxjVrGlRk/UcxDZES6OqyWEHY590QOkYyrB3C/sHOirbtUEddm///vL2yKZG5/hgq45oCbqQ=
X-Received: by 2002:a92:9892:: with SMTP id a18mr34946042ill.60.1596079058535; 
 Wed, 29 Jul 2020 20:17:38 -0700 (PDT)
MIME-Version: 1.0
References: <CAFubqFvm=k0FyELUd=rYK7CO=Dxns-jVxy4UGqfGfXPFNT1cFw@mail.gmail.com>
 <20200729101851-mutt-send-email-mst@kernel.org>
In-Reply-To: <20200729101851-mutt-send-email-mst@kernel.org>
From: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Date: Wed, 29 Jul 2020 21:17:27 -0600
Message-ID: <CAFubqFtJLpp0eceOKXkhuTd6Rb2xviymx6hr-qkTc9Bw1ffWtw@mail.gmail.com>
Subject: Re: Adding VHOST_USER_PROTOCOL_F_CONFIG_MEM_SLOTS to 5.1 release notes
To: "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::144;
 envelope-from=raphael.s.norwitz@gmail.com; helo=mail-il1-x144.google.com
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
Cc: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

How about something like:
"A new feature, VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS, has been
added to the vhost-user protocol which, when negotiated, changes the
way QEMU transmit memory regions to backend devices. Instead of
sending all regions in a single VHOST_USER_SET_MEM_TABLE message, QEMU
will send supporting backends individual VHOST_USER_ADD_MEM_REG and
VHOST_USER_REM_MEM_REG messages to update the devices memory tables.
VMs with vhost-user device backends which support this feature will
not be subject to the max RAM slots limit of 8 and will be able to
hot-add memory as many times as the target platform supports. Backends
which do not support VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS are
unaffected."

I don't have permission to edit the wiki. How can I get permission? Or
can someone post it for me?

On Wed, Jul 29, 2020 at 8:19 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Tue, Jul 28, 2020 at 09:16:10PM -0600, Raphael Norwitz wrote:
> > Hi mst,
> >
> > Looking at the current changelog
> > https://wiki.qemu.org/ChangeLog/5.1#virtio, I don't see any mention of
> > the VHOST_USER_PROTOCOL_F_CONFIG_MEM_SLOTS protocol feature. It is a
> > user visible change so shouldn't we add a note?
> >
> > Thanks,
> > Raphael
>
> I didn't look at updating the changelog yet.
> Would be great if you could write up new vhost user things.
>
> --
> MST
>

