Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EE9AC83001
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 00:54:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F2F82070B
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 00:54:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IF0ReJww"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F2F82070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37614 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTEWM-000060-Bl
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 20:54:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58744)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alexander.duyck@gmail.com>) id 1jTEVL-00073j-LY
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 20:53:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <alexander.duyck@gmail.com>) id 1jTEVL-0006ny-38
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 20:53:43 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:34019)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander.duyck@gmail.com>)
 id 1jTEVK-0006nQ-MW
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 20:53:42 -0400
Received: by mail-pf1-x441.google.com with SMTP id x15so9870347pfa.1
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2020 17:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:from:to:cc:date:message-id:user-agent:mime-version
 :content-transfer-encoding;
 bh=k3UVUs20y+yX+wfr6V8GsoD6lq/u4aCcTxRAbel2tQM=;
 b=IF0ReJwwv5XuhR0A3CQsoWomDyPtZaixxnVGPiN958F8yikKy9FjXihvDGAo0lomng
 buPTII/RibgCN+OTqC2W2r99YnaUcfGGllJ3YDOsDuttFowBDStJbf7b/g3uNSCRxXO7
 H5Vb3U1J++qfOlqvxgRhfAuh++/PE274D9BGI/I6nXR1FPOKo3183L1nWxeJNkX+3mWP
 truDcPEskho3Jy5h/+sCsYHUUPFTQutj4umK5NkWK4DL329bHFLudhfwO3UToHRENhjs
 U5y8GB03nGf64EZhAXNmLGxdy/QmNzVyWJ93pXIbufSxgAak4Vl9Y/gIcuYHP+cMNHDL
 3+EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:date:message-id:user-agent
 :mime-version:content-transfer-encoding;
 bh=k3UVUs20y+yX+wfr6V8GsoD6lq/u4aCcTxRAbel2tQM=;
 b=Nh4HJo9dr3xdPw0IeaTD7RjrU3N/bhNqy0H6E7veC69sCiDDmOC6+ZIbqrd/XH0rFK
 muSsHu9GjJNhFhet0+k7kEOsdzoHxRiBRjV+BtNZLj+1my/4X4bE5r7oghLteHh67unb
 VSBg8JKSvCpb9PFGXEWRbQfVUOJA1CYi2ArMRwKgfXoIDiIN/1EgvmUm9+zJwCDFzwC2
 8F5TA8cZv9AqBlTGBrkI5B40Kpqc4b55lFyUTPmlDqKMfquYme7isQjqpL0mJphXZ56D
 lPRGmv/YTUUI6U5tsSoQTqB/l7o0nq7kx/VIWSmnw+rSTR7oSHJ33ibuaaNonpJ2SNKk
 vXvw==
X-Gm-Message-State: AGi0PuaP3gYT0mv2Qgx7Msuvkr0HFGuwKSADsXXL7hpXpJw3Sf+prXsV
 /jkraUMSkjVXdxgFgdokBEs=
X-Google-Smtp-Source: APiQypLX8kyRYoMZMwymCoGFkcRmpvWsQb3muMjwCLzp27xgKc+QY4idywlDjvFkQhTpBU1g7LH6mg==
X-Received: by 2002:aa7:951b:: with SMTP id b27mr27130881pfp.2.1588035220855; 
 Mon, 27 Apr 2020 17:53:40 -0700 (PDT)
Received: from localhost.localdomain ([2001:470:b:9c3:9e5c:8eff:fe4f:f2d0])
 by smtp.gmail.com with ESMTPSA id x25sm13563976pfm.203.2020.04.27.17.53.40
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 27 Apr 2020 17:53:40 -0700 (PDT)
Subject: [PATCH v23 QEMU 0/5] virtio-balloon: add support for page poison
 reporting and free page reporting
From: Alexander Duyck <alexander.duyck@gmail.com>
To: david@redhat.com, mst@redhat.com
Date: Mon, 27 Apr 2020 17:53:39 -0700
Message-ID: <20200428005134.6158.88521.stgit@localhost.localdomain>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::441;
 envelope-from=alexander.duyck@gmail.com; helo=mail-pf1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::441
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
Cc: virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series provides an asynchronous means of reporting free guest pages
to QEMU through virtio-balloon so that the memory associated with those
pages can be dropped and reused by other processes and/or guests on the
host. Using this it is possible to avoid unnecessary I/O to disk and
greatly improve performance in the case of memory overcommit on the host.

I originally submitted this patch series back on February 11th 2020[1],
but at that time I was focused primarily on the kernel portion of this
patch set. However as of April 7th those patches are now included in
Linus's kernel tree[2] and so I am submitting the QEMU pieces for
inclusion.

[1]: https://lore.kernel.org/lkml/20200211224416.29318.44077.stgit@localhost.localdomain/
[2]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b0c504f154718904ae49349147e3b7e6ae91ffdc

Changes from v17:
Fixed typo in patch 1 title
Addressed white-space issues reported via checkpatch
Added braces {} for two if statements to match expected coding style

Changes from v18:
Updated patches 2 and 3 based on input from dhildenb
Added comment to patch 2 describing what keeps us from reporting a bad page
Added patch to address issue with ROM devices being directly writable

Changes from v19:
Added std-headers change to match changes pushed for linux kernel headers
Added patch to remove "report" from page hinting code paths
Updated comment to better explain why we disable hints w/ page poisoning
Removed code that was modifying config size for poison vs hinting
Dropped x-page-poison property
Added code to bounds check the reported region vs the RAM block
Dropped patch for ROM devices as that was already pulled in by Paolo

Changes from v20:
Rearranged patches to push Linux header sync patches to front
Removed association between free page hinting and VIRTIO_BALLOON_F_PAGE_POISON
Added code to enable VIRTIO_BALLOON_F_PAGE_POISON if page reporting is enabled
Fixed possible resource leak if poison or qemu_balloon_is_inhibited return true

Changes from v21:
Added ack for patch 3
Rewrote patch description for page poison reporting feature
Made page-poison independent property and set to enabled by default
Added logic to migrate poison_val
Added several comments in code to better explain features
Switched free-page-reporting property to disabled by default

Changes from v22:
Added ack for patches 4 & 5
Added additional comment fixes in patch 3 to remove "reporting" reference
Renamed rvq in patch 5 to reporting_vq to improve readability
Moved call adding reporting_vq to after free_page_vq to fix VQ ordering

---

Alexander Duyck (5):
      linux-headers: Update to allow renaming of free_page_report_cmd_id
      linux-headers: update to contain virito-balloon free page reporting
      virtio-balloon: Replace free page hinting references to 'report' with 'hint'
      virtio-balloon: Implement support for page poison reporting feature
      virtio-balloon: Provide an interface for free page reporting


 hw/virtio/virtio-balloon.c                      |  176 ++++++++++++++++++-----
 include/hw/virtio/virtio-balloon.h              |   23 ++-
 include/standard-headers/linux/virtio_balloon.h |   12 +-
 3 files changed, 159 insertions(+), 52 deletions(-)

--

