Return-Path: <SRS0=EA86=VT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06CDEC76188
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 09:46:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD3322190F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 09:46:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD3322190F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60088 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpUuB-0005fw-1Y
	for qemu-devel@archiver.kernel.org; Mon, 22 Jul 2019 05:46:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48596)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mlevitsk@redhat.com>) id 1hpUtx-00053l-HZ
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 05:46:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1hpUtw-0000R1-Ir
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 05:46:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36114)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1hpUtp-0000Ms-VA; Mon, 22 Jul 2019 05:46:31 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 38588300C72A;
 Mon, 22 Jul 2019 09:46:27 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.45])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 66D975C206;
 Mon, 22 Jul 2019 09:46:25 +0000 (UTC)
Message-ID: <a8979dcc4affa9adc50c54e9c1b640dee3d09b83.camel@redhat.com>
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 22 Jul 2019 12:46:24 +0300
In-Reply-To: <20190722094103.GA6583@localhost.localdomain>
References: <20190721181508.28608-1-mlevitsk@redhat.com>
 <20190721181508.28608-3-mlevitsk@redhat.com>
 <20190722094103.GA6583@localhost.localdomain>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Mon, 22 Jul 2019 09:46:27 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 2/2] qemu-img: better error message when
 opening a backing file fails
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
Cc: qemu-block@nongnu.org, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 2019-07-22 at 11:41 +0200, Kevin Wolf wrote:
> Am 21.07.2019 um 20:15 hat Maxim Levitsky geschrieben:
> > Currently we print message like that:
> > 
> > "
> > new_file.qcow2 : error message
> > "
> > 
> > However the error could have come from opening the backing file (e.g when it missing encryption keys),
> > thus try to clarify this by using this format:
> > 
> > "
> > qemu-img: error creating new_file.qcow2: base_file.qcow2: error message
> > Could not open backing image to determine size.
> > "
> 
> The old error message was just unspecific. Your new error message can be
> actively misleading because you just unconditionally print the filename
> of the direct backing file, even though the error could have occurred
> while opening the backing file of the backing file (or even further down
> the backing chain).
> 
> It's a common problem we have with backing files and error messages: We
> either don't print the filename where the error actually happened (like
> in this case), or we print all of the backing files in the chain (such
> as "Could not open top.qcow2: Could not open mid.qcow2: Could not open
> base.qcow2: Invalid something").
> 
> Ideally, we'd find a way to print only the backing filename in such
> cases ("Could not open base.qcow2: Invalid something"). I'd gladly
> accept a patch that fixes error messages in this way for both open and
> create, but I'm afraid that your approach in this patch is too
> simplistic and not an improvement

You raise a very good point, I didn't thought about this.
Thanks,

Best regards,
	Maxim Levitsky



