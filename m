Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E631C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 19:36:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1315E21D7D
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 19:36:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iME2lMB/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1315E21D7D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuiHT-0005pd-4t
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 14:36:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49338)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iug4R-0002wZ-28
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 12:15:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iug4O-0002Rl-0A
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 12:15:06 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23457
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iug4N-0002P8-Rg
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 12:15:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579799702;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=lXQiMnh+8nnMY8LfQp0somzgzARDqxmhTIrLeyB5+SQ=;
 b=iME2lMB/PBYcXYc1yJ/sYXEiHswHIY0hw5KLU75t2XPvCOmRRFtHYGynJsp3Y8fyoClFKN
 gy1YPUZy4py/preigxMhslr5pqcPFjSDhX6UIJ/8VQt+OUOU8NA/sD9XEuZpwVVUgK8IQ7
 8ZWRmU4kVb7q09PmqRVDYYf2tKNVkCI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-362-6P45-92lNm2_8CCoJmyoiw-1; Thu, 23 Jan 2020 12:12:02 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 494D7100551B;
 Thu, 23 Jan 2020 17:12:00 +0000 (UTC)
Received: from thuth.com (ovpn-116-64.ams2.redhat.com [10.36.116.64])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 45C1C85784;
 Thu, 23 Jan 2020 17:11:52 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: [qemu-web PATCH v2] Add "Security Process" information to the main
 website
Date: Thu, 23 Jan 2020 18:11:50 +0100
Message-Id: <20200123171150.12782-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: 6P45-92lNm2_8CCoJmyoiw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: pjp@redhat.com, sstabellini@kernel.org, pmatouse@redhat.com,
 mdroth@linux.vnet.ibm.com, "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

One reporter of a security issue recently complained that it might not
be the best idea to store our "Security Process" in the Wiki. Well, while
the page in the Wiki is protected (so that only some few people can edit
it), it is still possible that someone might find a bug in the Wiki
software to alter the page contents...
Anyway, it looks more trustworthy if we present the "Security Process"
information in the static website instead. Thus this patch adds the
information from the wiki to the Jekyll-based website now.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 v2: Improved some sentences as suggested by Paolo

 contribute.md                  |   3 +-
 contribute/report-a-bug.md     |   7 +-
 contribute/security-process.md | 129 +++++++++++++++++++++++++++++++++
 3 files changed, 134 insertions(+), 5 deletions(-)
 create mode 100644 contribute/security-process.md

diff --git a/contribute.md b/contribute.md
index 56306e0..96901b5 100644
--- a/contribute.md
+++ b/contribute.md
@@ -3,7 +3,8 @@ title: Contribute to QEMU!
 permalink: /contribute/
 ---
