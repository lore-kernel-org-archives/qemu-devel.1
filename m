Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB509C4727D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 12:53:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87CB12075E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 12:53:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R3ED/lw5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87CB12075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37850 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLnE2-0000aG-Mr
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 08:53:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48078)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kLnCc-0007M1-Iv
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 08:51:54 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:52800)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kLnCa-0001NQ-4o
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 08:51:54 -0400
Received: by mail-wm1-x341.google.com with SMTP id q9so2946658wmj.2
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2020 05:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=6mFQ8VpzrmbMOCqpnYjIMbNUVSnomJ1x/Qk71Rvs1y0=;
 b=R3ED/lw5dhoGoolIIEgu84rM9C6qp0s+cbZtnx5euOuqUgdeLUi4piqSeYuUlWODwK
 SepkYjDF4Mt/opsQu7trlLMeKHcngicTvDCTyYbVnsTvFbwkthlZGcnbw+XQOvdJCgmT
 Hhj5nJP54BLXXbmWcx+e28Z/p/XhTGYsrHu0FtHk5aUrKNjOBkwMzjMDokJKiA5z8OCg
 hTqHA9abg/Fmo/kX2hLo0UlVzWFRBcoLFLZEgfe3F7lW8HzNdDFVi7E0sJ1MBlzN8S3u
 1D+edPN3ITP5kvu7OQPkxlaqn4xnw521ZcBmlS69mj1mlQYFbbpivxKsCFwWZqkoezk9
 Jr+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=6mFQ8VpzrmbMOCqpnYjIMbNUVSnomJ1x/Qk71Rvs1y0=;
 b=dL3otVAZ4xAk9oLXvdP5ePn9GMtH5MkZiHBB0cNKtosCu2ZtB7wkE1KUFebf7NqiLb
 SIWrcDB8IyWu2Pt95WSJhhpvN8iGbE37cB3ozcMY+lsWOiFxIgBVUdx2vyQaiorGK5wM
 wsGK+LxjggBDfIe21ad+tWE2dYYDxgOb7z1czNhHtLJj5uce29cCywlcOfmT6G6hrUuO
 ztHPi78k6O8xwF0OGizhi/+bxV/AuQ6vyE2e/6CL35Dtwq4HpmKUIINge1Nh23CWYzfh
 snbr8Cu6YkDx20yTkVfNr9eEVHxyXy5I8EeWWY5k5YPcy6DvIuiacc6WSpN92S4Z6rBt
 s7FA==
X-Gm-Message-State: AOAM530bBPJY4BiBdjdWm84qP1kAHKE75m4o6AaWVz88gH/gEU2k+mWw
 7PApg9+ZLIuvYRGGq5Wb90rY7g==
X-Google-Smtp-Source: ABdhPJxznKkCiCp0cypkgr+MbBGziK/EtaKmN1u8NJ0i2PUEpJSsg/9BTD2DzIq/t0D5xdLEIqj3Aw==
X-Received: by 2002:a05:600c:414e:: with SMTP id
 h14mr2926737wmm.2.1601038309869; 
 Fri, 25 Sep 2020 05:51:49 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id u17sm3030823wri.45.2020.09.25.05.51.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2020 05:51:48 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 007681FF7E;
 Fri, 25 Sep 2020 13:51:47 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org, maxim.uvarov@linaro.org, joakim.bech@linaro.org,
 ilias.apalodimas@linaro.org, tomas.winkler@intel.com, yang.huang@intel.com,
 bing.zhu@intel.com, Matti.Moell@opensynergy.com, hmo@opensynergy.com
Subject: [RFC PATCH  00/19] vhost-user-rpmb (Replay Protected Memory Block)
Date: Fri, 25 Sep 2020 13:51:28 +0100
Message-Id: <20200925125147.26943-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: jean-philippe@linaro.org, takahiro.akashi@linaro.org,
 virtualization@lists.linuxfoundation.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, arnd@linaro.org,
 stratos-dev@op-lists.linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

This is an initial implementation of a vhost-user backend for the
VirtIO RPMB device. The device is currently in the draft of the next
VirtIO specification and describes block device which uses combination
of a key, nonce, hashing and a persistent write counter to prevent
replay attacks (hence Replay Protected Memory Block).

It is implemented as a vhost-user device because we want to experiment
in making portable backends that can be used with multiple
hypervisors. We also want to support backends isolated in their own
separate service VMs with limited memory cross-sections with the
principle guest. This is part of a wider initiative called project
Stratos for which you can find information here:

  https://collaborate.linaro.org/display/STR/Stratos

I mention this to explain the decision to duplicate some of the
utility functions (specifically iov and hmac handling) and write the
daemon as a fairly pure glib application that just depends on
libvhost-user. As it happens I ended up having to include libqemuutil
as libvhost-user requires qemu_memfd_alloc. Whether this is an
oversight for libvhost-user or it means we should split these daemons
into a separate repository is a discussion I would like to have with
the community. Now I have a working reference implementation I also
want to explore how easy it is to write a Rust version of the backend
which raises similar questions about where such a project should live.

The current Linux kernel doesn't support RPMB devices in the vanilla
tree so if you want to test you will need to look at my testing tree
which is based on Thomas Winkler's original patches although somewhat
cut down and pared back to just support the JDEC style frames of the
upstream spec and the simple chardev based userspace interface. You
can find my kernel testing tree here:

  https://git.linaro.org/people/alex.bennee/linux.git/log/?h=testing/virtio-rpmb   

