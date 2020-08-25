Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 281B3C433E3
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 21:47:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E52942071E
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 21:47:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U4Ek7T34"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E52942071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAgmb-0001XC-7E
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 17:47:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40852)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rjones@redhat.com>) id 1kAgNE-0006ZZ-LE
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 17:20:56 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:32509
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <rjones@redhat.com>) id 1kAgNB-0004Lp-Oa
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 17:20:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598390451;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=XuT42yOkfdA+wMaxyw5KDqINVZj8rLGxPLEtzLmXKdM=;
 b=U4Ek7T34qAd07FjcnOTIO4nT5tHAzXInLnn20GdAmvlsRFYLvnv2QG0LbYibCNzPJfv3kY
 dxYTXJ+ewh/2n9z/yfoKmVuC4gZCwEQXFa/oxiBIqlDqj1xefc+N3eETEKEzME1v8VTZri
 g3Ajy+R6MOItgSzqS4OkFJn3FvRoYEM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-337-fbUw_D34Mq28azx5ixV2gg-1; Tue, 25 Aug 2020 17:20:47 -0400
X-MC-Unique: fbUw_D34Mq28azx5ixV2gg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2CA7881F01D;
 Tue, 25 Aug 2020 21:20:46 +0000 (UTC)
Received: from localhost (ovpn-114-99.ams2.redhat.com [10.36.114.99])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E125074E00;
 Tue, 25 Aug 2020 21:20:40 +0000 (UTC)
Date: Tue, 25 Aug 2020 22:20:39 +0100
From: "Richard W.M. Jones" <rjones@redhat.com>
To: libguestfs@redhat.com, virt-tools-list@redhat.com, nbd@other.debian.org,
 qemu-devel@nongnu.org
Subject: ANNOUNCE: libnbd 1.4 - high performance NBD client library
Message-ID: <20200825212039.GR16477@redhat.com>
MIME-Version: 1.0
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=rjones@redhat.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=rjones@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/25 15:21:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.958,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I'm pleased to announce the release of libnbd 1.4.0,
a high performance Network Block Device (NBD) client library.


Key features of libnbd:

 * Synchronous API for ease of use.

 * Asynchronous API for writing non-blocking, multithreaded clients.
   You can mix both APIs freely.

 * High performance.

 * Minimal dependencies for the basic library.

 * Well-documented, stable API.

 * Bindings in several programming languages.

 * Shell (nbdsh) for command line and scripting.


Git:      https://github.com/libguestfs/libnbd
Download: https://download.libguestfs.org/libnbd/1.4-stable/
Release notes:
          https://libguestfs.org/libnbd-release-notes-1.4.1.html

Fedora:   https://koji.fedoraproject.org/koji/packageinfo?packageID=28807
Debian:   https://packages.debian.org/libnbd


*** Release notes for libnbd 1.4 ***

       These are the release notes for libnbd stable release 1.4.  This
       describes the major changes since 1.2.

       libnbd 1.4.0 was released on 25 August 2020.

   Security
       There were no security issues found in this release.  If you find a
       security issue, please read SECURITY in the source (online here:
       https://github.com/libguestfs/libnbd/blob/master/SECURITY).  To find
       out about previous security issues in libnbd, see libnbd-security(3).

   New APIs
       nbd_set_opt_mode(3)
       nbd_get_opt_mode(3)
       nbd_aio_is_negotiating(3)
           libnbd 1.4 adds a new “negotiating” state during NBD handshaking.
           For backwards compatibility programs must request this before
           starting the connection by calling nbd_set_opt_mode(3).  You can
           find out if the connection is in this state by calling
           nbd_aio_is_negotiating(3).

           For an in-depth description of how this extra state can be used to
           negotiate server options, see "CONTROLLING NEGOTIATION" in
           libnbd(3).

       nbd_aio_opt_abort(3)
       nbd_opt_abort(3)
           During the negotiating state, abort the connection.

       nbd_aio_opt_go(3)
       nbd_opt_go(3)
           During the negotiating state, complete the handshake.

       nbd_aio_opt_info(3)
       nbd_opt_info(3)
           During the negotiating state, request full information about the
           server export.

       nbd_aio_opt_list(3)
       nbd_opt_list(3)
           During the negotiating state, request the list of exports that the
           server provides.

       nbd_get_block_size(3)
           Return the minimum, preferred or maximum block size constraints for
           requests sent to the server.

       nbd_get_canonical_export_name(3)
           Return the canonical export name that the server defaults to.  This
           information may only be available if you call nbd_set_full_info(3)
           before connecting.

       nbd_get_export_description(3)
           Return the optional text description of the current export.  This
           information may only be available if you call nbd_set_full_info(3)
           before connecting.

       nbd_set_full_info(3)
       nbd_get_full_info(3)
           Enable extended information about exports from the server.

       Thanks: Eric Blake for all of the new APIs.

   New features
       Bindings are now available in the Go programming language.

       FreeBSD and OpenBSD are now fully supported platforms.

       Bash tab completion is available for all of the command line tools.

   Documentation
       Verbatim text in man pages that wrapped over several lines is now
       typeset correctly.

       Links within the documentation have been enhanced, and are now checked
       for correctness.

   Tools
       New nbdcopy(1) tool lets you copy between an NBD server and a local
       file, or stream to and from an NBD server.

       New nbdinfo(1) tool lets you print extended information about an NBD
       server’s exports (Eric Blake).

   Tests
       Test sockets are created in /tmp (instead of the local directory).
       This stops the test suite from failing if the local directory path is
       longer than the Unix domain socket maximum path length.

   Other improvements and bug fixes
       Trace messages have been improved: long strings are truncated, strings
       with non-printable characters are escaped, and lists of strings are
       printed.

       The generator was split from a large single script into several small
       files.  To build from git the OCaml bytecode compiler (ocamlc(1)) is
       now required instead of the interpreter (ocaml(1)).

       Long login names are supported in nbd_get_tls_username(3).

       The handle name in nbdsh(1) is now set to "nbdsh" (instead of a
       randomly generated name).

       Compatibility with OCaml 4.10.0 and 4.11.0.

       Python AIO buffer adds a new "is_zero" method allowing Python clients
       to do sparsification when copying.

       Compatibility with Python 3.9.

       External C programs can now be compiled against libnbd’s build
       directory using "../libnbd/run ./configure".

       Honggfuzz can be used as another external fuzzing option.

       Fix compilation with glibc 2.32 which deprecates "sys_errlist".

       Many examples added or extended to demonstrate uses of the new APIs
       (Eric Blake).

SEE ALSO
       libnbd(3).

AUTHORS
       Eric Blake

       Richard W.M. Jones




-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
libguestfs lets you edit virtual machines.  Supports shell scripting,
bindings from many languages.  http://libguestfs.org


