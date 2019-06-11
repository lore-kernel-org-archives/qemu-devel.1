Return-Path: <SRS0=mXWu=UK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43165C43218
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 08:50:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2057C208E3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 08:50:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2057C208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52918 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hacTd-0001Yc-RR
	for qemu-devel@archiver.kernel.org; Tue, 11 Jun 2019 04:50:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53857)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hacNk-0004G4-D9
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 04:43:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hacAu-0000XU-F6
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 04:30:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59588)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hacAu-0000Un-6d
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 04:30:36 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 02919356F6
 for <qemu-devel@nongnu.org>; Tue, 11 Jun 2019 08:30:31 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-148.ams2.redhat.com
 [10.36.116.148])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 64A2060A9F;
 Tue, 11 Jun 2019 08:30:26 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 185D811386A0; Tue, 11 Jun 2019 10:30:25 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
References: <1559205199-233510-2-git-send-email-imammedo@redhat.com>
 <1560172207-378962-1-git-send-email-imammedo@redhat.com>
Date: Tue, 11 Jun 2019 10:30:25 +0200
In-Reply-To: <1560172207-378962-1-git-send-email-imammedo@redhat.com> (Igor
 Mammedov's message of "Mon, 10 Jun 2019 15:10:07 +0200")
Message-ID: <87wohssevy.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Tue, 11 Jun 2019 08:30:31 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v5 1/3] machine: show if CLI option '-numa
 node, mem' is supported in QAPI schema
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
Cc: libvir-list@redhat.com, pbonzini@redhat.com, berrange@redhat.com,
 qemu-devel@nongnu.org, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Igor Mammedov <imammedo@redhat.com> writes:

> Legacy '-numa node,mem' option has a number of issues and mgmt often
> defaults to it. Unfortunately it's no possible to replace it with
> an alternative '-numa memdev' without breaking migration compatibility.
> What's possible though is to deprecate it, keeping option working with
> old machine types only.
>
> In order to help users to find out if being deprecated CLI option
> '-numa node,mem' is still supported by particular machine type, add new
> "numa-mem-supported" property to output of query-machines.
>
> "numa-mem-supported" is set to 'true' for machines that currently support
> NUMA, but it will be flipped to 'false' later on, once deprecation period
> expires and kept 'true' only for old machine types that used to support
> the legacy option so it won't break existing configuration that are using
> it.
>
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: Markus Armbruster <armbru@redhat.com>

