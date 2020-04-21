Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26E62C2BA19
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 05:07:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D12B7206D6
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 05:07:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=qnap.com header.i=@qnap.com header.b="JSbXiSZ3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D12B7206D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=qnap.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQl8H-0007sb-Vd
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 01:07:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41362)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dereksu@qnap.com>) id 1jQl7S-000771-Lx
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 01:06:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <dereksu@qnap.com>) id 1jQl7R-0000yy-5S
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 01:06:50 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:33909)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dereksu@qnap.com>) id 1jQl7Q-0000yA-Kb
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 01:06:48 -0400
Received: by mail-pj1-x1043.google.com with SMTP id my1so784994pjb.1
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2020 22:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qnap.com; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language;
 bh=Q/PyavAXXeHM7QKDyTjIJSple0+Kg45NVgt9n3Q98GQ=;
 b=JSbXiSZ3bh+tuhtvDIlsu8p5HKAuRhGyzCXXZdchhy7Q5Pak5mufn0viwA/mzPLQxV
 U/stVUPkMUmRycS/wraNxAe0yFbwqRIdnTxJYyBN8lASkxoZJeOnQY+MQV8igtNmoH9d
 9j2E4eZn4BwerPVoKKisz11hS5PCjBB6wTP1E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language;
 bh=Q/PyavAXXeHM7QKDyTjIJSple0+Kg45NVgt9n3Q98GQ=;
 b=ijJkGwnFoTfIF6UJSnwEiaI3iXfJLHqv1yn2cdjjqSP6WdRATFpP7mKRRww/zlggvw
 oi3LqESwZDzDl1wJjUZRI7HW1IZemucjoKpoMeJ9XpmRE7tU+9QXnAsTcWnjr+X1xJha
 qNaeZR0TKqjyus2w+ZzqTMuD3d82lqdA7+VD3SlOTu+eI/844HFCMUgZRN/RXgnp2ATS
 0sK3qss5zEomhEx9uS6n+HL70/yEiHLvBwpIeasbp1EuBz3vCVTI8YLosZJREKiPELPf
 9bNRw0idoqv3/4tRUR61+N4ML1DUvmppmufPoXkIUI+HhcNSnZzs+RyQxsoqwyaqSrQS
 lvHQ==
X-Gm-Message-State: AGi0PubHSFCyISxND6wBbsI/R/wDvaRPiMqOMS080kvlcIs86dmfICv8
 B9JnqG+Eo+QoTy3HJFGPsd+YF6Vy0/ktEQ==
X-Google-Smtp-Source: APiQypJFs1DAzVQNdThcciK9pCO1POxetrqxvmOaFES7YsMGWrdQJPzomYa4zyRDwaP5crZPNjs+dg==
X-Received: by 2002:a17:90a:9b82:: with SMTP id
 g2mr3557984pjp.72.1587445605513; 
 Mon, 20 Apr 2020 22:06:45 -0700 (PDT)
Received: from Jing-Weide-MacBook-Pro-3.local
 (202-39-79-13.HINET-IP.hinet.net. [202.39.79.13])
 by smtp.gmail.com with ESMTPSA id z23sm1196411pfr.136.2020.04.20.22.06.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Apr 2020 22:06:44 -0700 (PDT)
Subject: Re: [PATCH v4 00/30] Add subcluster allocation to qcow2
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
References: <cover.1584468723.git.berto@igalia.com>
From: Derek Su <dereksu@qnap.com>
Message-ID: <d27d16e3-f6c7-a960-5531-d3ed71b5b92a@qnap.com>
Date: Tue, 21 Apr 2020 13:06:42 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <cover.1584468723.git.berto@igalia.com>
Content-Type: multipart/alternative;
 boundary="------------A5CF68F3F777D14038F772A9"
Content-Language: en-US
Received-SPF: pass client-ip=2607:f8b0:4864:20::1043;
 envelope-from=dereksu@qnap.com; helo=mail-pj1-x1043.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::1043
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a multi-part message in MIME format.
--------------A5CF68F3F777D14038F772A9
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello,

