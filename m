Return-Path: <SRS0=zt/K=T3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6792C04AB3
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 18:39:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B30A3208CA
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 18:39:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B30A3208CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49372 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVKXN-0004pZ-S0
	for qemu-devel@archiver.kernel.org; Mon, 27 May 2019 14:39:57 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36839)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hVKWW-0004SY-Hk
	for qemu-devel@nongnu.org; Mon, 27 May 2019 14:39:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hVKWV-0005pq-Mw
	for qemu-devel@nongnu.org; Mon, 27 May 2019 14:39:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53560)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hVKWV-0005pQ-Ip
	for qemu-devel@nongnu.org; Mon, 27 May 2019 14:39:03 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F3F5E3087930
	for <qemu-devel@nongnu.org>; Mon, 27 May 2019 18:39:01 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-250.ams2.redhat.com
	[10.36.117.250])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 9520D7940D;
	Mon, 27 May 2019 18:38:58 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 435431138648; Mon, 27 May 2019 20:38:57 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
References: <1558079119-320634-1-git-send-email-imammedo@redhat.com>
	<1558079119-320634-5-git-send-email-imammedo@redhat.com>
Date: Mon, 27 May 2019 20:38:57 +0200
In-Reply-To: <1558079119-320634-5-git-send-email-imammedo@redhat.com> (Igor
	Mammedov's message of "Fri, 17 May 2019 09:45:17 +0200")
Message-ID: <87woibhhdq.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.45]);
	Mon, 27 May 2019 18:39:02 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 4/6] numa: introduce
 "numa-mem-supported" machine property
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
Cc: libvir-list@redhat.com, pbonzini@redhat.com, berrange@redhat.com,
	qemu-devel@nongnu.org, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Igor Mammedov <imammedo@redhat.com> writes:

> '-numa mem' option has a number of issues and mgmt often defaults
> to it. Unfortunately it's no possible to replace it with an alternative
> '-numa memdev' without breaking migration compatibility.

To be precise: -numa node,mem=... and -numa node,memdev=...  Correct?

>                                                          What's possible
> though is to deprecate it, keeping option working with old machine types.
> Once deprecation period expires, QEMU will disable '-numa mem' option,
> usage on new machine types and when the last machine type that supported
> it is removed we would be able to remove '-numa mem' with associated code.
>
> In order to help mgmt to find out if being deprecated CLI option
> '-numa mem=SZ' is still supported by particular machine type, expose
> this information via "numa-mem-supported" machine property.
>
> Users can use "qom-list-properties" QMP command to list machine type
> properties including initial proprety values (when probing for supported
> machine types with '-machine none') or at runtime at preconfig time
> before numa mapping is configured and decide if they should used legacy
> '-numa mem' or alternative '-numa memdev' option.

This sentence is impenetrable, I'm afraid :)

If we only want to convey whether a machine type supports -numa
node,mem=..., then adding a flag to query-machines suffices.  Since I'm
pretty sure you'd have figured that out yourself, I suspect I'm missing
something.  Can you give me some examples of intended usage?

