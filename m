Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B08BC7618B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 10:26:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5180E229F9
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 10:26:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5180E229F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38088 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqxQo-0007yL-JB
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 06:26:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59831)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jasowang@redhat.com>) id 1hqxQa-0007Yx-Ev
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 06:26:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1hqxQW-0000hm-FU
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 06:26:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57468)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1hqxQV-0000Oz-SN
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 06:26:16 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C074281F18;
 Fri, 26 Jul 2019 10:26:11 +0000 (UTC)
Received: from [10.72.12.238] (ovpn-12-238.pek2.redhat.com [10.72.12.238])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DF0C460A35;
 Fri, 26 Jul 2019 10:26:09 +0000 (UTC)
To: P J P <ppandit@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
References: <20190723104754.29324-1-ppandit@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <ee8f8b24-bc60-293b-e458-f598361612ea@redhat.com>
Date: Fri, 26 Jul 2019 18:26:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190723104754.29324-1-ppandit@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Fri, 26 Jul 2019 10:26:11 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v4 0/3] restrict bridge interface name to
 IFNAMSIZ
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
Cc: Li Qiang <liq3ea@gmail.com>,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Prasad J Pandit <pjp@fedoraproject.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2019/7/23 =E4=B8=8B=E5=8D=886:47, P J P wrote:
> From: Prasad J Pandit <pjp@fedoraproject.org>
>
> Hello,
>
> Linux net_deivce defines network interface name to be of IFNAMSIZE(=3D1=
6)
> bytes, including the terminating null('\0') byte.
>
> Qemu tap deivce, while invoking 'qemu-bridge-helper' tool to set up the
> network bridge interface, supplies bridge name of 16 characters, thus
> allowing to create an ACL bypass scenario.
>
> This patch series attempts to fix it. It also updates bridge helper
> invocation routine 'net_bridge_run_helper' to avoid snprintf() calls.
>
> Thank you.
> --
> Prasad J Pandit (3):
>    qemu-bridge-helper: restrict interface name to IFNAMSIZ
>    qemu-bridge-helper: move repeating code in parse_acl_file
>    net: tap: replace snprintf with g_strdup_printf calls
>
>   net/tap.c            | 19 +++++++++++--------
>   qemu-bridge-helper.c | 24 +++++++++++++++++-------
>   2 files changed, 28 insertions(+), 15 deletions(-)
>

Applied.

Thanks


