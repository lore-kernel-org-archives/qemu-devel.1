Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C37AC388F2
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 13:10:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1D602417D
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 13:10:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="VkEXzPOk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1D602417D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVaMW-0004l4-FY
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 09:10:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58688)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1kVaLF-00031o-Hw
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 09:09:17 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:38963)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1kVaLD-0001WP-95
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 09:09:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=MWUHg3jkjck8QMMoh3MU2EGpI3cw2pWWMdnHQXPFJ2I=; b=VkEXzPOktEqUdkl1Qbc7+vAJwB
 UxK/pz07MqKnRpOTa5fHDIfVPAnfY3DNYeW2EjKSmoh3t9ipNzvj8fkB+MT1RtvLngMjzRPUJqiD3
 EsACAaVJ+zcTCcc4ufyeUEuD+wOcGMWiZC5uD89oqi/OTusRa5daxwemkcLxXxmFobotq8oXuB5oy
 R+HDetn+/eUs1FvUXv5QYZlNzHQlP2ohdYl/OPKX2TSzH+8oBXKe6O/PlWYLD202Ct92od1loWSWe
 HbKpDtzJI2S3nFa4OBuq0EUDHWdLCGHL1DgR5YZk+kIWycKwuxlAffNmVkvTmnmepi+4u7e7/vOjO
 //pUXnOA==;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH v2 7/8] tests/9pfs: add local Tlink test
Date: Thu, 22 Oct 2020 15:09:09 +0200
Message-ID: <17621213.e7m4f8aTQE@silver>
In-Reply-To: <20201022110749.15488113@bahia.lan>
References: <cover.1603285620.git.qemu_oss@crudebyte.com>
 <5874251.7R3Ejnc4BG@silver> <20201022110749.15488113@bahia.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=91.194.90.13; envelope-from=qemu_oss@crudebyte.com;
 helo=lizzy.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/22 09:09:12
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Donnerstag, 22. Oktober 2020 11:07:49 CEST Greg Kurz wrote:
> > Ok, I found the problem on the mentioned box that failed to create hard
> > links with 9p: it is libvirt auto generating AppArmor policy rules for 9p
> > export pathes, which libvirt generates with "rw" AA (AppArmor)
> > permissions. Once I manually adjusted the AA rule to "rwl", creating hard
> > links worked again.
> > 
> > I guess I'll send a patch for libvirt to change that. At least IMO
> > creating
> > hard links with 9pfs is a very basic operation and should be enabled for
> > the respective 9p export path by default.
> > 
> > Actually I think it should also include "k" which means "file locking", as
> > file locking is also a fundamental operation with 9pfs, right?
> 
> Well, I don't know exactly why libvirt is generating a strict AppArmor
> policy but I'm not that surprised. If the user can _easily_ change the
> policy to fit its needs, it's fine to have a "better safe than sorry"
> default.

Alone identifying the root cause of this is not that easy I would say. And if
it takes me quite some time to find it, then I imagine that other people would
struggle with this even more.

A large portion of software, even scripts, rely on being able to create hard
links and locking files. Right now they typically error out on guest with no
helpful error message.

So you start looking into the logs, don't find something obvious, then strace
on guest side to find the most relevant failing syscall on guest side and see
it was probably link(). Then you have to check several security layers: file
permissions on guest, file permissions on host, effective UID of qemu process.
You try creating hard links directly on host with that UID, works. Next you
check is it qemu's seccomp? Is it host's SELinux? Is it AppArmor?

Even for an experienced sysadmin I doubt it'll be a matter of minutes to
resolve this issue. Now imagine a regular user who just wants to sandbox
something on a workstation.

Looking at libvirt git log, it seems this security policy exists more or less
since day one (SHA-1 29ea8a9b64aac60251d283f74d57690e4edb5a6b, Mar 9 2014).
And I don't see an explanation that would suggest a specific reason for
exactly "rw".

I think something has to be improved here, so I'll challenge by sending a
simple libvirt patch, CCing involved authors, and seeing the feedback:

diff --git a/src/security/virt-aa-helper.c b/src/security/virt-aa-helper.c
index 12429278fb..ce243e304b 100644
--- a/src/security/virt-aa-helper.c
+++ b/src/security/virt-aa-helper.c
@@ -1142,7 +1142,7 @@ get_files(vahControl * ctl)
             /* We don't need to add deny rw rules for readonly mounts,
              * this can only lead to troubles when mounting / readonly.
              */
-            if (vah_add_path(&buf, fs->src->path, fs->readonly ? "R" : "rw", true) != 0)
+            if (vah_add_path(&buf, fs->src->path, fs->readonly ? "R" : "rwlk", true) != 0)
                 goto cleanup;
         }
     }

Even after this change, this is not a global policy. Allowing hard links and
file locks would only be lifted for the 9p export path.

There would be other options as well of course: e.g. detecting on 9pfs side
whether AppArmor and co are enabled, and log a warning to the user a syscall
failed for that reason. But that would be much more complicated and I wonder
whether it would be worth it.

Best regards,
Christian Schoenebeck



