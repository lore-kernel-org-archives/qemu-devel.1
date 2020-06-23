Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E460C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 16:05:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5411206D4
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 16:05:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5411206D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60030 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnlQZ-0002PQ-2Y
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 12:05:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59364)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jnlM9-00061B-Tq
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 12:01:06 -0400
Received: from indium.canonical.com ([91.189.90.7]:60136)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jnlM2-0003Uo-Q8
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 12:01:05 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jnlLz-0003lL-DC
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 16:00:55 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 61E9E2E80BA
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 16:00:55 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2020 15:54:08 -0000
From: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <1878067@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: a1xndr philmd
X-Launchpad-Bug-Reporter: Alexander Bulekov (a1xndr)
X-Launchpad-Bug-Modifier: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9_=28philmd?=
 =?utf-8?q?=29?=
References: <158922026261.5250.13637087242622903872.malonedeb@chaenomeles.canonical.com>
Message-ID: <548b0c72-10c8-91a2-4eb8-018874fa7041@redhat.com>
Subject: Re: [Bug 1878067] [NEW] Assertion failure in eth_get_gso_type through
 the e1000e
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="1cbd0aa39df153c901321817f9b57cf3f232b507";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 9d601bcaa27b9a9eae14d35588b877eedbaf4cef
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/23 09:11:11
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, HEADER_FROM_DIFFERENT_DOMAINS=1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=_AUTOLEARN
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
Reply-To: Bug 1878067 <1878067@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20200623155408.rFVitt5xXwKLNPtuU4E6jFWXPqKFgkv1l66dzdzO58Q@z>

Cc'ing Dmitry

On 5/11/20 8:04 PM, Alexander Bulekov wrote:
> Public bug reported:
> =

> Hello,
> While fuzzing, I found an input that triggers an assertion failure in
> eth_get_gso_type through the e1000e:
> =

> #1  0x00007ffff685755b in __GI_abort () at abort.c:79
> #2  0x00007ffff7c75dc3 in  () at /usr/lib/x86_64-linux-gnu/libglib-2.0.so=
.0
> #3  0x00007ffff7cd0b0a in g_assertion_message_expr () at /usr/lib/x86_64-=
linux-gnu/libglib-2.0.so.0
> #4  0x0000555556875f33 in eth_get_gso_type (l3_proto=3D<optimized out>, l=
3_hdr=3D<optimized out>, l4proto=3D<optimized out>) at /home/alxndr/Develop=
ment/qemu/net/eth.c:76
> #5  0x00005555565e09ac in net_tx_pkt_get_gso_type (pkt=3D0x631000014800, =
tso_enable=3D0x1) at /home/alxndr/Development/qemu/hw/net/net_tx_pkt.c:300
> #6  0x00005555565e09ac in net_tx_pkt_build_vheader (pkt=3D0x631000014800,=
 tso_enable=3D<optimized out>, csum_enable=3D<optimized out>, gso_size=3D<o=
