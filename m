Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEB0AC2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 22:02:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C0FD20735
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 22:02:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="acJLxXYd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C0FD20735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45854 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKqMf-0005hW-CY
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 18:02:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48332)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kKqFa-0006Yt-IZ
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 17:55:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:20022)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kKqFW-0002SA-WE
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 17:55:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600811696;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GzKXC3xLfZ4R7mSigB7/jrkfc9wtR9HjglQAFpT8IF0=;
 b=acJLxXYdlycXCsyhH6NZVbUbx/TuC970nKJipEYE4IZGz5MbPE8Gzdf3q1Mq5p9Al2Bnwp
 RVM8CMKWoxB0aJ+nMo09ffbHXLXYTRu5CAXDkIiFpdyzlkRqO8SZCNyobzFKkGMwpRzxeT
 Y6RfRm2I0CsWJHu1Iwg1z1uGW28TkiU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-208-3feBeDqtPxWdDBsg0ipnCA-1; Tue, 22 Sep 2020 17:54:52 -0400
X-MC-Unique: 3feBeDqtPxWdDBsg0ipnCA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 367E7186DD35;
 Tue, 22 Sep 2020 21:54:51 +0000 (UTC)
Received: from localhost (unknown [10.10.67.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E125578810;
 Tue, 22 Sep 2020 21:54:50 +0000 (UTC)
Date: Tue, 22 Sep 2020 17:54:49 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v2 07/38] qapi: add pylintrc
Message-ID: <20200922215449.GI2044576@habkost.net>
References: <20200922210101.4081073-1-jsnow@redhat.com>
 <20200922210101.4081073-8-jsnow@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200922210101.4081073-8-jsnow@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 02:07:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Markus Armbruster <armbru@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 22, 2020 at 05:00:30PM -0400, John Snow wrote:
> Using `pylint --generate-rcfile > pylintrc`, generate a skeleton
> pylintrc file. Sections that are not presently relevant (by the end of
> this series) are removed leaving just the empty section as a search
> engine / documentation hint to future authors.
> 
> Right now, quite a few modules are ignored as they are known to fail as
> of this commit. modules will be removed from the known-bad list
> throughout this and following series as they are repaired.
> 
> Note: Normally, pylintrc would go in the folder above the module, but as
> that folder is shared by many things, it is going inside the module
> folder (for now). Due to a bug in pylint 2.5.x, pylint does not
> correctly recognize when it is being run from "inside" a package, and
> must be run *outside* of the package.
> 
> Therefore, to run it, you must:
> 
>  > pylint scripts/qapi/ --rcfile=scripts/qapi/pylintrc
> 
> Signed-off-by: John Snow <jsnow@redhat.com>

Tested-by: Eduardo Habkost <ehabkost@redhat.com>

This doesn't generate any warnings after this patch, but at the
end of your -pt6 branch I got some pylint warnings.  I am
bisecting it to try to identify the patch where the warnings are
introduced.

-- 
Eduardo


