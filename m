Return-Path: <SRS0=D7Ry=V3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB78DC0650F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 06:04:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78C432087F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 06:04:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cmCXlMYI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78C432087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58194 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsLFI-0000Iz-LW
	for qemu-devel@archiver.kernel.org; Tue, 30 Jul 2019 02:04:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52306)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stefanha@gmail.com>) id 1hsLEs-0008Jz-9N
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 02:03:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1hsLEr-0004Ab-9Z
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 02:03:58 -0400
Received: from mail-qk1-x743.google.com ([2607:f8b0:4864:20::743]:35335)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1hsLEr-0004AR-3h
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 02:03:57 -0400
Received: by mail-qk1-x743.google.com with SMTP id r21so45826854qke.2
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2019 23:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=pnrhoozQzwZGHWs2I0ATrJVy1i+opXverorLzk8gv+k=;
 b=cmCXlMYI3XEVfo7txLFg4mkDg3DdfSWmty0KYkV95IE2MaHLgUeW6lmp1m0HsaG6Vr
 MLSGjXE3k066klOyth6qWkm3cThWNEVnZunMWYQQomhQo9KSWf96tWLLdqAA9rtfhQev
 I4Q/FIxxrO88MWPvxhxAjYo6d51kgrySNtB6ALyOkELXYQX2E0WVmoMRGaOO/qZcIeCM
 Kq5JsLK9oDpUgu1IpWpH39lqBA8ij6jI1A+1JKSAaFA0LfSJf+yz2nhYRlNuIK7ahJuH
 5B7/pOi7T66AdGr2f94yQnpAoV6Ox2H44TTxPg1CauvkpbMONhbIQTBtI5yyRNp2yyfr
 COvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=pnrhoozQzwZGHWs2I0ATrJVy1i+opXverorLzk8gv+k=;
 b=jk9Y21QAVFeJqp/+fyy7CduOjA8TdJ14juGRV0YL6GHzf0WjqwEnjlNrcD/7sS06NB
 onWUesMDJvHD81SG1Rdfpyc8Zvi75dMkN5/Y+ZGPYSzLeJEJ82Bc6qjO+hmMvRcOBgcq
 lkWOeL0uGDpExlTgzw+niy1dUsU+fVRD1YrRvplqLVOCQVFfk6/GA1L2gcPDZ6C0XF/C
 YMRq1K9s7WxH5f5ZdQtwOkeoWKHtoOPbrlOJEGyGocEAnb2e6PVeKDr1WNNF3sFojOY8
 l0ulvxLOJqBcSV3pwwQOl2ohvlHfDJj0sFeLZ3lexfhJ1NzkknF0dUHruQkmP3uMk2SZ
 /xew==
X-Gm-Message-State: APjAAAVSVONOak2P7K9lADBgcRZQT0oB0l4TyqQtYCKLO01YKaRsxe0a
 jk00Jq5ayuu5sQuXo/rowmot90gku2zW53nDXyM=
X-Google-Smtp-Source: APXvYqylpnGo7NZVMECStvE3Wek5dmV8i6AxjmYvgtdRNcMzWRcjJq/0UGBUbisoNMACtfQkVpYbntVUbIVopedXdKU=
X-Received: by 2002:a37:2750:: with SMTP id n77mr77438239qkn.370.1564466636599; 
 Mon, 29 Jul 2019 23:03:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190724070307.12568-1-richardw.yang@linux.intel.com>
 <20190729135859.GD6771@stefanha-x1.localdomain>
 <20190730005150.GA27925@richard>
In-Reply-To: <20190730005150.GA27925@richard>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 30 Jul 2019 07:03:45 +0100
Message-ID: <CAJSP0QV0rvpJU3Ct7khcHgUQ9cCQAfUyJz5m6kQDNjA1dcc8EA@mail.gmail.com>
To: Wei Yang <richardw.yang@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::743
Subject: Re: [Qemu-devel] [PATCH] docs/nvdimm: add example on persistent
 backend setup
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
Cc: ross.zwisler@linux.intel.com, Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 qemu-devel <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jul 30, 2019 at 1:52 AM Wei Yang <richardw.yang@linux.intel.com> wrote:
>
> Hi, Stefan
>
> Thanks for your comments :-)
>
> On Mon, Jul 29, 2019 at 02:58:59PM +0100, Stefan Hajnoczi wrote:
> >On Wed, Jul 24, 2019 at 03:03:07PM +0800, Wei Yang wrote:
> >> Persistent backend setup requires some knowledge about nvdimm and ndctl
> >> tool. Some users report they may struggle to gather these knowledge and
> >> have difficulty to setup it properly.
> >>
> >> Here we provide two examples for persistent backend and gives the link
> >> to ndctl. By doing so, user could try it directly and do more
> >> investigation on persistent backend setup with ndctl.
> >>
> >> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> >> ---
> >>  docs/nvdimm.txt | 28 ++++++++++++++++++++++++++++
> >>  1 file changed, 28 insertions(+)
> >>
> >> diff --git a/docs/nvdimm.txt b/docs/nvdimm.txt
> >> index b531cacd35..baba7a940d 100644
> >> --- a/docs/nvdimm.txt
> >> +++ b/docs/nvdimm.txt
> >> @@ -171,6 +171,32 @@ guest software that this vNVDIMM device contains a region that cannot
> >>  accept persistent writes. In result, for example, the guest Linux
> >>  NVDIMM driver, marks such vNVDIMM device as read-only.
> >>
> >> +Backend File Setup Example
> >> +..........................
>
> Here I use '-' because I want to say this is a sub-section of "Guest Data
> Persistence".
>
> Actually, I struggled a little to pick up a proper character. Do you think '-'
> is the proper one?

This is a .txt file without syntax.  Whatever you choose might be
confusing to someone.  If you use a separate '-' section like the rest
of the document then that avoids confusion.

Stefan