ptimized out>) at /home/alxndr/Development/qemu/hw/net/net_tx_pkt.c:316
> #7  0x000055555660bdb1 in e1000e_setup_tx_offloads (core=3D0x7fffeeb754e0=
, tx=3D0x7fffeeb95748) at /home/alxndr/Development/qemu/hw/net/e1000e_core.=
c:637
> #8  0x000055555660bdb1 in e1000e_tx_pkt_send (core=3D0x7fffeeb754e0, tx=
=3D0x7fffeeb95748, queue_index=3D<optimized out>) at /home/alxndr/Developme=
nt/qemu/hw/net/e1000e_core.c:658
> #9  0x000055555660bdb1 in e1000e_process_tx_desc (core=3D0x7fffeeb754e0, =
tx=3D0x7fffeeb95748, dp=3D<optimized out>, queue_index=3D<optimized out>) a=
t /home/alxndr/Development/qemu/hw/net/e1000e_core.c:743
> #10 0x000055555660bdb1 in e1000e_start_xmit (core=3Dcore@entry=3D0x7fffee=
b754e0, txr=3D<optimized out>, txr@entry=3D0x7fffffffbe60) at /home/alxndr/=
Development/qemu/hw/net/e1000e_core.c:934
> #11 0x0000555556607e2e in e1000e_set_tctl (core=3D0x7fffeeb754e0, index=
=3D<optimized out>, val=3D<optimized out>) at /home/alxndr/Development/qemu=
/hw/net/e1000e_core.c:2431
> #12 0x00005555565f90fd in e1000e_core_write (core=3D<optimized out>, addr=
=3D<optimized out>, val=3D<optimized out>, size=3D<optimized out>) at /home=
/alxndr/Development/qemu/hw/net/e1000e_core.c:3261
> #13 0x0000555555ff4337 in memory_region_write_accessor (mr=3D<optimized o=
ut>, addr=3D<optimized out>, value=3D<optimized out>, size=3D<optimized out=
>, shift=3D<optimized out>, mask=3D<optimized out>, attrs=3D...) at /home/a=
lxndr/Development/qemu/memory.c:483
> #14 0x0000555555ff3ce0 in access_with_adjusted_size (addr=3D<optimized ou=
t>, value=3D<optimized out>, size=3D<optimized out>, access_size_min=3D<opt=
imized out>, access_size_max=3D<optimized out>, access_fn=3D<optimized out>=
, mr=3D0x7fffeeb75110, attrs=3D...) at /home/alxndr/Development/qemu/memory=
.c:544
> #15 0x0000555555ff3ce0 in memory_region_dispatch_write (mr=3D<optimized o=
ut>, addr=3D<optimized out>, data=3D0x2b, op=3D<optimized out>, attrs=3D...=
) at /home/alxndr/Development/qemu/memory.c:1476
> =

> I can reproduce it in qemu 5.0 built with using:
> cat << EOF | ~/Development/qemu/build/i386-softmmu/qemu-system-i386 -M pc=
-q35-5.0 -netdev user,id=3Dqtest-bn0 -device e1000e,netdev=3Dqtest-bn0 -dis=
play none -nodefaults -nographic -qtest stdio -monitor none -serial none
> outl 0xcf8 0x80000810
> outl 0xcfc 0xe0000000
> outl 0xcf8 0x80000814
> outl 0xcf8 0x80000804
> outw 0xcfc 0x7
> outl 0xcf8 0x800008a2
> write 0xe0000420 0x1fc 0x3ff9ffdf00000000002467ff272d2f3ff9ffdf0000000000=
246fff272d2f3ff9ffdf00000000002477ff272d2f3ff9ffdf0000000000247fff272d2f3ff=
9ffdf00000000002487ff272d2f3ff9ffdf0000000000248fff272d2f3ff9ffdf0000000000=
2497ff272d2f3ff9ffdf0000000000249fff272d2f3ff9ffdf000000000024a7ff272d2f3ff=
9ffdf000000000024afff272d2f3ff9ffdf000000000024b7ff272d2f3ff9ffdf0000000000=
24bfff272d2f3ff9ffdf000000000024c7ff272d2f3ff9ffdf000000000024cfff272d2f3ff=
9ffdf000000000024d7ff272d2f3ff9ffdf000000000024dfff272d2f3ff9ffdf0000000000=
24e7ff272d2f3ff9ffdf000000000024efff272d2f3ff9ffdf000000000024f7ff272d2f3ff=
9ffdf000000000024ffff272d2f3ff9ffdf00000000002407ff272d2f3ff9ffdf0000000000=
240fff272d2f3ff9ffdf00000000002417ff272d2f3ff9ffdf0000000000241fff272d2f3ff=
9ffdf00000000002427ff272d2f3ff9ffdf0000000000242fff272d2f3ff9ffdf0000000000=
2437ff272d2f3ff9ffdf0000000000243fff272d2f3ff9ffdf00000000002447ff272d2f3ff=
9ffdf0000000000244fff272d2f3ff9ffdf00000000002457ff272d2f3ff9ffdf0000000000=
245fff272d2f3ff9ffdf00000000002467ff272d2f3ff9ffdf0000000000246fff27
> write 0xe00000b8 0x349 0xa300f52bff003100ffa300f52bff003100ffa300f52bff00=
3100ffa300f52bff003100ffa300f52bff003100ffa300f52bff003100ffa300f52bff00310=
0ffa300f52bff003100ffa300f52bff003100ffa300f52bff003100ffa300f52bff003100ff=
a300f52bff003100ffa300f52bff003100ffa300f52bff003100ffa300f52bff003100ffa30=
0f52bff003100ffa300f52bff003100ffa300f52bff003100ffa300f52bff003100ffa300f5=
2bff003100ffa300f52bff003100ffa300f52bff003100ffa300f52bff003100ffa300f52bf=
f003100ffa300f52bff003100ffa300f52bff003100ffa300f52bff003100ffa300f52bff00=
3100ffa300f52bff003100ffa300f52bff003100ffa300f52bff003100ffa300f52bff00310=
0ffa300f52bff003100ffa300f52bff003100ffa300f52bff003100ffa300f52bff003100ff=
a300f52bff003100ffa300f52bff003100ffa300f52bff003100ffa300f52bff003100ffa30=
0f52bff003100ffa300f52bff003100ffa300f52bff003100ffa300f52bff003100ffa300f5=
2bff003100ffa300f52bff003100ffa300f52bff003100ffa300f52bff003100ffa300f52bf=
f003100ffa300f52bff003100ffa300f52bff003100ffa300f52bff003100ffa300f52bff00=
3100ffa300f52bff003100ffa300f52bff003100ffa300f52bff003100ffa300f52bff00310=
0ffa300f52bff003100ffa300f52bff003100ffa300f52bff003100ffa300f52bff003100ff=
a300f52bff003100ffa300f52bff003100ffa300f52bff003100ffa300f52bff003100ffa30=
0f52bff003100ffa300f52bff003100ffa300f52bff003100ffa300f52bff003100ffa300f5=
2bff003100ffa300f52bff003100ffa300f52bff003100ffa300f52bff003100ffa300f52bf=
f003100ffa300f52bff003100ffa300f52bff003100ffa300f52bff003100ffa300f52bff00=
3100ffa300f52bff003100ffa300f52bff003100ffa300f52bff003100ffa300f52bff00310=
0ffa300f52bff003100ffa300f52bff003100ffa300f52bff003100ffa300f52bff003100ff=
a300f52bff003100ffa300f52bff003100ffa300f52bff003100ffa300f52bff003100ffa30=
0f52bff003100ffa300f52bff003100ffa300f52bff003100ffa300f52b
> EOF
> =

