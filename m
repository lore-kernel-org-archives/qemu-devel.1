Return-Path: <SRS0=PAXx=ST=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C491EC10F12
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 08:28:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 987BB2073F
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 08:28:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 987BB2073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48917 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGfvL-0006Gu-Re
	for qemu-devel@archiver.kernel.org; Wed, 17 Apr 2019 04:28:07 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52815)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hGfuZ-0005yE-Ll
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 04:27:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hGfuY-0008B3-OT
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 04:27:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48200)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1hGfuY-00088N-GN
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 04:27:18 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C9D9981DE1;
	Wed, 17 Apr 2019 08:27:16 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-65.ams2.redhat.com
	[10.36.116.65])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 5861D5D6A6;
	Wed, 17 Apr 2019 08:27:13 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id 911701747B; Wed, 17 Apr 2019 10:27:12 +0200 (CEST)
Date: Wed, 17 Apr 2019 10:27:12 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20190417082712.5g5nztxcctembe3z@sirius.home.kraxel.org>
References: <20190415154503.6758-1-berrange@redhat.com>
	<CAFEAcA-YpG71aGtTVMafShGyd9uM599Uy_8S3vvvnPzfiKMqnw@mail.gmail.com>
	<CAFEAcA-kywfUEZARqzH=obD1p3UsAcsNneK-X0BPpoFnV-QK0A@mail.gmail.com>
	<CAFEAcA_+sf3L5ChBDKEekKb5iTTQZu4mEfF7eiTL78oMDuR16A@mail.gmail.com>
	<CAFEAcA84DLEGQduvubsKP-2NrdNkzLcihL2WusZiHReupbF1PA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <CAFEAcA84DLEGQduvubsKP-2NrdNkzLcihL2WusZiHReupbF1PA@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.25]);
	Wed, 17 Apr 2019 08:27:16 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 0/3] usb-mtp: fix ObjectInfo request
 handling
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
Cc: Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
	Greg Kurz <groug@kaod.org>, Bandan Das <bsd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190417082712.fwKyKuzayD1MUZt1yu6PixwJ5ZuQGZno1RY83xOgC1Q@z>

On Tue, Apr 16, 2019 at 11:27:06PM +0100, Peter Maydell wrote:
> On Tue, 16 Apr 2019 at 20:33, Peter Maydell <peter.maydell@linaro.org> wrote:
> >
> > On Tue, 16 Apr 2019 at 18:27, Peter Maydell <peter.maydell@linaro.org> wrote:
> > > Having thought a bit more I think I'd definitely like to apply
> > > just patch 2 for 4.0. Could people try to test that and confirm
> > > that it at least does not make the feature behave any worse?
> >
> > I've done a tentative merge test of patch 2, which is OK.
> > I'd like to push that either today or tomorrow (uk time):
> > objections?
> 
> ...now pushed.

Added the other two to the (4.1) usb queue.

thanks,
  Gerd


