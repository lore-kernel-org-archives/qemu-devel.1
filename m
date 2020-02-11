Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7A9AC352A3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 08:16:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8188220675
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 08:16:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="bMIe1XJR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8188220675
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44886 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1Qic-0000Nq-O5
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 03:16:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45632)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <qemu_oss@crudebyte.com>) id 1j1Qhv-0008Pg-3Y
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 03:15:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <qemu_oss@crudebyte.com>) id 1j1Qht-0006rU-PK
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 03:15:46 -0500
Received: from kylie.crudebyte.com ([5.189.157.229]:37543)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <qemu_oss@crudebyte.com>)
 id 1j1Qht-0006lk-D5
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 03:15:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=PIOVn72KYzsxNIcIBCoFPHD4ZPfHGe34Rn0hbn4DqRo=; b=bMIe1XJR+in6c4YkTYciO5w2uA
 Os8B4RorXL0jve8g5ggzVtrW9xry/Zzbze3N7dpy6UoqZ2rnCbizR0qled1ToD2bOVPcQwv5BzNyK
 XSJ7fV6uyEiJKHwMqshog6L+g0BefEqxoJFUPj+2gW+soPGlx3/+/iu/nv5HWBZPQwFBiDk+bBzO9
 YxM/tI/UNWSumZCCW9Z/Y/52yIpXutZqsIuu6xzMq5IaPUaywK5sTULkoLBsmHDZsNeo1ZuaoSuvB
 l/8J3a18Z0HvXStU2HEDNlGJ5ncNHkUiBA+Kdg0/4XFchSGmf5GVY9OoEJX/XPgX0BQHiWTkx9F7n
 szNZkbRA8MYSVLMOPmuQX79YWjEhk0mYiXudL3lEu+iMnYRqThdC4PLfdnuGo9OFg4NtYqsyKYtP+
 0CCplikdJQyXZ6eL2q65rteJIvnujWQDbBa8KEQ1SC7c6kC77S8TWzH5zI6UgCMjoHVyjAwLhMJgu
 7dlaxM45grZ2XYfgYsrDHpWQYS12Mxfdf5dCDHzzZhncAYOkTfY2v+3QB0C52RXvLlI/D/0ov3oGv
 Py8F6gBcWBk4OZLjTqRjnQQ/1TVdWF5ZH1m4IzORPYKMiBeZOSWWoVaBE1uwrDDeHkAEDxE7hpXHx
 B6fYqK70mr8QIr2D544R90KW1ANASS4FyAb9/1w5E=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Greg Kurz <groug@kaod.org>
Subject: Re: [PULL 0/6] 9p patches 2020-02-08
Date: Tue, 11 Feb 2020 09:15:41 +0100
Message-ID: <1679063.kJpWnTDlLf@silver>
In-Reply-To: <CAFEAcA_b0y6qX9LExsuNFEDivZN2y6-zbcrTLhX1djqPiYoA5A@mail.gmail.com>
References: <20200208104506.2727882-1-groug@kaod.org>
 <CAFEAcA_b0y6qX9LExsuNFEDivZN2y6-zbcrTLhX1djqPiYoA5A@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 5.189.157.229
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

On Montag, 10. Februar 2020 18:08:38 CET Peter Maydell wrote:
> On Sat, 8 Feb 2020 at 10:45, Greg Kurz <groug@kaod.org> wrote:
> > The following changes since commit 
42ccca1bd9456568f996d5646b2001faac96944b:
> >   Merge remote-tracking branch
> >   'remotes/berrange/tags/misc-fixes-pull-request' into staging
> >   (2020-02-07 15:01:23 +0000)> 
> > are available in the Git repository at:
> >   https://github.com/gkurz/qemu.git tags/9p-next-2020-02-08
> > 
> > for you to fetch changes up to 2822602cbe2be98229b882101dfdb9d3a738c611:
> >   MAINTAINERS: 9pfs: Add myself as reviewer (2020-02-08 09:29:04 +0100)
> > 
> > ----------------------------------------------------------------
> > 9p patches:
> > - some more protocol sanity checks
> > - qtest for readdir
> > - Christian Schoenebeck now official reviewer
> > 
> > ----------------------------------------------------------------
> 
> Applied, thanks.
> 
> Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
> for any user-visible changes.
> 
> -- PMM

I.e. msize >= 4096 now being required. AFAICS I cannot update the wiki myself.

Best regards,
Christian Schoenebeck