> I also attached the trace to this launchpad report, in case the
> formatting is broken:
> =

> qemu-system-i386 -M pc-q35-5.0 -netdev user,id=3Dqtest-bn0 -device
> e1000e,netdev=3Dqtest-bn0 -display none -nodefaults -nographic -qtest
> stdio -monitor none -serial none < attachment
> =

> Please let me know if I can provide any further info.
> -Alex
> =

> ** Affects: qemu
>      Importance: Undecided
>          Status: New
> =

> ** Attachment added: "attachment"
>    https://bugs.launchpad.net/bugs/1878067/+attachment/5369990/+files/att=
achment
>

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1878067

Title:
  Assertion failure in eth_get_gso_type through the e1000e

Status in QEMU:
  New

Bug description:
  Hello,
  While fuzzing, I found an input that triggers an assertion failure in
  eth_get_gso_type through the e1000e:

  #1  0x00007ffff685755b in __GI_abort () at abort.c:79
  #2  0x00007ffff7c75dc3 in  () at /usr/lib/x86_64-linux-gnu/libglib-2.0.so=
.0
  #3  0x00007ffff7cd0b0a in g_assertion_message_expr () at /usr/lib/x86_64-=
linux-gnu/libglib-2.0.so.0
  #4  0x0000555556875f33 in eth_get_gso_type (l3_proto=3D<optimized out>, l=
3_hdr=3D<optimized out>, l4proto=3D<optimized out>) at /home/alxndr/Develop=
ment/qemu/net/eth.c:76
  #5  0x00005555565e09ac in net_tx_pkt_get_gso_type (pkt=3D0x631000014800, =
tso_enable=3D0x1) at /home/alxndr/Development/qemu/hw/net/net_tx_pkt.c:300
  #6  0x00005555565e09ac in net_tx_pkt_build_vheader (pkt=3D0x631000014800,=
 tso_enable=3D<optimized out>, csum_enable=3D<optimized out>, gso_size=3D<o=
