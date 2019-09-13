Return-Path: <SRS0=wgY8=XI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C01E6C49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 12:53:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 947A0206BB
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 12:53:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 947A0206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43508 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8l52-0003zb-RR
	for qemu-devel@archiver.kernel.org; Fri, 13 Sep 2019 08:53:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58541)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1i8l4F-0003X0-Rw
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 08:52:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1i8l4E-0004zO-TQ
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 08:52:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57188)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1i8l4E-0004x5-O7
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 08:52:50 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0BD8D308A9E2;
 Fri, 13 Sep 2019 12:52:47 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-142.ams2.redhat.com
 [10.36.117.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 196915D9CC;
 Fri, 13 Sep 2019 12:52:44 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9D8E7113865F; Fri, 13 Sep 2019 14:52:42 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Michal Privoznik <mprivozn@redhat.com>
References: <faeb030e6a1044f0fd88208edfdb1c5fafe5def9.1567171655.git.mprivozn@redhat.com>
Date: Fri, 13 Sep 2019 14:52:42 +0200
In-Reply-To: <faeb030e6a1044f0fd88208edfdb1c5fafe5def9.1567171655.git.mprivozn@redhat.com>
 (Michal Privoznik's message of "Fri, 30 Aug 2019 15:29:45 +0200")
Message-ID: <87k1accq91.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Fri, 13 Sep 2019 12:52:47 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2] qapi/qmp-dispatch: Fix error class for
 reporting disabled commands
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
Cc: mdroth@linux.vnet.ibm.com, lcapitulino@redhat.com, qemu-devel@nongnu.org,
 armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Michal Privoznik <mprivozn@redhat.com> writes:

> If a command is disabled an error is reported. But due to usage
> of error_setg() the class of the error is GenericError which does
> not help callers in distinguishing this case from a case where a
> qmp command fails regularly due to other reasons. Use
> CommandNotFound error class which is much closer to the actual
> root cause.
>
> Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
> ---

I'd like to tweak the commit message a bit:

  qmp-dispatch: Use CommandNotFound error for disabled commands

  If a command is disabled an error is reported.  But due to usage of
  error_setg() the class of the error is GenericError which does not
  help callers in distinguishing this case from a case where a qmp
  command fails regularly due to other reasons.

  We used to use class CommandDisabled until the great error
  simplification (commit de253f1491 for QMP and commit 93b91c59db for
  qemu-ga, both v1.2.0).

  Use CommandNotFound error class, which is close enough.

Objections?

