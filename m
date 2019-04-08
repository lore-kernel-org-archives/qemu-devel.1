Return-Path: <SRS0=gAfu=SK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0279CC282CE
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 09:00:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4A1F20870
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 09:00:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4A1F20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49737 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDQ8z-0006Dy-Hh
	for qemu-devel@archiver.kernel.org; Mon, 08 Apr 2019 05:00:45 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33432)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hDQ87-0005j1-Ox
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 04:59:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hDQ86-0002TE-Vd
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 04:59:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36252)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hDQ86-0002Sp-Ny
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 04:59:50 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DB22430832E3;
	Mon,  8 Apr 2019 08:59:49 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-116.ams2.redhat.com
	[10.36.116.116])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 94A591A267;
	Mon,  8 Apr 2019 08:59:49 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 112701138648; Mon,  8 Apr 2019 10:59:48 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Wei Yang <richardw.yang@linux.intel.com>
References: <20190405064121.23662-1-richardw.yang@linux.intel.com>
	<20190405064121.23662-2-richardw.yang@linux.intel.com>
Date: Mon, 08 Apr 2019 10:59:48 +0200
In-Reply-To: <20190405064121.23662-2-richardw.yang@linux.intel.com> (Wei
	Yang's message of "Fri, 5 Apr 2019 14:41:18 +0800")
Message-ID: <875zroub23.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.44]);
	Mon, 08 Apr 2019 08:59:50 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 1/4] vl.c: make find_default_machine()
 local
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
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190408085948.d7CaBhWntbkbCqYz0-nQayjxLgW7ZbQSwbpT5e8SJi8@z>

Wei Yang <richardw.yang@linux.intel.com> writes:

> Function find_default_machine() is introduced by commit 2c8cffa599b7
> "vl: make find_default_machine externally visible", and it was used
> outside of vl.c until commit a904410af5f1 "pc_sysfw: remove the rom_only
> property".
>
> Commit a904410af5f1 "pc_sysfw: remove the rom_only property" removed the
> only user of find_default_machine() outside vl.c, but neglected to make
> it static. Do that now.
>
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>

Reviewed-by: Markus Armbruster <armbru@redhat.com>

