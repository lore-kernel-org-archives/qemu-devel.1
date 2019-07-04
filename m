Return-Path: <SRS0=blGQ=VB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04F97C0651F
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 19:14:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4AC321852
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 19:13:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VlRwQwqa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4AC321852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48302 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hj7B8-0007cB-Sr
	for qemu-devel@archiver.kernel.org; Thu, 04 Jul 2019 15:13:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36789)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <frasse.iglesias@gmail.com>) id 1hj79t-00075s-DW
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 15:12:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frasse.iglesias@gmail.com>) id 1hj79s-0004D0-9q
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 15:12:41 -0400
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:36343)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <frasse.iglesias@gmail.com>)
 id 1hj79s-0004C6-08; Thu, 04 Jul 2019 15:12:40 -0400
Received: by mail-lj1-x243.google.com with SMTP id i21so7051395ljj.3;
 Thu, 04 Jul 2019 12:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=MYLsK+KgpWko9IY90dDqVXRWtw25c37fNovrwPJIMhE=;
 b=VlRwQwqaog5CTdT+rrqF4Hnt5s/6HTrbRvfM6lGXvB3t3a5mD8nSBj8JwmEkoOey+w
 7s4fg8G3vEKCENOpFrjxzCYkiDkNx0kis7zdCbgZos+nl0R+J14HyvCaOdwp264TUQhs
 Hv3T+upZxm4ldcMhnhGDfYzPsj+FAlr7ntux7a4uqt59XtcoD21m9V0/86IzFs95WVVA
 JyWDF28fwV2slg5tAWiF3Gd3ANC8IJmVOkiBt0tLF/LnCG8zxPjOVXwsJlRyoioRYNRZ
 T0JIH8v4e3FLn0Ft+g/zTbObu63/Y+TPsQFQyinvloQ/rf3RYGPNEbe72G1J6mxJAPUI
 AV4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=MYLsK+KgpWko9IY90dDqVXRWtw25c37fNovrwPJIMhE=;
 b=fVLj4n4AILHJvSIQ7jd+dJ4aNor+DBZyaIHjZJyFj1YBM2UkZwUp70wUQFzQcMn6Lc
 CcLIHyfdxIW1Yhq9n+9JjjM3Qn/YSSr5J23E1f+TybR7XPAJzmOXivXCmXNjsvGic7Ct
 EYteUPYmC7OC5EvTxH3au0Rj0FQWW1tomg3vAc9pmxX/wk9f8FhPDSVZbbbKFFafbatY
 FW98rDgQWoA8XDuYqgdQzxjfk7a0Nmppbskb8Qt5rLGE7baRA9+U/c4ZloSCx9Q0tUye
 CcD3JsW8m+pC+D2ZEZv+ZalqMz24ZeU/h6ph21uudrCsmjRALsYp10ewVmxjZP7/LVh2
 t8Ng==
X-Gm-Message-State: APjAAAU+COcB2FXRIrsCgL7fZf3lgOff3Zv+ItAfg+ISFWrVKZheAvL9
 DP16oTfXArd7PekVpeFVCdY=
X-Google-Smtp-Source: APXvYqz/VpVN0+4q1LHaq+Heg8O//JEqi8D5GW4iBv1MU7RxYJww/1RY6xttNlIMerbdAuMqy3EJkQ==
X-Received: by 2002:a2e:5b0f:: with SMTP id p15mr25104340ljb.82.1562267557826; 
 Thu, 04 Jul 2019 12:12:37 -0700 (PDT)
Received: from fralle-msi (31-208-27-151.cust.bredband2.com. [31.208.27.151])
 by smtp.gmail.com with ESMTPSA id
 e26sm1294711ljl.33.2019.07.04.12.12.36
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 04 Jul 2019 12:12:37 -0700 (PDT)
Date: Thu, 4 Jul 2019 21:12:35 +0200
From: Francisco Iglesias <frasse.iglesias@gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20190704191234.72ozyrtwdnc7r35a@fralle-msi>
References: <20190703190615.31436-1-ppandit@redhat.com>
 <59f87427-3d1d-928b-ac87-0a0a4049c4f5@redhat.com>
 <CAFEAcA86=RDpZEzWF_5QL_ix8Bghqxvn7ykXUBkAzTWp7KUVcw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEAcA86=RDpZEzWF_5QL_ix8Bghqxvn7ykXUBkAzTWp7KUVcw@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::243
Subject: Re: [Qemu-devel] [PATCH] hw/ssi/xilinx_spips: add lqspi_write
 routine
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
 Alistair Francis <alistair@alistair23.me>,
 Qemu Developers <qemu-devel@nongnu.org>, P J P <ppandit@redhat.com>,
 Sai Pavan Boddu <saipava@xilinx.com>, Lei Sun <slei.casper@gmail.com>,
 qemu-arm <qemu-arm@nongnu.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

On [2019 Jul 04] Thu 11:42:54, Peter Maydell wrote:
> On Thu, 4 Jul 2019 at 11:11, Philippe Mathieu-Daudé <philmd@redhat.com> wrote:
> > However, looking at the datasheet 'UG1085 (v1.0) November 24, 2015',
> > Chapter 22: Quad-SPI Controller, I understand this region is only
> > accessible by the CPU in READ mode, as an AXI slave.

'Chapter 24: Quad-SPI controllers' in a newer UG1085 [1] says that
writes are ignored and that "All AXI writes generate an external AXI slave
error (SLVERR) on the write response channel" (when speaking of writes to
the linear address memory region). Philip's solution seems correct to me
with the minor change to return MEMTX_ERROR.

Best regards,
Francisco

[1] https://www.xilinx.com/support/documentation/user_guides/ug1085-zynq-ultrascale-trm.pdf)

> >
> > So, if we model this, even logging LOG_GUEST_ERROR is incorrect, we
> > should trap some AXI bus access error.
> 
> Well, that depends on what the decode and the device really do --
> often datasheets are pretty sloppy and just describe what
> software "should" do, not what the h/w does if software does
> odd things...
> 
> thanks
> -- PMM

