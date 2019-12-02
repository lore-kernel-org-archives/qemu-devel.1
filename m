Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48A3EC432C0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 15:32:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 133092073C
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 15:32:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L7Ow7T9I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 133092073C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibngk-000353-SP
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 10:32:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46593)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1ibne0-0001NI-AK
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 10:29:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1ibndz-00037q-C1
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 10:29:48 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42825
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1ibndz-00037L-8A
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 10:29:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575300586;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0z2tQm4iXkieh7Y2qc0PIyltREwM+PT4orb8BcP5pjQ=;
 b=L7Ow7T9IKoWV4v1vsTCAJkMg4MKpVo+pE5MHx+fBnyxU/TaljJlZEh0bbI5lTEApVP2J92
 B9WQM+s2KpHio8+3+ykoZYSr/PJ4RmGMYnsNUhjL0+wEADXyVO5tYpkwuMDlwIKe+UHGGC
 zrdU+WKq1FY2FyFWmyMgLTv8FWZpnG8=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-32-wp7Ys5CWN3W0gwUHUiUEcg-1; Mon, 02 Dec 2019 10:29:45 -0500
Received: by mail-qt1-f199.google.com with SMTP id e37so92840qtk.7
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2019 07:29:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=UHNVZK66LNTKTGCBCYSRNRG2nM4kaD92FRubfSh9yTo=;
 b=D2/fSkH/yuArOtQBtu1fbtEtCSJn6t/e3PI1ZwmD1tWYLRdkjaTPyC0bKl48f8T2hQ
 2P5TptM0MJG9n0gmuB9r+iQ2hLbOFz/vWiH4F130lnjiB3Xi2UKkP06CMcMYKb//W6MM
 HpV7CJHMXr43Q6bgNe/yJwfRA49FiM6CmnldhFRziPgFXyG3MmjZRhvgT3Wog4br8wzj
 LWp3i1/w7NQQzuk0atW4ljhHtOjJHHcPvh2jwtCDAK9UYPzScpO9lSCqf3whjTz2wMh9
 ctNaun/OViMQB1AbelTJFVLjEWtayu8iTlrgafuCG1yjd03NEmy7Qy8kUP27nMTvWQsA
 qCuA==
X-Gm-Message-State: APjAAAVoVsSWf7U7a4mFUO1TN1X6SNEZrRfAiSP0K2Xe+Iiv3K7nku8b
 6hWJ7kXv0+OB8dC8Ncvn8mckpaAlA5oLAf9M4NbhnvnE0ZoZ5Gw9ZceluEmYu+AJ/ULXbzFo89O
 oV4/LON32AN/8yag=
X-Received: by 2002:a0c:f990:: with SMTP id t16mr16297120qvn.134.1575300584890; 
 Mon, 02 Dec 2019 07:29:44 -0800 (PST)
X-Google-Smtp-Source: APXvYqwiflZ/75vDGfgMJ5OKhk/kspL4JpVa3xIK//K0jByQmCbTNb/IuB45oI9Mm2q6ml+h0rnrOg==
X-Received: by 2002:a0c:f990:: with SMTP id t16mr16297085qvn.134.1575300584679; 
 Mon, 02 Dec 2019 07:29:44 -0800 (PST)
Received: from redhat.com (bzq-79-181-48-215.red.bezeqint.net. [79.181.48.215])
 by smtp.gmail.com with ESMTPSA id v7sm16794967qtk.89.2019.12.02.07.29.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Dec 2019 07:29:43 -0800 (PST)
Date: Mon, 2 Dec 2019 10:29:38 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jakub Kicinski <jakub.kicinski@netronome.com>
Subject: Re: [RFC net-next 00/18] virtio_net XDP offload
Message-ID: <20191128024912-mutt-send-email-mst@kernel.org>
References: <20191126100744.5083-1-prashantbhole.linux@gmail.com>
 <20191126123514.3bdf6d6f@cakuba.netronome.com>
 <20191127152653-mutt-send-email-mst@kernel.org>
 <20191127154014.2b91ecc2@cakuba.netronome.com>
MIME-Version: 1.0
In-Reply-To: <20191127154014.2b91ecc2@cakuba.netronome.com>
X-MC-Unique: wp7Ys5CWN3W0gwUHUiUEcg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: Song Liu <songliubraving@fb.com>, Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, qemu-devel@nongnu.org,
 netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
 John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 Martin KaFai Lau <kafai@fb.com>,
 Prashant Bhole <prashantbhole.linux@gmail.com>, kvm@vger.kernel.org,
 Yonghong Song <yhs@fb.com>, Andrii Nakryiko <andriin@fb.com>,
 "David S . Miller" <davem@davemloft.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Nov 27, 2019 at 03:40:14PM -0800, Jakub Kicinski wrote:
> > For better or worse that's how userspace is written.
>=20
> HW offload requires modifying the user space, too. The offload is not
> transparent. Do you know that?

It's true, offload of program itself isn't transparent. Adding a 3rd
interface (software/hardware/host) isn't welcome though, IMHO.

--=20
MST


