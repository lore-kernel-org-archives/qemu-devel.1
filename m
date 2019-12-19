Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8712BC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 15:44:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51D2A2146E
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 15:44:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="LKShuh3f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51D2A2146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43744 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihxy9-0003GN-TB
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 10:44:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57538)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <anthony.perard@citrix.com>) id 1ihxwW-0001sK-Hh
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 10:42:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <anthony.perard@citrix.com>) id 1ihxwU-0005A5-3M
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 10:42:23 -0500
Received: from esa4.hc3370-68.iphmx.com ([216.71.155.144]:20753)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <anthony.perard@citrix.com>)
 id 1ihxwT-00054r-Es
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 10:42:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=citrix.com; s=securemail; t=1576770141;
 h=date:from:to:cc:subject:message-id:mime-version;
 bh=3GXTE9X22nST6sgApHMiGLF3yvqR1/NQKmZYwDz61Fc=;
 b=LKShuh3fQ+LfIU6NOdTNw1y4p70qRvFljWok7eGrw3aX2uctKbL+cfri
 m+7tFgBX1eK8DuGnOIWTurBE6Av5SwuaIhfNihRptYk58Mo123nBCc/C1
 6DYMuTGYHLQIH6sSfvD0f5khWBneZTCRNUBsi6t4dF9d5rsCsEPwAUZbT k=;
Authentication-Results: esa4.hc3370-68.iphmx.com;
 dkim=none (message not signed) header.i=none;
 spf=None smtp.pra=anthony.perard@citrix.com;
 spf=Pass smtp.mailfrom=anthony.perard@citrix.com;
 spf=None smtp.helo=postmaster@mail.citrix.com
Received-SPF: None (esa4.hc3370-68.iphmx.com: no sender
 authenticity information available from domain of
 anthony.perard@citrix.com) identity=pra;
 client-ip=162.221.158.21; receiver=esa4.hc3370-68.iphmx.com;
 envelope-from="anthony.perard@citrix.com";
 x-sender="anthony.perard@citrix.com";
 x-conformance=sidf_compatible
Received-SPF: Pass (esa4.hc3370-68.iphmx.com: domain of
 anthony.perard@citrix.com designates 162.221.158.21 as
 permitted sender) identity=mailfrom;
 client-ip=162.221.158.21; receiver=esa4.hc3370-68.iphmx.com;
 envelope-from="anthony.perard@citrix.com";
 x-sender="anthony.perard@citrix.com";
 x-conformance=sidf_compatible; x-record-type="v=spf1";
 x-record-text="v=spf1 ip4:209.167.231.154 ip4:178.63.86.133
 ip4:195.66.111.40/30 ip4:85.115.9.32/28 ip4:199.102.83.4
 ip4:192.28.146.160 ip4:192.28.146.107 ip4:216.52.6.88
 ip4:216.52.6.188 ip4:162.221.158.21 ip4:162.221.156.83
 ip4:168.245.78.127 ~all"
Received-SPF: None (esa4.hc3370-68.iphmx.com: no sender
 authenticity information available from domain of
 postmaster@mail.citrix.com) identity=helo;
 client-ip=162.221.158.21; receiver=esa4.hc3370-68.iphmx.com;
 envelope-from="anthony.perard@citrix.com";
 x-sender="postmaster@mail.citrix.com";
 x-conformance=sidf_compatible
IronPort-SDR: g9HeQq2hxlTUZpDC3ca1g3e4NGLqvGoXmQ+kP6NTRVyISp3xmd2TA7/e+/E/ZevcoXzr64GI9y
 L2T0qgynYgGF1ZzL1xOUTZLQPyU5H9USRDmbPdkJmruriDIB0zyS6dodS2feK/2/pTc1+VnYEQ
 p/2ietqjrBdCwgMml/qfgJhj1WRP/cNOGZFqIjesF0PinqsgLHHSCqFbvx33vKv2WccYJp6n6p
 tTQqm7t8Nnqgb/5ZDdPtxJ0Ae2+HdsqgSdraQHO0b7hIVdzrKHaDp0eTZxtSXmt+YNA/M3A70q
 980=
X-SBRS: 2.7
X-MesageID: 10528467
X-Ironport-Server: esa4.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.69,332,1571716800"; d="scan'208";a="10528467"
Date: Thu, 19 Dec 2019 15:42:14 +0000
From: Anthony PERARD <anthony.perard@citrix.com>
To: <qemu-devel@nongnu.org>, Beata Michalska <beata.michalska@linaro.org>
Subject: Recent change pmem related breaks Xen migration
Message-ID: <20191219154214.GE1267@perard.uk.xensource.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 216.71.155.144
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

Commit bd108a44bc29 ("migration: ram: Switch to ram block writeback")
breaks migration on Xen. We have:
  ramblock_ptr: Assertion `offset_in_ramblock(block, offset)' failed.

I've track it down to qemu_ram_writeback() calling ramblock_ptr()
unconditionally, even when the result will not be used.

Maybe we could call ramblock_ptr() twice in that function? I've prepared
a patch.


FYI, full-ish trace on restore of a xen guest:
#3  0x00007f82d0848526 in __assert_fail () from /usr/lib/libc.so.6
#4  0x0000562dc4578122 in ramblock_ptr (block=0x562dc5ebe2a0, offset=0) at /root/build/qemu/include/exec/ram_addr.h:120
#5  0x0000562dc457d1b7 in qemu_ram_writeback (block=0x562dc5ebe2a0, start=0, length=515899392) at /root/build/qemu/exec.c:2169
#6  0x0000562dc45e8941 in qemu_ram_block_writeback (block=0x562dc5ebe2a0) at /root/build/qemu/include/exec/ram_addr.h:182
#7  0x0000562dc45f0b56 in ram_load_cleanup (opaque=0x562dc510fe00 <ram_state>) at /root/build/qemu/migration/ram.c:3983
#8  0x0000562dc49970b6 in qemu_loadvm_state_cleanup () at migration/savevm.c:2415
#9  0x0000562dc4997548 in qemu_loadvm_state (f=0x562dc6a1c600) at migration/savevm.c:2597
#10 0x0000562dc4987be7 in process_incoming_migration_co (opaque=0x0) at migration/migration.c:454
#11 0x0000562dc4b907e5 in coroutine_trampoline (i0=-962514432, i1=22061) at util/coroutine-ucontext.c:115

And *block in ramblock_ptr():
(gdb) p *block
$2 = {
  rcu = {
    next = 0x0, 
    func = 0x0
  }, 
  mr = 0x562dc512e140 <ram_memory>, 
  host = 0x0, 
  colo_cache = 0x0, 
  offset = 0, 
  used_length = 515899392, 
  max_length = 515899392, 
  resized = 0x0, 
  flags = 16, 
  idstr = "xen.ram", '\000' <repeats 248 times>, 
  next = {
    le_next = 0x562dc67bf7e0, 
    le_prev = 0x562dc510f1a0 <ram_list+64>
  }, 
  ramblock_notifiers = {
    lh_first = 0x0
  }, 
  fd = -1, 
  page_size = 4096, 
  bmap = 0x0, 
  receivedmap = 0x562dc6a24a60, 
  clear_bmap = 0x0, 
  clear_bmap_shift = 0 '\000'
}

Cheers,

-- 
Anthony PERARD