=20
-* Report a bug: [https://bugs.launchpad.net/qemu/](https://bugs.launchpad.=
net/qemu/)<br>[How to report a bug](report-a-bug/)
+* Report a bug in our bugtracker: [https://bugs.launchpad.net/qemu/](https=
://bugs.launchpad.net/qemu/)<br>
+  See also [How to report a bug](report-a-bug/) or [How to report a securi=
ty bug](security-process/)
=20
 * Clone ([or browse](https://git.qemu.org/?p=3Dqemu.git)) the git reposito=
ry: <br>`git clone https://git.qemu.org/git/qemu.git`
=20
diff --git a/contribute/report-a-bug.md b/contribute/report-a-bug.md
index 441c61b..1cc42e7 100644
--- a/contribute/report-a-bug.md
+++ b/contribute/report-a-bug.md
@@ -17,10 +17,9 @@ When submitting a bug report, please try to do the follo=
wing:
=20
 * Do not contribute patches on the bug tracker; send patches to the mailin=
g list. Follow QEMU's [guidelines about submitting patches](https://wiki.qe=
mu.org/Contribute/SubmitAPatch).
=20
-Do NOT report security issues (or other bugs, too) as
-"private" bugs in the bug tracker.  QEMU has a [security
-process](https://wiki.qemu.org/SecurityProcess) for issues that should
-be reported in a non-public way instead.
+Do NOT report security issues (or other bugs, too) as "private" bugs in th=
e
+bug tracker.  QEMU has a [security process](../security-process) for issue=
s
+that should be reported in a non-public way instead.
=20
 For problems with KVM in the kernel, use the kernel bug tracker instead;
 the [KVM wiki](https://www.linux-kvm.org/page/Bugs) has the details.
diff --git a/contribute/security-process.md b/contribute/security-process.m=
d
new file mode 100644
index 0000000..ad10627
--- /dev/null
+++ b/contribute/security-process.md
@@ -0,0 +1,129 @@
+---
+title: Security Process
+permalink: /contribute/security-process/
+---
+
+QEMU takes security very seriously, and we aim to take immediate action to
+address serious security-related problems that involve our product.
+
+Please report any suspected security vulnerability in QEMU to the followin=
g
+addresses. You can use GPG keys for respective receipients to communicate =
with
+us securely. If you do, please upload your GPG public key or supply it to =
us
+in some other way, so that we can communicate to you in a secure way, too!
+Please include the tag **\[QEMU-SECURITY\]** on the subject line to help u=
s
+identify your message as security-related.=20
+
+## QEMU Security Contact List
+
+Please copy everyone on this list:
+
+ Contact Person(s)=09| Contact Address=09=09| Company=09|  GPG Key  | GPG =
key fingerprint
+:-----------------------|:------------------------------|:--------------|:=
---------:|:--------------------
+ Michael S. Tsirkin=09| mst@redhat.com=09=09| Red Hat Inc.=09| [&#x1f511;]=
(https://pgp.mit.edu/pks/lookup?op=3Dvindex&search=3D0xC3503912AFBE8E67) | =
0270 606B 6F3C DF3D 0B17 0970 C350 3912 AFBE 8E67
+ Petr Matousek=09=09| pmatouse@redhat.com=09=09| Red Hat Inc.=09| [&#x1f51=
1;](https://pgp.mit.edu/pks/lookup?op=3Dvindex&search=3D0x3E786F42C44977CA)=
 | 8107 AF16 A416 F9AF 18F3 D874 3E78 6F42 C449 77CA
+ Stefano Stabellini=09| sstabellini@kernel.org =09| Independent=09| [&#x1f=
511;](https://pgp.mit.edu/pks/lookup?op=3Dvindex&search=3D0x894F8F4870E1AE9=
0) | D04E 33AB A51F 67BA 07D3 0AEA 894F 8F48 70E1 AE90
+ Security Response Team | secalert@redhat.com=09=09| Red Hat Inc.=09| [&#x=
1f511;](https://access.redhat.com/site/security/team/contact/#contact) |
+ Michael Roth=09=09| mdroth@linux.vnet.ibm.com=09| IBM=09=09| [&#x1f511;](=
https://pgp.mit.edu/pks/lookup?op=3Dvindex&search=3D0x3353C9CEF108B584) | C=
EAC C9E1 5534 EBAB B82D 3FA0 3353 C9CE F108 B584
+ Prasad J Pandit =09| pjp@redhat.com=09=09| Red Hat Inc.=09| [&#x1f511;](h=
ttp://pool.sks-keyservers.net/pks/lookup?op=3Dvindex&search=3D0xE2858B5AF05=
0DE8D) | 8685 545E B54C 486B C6EB 271E E285 8B5A F050 DE8D=20
+
+## How to Contact Us Securely
+
+We use GNU Privacy Guard (GnuPG or GPG) keys to secure communications. Mai=
l
+sent to members of the list can be encrypted with public keys of all membe=
rs
+of the list. We expect to change some of the keys we use from time to time=
.
+Should a key change, the previous one will be revoked.
+
+## How we respond
+
+Maintainers listed on the security reporting list operate a policy of
+responsible disclosure. As such they agree that any information you share =
with
+them about security issues that are not public knowledge is kept confident=
ial
+within respective affiliated companies. It is not passed on to any third-p=
arty,
+including Xen Security Project, without your permission.
+
+Email sent to us is read and acknowledged with a non-automated response. F=
or
+issues that are complicated and require significant attention, we will ope=
n an
+investigation and keep you informed of our progress. We might take one or =
more
+of the following steps:
+
+### Publication embargo
+
+As a security issue reported, that is not already publically disclosed
+elsewhere, has an embargo date assigned and communicated to reporter. Emba=
rgo
+periods will be negotiated by mutual agreement between members of the secu=
rity
+team and other relevant parties to the problem. Members of the security co=
ntact
+list agree not to publically disclose any details of the security issue un=
til
+the embargo date expires.
+
+### CVE allocation
+
+An security issue is assigned with a CVE number. The CVE numbers will usua=
lly
+be allocated by one of the vendor security engineers on the security conta=
ct
+list.
+
+## When to contact the QEMU Security Contact List
+
+You should contact the Security Contact List if:
+* You think there may be a security vulnerability in QEMU.
+* You are unsure about how a known vulnerability affects QEMU.
+* You can contact us in English. We are unable to respond in other languag=
es.
+
+## When *not* to contact the QEMU Security Contact List
+* You need assistance in a language other than English.
+* You require technical assistance (for example, "how do I configure QEMU?=
").
+* You need help upgrading QEMU due to security alerts.
+* Your issue is not security related.
+
+## How impact and severity of a bug is decided
+
+All security issues in QEMU are not equal. Based on the parts of the QEMU
+sources wherein the bug is found, its impact and severity could vary.
+
+In particular, QEMU is used in many different scenarios; some of them assu=
me
+that the guest is trusted, some of them don't. General considerations to t=
riage
+QEMU issues and decide whether a configuration is security sensitive inclu=
de:
+
+* Is there any feasible way for a malicious party to exploit this flaw and
+  cause real damage? (e.g. from a guest or via downloadable images)
+* Does the flaw require access to the management interface? Would the
+  management interface be accessible in the scenario where the flaw could =
cause
+  real damage?
+* Is QEMU used in conjunction with a hypervisor (as opposed to TCG binary
+  translation)?
+* Is QEMU used to offer virtualised production services, as opposed to usa=
ge
+  as a development platform?
+
+Whenever some or all of these questions have negative answers, what appear=
s to
+be a major security flaw might be considered of low severity because it co=
uld
+only be exercised in use cases where QEMU and everything interacting with =
it is
+trusted.
+
+For  example, consider upstream commit [9201bb9 "sdhci.c: Limit the maximu=
m
+block size"](http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D9201bb9), an=
 of out of
+bounds (OOB) memory access (ie. buffer overflow) issue that was found and =
fixed
+in the SD Host  Controller emulation (hw/sd/sdhci.c).
+
+On the surface, this bug appears to be a genuine security flaw, with poten=
tially
+severe implications. But digging further down, there are only two ways to =
use
+SD Host Controller emulation, one is via 'sdhci-pci' interface and the oth=
er
+is via 'generic-sdhci' interface.
+
+Of these two, the 'sdhci-pci' interface had actually been disabled by defa=
ult
+in the upstream QEMU releases (commit [1910913 "sdhci: Make device "sdhci-=
pci"
+unavailable with -device"](http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=
=3D1910913)
+at the time the flaw was reported; therefore, guests could not possibly us=
e
+'sdhci-pci' for any  purpose.
+
+The 'generic-sdhci' interface, instead, had only one user in 'Xilinx Zynq
+Baseboard emulation' (hw/arm/xilinx_zynq.c). Xilinx Zynq is a programmable
+systems on chip (SoC) device. While QEMU does emulate this device, in prac=
tice
+it is used to facilitate cross-platform developmental efforts, i.e. QEMU i=
s
+used to write programs for the SoC device. In such developer environments,=
 it
+is generally assumed that the guest is trusted.
+
+And thus, this buffer overflow turned out to be a security non-issue.
+
+## What to Send to the QEMU Security Contact List
+
+Please provide as much information about your system and the issue as poss=
ible
+when contacting the list.
--=20
2.18.1


