Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A65BDC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 09:58:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D0FF20709
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 09:58:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y/a4Ny35"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D0FF20709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZX73-0006JP-Lc
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 05:58:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41320)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jZX66-00050G-4x
 for qemu-devel@nongnu.org; Fri, 15 May 2020 05:57:42 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:37327
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jZX65-0005Iz-BA
 for qemu-devel@nongnu.org; Fri, 15 May 2020 05:57:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589536660;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KH7ikdjScKYDHft8zg2yalQ+UGNyUwoHUHK55LRVrtk=;
 b=Y/a4Ny35BW/azfOWtTX3QzCO4hB6jzph45KqRx9RoNXLQU1eNnk034j7LkqE74prdbhPoe
 wzkHHkXwbxjjuZBwsL6brB1vUEPSJ9yr1enGAYdundvuQPgdSh404rhigoe/NGFyVP/Gf2
 gj5olCA3qB48bDi1bnlqzFx+JLCIajY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-323-iSiDDbQhOJOidO9t93gpOA-1; Fri, 15 May 2020 05:57:37 -0400
X-MC-Unique: iSiDDbQhOJOidO9t93gpOA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7A676100CD09;
 Fri, 15 May 2020 09:57:36 +0000 (UTC)
Received: from linux.fritz.box (ovpn-113-110.ams2.redhat.com [10.36.113.110])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6E65678B23;
 Fri, 15 May 2020 09:57:35 +0000 (UTC)
Date: Fri, 15 May 2020 11:57:33 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH 0/3] iotests: enable logging prior to notrun() invocation
Message-ID: <20200515095733.GE93011@linux.fritz.box>
References: <20200514201614.19941-1-jsnow@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200514201614.19941-1-jsnow@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/15 00:39:12
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 14.05.2020 um 22:16 hat John Snow geschrieben:
> Hi, you can take just patch 1.

Thanks, I'm doing that now.

> patches 2-3 admittedly don't do a whole heck of a lot, because I
> didn't realize that ./check discards *all* output from either stdout
> or stderr.

It doesn't discard it, but it compares it to the reference output and
prints a diff if it's non-empty.

At least for bash scripts, stderr contains important test output. Not
sure what the *_log() functions in iotests.py do, maybe they redirect
the stderr output from tools to stdout.

> The changes are tiny, though, and maybe still worth doing in the long
> run? Hm. They are archived on the list now, anyway.

We can still take these patches for a later pull request if you think we
should, though I'm not sure if they are useful given how things actually
work. I don't have a strong opinion either way (except that I don't want
to see more than a single line per test without -d, but these patches
don't try to do this even though you wrote them under the assumption
that this is how things work).

Kevin


