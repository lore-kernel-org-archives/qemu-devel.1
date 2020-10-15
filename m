Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65B35C433E7
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 11:47:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DFFC20BED
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 11:47:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KawJBla1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DFFC20BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kT1jM-0001Zy-IC
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 07:47:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52714)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kT1iU-0000p1-MM
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 07:46:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:51059)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kT1iS-0002f5-PT
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 07:46:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602762399;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V9WX+yv1+WD0V4aye6W7SJEE1GZCq7/F6yqDF9/y7f8=;
 b=KawJBla1hQN4OhuDi8hYzqWTxw+7Zjfekgc8RlEv0JJFdb/4Op0OgSAjJPv+qVVh51cmdH
 5BWZLNsnagdGFFsxGqLmV0swbXQFIUtg6l7tYxQjoFb99u6sbFEyIZiuSs4VFp+gQvjAhR
 6+rAeibjDd1fhc/jJOhlKTFpxqiEUPs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-208-pndmA-NLNi29Niw0gbsa9A-1; Thu, 15 Oct 2020 07:46:29 -0400
X-MC-Unique: pndmA-NLNi29Niw0gbsa9A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8B075803620;
 Thu, 15 Oct 2020 11:46:28 +0000 (UTC)
Received: from redhat.com (ovpn-114-115.ams2.redhat.com [10.36.114.115])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BA35D76669;
 Thu, 15 Oct 2020 11:46:25 +0000 (UTC)
Date: Thu, 15 Oct 2020 12:46:22 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH v6 00/10] migration: bring improved savevm/loadvm/delvm
 to QMP
Message-ID: <20201015114622.GF163620@redhat.com>
References: <20201008155001.3357288-1-berrange@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201008155001.3357288-1-berrange@redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/15 02:10:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Krempa <pkrempa@redhat.com>,
 "Denis V. Lunev" <den@virtuozzo.com>, qemu-block@nongnu.org,
 Juan Quintela <quintela@redhat.com>, John Snow <jsnow@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

ping: for anyone in the block or migration maintainers teams to
review this, since Markus has acked the QAPI design side of it.

