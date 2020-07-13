Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8B79C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 08:31:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 810092067D
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 08:31:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YK7VhY29"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 810092067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48272 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jutrg-0002eg-Px
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 04:31:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44114)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1jutqr-0002AF-P0
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 04:30:17 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:50285
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1jutqp-0007EV-LF
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 04:30:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594629014;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cE60dZWYrnW0PAqrm1AvdhzQMAtg21aJc5UFN237G6E=;
 b=YK7VhY299aWamaFSltS6zdKCAdx+GPvlabsS9w/ufKe0y9biumFci2k0jzUeHQL6AnV46O
 3SfuQaMtjXuggCHw3+f2KDY8YmIu6mt1ix7BZ6HVQLHbXY7+gHTXODIlIR/bpD5AbwIwwT
 awg90to9SXX9zFGdkywW4Mpok+ZFEyw=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-480-AYmQoTIvNuy6czHx83i45g-1; Mon, 13 Jul 2020 04:30:12 -0400
X-MC-Unique: AYmQoTIvNuy6czHx83i45g-1
Received: by mail-il1-f198.google.com with SMTP id w10so9058901ilm.16
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 01:30:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=cE60dZWYrnW0PAqrm1AvdhzQMAtg21aJc5UFN237G6E=;
 b=JxsiJfFJwyytOlSu9VgAJduOx6jdgBzVKdwUTC3G78MzM8IJu58s5p6C7AjbbQJ2BQ
 UwiA/eQwhoWyHc0RIn5BEgXkVvkruL2GnlyT33vGBR8DW0EFITxsvPPrNqpOlYAzPFcD
 uaiE3tJqr3bi9qLjjRuwvnkGpZNougXvK6Xpnnvod09aOj9lZkJ7j2hXfOHDQXz3TfRt
 TH7LJTgeA3NwXQX7aqT9j5F5Lzs7Wn0YqLzf1EYWynA1Wxg1avyKuC6zLfZALweqkoMe
 Bdnd8NBghN3dlo/WYZVrQNa88f5FvVlbk2QMPWOHXPRbo2vgU6p8WgNHmL/UhWpA0gy/
 cVhA==
X-Gm-Message-State: AOAM5330aNYuDFPfPiL4xI00mDB0XLwiVkhHwuR/MHlXCI+ho56Akxa4
 +ok4MVw5SLFyLGLpuVhooHMKj+vip0AOhhq0UEomTsumk0uKe4/nUXxw0CkfN+8NH6Ou9vGjoXj
 LUYMNDKE1FSUvPwyaSYY3AZMQr89hOTw=
X-Received: by 2002:a6b:6303:: with SMTP id p3mr60740987iog.111.1594629012164; 
 Mon, 13 Jul 2020 01:30:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyspmVA2UCiQ668GtVbTqN+ECdHpzGS27DsST8AVfy1zlc7MP3Idp4HQtSdOMIIXwJAdCnhlZPjt3JYe/Y0R18=
X-Received: by 2002:a6b:6303:: with SMTP id p3mr60740976iog.111.1594629011950; 
 Mon, 13 Jul 2020 01:30:11 -0700 (PDT)
MIME-Version: 1.0
References: <42a0ee9.78e1.1733dd8c113.Coremail.19210240159@fudan.edu.cn>
 <6160dba5-fd15-2467-fe53-14c391b2ce30@redhat.com>
In-Reply-To: <6160dba5-fd15-2467-fe53-14c391b2ce30@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 13 Jul 2020 12:30:00 +0400
Message-ID: <CAMxuvawJQv6av87PGO0FnFupLvR8Am-kWp4OaNhOnCX0YtYoHQ@mail.gmail.com>
Subject: Re: cve patch wanted
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 01:36:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Prasad J Pandit <pjp@fedoraproject.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel <qemu-devel@nongnu.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 =?UTF-8?B?5p6X5aWV5biG?= <19210240159@fudan.edu.cn>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Mon, Jul 13, 2020 at 12:16 PM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
> * CVE-2019-6778
>
> This one is in SLiRP, Cc'ing Samuel and Marc-Andr=C3=A9.

I was about to send a patch to update slirp to 4.3.1. Note that this
particular CVE should be fixed since 4.1, where "emu" support is
disabled.


