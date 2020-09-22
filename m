Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65EFAC2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 22:05:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 183EE206B5
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 22:05:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QnHFBKH1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 183EE206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53110 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKqPF-0000EG-85
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 18:05:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42588)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kKpmv-0008R7-7E
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 17:25:30 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24424
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kKpmq-0007cs-P1
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 17:25:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600809919;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kdEU7O/+QEaYgDPBe7cz7fnWLGHTCr1uKs7+U8eAZ8s=;
 b=QnHFBKH12SU2WMnro+gJlzPAhAjmZTmmBY/9IZR2N61IeLK0vYgCd5acszEwIto4gXBYqb
 KzdDSFGgeeh53e85UsIIAbJIFg4iKXKf7RJKtF2Va570ViBUsgrijPCFkjM3L7Kl7mDZJ5
 T5kUd1zfWcrBHibedLWm91ZMu2hVIMA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-247-xBmZKD1INHi65Y81klZzvg-1; Tue, 22 Sep 2020 17:25:16 -0400
X-MC-Unique: xBmZKD1INHi65Y81klZzvg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 627D2802B70;
 Tue, 22 Sep 2020 21:25:15 +0000 (UTC)
Received: from localhost (unknown [10.10.67.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2ABD027BD8;
 Tue, 22 Sep 2020 21:25:15 +0000 (UTC)
Date: Tue, 22 Sep 2020 17:25:14 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v2 04/38] qapi: Prefer explicit relative imports
Message-ID: <20200922212514.GE2044576@habkost.net>
References: <20200922210101.4081073-1-jsnow@redhat.com>
 <20200922210101.4081073-5-jsnow@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200922210101.4081073-5-jsnow@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 17:01:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Markus Armbruster <armbru@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 22, 2020 at 05:00:27PM -0400, John Snow wrote:
> All of the QAPI include statements are changed to be package-aware, as
> explicit relative imports.
> 
> A quirk of Python packages is that the name of the package exists only
> *outside* of the package. This means that to a module inside of the qapi
> folder, there is inherently no such thing as the "qapi" package. The
> reason these imports work is because the "qapi" package exists in the
> context of the caller -- the execution shim, where sys.path includes a
> directory that has a 'qapi' folder in it.
> 
> When we write "from qapi import sibling", we are NOT referencing the folder
> 'qapi', but rather "any package named qapi in sys.path". If you should
> so happen to have a 'qapi' package in your path, it will use *that*
> package.
> 
> When we write "from .sibling import foo", we always reference explicitly
> our sibling module; guaranteeing consistency in *where* we are importing
> these modules from.
> 
> This can be useful when working with virtual environments and packages
> in development mode. In development mode, a package is installed as a
> series of symlinks that forwards to your same source files. The problem
> arises because code quality checkers will follow "import qapi.x" to the
> "installed" version instead of the sibling file and -- even though they
> are the same file -- they have different module paths, and this causes
> cyclic import problems, false positive type mismatch errors, and more.
> 
> It can also be useful when dealing with hierarchical packages, e.g. if
> we allow qemu.core.qmp, qemu.qapi.parser, etc.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>

Here's the answer to the question I sent on patch 03/38.  :)

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

-- 
Eduardo


