Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FAKE_REPLY_C,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25C32C33CB1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 11:33:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E608B2073A
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 11:33:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UJL/fsFH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E608B2073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55814 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isPsM-0006h6-V2
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 06:33:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35554)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1isPrT-0006HL-18
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 06:32:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1isPrQ-0006pi-Gu
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 06:32:22 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26523
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1isPrQ-0006nz-Cf
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 06:32:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579260737;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to; 
 bh=EJpXHg/moWHDLeMGa4OWIsjSP+FHDBH1yvvztZBmk28=;
 b=UJL/fsFHvkQacQWQ+QLhno5ff0GiSrtVim4KSdq8qYqe26B+5wDQM9k1nTdnUSrYA1w5JG
 ZDV/xn+rlAbUPCnGf+VoMI73tUNON4tIfQ6QMD0cX5XkotZwI+ACZOuLMa2XWHbnfTMi49
 s00kWTMaqbtJRX6dGna6mtCd6Mko/yM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-163-L_2_J1tVP4e-mPkrSelCoA-1; Fri, 17 Jan 2020 06:32:16 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9E397DB21;
 Fri, 17 Jan 2020 11:32:15 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.51])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 709EA60C87;
 Fri, 17 Jan 2020 11:32:06 +0000 (UTC)
Date: Fri, 17 Jan 2020 11:32:03 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com, vgoyal@redhat.com,
 berrange@redhat.com, m.mizuma@jp.fujitsu.com,
 misono.tomohiro@jp.fujitsu.com, philmd@redhat.com, slp@redhat.com
