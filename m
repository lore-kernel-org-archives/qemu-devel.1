Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 087BCC433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 08:41:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D145B20772
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 08:41:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D145B20772
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50334 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jh7vF-0001GB-5O
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 04:41:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34432)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jh7uV-0000b0-MA
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 04:41:07 -0400
Received: from indium.canonical.com ([91.189.90.7]:39388)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jh7uU-0001YT-8P
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 04:41:07 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jh7uS-0001ue-Cq
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2020 08:41:04 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 5ECD12E80E7
 for <qemu-devel@nongnu.org>; Fri,  5 Jun 2020 08:41:04 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2020 08:34:17 -0000
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
 <20200604182502.24228-1-f4bug@amsat.org>
Message-ID: <057b7d37-204f-32e1-3548-5e51def423a2@redhat.com>
Subject: [Bug 1880822] Re: [PATCH v2] hw/sd/sdcard: Verify CMD24 (Block Write)
 address is valid
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="ef9fc486e875d54078fa61cf91e898b895125d89";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: bb5f27f498167d076ea33b18cc5d177bae8c816d
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 04:10:55
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
Message-ID: <20200605083417.0PVL7aA4Tb-ZGo8aCmiGTqD2k8HPfG5yrdkt_Rd5Y0M@z>

On 6/4/20 8:25 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> Avoid OOB access by verifying the requested address belong to
> the actual card size. Return ADDRESS_ERROR when not in range.
> Only move the state machine to ReceivingData if there is no
> pending error.
> =

>   "SD Specifications Part 1 Physical Layer Simplified Spec. v3.01"
> =

>   4.3.4 Data Write
> =

>   * Block Write
> =

>   Write command is rejected if BLOCK_LEN_ERROR or ADDRESS_ERROR
>   occurred and no data transfer is performed.
> =

> Fixes: CVE-2020-13253
> Reported-by: Alexander Bulekov <alxndr@bu.edu>
> Buglink: https://bugs.launchpad.net/qemu/+bug/1880822

While the reproducer triggers the OOB via CMD24, other commands have the
same problem, so I'll post a v3.

> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
> Cc: Prasad J Pandit <pjp@fedoraproject.org>
> =

> v2: check for blksz in range, only go to sd_receivingdata_state
>     if no error.
> ---
>  hw/sd/sd.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
> =

> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index 3c06a0ac6d..2254dc7acc 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -1211,17 +1211,18 @@ static sd_rsp_type_t sd_normal_command(SDState *s=
d, SDRequest req)
>              /* Writing in SPI mode not implemented.  */
>              if (sd->spi)
>                  break;
> -            sd->state =3D sd_receivingdata_state;
> -            sd->data_start =3D addr;
> -            sd->data_offset =3D 0;
> -            sd->blk_written =3D 0;
> -
> -            if (sd->data_start + sd->blk_len > sd->size)
> +            if (addr + sd->blk_len >=3D sd->size) {
>                  sd->card_status |=3D ADDRESS_ERROR;
> -            if (sd_wp_addr(sd, sd->data_start))
> +            } else if (sd_wp_addr(sd, sd->data_start)) {
>                  sd->card_status |=3D WP_VIOLATION;
> -            if (sd->csd[14] & 0x30)
> +            } else if (sd->csd[14] & 0x30) {
>                  sd->card_status |=3D WP_VIOLATION;
> +            } else {
> +                sd->state =3D sd_receivingdata_state;
> +                sd->data_start =3D addr;
> +                sd->data_offset =3D 0;
> +                sd->blk_written =3D 0;
> +            }
>              return sd_r1;
>  =

>          default:
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

