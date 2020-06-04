Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6BFAC433E1
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 18:31:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EC1A2077D
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 18:31:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EC1A2077D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51642 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgueP-0005Tc-MY
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 14:31:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38096)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jgudd-0004VG-ND
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 14:30:49 -0400
Received: from indium.canonical.com ([91.189.90.7]:58870)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jgudc-0007k5-Jo
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 14:30:49 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jgudb-0006VR-3Y
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2020 18:30:47 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 14BE72E8052
 for <qemu-devel@nongnu.org>; Thu,  4 Jun 2020 18:30:47 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2020 18:20:50 -0000
From: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <1880822@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Confirmed; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Tags: cve qemu security
X-Launchpad-Bug-Information-Type: Public Security
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: yes
X-Launchpad-Bug-Commenters: philmd pjps
X-Launchpad-Bug-Reporter: P J P (pjps)
X-Launchpad-Bug-Modifier: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9_=28philmd?=
 =?utf-8?q?=29?=
References: <159056340380.1780.3709038768569765525.malonedeb@chaenomeles.canonical.com>
Message-ID: <211a55bf-0d1b-31f4-995f-eca8608e9e6c@amsat.org>
Subject: [Bug 1880822] Re: [PATCH] hw/sd/sdcard: Verify CMD24 (Block Write)
 address is valid
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="ef9fc486e875d54078fa61cf91e898b895125d89";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 4c81a398d59f55198ca11a618dc895bfc8bd6ca2
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/04 10:55:42
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
Reply-To: Bug 1880822 <1880822@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20200604182050.ueT_1swW_TAPWUfEel21ono4I2wKACuWuZUSoNMFX40@z>

On 6/4/20 8:03 PM, Paolo Bonzini wrote:
> On 04/06/20 19:34, Philippe Mathieu-Daud=C3=A9 wrote:
>> Avoid OOB access by verifying the requested address belong to
>> the actual card size. Return ADDRESS_ERROR when not in range.
>>
>>   "SD Specifications Part 1 Physical Layer Simplified Spec. v3.01"
>>
>>   4.3.4 Data Write
>>
>>   * Block Write
>>
>>   Write command is rejected if BLOCK_LEN_ERROR or ADDRESS_ERROR
>>   occurred and no data transfer is performed.
>>
>> Fixes: CVE-2020-13253
>> Reported-by: Alexander Bulekov <alxndr@bu.edu>
>> Buglink: https://bugs.launchpad.net/qemu/+bug/1880822
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> ---
>> Cc: Prasad J Pandit <pjp@fedoraproject.org>
>> ---
>>  hw/sd/sd.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
>> index 3c06a0ac6d..0ced3b5e14 100644
>> --- a/hw/sd/sd.c
>> +++ b/hw/sd/sd.c
>> @@ -1211,6 +1211,10 @@ static sd_rsp_type_t sd_normal_command(SDState *s=
d, SDRequest req)
>>              /* Writing in SPI mode not implemented.  */
>>              if (sd->spi)
>>                  break;
>> +            if (addr >=3D sd->size) {
>> +                sd->card_status |=3D ADDRESS_ERROR;
>> +                return sd_r1;
>> +            }
>>              sd->state =3D sd_receivingdata_state;
>>              sd->data_start =3D addr;
>>              sd->data_offset =3D 0;
>>
> =

> I'm not sure if you want me to queue it, but I did.

Hmm I guess I typed "^RPrasad" in my shell to have the last git-publish
command with his email, and I didn't noticed you were also there...

Anyway looking at it again, this patch is wrong because I should check
for addr + blksize < sd_size instead. Can you drop it please?

>  Probably we should
> add qemu-block@nongnu.org to the hw/sd stanza.

OK will do.

> =

> Paolo
>

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1880822

Title:
  CVE-2020-13253 QEMU: sd: OOB access could crash the guest resulting in
  DoS

Status in QEMU:
  Confirmed

Bug description:
  An out-of-bounds read access issue was found in the SD Memory Card
  emulator of the QEMU. It occurs while performing block write commands
  via sdhci_write(), if a guest user has sent 'address' which is OOB of
  's->wp_groups'. A guest user/process may use this flaw to crash the
  QEMU process resulting in DoS.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1880822/+subscriptions

