Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92FF2C282DE
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 06:50:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EDCF2075B
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 06:50:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P1dvBj0i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EDCF2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36512 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYPlB-0000GT-Ks
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 02:50:57 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55082)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <elohimes@gmail.com>) id 1hYPkL-0008KE-IP
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 02:50:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <elohimes@gmail.com>) id 1hYPkH-0002w5-Au
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 02:50:05 -0400
Received: from mail-qt1-x842.google.com ([2607:f8b0:4864:20::842]:43506)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <elohimes@gmail.com>) id 1hYPk7-0002h8-Kd
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 02:49:53 -0400
Received: by mail-qt1-x842.google.com with SMTP id z24so9655557qtj.10
	for <qemu-devel@nongnu.org>; Tue, 04 Jun 2019 23:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=+lEZUZJkq3/vYLFYcECbii9P/fzadEXyqz+Lc/iHl80=;
	b=P1dvBj0iX+PqveQBjg9M1Z29QcA0dC3D3szLdSc/FoXeWo8Jpico/fywaBi29MLDld
	G/7PewyamaLzYfTLTb47pOETauelLRas3jdEShcm+qYYZ+uZIilg/TKEnpOrLRuQ4tXB
	ZouVB6uQmgs/WNosNSYeQE2KP/0yMwzNGG3UCI0jVUV0G6FizEqN6204Rfdjp+jV8XTJ
	p3SvInrIGAOKtDUyyKxL8nvRCAkLNZ16+w2JiKOZ5guPgd1FH/louMM1TFdETrv0VT8g
	q1okFwk6JFAwlH+NTXAmFOXgwtDGyUqhekDSIIMaG8rNL6bOaikw96mIL3QwLVQa0QNN
	qzhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=+lEZUZJkq3/vYLFYcECbii9P/fzadEXyqz+Lc/iHl80=;
	b=B9bx/PnT3EffRCpb8ZCvFaR2pqExogKw+RdUqbXzm5FW9X6rjYRJcbeMkwy1ZXQSjl
	h0SusGcfkV/eSiW+BPyyAlc/t/y6XaF9i2IxQhRMY0y7iIKmzl40lKFi9qafEStj/pG4
	miP2bh4xQxxjdp8tJJYwyeSaZNp6qmgr7U6foDuPHb8393XlsT+4gZskAjNc58mrG1pr
	DR/726xFpGFPC3oytWNd39KeJ/1JTP0VshRnuGG7rq6WplyfEqbFebxHLbyUwEAwJngv
	kUhCbQkZbfijepguXQFaCo5B7E7BClcKibsDtFJVvHxYTIkDNZ6DgaKNfHG1JmCs35LK
	rd+A==
X-Gm-Message-State: APjAAAWV9NvBRtiHuEc8we+8o31qkcjHlvWIZ2bnHVhB6njSYN3qO+2h
	hKlfphCpkGXN5piQtctF19i2MWoSEOeEUqej4xY=
X-Google-Smtp-Source: APXvYqwLDpxVPr9TXROUOKdsvwAS4JQJAOiOl7NgIO80r/hrrrbIR35XBUJ51kp0eC9pbd8lf13EPQ9FE+2rFeyWGqY=
X-Received: by 2002:a0c:b084:: with SMTP id o4mr4855048qvc.227.1559717385521; 
	Tue, 04 Jun 2019 23:49:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190604073459.15651-1-xieyongji@baidu.com>
	<20190604073459.15651-3-xieyongji@baidu.com>
	<20190605084224.22e4cd92@bahia.lab.toulouse-stg.fr.ibm.com>
In-Reply-To: <20190605084224.22e4cd92@bahia.lab.toulouse-stg.fr.ibm.com>
From: Yongji Xie <elohimes@gmail.com>
Date: Wed, 5 Jun 2019 14:49:34 +0800
Message-ID: <CAONzpcZ_Wosy3BUZYDUp8UuEYk_3VSpSP+MQr7QRab8bKJ4-JQ@mail.gmail.com>
To: Greg Kurz <groug@kaod.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::842
Subject: Re: [Qemu-devel] [PATCH v2 2/5] virtio: Set "start_on_kick" for
 legacy devices
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-devel <qemu-devel@nongnu.org>, Xie Yongji <xieyongji@baidu.com>,
	"Dr. David Alan Gilbert" <dgilbert@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 5 Jun 2019 at 14:42, Greg Kurz <groug@kaod.org> wrote:
>
> On Tue,  4 Jun 2019 15:34:56 +0800
> elohimes@gmail.com wrote:
>
> > From: Xie Yongji <xieyongji@baidu.com>
> >
> > Besides virtio 1.0 transitional devices, we should also
> > set "start_on_kick" flag for legacy devices (virtio 0.9).
> >
> > Signed-off-by: Xie Yongji <xieyongji@baidu.com>
> > ---
>
> Patch looks good but it would be even better if applied
> earlier so that it doesn't revert lines added by the
> previous patch...
>

Fine with me. Will do it in v3.

Thanks,
Yongji