This work is promising and interesting.
I'd like to try this new feature.
Could you please export a branch because the patches cannot be applied to current master?
Thanks.

Regards,
Derek


On 2020/3/18 上午2:15, Alberto Garcia wrote:
> Hi,
>
> here's the new version of the patches to add subcluster allocation
> support to qcow2.
>
> Please refer to the cover letter of the first version for a full
> description of the patches:
>
>     https://lists.gnu.org/archive/html/qemu-block/2019-10/msg00983.html
>
> I think that this version fixes all the problems pointed out by Max
> and Eric during the review a couple of weeks ago. I also dropped the
> RFC tag.
>
> Berto
>
> v4:
> - Patch 01: New patch
> - Patch 02: New patch
> - Patch 05: Documentation updates [Eric]
> - Patch 06: Fix rebase conflicts
> - Patch 07: Change bit order in the subcluster allocation bitmap.
>              Change incompatible bit number. [Max, Eric]
> - Patch 09: Rename QCOW_MAX_SUBCLUSTERS_PER_CLUSTER to
>              QCOW_EXTL2_SUBCLUSTERS_PER_CLUSTER [Eric]
> - Patch 13: Change bit order in the subcluster allocation bitmap [Max, Eric]
>              Add more documentation.
>              Ignore the subcluster bitmap in the L2 entries of
>              compressed clusters.
> - Patch 14: New patch
> - Patch 15: Update to work with the changes from patches 02 and 14.
> - Patch 16: Update to work with the changes from patches 02 and 14.
> - Patch 18: Update to work with the changes from patches 02 and 14.
>              Update documentation.
>              Fix return value on early exit.
> - Patch 20: Make sure to clear the subcluster allocation bitmap when a
>              cluster is unallocated.
> - Patch 26: Update to work with the changes from patch 14.
> - Patch 27: New patch [Max]
> - Patch 28: Update version number, incompatible bit number and test
>              expectations.
> - Patch 30: Add new tests.
>              Make the test verify its own results. [Max]
>
> v3: https://lists.gnu.org/archive/html/qemu-block/2019-12/msg00587.html
> - Patch 01: Rename host_offset to host_cluster_offset and make 'bytes'
>              an unsigned int [Max]
> - Patch 03: Rename cluster_needs_cow to cluster_needs_new_alloc and
>              count_cow_clusters to count_single_write_clusters. Update
>              documentation and add more assertions and checks [Max]
> - Patch 09: Update qcow2_co_truncate() to properly support extended L2
>              entries [Max]
> - Patch 10: Forbid calling set_l2_bitmap() if the image does not have
>              extended L2 entries [Max]
> - Patch 11 (new): Add QCow2SubclusterType [Max]
> - Patch 12 (new): Replace QCOW2_CLUSTER_* with QCOW2_SUBCLUSTER_*
> - Patch 13 (new): Handle QCOW2_SUBCLUSTER_UNALLOCATED_ALLOC
> - Patch 14: Use QCow2SubclusterType instead of QCow2ClusterType [Max]
> - Patch 15: Use QCow2SubclusterType instead of QCow2ClusterType [Max]
> - Patch 19: Don't call set_l2_bitmap() if the image does not have
>              extended L2 entries [Max]
> - Patch 21: Use smaller data types.
> - Patch 22: Don't call set_l2_bitmap() if the image does not have
>              extended L2 entries [Max]
> - Patch 23: Use smaller data types.
> - Patch 25: Update test results and documentation. Move the check for
>              the minimum subcluster size to validate_cluster_size().
> - Patch 26 (new): Add subcluster support to qcow2_measure()
> - Patch 27: Add more tests
>
> v2: https://lists.gnu.org/archive/html/qemu-block/2019-10/msg01642.html
> - Patch 12: Update after the changes in 88f468e546.
> - Patch 21 (new): Clear the L2 bitmap when allocating a compressed
>    cluster. Compressed clusters should have the bitmap all set to 0.
> - Patch 24: Document the new fields in the QAPI documentation [Eric].
> - Patch 25: Allow qcow2 preallocation with backing files.
> - Patch 26: Add some tests for qcow2 images with extended L2 entries.
>
> v1: https://lists.gnu.org/archive/html/qemu-block/2019-10/msg00983.html
>
> Output of git backport-diff against v3:
>
> Key:
> [----] : patches are identical
> [####] : number of functional differences between upstream/downstream patch
> [down] : patch is downstream-only
> The flags [FC] indicate (F)unctional and (C)ontextual differences, respectively
>
> 001/30:[down] 'qcow2: Make Qcow2AioTask store the full host offset'
> 002/30:[down] 'qcow2: Convert qcow2_get_cluster_offset() into qcow2_get_host_offset()'
> 003/30:[----] [-C] 'qcow2: Add calculate_l2_meta()'
> 004/30:[----] [--] 'qcow2: Split cluster_needs_cow() out of count_cow_clusters()'
> 005/30:[0020] [FC] 'qcow2: Process QCOW2_CLUSTER_ZERO_ALLOC clusters in handle_copied()'
> 006/30:[0010] [FC] 'qcow2: Add get_l2_entry() and set_l2_entry()'
> 007/30:[0020] [FC] 'qcow2: Document the Extended L2 Entries feature'
> 008/30:[----] [--] 'qcow2: Add dummy has_subclusters() function'
> 009/30:[0004] [FC] 'qcow2: Add subcluster-related fields to BDRVQcow2State'
> 010/30:[----] [--] 'qcow2: Add offset_to_sc_index()'
> 011/30:[----] [-C] 'qcow2: Add l2_entry_size()'
> 012/30:[----] [--] 'qcow2: Update get/set_l2_entry() and add get/set_l2_bitmap()'
> 013/30:[0046] [FC] 'qcow2: Add QCow2SubclusterType and qcow2_get_subcluster_type()'
> 014/30:[down] 'qcow2: Add cluster type parameter to qcow2_get_host_offset()'
> 015/30:[0082] [FC] 'qcow2: Replace QCOW2_CLUSTER_* with QCOW2_SUBCLUSTER_*'
> 016/30:[0002] [FC] 'qcow2: Handle QCOW2_SUBCLUSTER_UNALLOCATED_ALLOC'
> 017/30:[----] [-C] 'qcow2: Add subcluster support to calculate_l2_meta()'
> 018/30:[down] 'qcow2: Add subcluster support to qcow2_get_host_offset()'
> 019/30:[----] [--] 'qcow2: Add subcluster support to zero_in_l2_slice()'
> 020/30:[0012] [FC] 'qcow2: Add subcluster support to discard_in_l2_slice()'
> 021/30:[----] [--] 'qcow2: Add subcluster support to check_refcounts_l2()'
> 022/30:[----] [--] 'qcow2: Fix offset calculation in handle_dependencies()'
> 023/30:[----] [-C] 'qcow2: Update L2 bitmap in qcow2_alloc_cluster_link_l2()'
> 024/30:[----] [--] 'qcow2: Clear the L2 bitmap when allocating a compressed cluster'
> 025/30:[----] [--] 'qcow2: Add subcluster support to handle_alloc_space()'
> 026/30:[0006] [FC] 'qcow2: Restrict qcow2_co_pwrite_zeroes() to full clusters only'
> 027/30:[down] 'qcow2: Assert that expand_zero_clusters_in_l1() does not support subclusters'
> 028/30:[0019] [FC] 'qcow2: Add the 'extended_l2' option and the QCOW2_INCOMPAT_EXTL2 bit'
> 029/30:[----] [--] 'qcow2: Add subcluster support to qcow2_measure()'
> 030/30:[0313] [FC] 'iotests: Add tests for qcow2 images with extended L2 entries'
>
> Alberto Garcia (30):
>    qcow2: Make Qcow2AioTask store the full host offset
>    qcow2: Convert qcow2_get_cluster_offset() into qcow2_get_host_offset()
>    qcow2: Add calculate_l2_meta()
>    qcow2: Split cluster_needs_cow() out of count_cow_clusters()
>    qcow2: Process QCOW2_CLUSTER_ZERO_ALLOC clusters in handle_copied()
>    qcow2: Add get_l2_entry() and set_l2_entry()
>    qcow2: Document the Extended L2 Entries feature
>    qcow2: Add dummy has_subclusters() function
>    qcow2: Add subcluster-related fields to BDRVQcow2State
>    qcow2: Add offset_to_sc_index()
>    qcow2: Add l2_entry_size()
>    qcow2: Update get/set_l2_entry() and add get/set_l2_bitmap()
>    qcow2: Add QCow2SubclusterType and qcow2_get_subcluster_type()
>    qcow2: Add cluster type parameter to qcow2_get_host_offset()
>    qcow2: Replace QCOW2_CLUSTER_* with QCOW2_SUBCLUSTER_*
>    qcow2: Handle QCOW2_SUBCLUSTER_UNALLOCATED_ALLOC
>    qcow2: Add subcluster support to calculate_l2_meta()
>    qcow2: Add subcluster support to qcow2_get_host_offset()
>    qcow2: Add subcluster support to zero_in_l2_slice()
>    qcow2: Add subcluster support to discard_in_l2_slice()
>    qcow2: Add subcluster support to check_refcounts_l2()
>    qcow2: Fix offset calculation in handle_dependencies()
>    qcow2: Update L2 bitmap in qcow2_alloc_cluster_link_l2()
>    qcow2: Clear the L2 bitmap when allocating a compressed cluster
>    qcow2: Add subcluster support to handle_alloc_space()
>    qcow2: Restrict qcow2_co_pwrite_zeroes() to full clusters only
>    qcow2: Assert that expand_zero_clusters_in_l1() does not support
>      subclusters
>    qcow2: Add the 'extended_l2' option and the QCOW2_INCOMPAT_EXTL2 bit
>    qcow2: Add subcluster support to qcow2_measure()
>    iotests: Add tests for qcow2 images with extended L2 entries
>
>   docs/interop/qcow2.txt           |  68 ++-
>   docs/qcow2-cache.txt             |  19 +-
>   qapi/block-core.json             |   7 +
>   block/qcow2.h                    | 178 +++++++-
>   include/block/block_int.h        |   1 +
>   block/qcow2-cluster.c            | 696 ++++++++++++++++++++-----------
>   block/qcow2-refcount.c           |  38 +-
>   block/qcow2.c                    | 257 +++++++-----
>   tests/qemu-iotests/031.out       |   8 +-
>   tests/qemu-iotests/036.out       |   4 +-
>   tests/qemu-iotests/049.out       | 102 ++---
>   tests/qemu-iotests/060.out       |   1 +
>   tests/qemu-iotests/061           |   6 +
>   tests/qemu-iotests/061.out       |  25 +-
>   tests/qemu-iotests/065           |  18 +-
>   tests/qemu-iotests/082.out       |  48 ++-
>   tests/qemu-iotests/085.out       |  38 +-
>   tests/qemu-iotests/144.out       |   4 +-
>   tests/qemu-iotests/182.out       |   2 +-
>   tests/qemu-iotests/185.out       |   8 +-
>   tests/qemu-iotests/198.out       |   2 +
>   tests/qemu-iotests/206.out       |   4 +
>   tests/qemu-iotests/242.out       |   5 +
>   tests/qemu-iotests/255.out       |   8 +-
>   tests/qemu-iotests/271           | 359 ++++++++++++++++
>   tests/qemu-iotests/271.out       | 244 +++++++++++
>   tests/qemu-iotests/280.out       |   2 +-
>   tests/qemu-iotests/common.filter |   1 +
>   tests/qemu-iotests/group         |   1 +
>   29 files changed, 1682 insertions(+), 472 deletions(-)
>   create mode 100755 tests/qemu-iotests/271
>   create mode 100644 tests/qemu-iotests/271.out
>


--------------A5CF68F3F777D14038F772A9
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <div class="moz-cite-prefix">
      <pre class="content" style="box-sizing: border-box; overflow: auto; font-family: Menlo, Monaco, Consolas, &quot;Courier New&quot;, monospace; font-size: 13px; display: block; padding: 9.5px; margin: 0px 0px 10px; line-height: 14.3px; color: rgb(51, 51, 51); word-break: break-all; overflow-wrap: break-word; background-color: white; border: 0px; border-radius: 0px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration-style: initial; text-decoration-color: initial;">Hello,

This work is promising and interesting.
I'd like to try this new feature.
Could you please export a branch because the patches cannot be applied to current master?
Thanks.

Regards,
Derek

</pre>
      <br class="Apple-interchange-newline">
    </div>
    <div class="moz-cite-prefix">On 2020/3/18 上午2:15, Alberto Garcia
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:cover.1584468723.git.berto@igalia.com">
      <pre class="moz-quote-pre" wrap="">Hi,

here's the new version of the patches to add subcluster allocation
support to qcow2.

Please refer to the cover letter of the first version for a full
description of the patches:

   <a class="moz-txt-link-freetext" href="https://lists.gnu.org/archive/html/qemu-block/2019-10/msg00983.html">https://lists.gnu.org/archive/html/qemu-block/2019-10/msg00983.html</a>

I think that this version fixes all the problems pointed out by Max
and Eric during the review a couple of weeks ago. I also dropped the
RFC tag.

Berto

v4:
- Patch 01: New patch
- Patch 02: New patch
- Patch 05: Documentation updates [Eric]
- Patch 06: Fix rebase conflicts
- Patch 07: Change bit order in the subcluster allocation bitmap.
            Change incompatible bit number. [Max, Eric]
- Patch 09: Rename QCOW_MAX_SUBCLUSTERS_PER_CLUSTER to
            QCOW_EXTL2_SUBCLUSTERS_PER_CLUSTER [Eric]
- Patch 13: Change bit order in the subcluster allocation bitmap [Max, Eric]
            Add more documentation.
            Ignore the subcluster bitmap in the L2 entries of
            compressed clusters.
- Patch 14: New patch
- Patch 15: Update to work with the changes from patches 02 and 14.
- Patch 16: Update to work with the changes from patches 02 and 14.
- Patch 18: Update to work with the changes from patches 02 and 14.
            Update documentation.
            Fix return value on early exit.
- Patch 20: Make sure to clear the subcluster allocation bitmap when a
            cluster is unallocated.
- Patch 26: Update to work with the changes from patch 14.
- Patch 27: New patch [Max]
- Patch 28: Update version number, incompatible bit number and test
            expectations.
- Patch 30: Add new tests.
            Make the test verify its own results. [Max]

v3: <a class="moz-txt-link-freetext" href="https://lists.gnu.org/archive/html/qemu-block/2019-12/msg00587.html">https://lists.gnu.org/archive/html/qemu-block/2019-12/msg00587.html</a>
- Patch 01: Rename host_offset to host_cluster_offset and make 'bytes'
            an unsigned int [Max]
- Patch 03: Rename cluster_needs_cow to cluster_needs_new_alloc and
            count_cow_clusters to count_single_write_clusters. Update
            documentation and add more assertions and checks [Max]
- Patch 09: Update qcow2_co_truncate() to properly support extended L2
            entries [Max]
- Patch 10: Forbid calling set_l2_bitmap() if the image does not have
            extended L2 entries [Max]
- Patch 11 (new): Add QCow2SubclusterType [Max]
- Patch 12 (new): Replace QCOW2_CLUSTER_* with QCOW2_SUBCLUSTER_*
- Patch 13 (new): Handle QCOW2_SUBCLUSTER_UNALLOCATED_ALLOC
- Patch 14: Use QCow2SubclusterType instead of QCow2ClusterType [Max]
- Patch 15: Use QCow2SubclusterType instead of QCow2ClusterType [Max]
- Patch 19: Don't call set_l2_bitmap() if the image does not have
            extended L2 entries [Max]
- Patch 21: Use smaller data types.
- Patch 22: Don't call set_l2_bitmap() if the image does not have
            extended L2 entries [Max]
- Patch 23: Use smaller data types.
- Patch 25: Update test results and documentation. Move the check for
            the minimum subcluster size to validate_cluster_size().
- Patch 26 (new): Add subcluster support to qcow2_measure()
- Patch 27: Add more tests

v2: <a class="moz-txt-link-freetext" href="https://lists.gnu.org/archive/html/qemu-block/2019-10/msg01642.html">https://lists.gnu.org/archive/html/qemu-block/2019-10/msg01642.html</a>
- Patch 12: Update after the changes in 88f468e546.
- Patch 21 (new): Clear the L2 bitmap when allocating a compressed
  cluster. Compressed clusters should have the bitmap all set to 0.
- Patch 24: Document the new fields in the QAPI documentation [Eric].
- Patch 25: Allow qcow2 preallocation with backing files.
- Patch 26: Add some tests for qcow2 images with extended L2 entries.

v1: <a class="moz-txt-link-freetext" href="https://lists.gnu.org/archive/html/qemu-block/2019-10/msg00983.html">https://lists.gnu.org/archive/html/qemu-block/2019-10/msg00983.html</a>

Output of git backport-diff against v3:

Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream patch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respectively

001/30:[down] 'qcow2: Make Qcow2AioTask store the full host offset'
002/30:[down] 'qcow2: Convert qcow2_get_cluster_offset() into qcow2_get_host_offset()'
003/30:[----] [-C] 'qcow2: Add calculate_l2_meta()'
004/30:[----] [--] 'qcow2: Split cluster_needs_cow() out of count_cow_clusters()'
005/30:[0020] [FC] 'qcow2: Process QCOW2_CLUSTER_ZERO_ALLOC clusters in handle_copied()'
006/30:[0010] [FC] 'qcow2: Add get_l2_entry() and set_l2_entry()'
007/30:[0020] [FC] 'qcow2: Document the Extended L2 Entries feature'
008/30:[----] [--] 'qcow2: Add dummy has_subclusters() function'
009/30:[0004] [FC] 'qcow2: Add subcluster-related fields to BDRVQcow2State'
010/30:[----] [--] 'qcow2: Add offset_to_sc_index()'
011/30:[----] [-C] 'qcow2: Add l2_entry_size()'
012/30:[----] [--] 'qcow2: Update get/set_l2_entry() and add get/set_l2_bitmap()'
013/30:[0046] [FC] 'qcow2: Add QCow2SubclusterType and qcow2_get_subcluster_type()'
014/30:[down] 'qcow2: Add cluster type parameter to qcow2_get_host_offset()'
015/30:[0082] [FC] 'qcow2: Replace QCOW2_CLUSTER_* with QCOW2_SUBCLUSTER_*'
016/30:[0002] [FC] 'qcow2: Handle QCOW2_SUBCLUSTER_UNALLOCATED_ALLOC'
017/30:[----] [-C] 'qcow2: Add subcluster support to calculate_l2_meta()'
018/30:[down] 'qcow2: Add subcluster support to qcow2_get_host_offset()'
019/30:[----] [--] 'qcow2: Add subcluster support to zero_in_l2_slice()'
020/30:[0012] [FC] 'qcow2: Add subcluster support to discard_in_l2_slice()'
021/30:[----] [--] 'qcow2: Add subcluster support to check_refcounts_l2()'
022/30:[----] [--] 'qcow2: Fix offset calculation in handle_dependencies()'
023/30:[----] [-C] 'qcow2: Update L2 bitmap in qcow2_alloc_cluster_link_l2()'
024/30:[----] [--] 'qcow2: Clear the L2 bitmap when allocating a compressed cluster'
025/30:[----] [--] 'qcow2: Add subcluster support to handle_alloc_space()'
026/30:[0006] [FC] 'qcow2: Restrict qcow2_co_pwrite_zeroes() to full clusters only'
027/30:[down] 'qcow2: Assert that expand_zero_clusters_in_l1() does not support subclusters'
028/30:[0019] [FC] 'qcow2: Add the 'extended_l2' option and the QCOW2_INCOMPAT_EXTL2 bit'
029/30:[----] [--] 'qcow2: Add subcluster support to qcow2_measure()'
030/30:[0313] [FC] 'iotests: Add tests for qcow2 images with extended L2 entries'

Alberto Garcia (30):
  qcow2: Make Qcow2AioTask store the full host offset
  qcow2: Convert qcow2_get_cluster_offset() into qcow2_get_host_offset()
  qcow2: Add calculate_l2_meta()
  qcow2: Split cluster_needs_cow() out of count_cow_clusters()
  qcow2: Process QCOW2_CLUSTER_ZERO_ALLOC clusters in handle_copied()
  qcow2: Add get_l2_entry() and set_l2_entry()
  qcow2: Document the Extended L2 Entries feature
  qcow2: Add dummy has_subclusters() function
  qcow2: Add subcluster-related fields to BDRVQcow2State
  qcow2: Add offset_to_sc_index()
  qcow2: Add l2_entry_size()
  qcow2: Update get/set_l2_entry() and add get/set_l2_bitmap()
  qcow2: Add QCow2SubclusterType and qcow2_get_subcluster_type()
  qcow2: Add cluster type parameter to qcow2_get_host_offset()
  qcow2: Replace QCOW2_CLUSTER_* with QCOW2_SUBCLUSTER_*
  qcow2: Handle QCOW2_SUBCLUSTER_UNALLOCATED_ALLOC
  qcow2: Add subcluster support to calculate_l2_meta()
  qcow2: Add subcluster support to qcow2_get_host_offset()
  qcow2: Add subcluster support to zero_in_l2_slice()
  qcow2: Add subcluster support to discard_in_l2_slice()
  qcow2: Add subcluster support to check_refcounts_l2()
  qcow2: Fix offset calculation in handle_dependencies()
  qcow2: Update L2 bitmap in qcow2_alloc_cluster_link_l2()
  qcow2: Clear the L2 bitmap when allocating a compressed cluster
  qcow2: Add subcluster support to handle_alloc_space()
  qcow2: Restrict qcow2_co_pwrite_zeroes() to full clusters only
  qcow2: Assert that expand_zero_clusters_in_l1() does not support
    subclusters
  qcow2: Add the 'extended_l2' option and the QCOW2_INCOMPAT_EXTL2 bit
  qcow2: Add subcluster support to qcow2_measure()
  iotests: Add tests for qcow2 images with extended L2 entries

 docs/interop/qcow2.txt           |  68 ++-
 docs/qcow2-cache.txt             |  19 +-
 qapi/block-core.json             |   7 +
 block/qcow2.h                    | 178 +++++++-
 include/block/block_int.h        |   1 +
 block/qcow2-cluster.c            | 696 ++++++++++++++++++++-----------
 block/qcow2-refcount.c           |  38 +-
 block/qcow2.c                    | 257 +++++++-----
 tests/qemu-iotests/031.out       |   8 +-
 tests/qemu-iotests/036.out       |   4 +-
 tests/qemu-iotests/049.out       | 102 ++---
 tests/qemu-iotests/060.out       |   1 +
 tests/qemu-iotests/061           |   6 +
 tests/qemu-iotests/061.out       |  25 +-
 tests/qemu-iotests/065           |  18 +-
 tests/qemu-iotests/082.out       |  48 ++-
 tests/qemu-iotests/085.out       |  38 +-
 tests/qemu-iotests/144.out       |   4 +-
 tests/qemu-iotests/182.out       |   2 +-
 tests/qemu-iotests/185.out       |   8 +-
 tests/qemu-iotests/198.out       |   2 +
 tests/qemu-iotests/206.out       |   4 +
 tests/qemu-iotests/242.out       |   5 +
 tests/qemu-iotests/255.out       |   8 +-
 tests/qemu-iotests/271           | 359 ++++++++++++++++
 tests/qemu-iotests/271.out       | 244 +++++++++++
 tests/qemu-iotests/280.out       |   2 +-
 tests/qemu-iotests/common.filter |   1 +
 tests/qemu-iotests/group         |   1 +
 29 files changed, 1682 insertions(+), 472 deletions(-)
 create mode 100755 tests/qemu-iotests/271
 create mode 100644 tests/qemu-iotests/271.out

</pre>
    </blockquote>
    <p><br>
    </p>
  </body>
</html>

--------------A5CF68F3F777D14038F772A9--

