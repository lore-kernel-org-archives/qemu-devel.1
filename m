Return-Path: <SRS0=LaQQ=XZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D4F8C32792
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 17:13:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E68D21855
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 17:13:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E68D21855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55254 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iEzES-0003GP-SN
	for qemu-devel@archiver.kernel.org; Mon, 30 Sep 2019 13:13:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47309)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1iEzCh-0001qo-Gx
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 13:11:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1iEzCg-0005gj-HX
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 13:11:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50568)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1iEzCe-0005fT-2T; Mon, 30 Sep 2019 13:11:16 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7D35B356CE;
 Mon, 30 Sep 2019 17:11:14 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.22])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A217560126;
 Mon, 30 Sep 2019 17:11:10 +0000 (UTC)
Message-ID: <2ec8551dd17b13fb173cdbe12979761a89332948.camel@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 00/11] RFC crypto/luks: encryption key
 managment using amend interface
From: Maxim Levitsky <mlevitsk@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Date: Mon, 30 Sep 2019 20:11:09 +0300
In-Reply-To: <632e3a8b-ee54-50e0-83a2-ea82ad8e061f@redhat.com>
References: <20190912223028.18496-1-mlevitsk@redhat.com>
 <632e3a8b-ee54-50e0-83a2-ea82ad8e061f@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Mon, 30 Sep 2019 17:11:14 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "Daniel P. =?ISO-8859-1?Q?Berrang=E9?=" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 2019-09-20 at 17:14 -0400, John Snow wrote:
> 
> On 9/12/19 6:30 PM, Maxim Levitsky wrote:
> > This patch series is continuation of my work to add encryption
> > key managment to luks/qcow2 with luks.
> > 
> > This is second version of this patch set.
> > The changes are mostly addressing the review feedback,
> > plus I tested (and fixed sadly) the somewhat ugly code
> > that allows to still write share a raw luks device,
> > while preveting the key managment from happening in this case,
> > as it is unsafe.
> > I added a new iotest dedicated to that as well.
> > 
> > Best regards,
> > 	Maxim Levitsky
> > 
> 
> What branch is this based on?
> It doesn't seem to apply to origin/master.
> 
> --js
Hi!

Most of the refactoring patches are now on the master branch,
(one patch was dropped due to me being blind :-(), so should I resend
this patch series with the missing patch or wait for some review? 

At that stage I would like to hear about agreement/disagreement on the new APIs,
and stuff like that.

Best regards,
	Maxim Levitsky


