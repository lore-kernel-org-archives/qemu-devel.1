Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF4E6CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 09:42:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C21721D71
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 09:42:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pe4FecKH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C21721D71
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58090 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNw7E-0004JT-PK
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 05:42:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59062)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jasowang@redhat.com>) id 1iNw69-0003NM-VI
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 05:41:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1iNw67-0007y2-Kt
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 05:41:32 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:22171
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1iNw67-0007xd-Cv
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 05:41:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571996489;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AR8l0CtDEsL1TcfTMDVhr5kGYCkEqpmvWVMWu1qXp0Q=;
 b=Pe4FecKHCi9x5s1vNBXpJ227IjVOusk/f5iqZVc8gn3+3zXl/cdr5klgDLEJDKqvU8fSPI
 vjI7HLjb3OLZYDKCAhs6iCbpZ4cyw6bhCiWtT481yVGiRRBl/0lQ1XcMWVWlffoQddDNuB
 Kw1lCmMT55UKUj3QXCi2de471EbuTrU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-173-eTng1RRaOE-8b2lwhIg5Mw-1; Fri, 25 Oct 2019 05:41:25 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A73F61005509;
 Fri, 25 Oct 2019 09:41:24 +0000 (UTC)
Received: from [10.72.12.249] (ovpn-12-249.pek2.redhat.com [10.72.12.249])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 887845DAAF;
 Fri, 25 Oct 2019 09:41:20 +0000 (UTC)
Subject: Re: [PATCH v3] net: add tulip (dec21143) driver
To: Sven Schnelle <svens@stackframe.org>
References: <20191023084244.25244-1-svens@stackframe.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <e9cb2359-d5d3-314b-8e4e-eccd88f04ccc@redhat.com>
Date: Fri, 25 Oct 2019 17:41:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191023084244.25244-1-svens@stackframe.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: eTng1RRaOE-8b2lwhIg5Mw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2019/10/23 =E4=B8=8B=E5=8D=884:42, Sven Schnelle wrote:
> This adds the basic functionality to emulate a Tulip NIC.
>
> Implemented are:
>
> - RX and TX functionality
> - Perfect Frame Filtering
> - Big/Little Endian descriptor support
> - 93C46 EEPROM support
> - LXT970 PHY
>
> Not implemented, mostly because i had no OS using these functions:
>
> - Imperfect frame filtering
> - General Purpose Timer
> - Transmit automatic polling
> - Boot ROM support
> - SIA interface
> - Big/Little Endian data buffer conversion
>
> Successfully tested with the following Operating Systems:
>
> - MSDOS with Microsoft Network Client 3.0 and DEC ODI drivers
> - HPPA Linux
> - Windows XP
> - HP-UX
>
> Signed-off-by: Sven Schnelle<svens@stackframe.org>
> Message-Id:<20191022155413.4619-1-svens@stackframe.org>
> Reviewed-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>
> Changes in v3:
>   - fix whitespace
>   - fix format string in read/write functions
>
> Changes in v2:
>   - changed tulip_desc_{read,write} to take a struct descriptor *
>     and no longer use a single pci DMA write, instead write one
>     struct member at a time.
>   - fix _tulip_receive function name
>   - fix reset function and provide tulip_qdev_reset() for dc->reset.
>   - no longer write registers in the default case in tulip_write()
>   - set .impl.min_access_size and .impl.max_access_size
>
>   MAINTAINERS              |    6 +
>   hw/net/Kconfig           |    5 +
>   hw/net/Makefile.objs     |    1 +
>   hw/net/trace-events      |   14 +
>   hw/net/tulip.c           | 1029 ++++++++++++++++++++++++++++++++++++++
>   hw/net/tulip.h           |  267 ++++++++++
>   include/hw/pci/pci_ids.h |    1 +
>   7 files changed, 1323 insertions(+)
>   create mode 100644 hw/net/tulip.c
>   create mode 100644 hw/net/tulip.h
>
> diff --git a/MAINTAINERS b/MAINTAINERS


Applied.

Thanks


