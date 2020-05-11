Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0146C47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 14:10:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A396F206DB
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 14:10:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A396F206DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=opensynergy.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46748 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY98p-000787-Qc
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 10:10:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41144)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Dmitry.Sepp@opensynergy.com>)
 id 1jY4vP-00014N-AZ
 for qemu-devel@nongnu.org; Mon, 11 May 2020 05:40:39 -0400
Received: from plasma4.jpberlin.de ([80.241.57.33]:54659)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Dmitry.Sepp@opensynergy.com>)
 id 1jY4vN-0000zs-AW
 for qemu-devel@nongnu.org; Mon, 11 May 2020 05:40:38 -0400
Received: from spamfilter05.heinlein-hosting.de
 (spamfilter05.heinlein-hosting.de [80.241.56.123])
 by plasma.jpberlin.de (Postfix) with ESMTP id 61813BE4F7;
 Mon, 11 May 2020 11:40:30 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from plasma.jpberlin.de ([80.241.56.68])
 by spamfilter05.heinlein-hosting.de (spamfilter05.heinlein-hosting.de
 [80.241.56.123]) (amavisd-new, port 10030)
 with ESMTP id wcI2nhFaRMNp; Mon, 11 May 2020 11:40:28 +0200 (CEST)
Received: from webmail.opensynergy.com (unknown [217.66.60.5])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "webmail.opensynergy.com",
 Issuer "GeoTrust EV RSA CA 2018" (not verified))
 (Authenticated sender: opensynergy@jpberlin.de)
 by plasma.jpberlin.de (Postfix) with ESMTPSA id B6A5CBE3F0;
 Mon, 11 May 2020 11:40:28 +0200 (CEST)
Received: from os-lin-dmo.localnet (10.25.255.1) by MXS02.open-synergy.com
 (10.25.10.18) with Microsoft SMTP Server (TLS) id 14.3.487.0; Mon, 11 May
 2020 11:40:28 +0200
From: Dmitry Sepp <dmitry.sepp@opensynergy.com>
To: Kiran Pawar <Kiran.Pawar@opensynergy.com>, Samiullah Khawaja
 <samiullah.khawaja@opensynergy.com>, <qemu-devel@nongnu.org>, Saket Sinha
 <saket.sinha89@gmail.com>
Subject: Re: Fwd: Qemu Support for Virtio Video V4L2 driver
Date: Mon, 11 May 2020 11:40:22 +0200
Message-ID: <2405792.XL1faGB9W5@os-lin-dmo>
Organization: OpenSynergy
In-Reply-To: <CAK25hWOPS1wGORXgtv8hUNu9-mLO+5C_k3Cj=8pnoFWmjuhJdg@mail.gmail.com>
References: <CAK25hWN3kJcW-dcpryFrvZ50t7Y0Z=MZM66-8NMuhwjRpNo2aQ@mail.gmail.com>
 <CAK25hWMj5PyQFZVN5AToHjdySvi6iZ4zjZeUJQR85jNgoeLeAw@mail.gmail.com>
 <CAK25hWOPS1wGORXgtv8hUNu9-mLO+5C_k3Cj=8pnoFWmjuhJdg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [10.25.255.1]
X-Rspamd-Queue-Id: 61813BE4F7
X-Rspamd-Score: -0.81 / 15.00 / 200.00
Received-SPF: none client-ip=80.241.57.33;
 envelope-from=Dmitry.Sepp@opensynergy.com; helo=plasma4.jpberlin.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/11 05:40:32
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 11 May 2020 10:09:20 -0400
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
Cc: virtio-dev@lists.oasis-open.org, Gerd Hoffmann <kraxel@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Saket and all,

As we are working with automotive platforms, unfortunately we don't plan any 
Qemu reference implementation so far.

Of course we are ready to support the community if any help is needed. Is 
there interest in support for the FWHT format only for testing purpose or you 
want a full-featured implementation on the QEMU side?

Please note that the spec is not finalized yet and a major update is now 
discussed with upstream and the Chrome OS team, which is also interested and 
deeply involved in the process. The update mostly implies some rewording and 
reorganization of data structures, but for sure will require a driver rework.

Best regards,
Dmitry.

On Samstag, 9. Mai 2020 16:11:43 CEST Saket Sinha wrote:
> Hi,
> 
> As suggested on #qemu-devel IRC channel, I am including virtio-dev, Gerd and
> Michael to point in the right direction how to move forward with Qemu
> support for Virtio Video V4L2 driver
> posted in [1].
> 
> [1]: https://patchwork.linuxtv.org/patch/61717/
> 
> Regards,
> Saket Sinha
> 
> On Sat, May 9, 2020 at 1:09 AM Saket Sinha <saket.sinha89@gmail.com> wrote:
> > Hi ,
> > 
> > This is to inquire about Qemu support for Virtio Video V4L2 driver
> > posted in [1].
> > I am currently not aware of any upstream effort for Qemu reference
> > implementation and would like to discuss how to proceed with the same.
> > 
> > [1]: https://patchwork.linuxtv.org/patch/61717/
> > 
> > Regards,
> > Saket Sinha