ptimized out>) at /home/alxndr/Development/qemu/hw/net/net_tx_pkt.c:316
  #7  0x000055555660bdb1 in e1000e_setup_tx_offloads (core=3D0x7fffeeb754e0=
, tx=3D0x7fffeeb95748) at /home/alxndr/Development/qemu/hw/net/e1000e_core.=
c:637
  #8  0x000055555660bdb1 in e1000e_tx_pkt_send (core=3D0x7fffeeb754e0, tx=
=3D0x7fffeeb95748, queue_index=3D<optimized out>) at /home/alxndr/Developme=
nt/qemu/hw/net/e1000e_core.c:658
  #9  0x000055555660bdb1 in e1000e_process_tx_desc (core=3D0x7fffeeb754e0, =
tx=3D0x7fffeeb95748, dp=3D<optimized out>, queue_index=3D<optimized out>) a=
t /home/alxndr/Development/qemu/hw/net/e1000e_core.c:743
  #10 0x000055555660bdb1 in e1000e_start_xmit (core=3Dcore@entry=3D0x7fffee=
b754e0, txr=3D<optimized out>, txr@entry=3D0x7fffffffbe60) at /home/alxndr/=
Development/qemu/hw/net/e1000e_core.c:934
  #11 0x0000555556607e2e in e1000e_set_tctl (core=3D0x7fffeeb754e0, index=
=3D<optimized out>, val=3D<optimized out>) at /home/alxndr/Development/qemu=
/hw/net/e1000e_core.c:2431
  #12 0x00005555565f90fd in e1000e_core_write (core=3D<optimized out>, addr=
=3D<optimized out>, val=3D<optimized out>, size=3D<optimized out>) at /home=
/alxndr/Development/qemu/hw/net/e1000e_core.c:3261
  #13 0x0000555555ff4337 in memory_region_write_accessor (mr=3D<optimized o=
ut>, addr=3D<optimized out>, value=3D<optimized out>, size=3D<optimized out=
>, shift=3D<optimized out>, mask=3D<optimized out>, attrs=3D...) at /home/a=
lxndr/Development/qemu/memory.c:483
  #14 0x0000555555ff3ce0 in access_with_adjusted_size (addr=3D<optimized ou=
t>, value=3D<optimized out>, size=3D<optimized out>, access_size_min=3D<opt=
imized out>, access_size_max=3D<optimized out>, access_fn=3D<optimized out>=
, mr=3D0x7fffeeb75110, attrs=3D...) at /home/alxndr/Development/qemu/memory=
.c:544
  #15 0x0000555555ff3ce0 in memory_region_dispatch_write (mr=3D<optimized o=
ut>, addr=3D<optimized out>, data=3D0x2b, op=3D<optimized out>, attrs=3D...=
) at /home/alxndr/Development/qemu/memory.c:1476

  I can reproduce it in qemu 5.0 built with using:
  cat << EOF | ~/Development/qemu/build/i386-softmmu/qemu-system-i386 -M pc=
-q35-5.0 -netdev user,id=3Dqtest-bn0 -device e1000e,netdev=3Dqtest-bn0 -dis=
play none -nodefaults -nographic -qtest stdio -monitor none -serial none
  outl 0xcf8 0x80000810
  outl 0xcfc 0xe0000000
  outl 0xcf8 0x80000814
  outl 0xcf8 0x80000804
  outw 0xcfc 0x7
  outl 0xcf8 0x800008a2
  write 0xe0000420 0x1fc 0x3ff9ffdf00000000002467ff272d2f3ff9ffdf0000000000=