Subject: Re: [PATCH 000/104] virtiofs daemon [all]
Message-ID: <20200117113203.GD3209@work-vm>
MIME-Version: 1.0
In-Reply-To: <20191212163904.159893-1-dgilbert@redhat.com>
User-Agent: Mutt/1.13.0 (2019-11-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: L_2_J1tVP4e-mPkrSelCoA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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


Hi,
  Here's a summary of the review status of this set,

Total: 109 Reviewed: 81 New: 5  changed/rr: 8

The first column is:
  'blank' - no change
  'D' - some diff from the original patch
        - from a simple diff script
  'N' - a new patch

The second column is:
  'R' - has a Reviewed-by
  'c' - Someone reviewed it and asked for changes
  ' ' - no one reviewed it

That leaves ~15 patches from this post that haven't
had reviews (and aren't new).

As soon as most of those are reviewed I'll rebase and repost.

Dave

  R : virtiofsd-Pull-in-upstream-headers
  R : virtiofsd-Pull-in-kernel-s-fuse.h
  R : virtiofsd-Add-auxiliary-.c-s
  R : virtiofsd-Add-fuse_lowlevel.c
D R : virtiofsd-Add-passthrough_ll
D R : virtiofsd-Trim-down-imported-files
D R : virtiofsd-Format-imported-files-to-qemu-style
  R : virtiofsd-remove-mountpoint-dummy-argument
  R : virtiofsd-remove-unused-notify-reply-support
  R : virtiofsd-Fix-fuse_daemonize-ignored-return-value
D c : virtiofsd-Fix-common-header-and-define-for-QEMU-b
  R : virtiofsd-Trim-out-compatibility-code
N   : vitriofsd-passthrough_ll-fix-fallocate-ifdefs
  R : virtiofsd-Make-fsync-work-even-if-only-inode-is-p
D c : virtiofsd-Add-options-for-virtio
  R : virtiofsd-add-o-source-PATH-to-help-output
  R : virtiofsd-Open-vhost-connection-instead-of-mounti
  R : virtiofsd-Start-wiring-up-vhost-user
  R : virtiofsd-Add-main-virtio-loop
  R : virtiofsd-get-set-features-callbacks
  R : virtiofsd-Start-queue-threads
  R : virtiofsd-Poll-kick_fd-for-queue
  R : virtiofsd-Start-reading-commands-from-queue
  R : virtiofsd-Send-replies-to-messages
  R : virtiofsd-Keep-track-of-replies
  R : virtiofsd-Add-Makefile-wiring-for-virtiofsd-contr
    : virtiofsd-Fast-path-for-virtio-read
  R : virtiofsd-add-fd-FDNUM-fd-passing-option
  R : virtiofsd-make-f-foreground-the-default
  R : virtiofsd-add-vhost-user.json-file
  R : virtiofsd-add-print-capabilities-option
  R : virtiofs-Add-maintainers-entry
D c : virtiofsd-passthrough_ll-create-new-files-in-call
    : virtiofsd-passthrough_ll-add-lo_map-for-ino-fh-in
    : virtiofsd-passthrough_ll-add-ino_map-to-hide-lo_i
    : virtiofsd-passthrough_ll-add-dirp_map-to-hide-lo_
D   : virtiofsd-passthrough_ll-add-fd_map-to-hide-file-
D   : virtiofsd-passthrough_ll-add-fallback-for-racy-op
  R : virtiofsd-validate-path-components
    : virtiofsd-Plumb-fuse_bufvec-through-to-do_write_b
    : virtiofsd-Pass-write-iov-s-all-the-way-through
    : virtiofsd-add-fuse_mbuf_iter-API
  R : virtiofsd-validate-input-buffer-sizes-in-do_write
  R : virtiofsd-check-input-buffer-size-in-fuse_lowleve
  R : virtiofsd-prevent-.-escape-in-lo_do_lookup
  R : virtiofsd-prevent-.-escape-in-lo_do_readdir
D R : virtiofsd-use-proc-self-fd-O_PATH-file-descriptor
  R : virtiofsd-sandbox-mount-namespace
  R : virtiofsd-move-to-an-empty-network-namespace
  R : virtiofsd-move-to-a-new-pid-namespace
D c : virtiofsd-add-seccomp-whitelist
  R : virtiofsd-Parse-flag-FUSE_WRITE_KILL_PRIV
  R : virtiofsd-cap-ng-helpers
  R : virtiofsd-Drop-CAP_FSETID-if-client-asked-for-it
  R : virtiofsd-set-maximum-RLIMIT_NOFILE-limit
  R : virtiofsd-fix-libfuse-information-leaks
N   : docs-Add-docs-tools
D R : virtiofsd-add-security-guide-document
  R : virtiofsd-add-syslog-command-line-option
D R : virtiofsd-print-log-only-when-priority-is-high-en
D c : virtiofsd-Add-ID-to-the-log-with-FUSE_LOG_DEBUG-l
D   : virtiofsd-Add-timestamp-to-the-log-with-FUSE_LOG_
  R : virtiofsd-Handle-reinit
  R : virtiofsd-Handle-hard-reboot
D R : virtiofsd-Kill-threads-when-queues-are-stopped
  R : vhost-user-Print-unexpected-slave-message-types
  R : contrib-libvhost-user-Protect-slave-fd-with-mutex
D c : virtiofsd-passthrough_ll-add-renameat2-support
  R : virtiofsd-passthrough_ll-disable-readdirplus-on-c
D   : virtiofsd-passthrough_ll-control-readdirplus
  R : virtiofsd-rename-unref_inode-to-unref_inode_loloc
  R : virtiofsd-fail-when-parent-inode-isn-t-known-in-l
D c : virtiofsd-extract-root-inode-init-into-setup_root
  R : virtiofsd-passthrough_ll-fix-refcounting-on-remov
D R : virtiofsd-passthrough_ll-clean-up-cache-related-o
  R : virtiofsd-passthrough_ll-use-hashtable
  R : virtiofsd-Clean-up-inodes-on-destroy
  R : virtiofsd-support-nanosecond-resolution-for-file-
  R : virtiofsd-fix-error-handling-in-main
  R : virtiofsd-cleanup-allocated-resource-in-se
D c : virtiofsd-fix-memory-leak-on-lo.source
D R : virtiofsd-add-helper-for-lo_data-cleanup
  R : virtiofsd-Prevent-multiply-running-with-same-vhos
  R : virtiofsd-enable-PARALLEL_DIROPS-during-INIT
  R : virtiofsd-fix-incorrect-error-handling-in-lo_do_l
D R : Virtiofsd-fix-memory-leak-on-fuse-queueinfo
D R : virtiofsd-Support-remote-posix-locks
  R : virtiofsd-use-fuse_lowlevel_is_virtio-in-fuse_ses
  R : virtiofsd-prevent-fv_queue_thread-vs-virtio_loop-
  R : virtiofsd-make-lo_release-atomic
    : virtiofsd-prevent-races-with-lo_dirp_put
    : virtiofsd-rename-inode-refcount-to-inode-nlookup
    : libvhost-user-Fix-some-memtable-remap-cases
D R : virtiofsd-add-man-page
D R : virtiofsd-introduce-inode-refcount-to-prevent-use
  R : virtiofsd-do-not-always-set-FUSE_FLOCK_LOCKS
D R : virtiofsd-convert-more-fprintf-and-perror-to-use-
  R : virtiofsd-Reset-O_DIRECT-flag-during-file-open
  R : virtiofsd-Fix-data-corruption-with-O_APPEND-wirte
D R : virtiofsd-add-definition-of-fuse_buf_writev
D R : virtiofsd-use-fuse_buf_writev-to-replace-fuse_buf
D   : virtiofsd-process-requests-in-a-thread-pool
  R : virtiofsd-prevent-FUSE_INIT-FUSE_DESTROY-races
    : virtiofsd-fix-lo_destroy-resource-leaks
  R : virtiofsd-add-thread-pool-size-NUM-option
    : virtiofsd-Convert-lo_destroy-to-take-the-lo-mutex
N R : virtiofsd-passthrough_ll-Pass-errno-to-fuse_reply
N R : virtiofsd-stop-all-queue-threads-on-exit-in-virti
N   : virtiofsd-add-some-options-to-the-help-message
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


