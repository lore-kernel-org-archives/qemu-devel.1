Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24F9FC433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 16:44:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7468C206A5
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 16:44:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7468C206A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHraL-0005rL-EX
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 12:44:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35344)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kHpyT-0003la-2p
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 11:00:57 -0400
Received: from indium.canonical.com ([91.189.90.7]:39692)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kHpyQ-00075Z-SC
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 11:00:56 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1kHpyO-00043s-43
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2020 15:00:52 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 0F2432E80E9
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2020 15:00:52 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2020 14:53:57 -0000
From: Harry Coin <1895399@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: hcoin stefanha
X-Launchpad-Bug-Reporter: Harry Coin (hcoin)
X-Launchpad-Bug-Modifier: Harry Coin (hcoin)
References: <159992963448.16886.7579356964954187024.malonedeb@soybean.canonical.com>
 <20200914100806.GC579094@stefanha-x1.localdomain>
Message-Id: <5d7c2982-4282-d521-82d7-196468b45fee@gmail.com>
Subject: Re: [Bug 1895399] [NEW] Docfix: add missing virtiofsd cache default
 'auto'
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="83bdf6c8a3a5f87722c8927e54838522f3e57504"; Instance="production"
X-Launchpad-Hash: c48e0796bf57da41577f8a7a4d833d161b0c9c71
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/14 05:55:43
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
Reply-To: Bug 1895399 <1895399@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/14/20 5:08 AM, Stefan Hajnoczi wrote:
> On Sat, Sep 12, 2020 at 04:53:54PM -0000, Harry Coin wrote:
>> Public bug reported:
>>
>> The usage command line for virtiofsd has:
>>
>> void fuse_cmdline_help(void)
>> {
>>     printf("    -h   --help                print help\n"
>> ...
>>            "    -o cache=3D<mode>            cache mode. could be one of=
 \"auto, "
>>            "always, none\"\n"
>>            "                               default: auto\n"
>>
>>
>> But the default: auto info is missing from the man page.  I suggest this=
 patch:
>>
>> --- docs/tools/virtiofsd.rst    2020-09-10 18:07:45.380430677 -0500
>> +++ /tmp/virtiofsd.rst  2020-09-12 11:48:10.440815204 -0500
>> @@ -106,6 +106,7 @@
>>    forbids the FUSE client from caching to achieve best coherency at the=
 cost of
>>    performance.  ``auto`` acts similar to NFS with a 1 second metadata c=
ache
>>    timeout.  ``always`` sets a long cache lifetime at the expense of coh=
erency.
>> +  The default is ``auto``.
>>  =

>>  Examples
>>  --------
>>
> Thanks, that looks good.
>
> Please either submit a patch
> (https://wiki.qemu.org/Contribute/SubmitAPatch) or reply with a line in
> the following format so I can send a patch on your behalf:
>
>   Signed-off-by: Full Name <your@email.com>
>
> The "Signed-off-by:" tag indicates that you are contributing under the
> Developer Certificate of Origin (https://developercertificate.org/) that
> QEMU, Linux, and other open source projects use.
>
OK.=C2=A0 First time for everything:

Signed-off-by: Harry G. Coin <hgcoin@gmail.com>

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1895399

Title:
  Docfix: add missing virtiofsd cache default 'auto'

Status in QEMU:
  New

Bug description:
  The usage command line for virtiofsd has:

  void fuse_cmdline_help(void)
  {
      printf("    -h   --help                print help\n"
  ...
             "    -o cache=3D<mode>            cache mode. could be one of =
\"auto, "
             "always, none\"\n"
             "                               default: auto\n"

  =

  But the default: auto info is missing from the man page.  I suggest this =
patch:

  --- docs/tools/virtiofsd.rst    2020-09-10 18:07:45.380430677 -0500
  +++ /tmp/virtiofsd.rst  2020-09-12 11:48:10.440815204 -0500
  @@ -106,6 +106,7 @@
     forbids the FUSE client from caching to achieve best coherency at the =
cost of
     performance.  ``auto`` acts similar to NFS with a 1 second metadata ca=
che
     timeout.  ``always`` sets a long cache lifetime at the expense of cohe=
rency.
  +  The default is ``auto``.
   =

   Examples
   --------

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1895399/+subscriptions

