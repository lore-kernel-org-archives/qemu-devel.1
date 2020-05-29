Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D2A6C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 09:56:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA1F0207D4
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 09:56:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA1F0207D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jebkp-0005dN-2f
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 05:56:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51162)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jebjq-0003yX-Af
 for qemu-devel@nongnu.org; Fri, 29 May 2020 05:55:42 -0400
Received: from indium.canonical.com ([91.189.90.7]:53262)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jebjp-0008R5-81
 for qemu-devel@nongnu.org; Fri, 29 May 2020 05:55:42 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jebjn-0006BA-Lj
 for <qemu-devel@nongnu.org>; Fri, 29 May 2020 09:55:39 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id A13BE2E8105
 for <qemu-devel@nongnu.org>; Fri, 29 May 2020 09:55:39 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 29 May 2020 09:49:54 -0000
From: "ye.zou" <1881231@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: alanjager2321
X-Launchpad-Bug-Reporter: ye.zou (alanjager2321)
X-Launchpad-Bug-Modifier: ye.zou (alanjager2321)
References: <159072520391.13844.465385675639953986.malonedeb@soybean.canonical.com>
Message-Id: <159074579420.29937.1643486335650066497.malone@chaenomeles.canonical.com>
Subject: [Bug 1881231] Re: colo: Can not recover colo after svm failover twice
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="275d46a24253e557e4403d52832837e4bfa425b6";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: f167320c88bc3797a600c4a5c253c66be76c85c9
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/29 02:40:58
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -65
X-Spam_score: -6.6
X-Spam_bar: ------
X-Spam_report: (-6.6 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Bug 1881231 <1881231@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

primary vm command:
./qemu-system-x86_64 -L /usr/share/qemu-kvm/ -enable-kvm -cpu qemu64,+kvmcl=
ock -m 2048 -smp 2 -qmp stdio -vnc :0 -device piix3-usb-uhci -device usb-ta=
blet -name primary -netdev tap,id=3Dhn0,vhost=3Doff,br=3Dbr_bond1,helper=3D=
/usr/libexec/qemu-bridge-helper -device rtl8139,id=3De0,netdev=3Dhn0,romfil=
e=3D"" -chardev socket,id=3Dmirror0,host=3D169.254.66.11,port=3D9003,server=
,nowait -chardev socket,id=3Dcompare1,host=3D169.254.66.11,port=3D9004,serv=
er,wait -chardev socket,id=3Dcompare0,host=3D169.254.66.11,port=3D9001,serv=
er,nowait -chardev socket,id=3Dcompare0-0,host=3D169.254.66.11,port=3D9001 =
-chardev socket,id=3Dcompare_out,host=3D169.254.66.11,port=3D9005,server,no=
wait -chardev socket,id=3Dcompare_out0,host=3D169.254.66.11,port=3D9005 -ob=
ject filter-mirror,id=3Dm0,netdev=3Dhn0,queue=3Dtx,outdev=3Dmirror0 -object=
 filter-redirector,netdev=3Dhn0,id=3Dredire0,queue=3Drx,indev=3Dcompare_out=
 -object filter-redirector,netdev=3Dhn0,id=3Dredire1,queue=3Drx,outdev=3Dco=
mpare0 -object iothread,id=3Diothread1 -object colo-compare,id=3Dcomp0,prim=
ary_in=3Dcompare0-0,secondary_in=3Dcompare1,outdev=3Dcompare_out0,iothread=
=3Diothread1 -drive if=3Dide,id=3Dcolo-disk0,driver=3Dquorum,read-pattern=
=3Dfifo,vote-threshold=3D1,children.0.file.filename=3D/root/Centos7.4.qcow2=
,children.0.driver=3Dqcow2 -S

secondary vm:
./qemu-system-x86_64 -L /usr/share/qemu-kvm/ -enable-kvm -cpu qemu64,+kvmcl=
ock -m 2048 -smp 2 -qmp stdio -vnc :1 -device piix3-usb-uhci -device usb-ta=
blet -name secondary -netdev tap,id=3Dhn0,vhost=3Doff,br=3Dbr_bond1,helper=
=3D/usr/libexec/qemu-bridge-helper -device rtl8139,id=3De0,netdev=3Dhn0,rom=
file=3D"" -chardev socket,id=3Dred0,host=3D169.254.66.11,port=3D9003,reconn=
ect=3D1 -chardev socket,id=3Dred1,host=3D169.254.66.11,port=3D9004,reconnec=
t=3D1 -object filter-redirector,id=3Df1,netdev=3Dhn0,queue=3Dtx,indev=3Dred=
0 -object filter-redirector,id=3Df2,netdev=3Dhn0,queue=3Drx,outdev=3Dred1 -=
object filter-rewriter,id=3Drew0,netdev=3Dhn0,queue=3Dall -drive if=3Dnone,=
id=3Dparent0,file.filename=3D/root/Centos7.4.qcow2,driver=3Dqcow2 -drive if=
=3Dnone,id=3Dchilds0,driver=3Dreplication,mode=3Dsecondary,file.driver=3Dqc=
ow2,top-id=3Dchilds0,file.file.filename=3D/root/active.qcow2,file.backing.d=
river=3Dqcow2,file.backing.file.filename=3D/root/hidden.qcow2,file.backing.=
backing=3Dparent0 -drive if=3Dnone,id=3Dcolo-disk0,driver=3Dquorum,read-pat=
tern=3Dfifo,vote-threshold=3D1,children.0=3Dchilds0 -incoming tcp:0:9998

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1881231

Title:
  colo: Can not  recover colo after svm failover twice

Status in QEMU:
  New

Bug description:
  Hi Expert,
  x-blockdev-change met some error, during testing colo

  Host os:
  CentOS Linux release 7.6.1810 (Core)

  Reproduce steps:
  1. create colo vm following https://github.com/qemu/qemu/blob/master/docs=
/COLO-FT.txt
  2. kill secondary vm and remove the nbd child from the quorum to wait for=
 recover
    type those commands on primary vm console:
    { 'execute': 'x-blockdev-change', 'arguments': {'parent': 'colo-disk0',=
 'child': 'children.1'}}
    { 'execute': 'human-monitor-command','arguments': {'command-line': 'dri=
ve_del replication0'}}
    { 'execute': 'x-colo-lost-heartbeat'}
  3. recover colo
  4. kill secondary vm again after recover colo and type same commands as s=
tep 2:
    { 'execute': 'x-blockdev-change', 'arguments': {'parent': 'colo-disk0',=
 'child': 'children.1'}}
    { 'execute': 'human-monitor-command','arguments': {'command-line': 'dri=
ve_del replication0'}}
    { 'execute': 'x-colo-lost-heartbeat'}
    but the first command got error
    { 'execute': 'x-blockdev-change', 'arguments': {'parent': 'colo-disk0',=
 'child': 'children.1'}}
  {"error": {"class": "GenericError", "desc": "Node 'colo-disk0' does not h=
ave child 'children.1'"}}

  according to https://www.qemu.org/docs/master/qemu-qmp-ref.html
  Command: x-blockdev-change
  Dynamically reconfigure the block driver state graph. It can be used to a=
dd, remove, insert or replace a graph node. Currently only the Quorum drive=
r implements this feature to add or remove its child. This is useful to fix=
 a broken quorum child.

  It seems x-blockdev-change not worked as expected.

  Thanks.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1881231/+subscriptions

