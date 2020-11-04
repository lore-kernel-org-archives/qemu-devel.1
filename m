Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B9BAC2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 01:33:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99715223C7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 01:33:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ciJ9CO14"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99715223C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ka7g6-0002lM-MG
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 20:33:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36360)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1ka6p4-0000tv-6I
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 19:38:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39907)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1ka6p2-00054r-DB
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 19:38:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604450323;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NR4tK91hmKdhckmuWZTqCvQYCCZuvYxuejZtCyp6aCQ=;
 b=ciJ9CO14ZvVbBWT/qEAb+6GLspHdK7iZ4FkjBbRdgj/UE3ih3W/s1TL0x+tTAvCXnTYaWs
 lYs5S4iso6837trbyrXzMLI/ktKJ8tW5Pky71jb61Mouc0TiNhTTpIx+xTzn9pYmAm1btr
 zenkOd0AS0hNdBdHs16IpervidUoqtk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-358-7uRJkER6NBaD2KHIvaFWqA-1; Tue, 03 Nov 2020 19:38:41 -0500
X-MC-Unique: 7uRJkER6NBaD2KHIvaFWqA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 125696D243
 for <qemu-devel@nongnu.org>; Wed,  4 Nov 2020 00:38:41 +0000 (UTC)
Received: from [10.10.119.97] (ovpn-119-97.rdu2.redhat.com [10.10.119.97])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 54E5F5B4A1;
 Wed,  4 Nov 2020 00:38:40 +0000 (UTC)
Subject: Re: [PATCH 00/15] python: absorb scripts/qmp/qom-* tooling
To: qemu-devel@nongnu.org
References: <20201021185208.1611145-1-jsnow@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <4043a544-604b-cbd3-9953-e147a7cddcfe@redhat.com>
Date: Tue, 3 Nov 2020 19:38:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201021185208.1611145-1-jsnow@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 01:02:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/21/20 2:51 PM, John Snow wrote:
> Based-on: <20201020193555.1493936-1-jsnow@redhat.com>
>            [PATCH v3 00/15] python: create installable package
> 

Thanks for the early look. This is superseded by:

[PATCH v2 00/72] python: move scripts/qmp to python/qemu/qmp

> This is a bit of a demonstration of the direction I want to take our
> python tooling, and how it *might* work.
> 
> By moving items from ./scripts/*.py over to ./python/qemu/* somewhere,
> they can be checked with the same isort/flake8/pylint/mypy tooling as
> everything else. This will help prevent regressions.
> 
> I would like to, over time, move all applicable python scripts from
> ./scripts to ./python. That will be a long, gradual stream of changes,
> but the more we do it, the better off we'll be for these tools.
> 
> Reviewer notes:
> 
> - I just rewrote qom-xxx entirely, though it is based on the original
>    scripts. Doing it brick by brick was too slow.
> 
> - I added a symlink to the qom-fuse file under the python/ tree so I
>    could check it with the usual linters. This causes some future
>    knowledge to bleed through in a few places; notably I update the
>    python setup.cfg several times in the middle of the series where it
>    doesn't seem like that should have an effect.
> 
> - qom-fuse disappears from the tree for a single commit, but that
>    preserves git-blame history. Best I could do.
> 
> John Snow (15):
>    python/qmp: Add qom script rewrites
>    python/qmp: add qom script entry points
>    scripts/qmp: redirect qom-xxx scripts to python/qemu/qmp/
>    scripts/qom-fuse: apply isort rules
>    scripts/qom-fuse: apply flake8 rules
>    python: Add 'fh' to known-good variable names
>    scripts/qom-fuse: Apply pylint rules
>    scripts/qom-fuse: Add docstrings
>    scripts/qom-fuse: Convert to QOMCommand
>    scripts/qom-fuse: use QOMCommand.qom_list()
>    scripts/qom-fuse: ensure QOMFuse.read always returns bytes
>    scripts/qom-fuse: add static type hints
>    scripts/qom-fuse: move to python/qemu/qmp/qom_fuse.py
>    scripts/qom-fuse: add redirection shim to python/qemu/qmp/qom-fuse.py
>    python: add fuse command to 'qom' tools
> 
>   python/qemu/qmp/qom.py        | 217 ++++++++++++++++++++++++++++++++++
>   python/qemu/qmp/qom_common.py | 153 ++++++++++++++++++++++++
>   python/qemu/qmp/qom_fuse.py   | 207 ++++++++++++++++++++++++++++++++
>   python/setup.cfg              |  24 +++-
>   scripts/qmp/qom-fuse          | 144 +---------------------
>   scripts/qmp/qom-get           |  66 +----------
>   scripts/qmp/qom-list          |  63 +---------
>   scripts/qmp/qom-set           |  63 +---------
>   scripts/qmp/qom-tree          |  74 +-----------
>   9 files changed, 618 insertions(+), 393 deletions(-)
>   create mode 100644 python/qemu/qmp/qom.py
>   create mode 100644 python/qemu/qmp/qom_common.py
>   create mode 100644 python/qemu/qmp/qom_fuse.py
> 

NACK


