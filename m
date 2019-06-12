Return-Path: <SRS0=XH1q=UL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68492C31E46
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 14:31:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42B612082C
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 14:31:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42B612082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60908 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hb4HM-0007AJ-3F
	for qemu-devel@archiver.kernel.org; Wed, 12 Jun 2019 10:31:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49136)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hb4DK-0005B9-2D
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 10:26:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hb493-0006TT-28
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 10:22:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:13020)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>)
 id 1hb491-0006Pu-QI; Wed, 12 Jun 2019 10:22:31 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id F3245305FC56;
 Wed, 12 Jun 2019 14:22:25 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-148.ams2.redhat.com
 [10.36.116.148])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BD32E5C644;
 Wed, 12 Jun 2019 14:22:25 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 50CA41138648; Wed, 12 Jun 2019 16:22:24 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
References: <20190611134043.9524-1-kwolf@redhat.com>
Date: Wed, 12 Jun 2019 16:22:24 +0200
In-Reply-To: <20190611134043.9524-1-kwolf@redhat.com> (Kevin Wolf's message of
 "Tue, 11 Jun 2019 15:40:32 +0200")
Message-ID: <87muimx4rj.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Wed, 12 Jun 2019 14:22:31 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 00/11] monitor: Split monitor.c in
 core/HMP/QMP/misc
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
Cc: berrange@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Kevin Wolf <kwolf@redhat.com> writes:

> monitor.c mixes a lot of different things in a single file: The core
> monitor infrastructure, HMP infrastrcture, QMP infrastructure, and the
> implementation of several HMP and QMP commands. Almost worse, struct
> Monitor mixes state for HMP, for QMP, and state actually shared between
> all monitors. monitor.c must be linked with a system emulator and even
> requires per-target compilation because some of the commands it
> implements access system emulator state.

Also: it's so fat it hasn't seen its feet in years.

> The reason why I care about this is that I'm working on a protoype for a
> storage daemon, which wants to use QMP (but probably not HMP) and
> obviously doesn't have any system emulator state. So I'm interested in
> some core monitor parts that can be linked to non-system-emulator tools.
>
> This series first creates separate structs MonitorQMP and MonitorHMP
> which inherit from Monitor, and then moves the associated infrastructure
> code into separate source files.
>
> While the split is probably not perfect,

It's not :)

>                                          I think it's an improvement of
> the current state even for QEMU proper,

It very much is!

There are a few issues to address, but nothing structural.  Looking
forward to v3.

>                                         and it's good enough so I can
> link my storage daemon against just monitor/core.o and monitor/qmp.o and
> get a useless QMP monitor that parses the JSON input and rejects
> everything as an unknown command.
>
> Next I'll try to teach it a subset of QMP commands that can actually be
> supported in a tool, but while there will be a few follow-up patches to
> achieve this, I don't expect that this work will bring up much that
> needs to be changed in the splitting process done in this series.