The above branch includes a simple test script with the rpmb userspace
tool which I've used to exercise the various features. I'm unsure if
there will ever be a push to upstream support for RPMB to the kernel
as access to these sorts of devices are usually the preserve of
firmware living in the secure world. There is currently work underway
to support this device in uboot and I suspect eventually there will be
support for OPTEE as well.

Any review comments gratefully received as well as discussion about if
we should consider creating some new projects for housing these sort
of vhost-user backends. 

Alex Bennée (19):
  tools/virtiofsd: add support for --socket-group
  hw/block: add boilerplate for vhost-user-rpmb device
  hw/virtio: move virtio-pci.h into shared include space
  hw/block: add vhost-user-rpmb-pci boilerplate
  virtio-pci: add notification trace points
  tools/vhost-user-rpmb: add boilerplate and initial main
  tools/vhost-user-rpmb: implement --print-capabilities
  tools/vhost-user-rpmb: connect to fd and instantiate basic run loop
  tools/vhost-user-rpmb: add a --verbose/debug flags for logging
  tools/vhost-user-rpmb: handle shutdown and SIGINT/SIGHUP cleanly
  tools/vhost-user-rpmb: add --flash-path for backing store
  tools/vhost-user-rpmb: import hmac_sha256 functions
  tools/vhost-user-rpmb: implement the PROGRAM_KEY handshake
  tools/vhost-user-rpmb: implement VIRTIO_RPMB_REQ_GET_WRITE_COUNTER
  tools/vhost-user-rpmb: implement VIRTIO_RPMB_REQ_DATA_WRITE
  tools/vhost-user-rpmb: implement VIRTIO_RPMB_REQ_DATA_READ
  tools/vhost-user-rpmb: add key persistence
  tools/vhost-user-rpmb: allow setting of the write_count
  docs: add a man page for vhost-user-rpmb

 docs/tools/index.rst                       |   1 +
 docs/tools/vhost-user-rpmb.rst             | 102 +++
 docs/tools/virtiofsd.rst                   |   4 +
 include/hw/virtio/vhost-user-rpmb.h        |  46 ++
 {hw => include/hw}/virtio/virtio-pci.h     |   0
 tools/vhost-user-rpmb/hmac_sha256.h        |  87 ++
 tools/virtiofsd/fuse_i.h                   |   1 +
 hw/block/vhost-user-rpmb-pci.c             |  82 ++
 hw/block/vhost-user-rpmb.c                 | 333 ++++++++
 hw/virtio/vhost-scsi-pci.c                 |   2 +-
 hw/virtio/vhost-user-blk-pci.c             |   2 +-
 hw/virtio/vhost-user-fs-pci.c              |   2 +-
 hw/virtio/vhost-user-input-pci.c           |   2 +-
 hw/virtio/vhost-user-scsi-pci.c            |   2 +-
 hw/virtio/vhost-user-vsock-pci.c           |   2 +-
 hw/virtio/vhost-vsock-pci.c                |   2 +-
 hw/virtio/virtio-9p-pci.c                  |   2 +-
 hw/virtio/virtio-balloon-pci.c             |   2 +-
 hw/virtio/virtio-blk-pci.c                 |   2 +-
 hw/virtio/virtio-input-host-pci.c          |   2 +-
 hw/virtio/virtio-input-pci.c               |   2 +-
 hw/virtio/virtio-iommu-pci.c               |   2 +-
 hw/virtio/virtio-net-pci.c                 |   2 +-
 hw/virtio/virtio-pci.c                     |   5 +-
 hw/virtio/virtio-rng-pci.c                 |   2 +-
 hw/virtio/virtio-scsi-pci.c                |   2 +-
 hw/virtio/virtio-serial-pci.c              |   2 +-
 tools/vhost-user-rpmb/hmac_sha256.c        | 331 ++++++++
 tools/vhost-user-rpmb/main.c               | 880 +++++++++++++++++++++
 tools/virtiofsd/fuse_lowlevel.c            |   6 +
 tools/virtiofsd/fuse_virtio.c              |  20 +-
 MAINTAINERS                                |   5 +
 hw/block/Kconfig                           |   5 +
 hw/block/meson.build                       |   3 +
 hw/virtio/trace-events                     |   7 +-
 tools/meson.build                          |   8 +
 tools/vhost-user-rpmb/50-qemu-rpmb.json.in |   5 +
 tools/vhost-user-rpmb/meson.build          |  12 +
 38 files changed, 1956 insertions(+), 21 deletions(-)
 create mode 100644 docs/tools/vhost-user-rpmb.rst
 create mode 100644 include/hw/virtio/vhost-user-rpmb.h
 rename {hw => include/hw}/virtio/virtio-pci.h (100%)
 create mode 100644 tools/vhost-user-rpmb/hmac_sha256.h
 create mode 100644 hw/block/vhost-user-rpmb-pci.c
 create mode 100644 hw/block/vhost-user-rpmb.c
 create mode 100644 tools/vhost-user-rpmb/hmac_sha256.c
 create mode 100644 tools/vhost-user-rpmb/main.c
 create mode 100644 tools/vhost-user-rpmb/50-qemu-rpmb.json.in
 create mode 100644 tools/vhost-user-rpmb/meson.build

-- 
2.20.1


