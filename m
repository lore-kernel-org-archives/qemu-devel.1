Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C85CC004C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 05:14:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4955F20825
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 05:14:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4955F20825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40055 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNsRN-0007gx-Je
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 01:14:57 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54761)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hNsQh-0007O5-2o
	for qemu-devel@nongnu.org; Tue, 07 May 2019 01:14:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hNsQg-00018V-5r
	for qemu-devel@nongnu.org; Tue, 07 May 2019 01:14:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60194)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hNsQg-00018J-0o
	for qemu-devel@nongnu.org; Tue, 07 May 2019 01:14:14 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EB2DF3091786;
	Tue,  7 May 2019 05:14:12 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-28.ams2.redhat.com
	[10.36.116.28])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id A895C18219;
	Tue,  7 May 2019 05:14:12 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 25BC81132B35; Tue,  7 May 2019 07:14:06 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Zhang Chen <chen.zhang@intel.com>
References: <20190426093920.5616-1-chen.zhang@intel.com>
Date: Tue, 07 May 2019 07:14:06 +0200
In-Reply-To: <20190426093920.5616-1-chen.zhang@intel.com> (Zhang Chen's
	message of "Fri, 26 Apr 2019 17:39:20 +0800")
Message-ID: <87ef5aj17l.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.41]);
	Tue, 07 May 2019 05:14:13 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] MAINTAINERS: Add qemu-options* to related
 field
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
Cc: Zhang Chen <chen.zhang@intel.com>, qemu-dev <qemu-devel@nongnu.org>,
	Zhang Chen <zhangckid@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Zhang Chen <chen.zhang@intel.com > writes:

> From: Zhang Chen <chen.zhang@intel.com>
>
> No one to maintain qemu-options related file, add it to Markus's
> Command line option argument parsing field.
>
> Signed-off-by: Zhang Chen <chen.zhang@intel.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 23db6f8408..acc3b32f88 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1800,6 +1800,7 @@ F: tests/test-keyval.c
   Command line option argument parsing
   M: Markus Armbruster <armbru@redhat.com>
   S: Supported
   F: include/qemu/option.h
   F: tests/test-keyval.c
>  F: tests/test-qemu-opts.c
>  F: util/keyval.c
>  F: util/qemu-option.c
> +F: qemu-options*
>  
>  Coverity model
>  M: Markus Armbruster <armbru@redhat.com>

Please don't.

There's command line option parsing infrastructure, and there's the
command line interface.  The latter uses the former.

I'm maintaining the former.  I don't have capacity to take on the latter
right now.

Note that the same split exists between QAPI/QMP infrastructure (stanza
"QAPI", maintained by Michael Roth and me) and the QAPI Schema (stanza
"QAPI Schema", maintained by Eric Blake and me).