On Thu, Oct 08, 2020 at 04:49:51PM +0100, Daniel P. Berrangé wrote:
>  v1: https://lists.gnu.org/archive/html/qemu-devel/2020-07/msg00866.html
>  v2: https://lists.gnu.org/archive/html/qemu-devel/2020-07/msg07523.html
>  v3: https://lists.gnu.org/archive/html/qemu-devel/2020-08/msg07076.html
>  v4: https://lists.gnu.org/archive/html/qemu-devel/2020-09/msg05221.html
>  v5: https://lists.gnu.org/archive/html/qemu-devel/2020-10/msg00587.html
> 
> This series aims to provide a better designed replacement for the
> savevm/loadvm/delvm HMP commands, which despite their flaws continue
> to be actively used in the QMP world via the HMP command passthrough
> facility.
> 
> The main problems addressed are:
> 
>  - The logic to pick which disk to store the vmstate in is not
>    satsifactory.
> 
>    The first block driver state cannot be assumed to be the root disk
>    image, it might be OVMF varstore and we don't want to store vmstate
>    in there.
> 
>  - The logic to decide which disks must be snapshotted is hardwired
>    to all disks which are writable
> 
>    Again with OVMF there might be a writable varstore, but this can be
>    raw rather than qcow2 format, and thus unable to be snapshotted.
>    While users might wish to snapshot their varstore, in some/many/most
>    cases it is entirely uneccessary. Users are blocked from snapshotting
>    their VM though due to this varstore.
> 
>  - The commands are synchronous blocking execution and returning
>    errors immediately.
> 
>    This is partially addressed by integrating with the job framework.
>    This forces the client to use the async commands to determine
>    the completion status or error message from the operations.
> 
> In the block code I've only dealt with node names for block devices, as
> IIUC, this is all that libvirt should need in the -blockdev world it now
> lives in. IOW, I've made not attempt to cope with people wanting to use
> these QMP commands in combination with -drive args, as libvirt will
> never use -drive with a QEMU new enough to have these new commands.
> 
> The main limitations of this current impl
> 
>  - The snapshot process runs serialized in the main thread. ie QEMU
>    guest execution is blocked for the duration. The job framework
>    lets us fix this in future without changing the QMP semantics
>    exposed to the apps.
> 
>  - Most vmstate loading errors just go to stderr, as they are not
>    using Error **errp reporting. Thus the job framework just
>    reports a fairly generic message
> 
>      "Error -22 while loading VM state"
> 
>    Again this can be fixed later without changing the QMP semantics
>    exposed to apps.
> 
> I've done some minimal work in libvirt to start to make use of the new
> commands to validate their functionality, but this isn't finished yet.
> 
> My ultimate goal is to make the GNOME Boxes maintainer happy again by
> having internal snapshots work with OVMF:
> 
>   https://gitlab.gnome.org/GNOME/gnome-boxes/-/commit/c486da262f6566326fbcb5e=
> f45c5f64048f16a6e
> 
> Changed in v6:
> 
>  - Resolve many conflicts with recent replay changes
>  - Misc typos in QAPI
> 
> Changed in v5:
> 
>  - Fix prevention of tag overwriting
>  - Refactor and expand test suite coverage to validate
>    more negative scenarios
> 
> Changed in v4:
> 
>  - Make the device lists mandatory, dropping all support for
>    QEMU's built-in heuristics to select devices.
> 
>  - Improve some error reporting and I/O test coverage
> 
> Changed in v3:
> 
>  - Schedule a bottom half to escape from coroutine context in
>    the jobs. This is needed because the locking in the snapshot
>    code goes horribly wrong when run from a background coroutine
>    instead of the main event thread.
> 
>  - Re-factor way we iterate over devices, so that we correctly
>    report non-existant devices passed by the user over QMP.
> 
>  - Add QAPI docs notes about limitations wrt vmstate error
>    reporting (it all goes to stderr not an Error **errp)
>    so QMP only gets a fairly generic error message currently.
> 
>  - Add I/O test to validate many usage scenarios / errors
> 
>  - Add I/O test helpers to handle QMP events with a deterministic
>    ordering
> 
>  - Ensure 'delete-snapshot' reports an error if requesting
>    delete from devices that don't support snapshot, instead of
>    silently succeeding with no erro.
> 
> Changed in v2:
> 
>  - Use new command names "snapshot-{load,save,delete}" to make it
>    clear that these are different from the "savevm|loadvm|delvm"
>    as they use the Job framework
> 
>  - Use an include list for block devs, not an exclude list
> 
> Daniel P. Berrang=C3=A9 (10):
>   block: push error reporting into bdrv_all_*_snapshot functions
>   migration: stop returning errno from load_snapshot()
>   block: add ability to specify list of blockdevs during snapshot
>   block: allow specifying name of block device for vmstate storage
>   block: rename and alter bdrv_all_find_snapshot semantics
>   migration: control whether snapshots are ovewritten
>   migration: wire up support for snapshot device selection
>   migration: introduce a delete_snapshot wrapper
>   iotests: add support for capturing and matching QMP events
>   migration: introduce snapshot-{save,load,delete} QMP commands
> 
>  block/monitor/block-hmp-cmds.c |   7 +-
>  block/snapshot.c               | 256 +++++++++++++++------
>  include/block/snapshot.h       |  23 +-
>  include/migration/snapshot.h   |  14 +-
>  migration/savevm.c             | 280 ++++++++++++++++++++---
>  monitor/hmp-cmds.c             |  12 +-
>  qapi/job.json                  |   9 +-
>  qapi/migration.json            | 121 ++++++++++
>  replay/replay-debugging.c      |  12 +-
>  replay/replay-snapshot.c       |   5 +-
>  softmmu/vl.c                   |   2 +-
>  tests/qemu-iotests/267.out     |  12 +-
>  tests/qemu-iotests/310         | 385 +++++++++++++++++++++++++++++++
>  tests/qemu-iotests/310.out     | 407 +++++++++++++++++++++++++++++++++
>  tests/qemu-iotests/common.qemu | 107 ++++++++-
>  tests/qemu-iotests/group       |   1 +
>  16 files changed, 1508 insertions(+), 145 deletions(-)
>  create mode 100755 tests/qemu-iotests/310
>  create mode 100644 tests/qemu-iotests/310.out
> 
> --=20
> 2.26.2
> 

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