246fff272d2f3ff9ffdf00000000002477ff272d2f3ff9ffdf0000000000247fff272d2f3ff=
9ffdf00000000002487ff272d2f3ff9ffdf0000000000248fff272d2f3ff9ffdf0000000000=
2497ff272d2f3ff9ffdf0000000000249fff272d2f3ff9ffdf000000000024a7ff272d2f3ff=
9ffdf000000000024afff272d2f3ff9ffdf000000000024b7ff272d2f3ff9ffdf0000000000=
24bfff272d2f3ff9ffdf000000000024c7ff272d2f3ff9ffdf000000000024cfff272d2f3ff=
9ffdf000000000024d7ff272d2f3ff9ffdf000000000024dfff272d2f3ff9ffdf0000000000=
24e7ff272d2f3ff9ffdf000000000024efff272d2f3ff9ffdf000000000024f7ff272d2f3ff=
9ffdf000000000024ffff272d2f3ff9ffdf00000000002407ff272d2f3ff9ffdf0000000000=
240fff272d2f3ff9ffdf00000000002417ff272d2f3ff9ffdf0000000000241fff272d2f3ff=
9ffdf00000000002427ff272d2f3ff9ffdf0000000000242fff272d2f3ff9ffdf0000000000=
2437ff272d2f3ff9ffdf0000000000243fff272d2f3ff9ffdf00000000002447ff272d2f3ff=
9ffdf0000000000244fff272d2f3ff9ffdf00000000002457ff272d2f3ff9ffdf0000000000=
245fff272d2f3ff9ffdf00000000002467ff272d2f3ff9ffdf0000000000246fff27
  write 0xe00000b8 0x349 0xa300f52bff003100ffa300f52bff003100ffa300f52bff00=
3100ffa300f52bff003100ffa300f52bff003100ffa300f52bff003100ffa300f52bff00310=
0ffa300f52bff003100ffa300f52bff003100ffa300f52bff003100ffa300f52bff003100ff=
a300f52bff003100ffa300f52bff003100ffa300f52bff003100ffa300f52bff003100ffa30=
0f52bff003100ffa300f52bff003100ffa300f52bff003100ffa300f52bff003100ffa300f5=
2bff003100ffa300f52bff003100ffa300f52bff003100ffa300f52bff003100ffa300f52bf=
f003100ffa300f52bff003100ffa300f52bff003100ffa300f52bff003100ffa300f52bff00=
3100ffa300f52bff003100ffa300f52bff003100ffa300f52bff003100ffa300f52bff00310=
0ffa300f52bff003100ffa300f52bff003100ffa300f52bff003100ffa300f52bff003100ff=
a300f52bff003100ffa300f52bff003100ffa300f52bff003100ffa300f52bff003100ffa30=
0f52bff003100ffa300f52bff003100ffa300f52bff003100ffa300f52bff003100ffa300f5=
2bff003100ffa300f52bff003100ffa300f52bff003100ffa300f52bff003100ffa300f52bf=
f003100ffa300f52bff003100ffa300f52bff003100ffa300f52bff003100ffa300f52bff00=
3100ffa300f52bff003100ffa300f52bff003100ffa300f52bff003100ffa300f52bff00310=
0ffa300f52bff003100ffa300f52bff003100ffa300f52bff003100ffa300f52bff003100ff=
a300f52bff003100ffa300f52bff003100ffa300f52bff003100ffa300f52bff003100ffa30=
0f52bff003100ffa300f52bff003100ffa300f52bff003100ffa300f52bff003100ffa300f5=
2bff003100ffa300f52bff003100ffa300f52bff003100ffa300f52bff003100ffa300f52bf=
f003100ffa300f52bff003100ffa300f52bff003100ffa300f52bff003100ffa300f52bff00=
3100ffa300f52bff003100ffa300f52bff003100ffa300f52bff003100ffa300f52bff00310=
0ffa300f52bff003100ffa300f52bff003100ffa300f52bff003100ffa300f52bff003100ff=
a300f52bff003100ffa300f52bff003100ffa300f52bff003100ffa300f52bff003100ffa30=
0f52bff003100ffa300f52bff003100ffa300f52bff003100ffa300f52b
  EOF

  I also attached the trace to this launchpad report, in case the
  formatting is broken:

  qemu-system-i386 -M pc-q35-5.0 -netdev user,id=3Dqtest-bn0 -device
  e1000e,netdev=3Dqtest-bn0 -display none -nodefaults -nographic -qtest
  stdio -monitor none -serial none < attachment

  Please let me know if I can provide any further info.
  -Alex

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1878067/+subscriptions

