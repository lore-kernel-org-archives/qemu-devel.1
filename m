Return-Path: <SRS0=pVGd=WM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22FE5C3A59C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 12:34:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE77F20644
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 12:34:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE77F20644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55204 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hybRa-0005yy-2Q
	for qemu-devel@archiver.kernel.org; Fri, 16 Aug 2019 08:34:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58059)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1hybQR-0005TP-2k
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 08:33:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hybQQ-00037j-2e
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 08:33:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46184)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>)
 id 1hybQM-00035f-0L; Fri, 16 Aug 2019 08:33:42 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7C7E2308302F;
 Fri, 16 Aug 2019 12:33:40 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-142.ams2.redhat.com
 [10.36.117.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 145B01757C;
 Fri, 16 Aug 2019 12:33:34 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6C89310E6CCA; Fri, 16 Aug 2019 14:33:26 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
References: <20190814100735.24234-1-vsementsov@virtuozzo.com>
 <20190814100735.24234-3-vsementsov@virtuozzo.com>
 <3eded188-0161-d494-194c-9d67da644eb1@redhat.com>
 <20190815104928.GC7415@linux.fritz.box>
 <9c290e4e-1d3b-bc6e-c6e6-28a0414b866e@redhat.com>
 <20190815164821.GE7415@linux.fritz.box>
 <87a7caut8t.fsf@dusky.pond.sub.org>
 <20190816082013.GB5014@localhost.localdomain>
Date: Fri, 16 Aug 2019 14:33:26 +0200
In-Reply-To: <20190816082013.GB5014@localhost.localdomain> (Kevin Wolf's
 message of "Fri, 16 Aug 2019 10:20:13 +0200")
Message-ID: <87d0h5p9wp.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Fri, 16 Aug 2019 12:33:40 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 2/2] qapi: deprecate implicit filters
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, libvir-list@redhat.com, qemu-devel@nongnu.org,
 mreitz@redhat.com, den@openvz.org, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Kevin Wolf <kwolf@redhat.com> writes:

> Am 15.08.2019 um 21:24 hat Markus Armbruster geschrieben:
[...]
>> Let's assume all libvirt ever does with deprecation notices is logging
>> them.  Would that solve the problem of reliably alerting libvirt
>> developers to deprecation issues?  Nope.  But it could help
>> occasionally.
>
> I'm not saying that deprecation notices would hurt, just that they
> probably won't solve problem alone.

No argument.

> Crashing if --future is given and logging otherwise seems reasonable
> enough to me. Whether we need to wire up a new deprecation mechanism in
> QMP for the logging or if we can just keep printing to stderr is
> debatable. stderr already ends up in a log file, a QMP extension would
> require new libvirt code. If libvirt would log deprecation notices more
> prominently, or use the information for tainting or any other kind of
> processing, a dedicated QMP mechanism could be justified.

I'd like to start with two tasks:

* A CLI option to configure what to do on use of a deprecated feature.

  We currently warn.  We want to be able to crash instead.  Silencing
  the warnings might be useful.  Turning them into errors might be
  useful.

  The existing ad hoc warnings need to be replaced by a call of a common
  function that implements the configurable behavior.

* QAPI feature flag "deprecated", for introspectable deprecation, and
  without ad hoc code.

Then see whether our users need more.

