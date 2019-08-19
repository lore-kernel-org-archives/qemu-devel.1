Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1B03C3A59D
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 11:01:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A95BC20844
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 11:01:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DCsoYlGN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A95BC20844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzfQ7-0004OW-NF
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 07:01:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52295)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1hzfOn-0003iu-VV
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 07:00:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hzfOm-0004OB-J2
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 07:00:29 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:44344)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hzfOm-0004Lt-Dc
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 07:00:28 -0400
Received: by mail-ot1-x344.google.com with SMTP id w4so1237322ote.11
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2019 04:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=lOvci48+GRmk6y2WmOOlMWeOmFnTdx3eQusm1LjSmXY=;
 b=DCsoYlGNBJVANPo10stH9U1DXfNGpQyInwYTX5iQfTqN3pFHB5cNXn4fr3/NOy0HeK
 wkR9RcllIxz4Af0ZNN/uw9KHFwuaWFFzJaNbRcJTeSYiU+P58uIVL6ezScz8a4HsWjrt
 6GSI/Db0eP/hruCeZMMRqpQSMaRT+L2Ewz0eWLZ0soZR487Qn8QRCmI86VycdDFJDGJs
 iCX7qrZYsuRXeQyeZatTYUQV+B+DcpIyAqdLSdCGKj1EBtJp+bhs3pDbxxe1f+TKobWx
 KgrNnSNFUl679O6AQxDOM2EWFRWwt+B8Is2Qsvtg1Z1ICZyccFCLvyHaaac1ZEnUf0jJ
 US8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=lOvci48+GRmk6y2WmOOlMWeOmFnTdx3eQusm1LjSmXY=;
 b=FdEhqeOPKUrCZdoycKFII0lU0N0FIAfUtLfhMHEw27BBUN4dsv86gHhaVQ064zFaH4
 Nzx/EAAhSp/o1e0myJ9ob79BvGjTu5TuMk934uKQ2P87nboqhz1WAY3q8qDVl3qpFfMn
 4u/4nqgREayViAHTDCCPmggbJAM7H1L9PxKH2RLosZ/eIwHoG5EXnZFE9a6jo6uq6457
 rZgnO935XkI+QAxCDEVfvH1T/VcsLUbLLbodjdqh8LEDNRKdfR5FKsCcVfn8FvKQGC+x
 xgn6rETMqvkiByk1ZQePqJL4eMrKYBAom+sVX0wbnODhhC4SBMvjzIOQ+33iKWiFsM5B
 9Frw==
X-Gm-Message-State: APjAAAX/NaRNMmN93uwcFp9U58gZGeQsyjYxX+edQ9ovxkBfNlSWB3SF
 ZdkjCxyF2PDvul1AKt1JYamMrR9I7Aazl2VQ0o2Tzw==
X-Google-Smtp-Source: APXvYqzv+1xlOwAiumb3nxCLz6kVLM7LOmmz+Y7l0Msx5B1BQkMR/7BlKqbnxelVyxMP+OqUXfxMZRwI3BKJix/OO0s=
X-Received: by 2002:a9d:4817:: with SMTP id c23mr16402858otf.97.1566212426624; 
 Mon, 19 Aug 2019 04:00:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190814020218.1868-1-quintela@redhat.com>
 <20190814020218.1868-7-quintela@redhat.com>
 <20190819095228.GC12960@redhat.com> <87pnl1301v.fsf@trasno.org>
 <20190819104916.GG12960@redhat.com>
In-Reply-To: <20190819104916.GG12960@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 19 Aug 2019 12:00:15 +0100
Message-ID: <CAFEAcA-00fv0q7gg_j0ZZT5cp0sNJVf_yXk174E0svx1e5hdSQ@mail.gmail.com>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
Subject: Re: [Qemu-devel] [PATCH 6/6] RFH: We lost "connect" events
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 19 Aug 2019 at 11:50, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
> I don't think we want to expose this in the QAPI schema for the socket
> address, since the correct value is really something that QEMU should
> figure out based on usage context.
>
> Thus, I think we'll have to make it an explicit parameter to the
> qio_channel_socket_listen_{sync,async} APIs, and socket_listen()
> and inet_listen_saddr(), etc. Then the migration code can pass in
> a sensible value based on multifd usage.

How bad would it be if we just passed SOMAXCONN for the backlog
value always?

thanks
-- PMM

