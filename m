Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E7CEC433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 22:14:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEBE6205CB
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 22:14:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEBE6205CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43618 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgbeC-0005bY-5C
	for qemu-devel@archiver.kernel.org; Wed, 03 Jun 2020 18:14:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51856)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jgbdO-0004rR-L8
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 18:13:18 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:57300)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jgbdM-0003jI-EV
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 18:13:17 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id AB738745712;
 Thu,  4 Jun 2020 00:13:12 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 89A86745702; Thu,  4 Jun 2020 00:13:12 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 883E97456F8;
 Thu,  4 Jun 2020 00:13:12 +0200 (CEST)
Date: Thu, 4 Jun 2020 00:13:12 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: P J P <ppandit@redhat.com>
Subject: Re: [PATCH v2 2/2] pci: ensure configuration access is within bounds
In-Reply-To: <20200603202251.1199170-3-ppandit@redhat.com>
Message-ID: <alpine.BSF.2.22.395.2006040006520.56892@zero.eik.bme.hu>
References: <20200603202251.1199170-1-ppandit@redhat.com>
 <20200603202251.1199170-3-ppandit@redhat.com>
User-Agent: Alpine 2.22 (BSF 395 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-535343286-1591222392=:56892"
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: =?ISO-8859-15?Q?Daniel_P_=2E_Berrang=E9?= <berrange@redhat.com>,
 Prasad J Pandit <pjp@fedoraproject.org>,
 "Michael S . Tsirkin" <mst@redhat.com>, Yi Ren <c4tren@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Ren Ding <rding@gatech.edu>,
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>,
 Hanqing Zhao <hanqing@gatech.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-535343286-1591222392=:56892
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Thu, 4 Jun 2020, P J P wrote:
> From: Prasad J Pandit <pjp@fedoraproject.org>
>
> While reading PCI configuration bytes, a guest may send an
> address towards the end of the configuration space. It may lead
> to an OOB access issue. Assert that 'address + len' is within
> PCI configuration space.
>
> Suggested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> ---
> hw/pci/pci.c | 2 ++
> 1 file changed, 2 insertions(+)
>
> Update v2: assert PCI configuration access is within bounds
>  -> https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg00711.html
>
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index 70c66965f5..173bec4fd5 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -1381,6 +1381,8 @@ uint32_t pci_default_read_config(PCIDevice *d,
> {
>     uint32_t val = 0;
>
> +    assert(address + len <= pci_config_size(d));

Does this allow guest now to crash QEMU? I think it was suggested that 
assert should only be used for cases that can only arise from a 
programming error and not from values set by the guest. If this is 
considered to be an error now to call this function with wrong parameters 
did you check other callers? I've found a few such as:

hw/scsi/esp-pci.c
hw/watchdog/wdt_i6300esb.c
hw/ide/cmd646.c
hw/vfio/pci.c

and maybe others. Would it be better to not crash just log invalid access 
and either fix up parameters or return some garbage like 0?

Regards,
BALATON Zoltan

> +
>     if (pci_is_express_downstream_port(d) &&
>         ranges_overlap(address, len, d->exp.exp_cap + PCI_EXP_LNKSTA, 2)) {
>         pcie_sync_bridge_lnk(d);
>
--3866299591-535343286-1591222392=:56892--

