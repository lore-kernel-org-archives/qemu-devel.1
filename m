Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0411AC433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 14:25:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36CFD2075B
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 14:25:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="aCU77zBz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36CFD2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44246 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIuqP-0000Dv-3v
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 10:25:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37744)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1kIuWi-0005VC-9p
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 10:04:44 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:49599)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1kIuWa-0000wH-3x
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 10:04:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=ZNiJsORcp4Qu2yaXOyJKbh2peAVLBuxy6it8UMI6dZ4=; b=aCU77zBzGr5EzYymatgQmhLxes
 bEY2FoWNLsW/sw7lGZ46Is8BbZvQBz9Z+NmqiTwp39fzMSqq992/ptthKvWqzQpj+7tX1Kre6vjxK
 Li+OgGM5KvELe3lqn0PmSwpGM0mAAwINBBP2jj6hgz2KcGxCDNOM+FkQfyqR4i2sn8wIzWEPNDIZh
 NPgBA7wl3LtOIaPH8sWeZelDFw7u2q+SYaBK3HD5jHgwXVjLX7TrpITrVkB/Hhx2JmEFc3DAZEBJi
 sz3qvhbA8PUdamvIXMTJ13KU+VTdg59nc6RPxDB1W6W27W4Dr172RKuC0aWIueQR8FE3ljjPwlLhS
 Vd2hweqQ==;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Daniel =?ISO-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Greg Kurz <groug@kaod.org>, Max Reitz <mreitz@redhat.com>,
 Alex =?ISO-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: QEMU policy for real file tests
Date: Thu, 17 Sep 2020 16:04:32 +0200
Message-ID: <1957763.100GGpGQLh@silver>
In-Reply-To: <CAFEAcA8yTpHE2WaBL3B8fbQtetqmH5uXgCudtfHXuYuA+LpavQ@mail.gmail.com>
References: <1836935.RIYQIvKipu@silver>
 <a60c566c-986c-2534-3e8e-6a3ff23b9d00@redhat.com>
 <CAFEAcA8yTpHE2WaBL3B8fbQtetqmH5uXgCudtfHXuYuA+LpavQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=91.194.90.13; envelope-from=qemu_oss@crudebyte.com;
 helo=lizzy.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/17 08:06:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Donnerstag, 17. September 2020 14:40:42 CEST Peter Maydell wrote:
> (Ideally we'd put in some more consistent framework for temp files
> used by tests to put them all in a single subdir or something, for
> convenience in cleaning up afterwards.)

Yes, a unified interface for creating and auto wiping these, as well as 
communicating limits for them would be nice to allow test cases adapting to 
low quota vs. generous environments automatically.

For now I take Thomas' advice of 4GB as very rough barrier to stay away from.

On Donnerstag, 17. September 2020 15:11:18 CEST Peter Maydell wrote:
> On Thu, 17 Sep 2020 at 14:04, Thomas Huth <thuth@redhat.com> wrote:
> > On 17/09/2020 14.06, Christian Schoenebeck wrote:
> > [...]
> > 
> > > Final question: if at some later point one large file needs to be
> > > created for some test case, is there some approximate size limit to
> > > stay below for not causing issues with free CI cloud services?
> > 
> > FWIW, I know that 4G is already too big for some containers on Travis,
> > see commit 178d383f10e15f5e5a7.
> 
> Yes. Also "it's sparse" doesn't always help -- eg on OSX there is
> no sparse-file support so a 4GB file really does take 4GB even
> if it's mostly zeroes...

While I agree not using sparse files for test cases, as many environments 
don't support them; as a side note though: macOS actually supports sparse 
files for a long time, both on APFS and HPFS+ volumes. There is F_PUNCHHOLE 
and F_PREALLOCATE for that purpose and st_size reflects the logical file size, 
whereas st_blocks*S_BLKSIZE returns the actual allocated physical file size.

Best regards,
Christian Schoenebeck



