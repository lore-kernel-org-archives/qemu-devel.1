Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 196C6C2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 18:36:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 575B72067B
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 18:36:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 575B72067B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34822 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kcC1y-0006D8-BZ
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 13:36:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54050)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kcC0t-0004wj-US
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 13:35:35 -0500
Received: from indium.canonical.com ([91.189.90.7]:57188)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kcC0r-0000yW-KY
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 13:35:35 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1kcC0p-0005X1-H7
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2020 18:35:31 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 5806A2E8042
 for <qemu-devel@nongnu.org>; Mon,  9 Nov 2020 18:35:31 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2020 18:29:51 -0000
From: Thomas Huth <1712027@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Incomplete; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: h14522 th-huth
X-Launchpad-Bug-Reporter: Huang Yong (h14522)
X-Launchpad-Bug-Modifier: Thomas Huth (th-huth)
References: <150330672268.8725.17665790368733773133.malonedeb@soybean.canonical.com>
Message-Id: <160494659192.18639.9167706193373022181.malone@wampee.canonical.com>
Subject: [Bug 1712027] Re: qemu: Cryptography adding encrypted disk with luks
 format failed
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="e39939c02bd86af4202bc6e2123a7708215ec8ea"; Instance="production"
X-Launchpad-Hash: 56b831bdf94a12d94a93a92d64b54397746986d5
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/09 11:16:03
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -65
X-Spam_score: -6.6
X-Spam_bar: ------
X-Spam_report: (-6.6 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Reply-To: Bug 1712027 <1712027@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The QEMU project is currently considering to move its bug tracking to anoth=
er system. For this we need to know which bugs are still valid and which co=
uld be closed already. Thus we are setting older bugs to "Incomplete" now.
If you still think this bug report here is valid, then please switch the st=
ate back to "New" within the next 60 days, otherwise this report will be ma=
rked as "Expired". Thank you and sorry for the inconvenience.

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1712027

Title:
  qemu: Cryptography adding encrypted disk with luks format failed

Status in QEMU:
  Incomplete

Bug description:
  I'm using libvirt to attach luks encrypted disk to a running VM. The
  qemu-monitor-command like the

  following:

  {"execute":"object-add","arguments":{"qom-type":"secret","id":"virtio-
  disk11-luks-
  secret0","props":{"data":"El7jOYLCZwrij2Mue0q2tA=3D=3D","keyid":"masterKe=
y0","iv":"J2je0WJjCa89L3iKc1lceg=3D=3D","format":"base64"}}

  the masterKey0 specify the secret which has been created before.

  command above return with error message "Incorrect number of padding
  bytes XXX found on decrypted

  data". This is triggered by the following code snippets in qemu/crypto/se=
cret.c:
           =

  if (plaintext[ciphertextlen - 1] > 16 ||
               plaintext[ciphertextlen - 1] > ciphertextlen) {
               error_setg(errp, "Incorrect number of padding bytes (%d) "
                       "found on decrypted data",
                       (int)plaintext[ciphertextlen - 1]); =

                     =E2=80=A6
           }

  The bug is: There is on padding in plaintext if the actual length of
  the plaintext  decrypted is

  equal to ciphertext.

  In this case, the last element in plaintext array may be one of the
  character in base64 code table

  or other.

  I would like to know why length of padding bytes cannot exceed 16 and
  whether i can remove

  judement: =E2=80=9Cplaintext[ciphertextlen - 1] > 16=E2=80=9D so that I c=
an eliminate
  the error above.

  Much appreciate it if doubts above is cleared up.

  libvirt/qemu version:

  # virsh version
  Compiled against library: libvirt 3.0.0
  Using library: libvirt 3.0.0
  Using API: QEMU 3.0.0
  Running hypervisor: QEMU 2.7.1

  OS: Ubuntu 12.04 LTS

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1712027/+subscriptions

