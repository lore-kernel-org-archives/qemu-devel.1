Return-Path: <SRS0=GUf1=UD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D3B6C282CE
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 16:56:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B3B223CA1
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 16:56:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y05LpmOQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B3B223CA1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55478 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYCjt-0001pR-9S
	for qemu-devel@archiver.kernel.org; Tue, 04 Jun 2019 12:56:45 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50230)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hYCj9-0001Oq-Fn
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 12:56:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hYCj8-0006DB-Mm
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 12:55:59 -0400
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230]:46470)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hYCj5-0005wP-C6
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 12:55:56 -0400
Received: by mail-oi1-x230.google.com with SMTP id 203so16058612oid.13
	for <qemu-devel@nongnu.org>; Tue, 04 Jun 2019 09:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=HL45/9b6YnTGrLSO+3cCw6OV6dXtkmHqwX5cFGhMsIM=;
	b=y05LpmOQQvgZHBQ497Ap1rDs45rKtwXyNK/gnxsOwWGwX8zIjRuMMJGYu3vTJMyqgo
	DHcvsiJKszMZ4Fft/NioGtXFcVLXje6p1lulw/iN494pOz2ofsc0BeRoGMggJ/ScEt29
	w/vYn3UbQg2RewUIlYLCOPbJw0A5oyldVXGcbw+Y/LizJFgRxZibduDC9e0HBZsL3gRQ
	n0tioSCWTaSC7E4l7AJr2KRRd0d3xEDgETOCVL3zs02RFyaDzNvYJBWkmZLG2hUGXzCY
	4LVmKBkZr8dC+weLQ8W9HLIlNFOPIch1w5maZAhM2UiWICAU92K2vgR7x2gnXi/gBI4u
	UKlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=HL45/9b6YnTGrLSO+3cCw6OV6dXtkmHqwX5cFGhMsIM=;
	b=JyJ3xmrjJJZSe4narlGLU4ase0MYnHcNF32O/t17kk2m4ApcXBiwM1wty8ugOqluZz
	yZlCpbj3L+dSA4EM25ntEFaggWP2Nf4BbZhCZCldaw31vg/fWJQGb+6eak2VJIHO9ZNy
	5vbTNZ3kcdIxZyXjKwglv/hk41vzSXlbTFQ4CEf1TsSusChTuyDEPc8RYc+VNGAmEi2x
	6tN2+6DDyK6jWf5PykG3RLTT//zkeFtP3N0wNALZn0/LZWEA0e34AO5Q3xuFr+ntmEli
	h0YKlRSuU5k/fri+lQ8yZR9usu12alTDfm4t8FKO17hNmTR2+1UN88RVqaVQ0A6iUrmS
	LFfg==
X-Gm-Message-State: APjAAAVeuponHVdB4bqqD2mS9y5Xhl075eED6qgmvEBF51e6pySlPNrj
	iecHVVKObNTLIdCbB0Wv3/5NpfeEmsmC7WdEILY1rg==
X-Google-Smtp-Source: APXvYqwodC9q5DIHse9UYfVnvaNFVH+hvipgFVEVbE5qR9yj+pwrsCW50s0e+svMLhTPoZSQDVemDBZ9g1t+tRh6EsI=
X-Received: by 2002:aca:5785:: with SMTP id l127mr4621877oib.48.1559667347386; 
	Tue, 04 Jun 2019 09:55:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190603180807.16140-1-mst@redhat.com>
	<CAFEAcA8zMLAs6-ssLhsKBfhRECzADUzpKWw+_jgJhQz0BnxciQ@mail.gmail.com>
	<20190604122506-mutt-send-email-mst@kernel.org>
In-Reply-To: <20190604122506-mutt-send-email-mst@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 4 Jun 2019 17:55:36 +0100
Message-ID: <CAFEAcA-d9cK_SOmFV6b6koA8j=xzdknkP=g3NHgBEG2Wr4Mx6A@mail.gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::230
Subject: Re: [Qemu-devel] [PULL v2 00/14] virtio, pci, pc: cleanups, features
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 4 Jun 2019 at 17:48, Michael S. Tsirkin <mst@redhat.com> wrote:
> I see. I can drop this patch for now, but I suspect this
> means this host always produced warning and possibly
> that the tables are all wrong.
> Could you send me the actual and expected files please?
> Preferably both dsl and binary.

Sure, if you can give me commands to run to do that.

thanks
-- PMM

