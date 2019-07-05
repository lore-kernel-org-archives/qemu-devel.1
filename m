Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D89BC46499
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 15:09:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B33D216E3
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 15:09:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G2eYhLPg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B33D216E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54052 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjPpl-0001WU-Hi
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 11:09:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57261)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <zhangfei.gao@gmail.com>) id 1hjPne-0000Mn-HV
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 11:06:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhangfei.gao@gmail.com>) id 1hjPnb-0007EN-Jj
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 11:06:57 -0400
Received: from mail-io1-xd31.google.com ([2607:f8b0:4864:20::d31]:44354)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <zhangfei.gao@gmail.com>)
 id 1hjPnW-0006La-Ix; Fri, 05 Jul 2019 11:06:50 -0400
Received: by mail-io1-xd31.google.com with SMTP id s7so19728402iob.11;
 Fri, 05 Jul 2019 08:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=fS1XqJWqVjRHcta7KHWeyMOfnXXwi8tdMareZxThb2I=;
 b=G2eYhLPgxZ8gGuHfFBPNItxk3ckhVoGlJ51smvVYmMlSctLNv8md9m9/faVpp+3sWn
 G7dsjXrcvnbGqyokCPTI8G56y2jSPwPfbx6JhsKmugaAoFu8u7Mo6+z0Ug+eBiChuQSE
 StatRFk+eVzxi5ZwobOVJJqNPnYRJvZeyY0dZaMx+gaW7QhAmaaQsT1jPH991/6cFysu
 qRazaxALmdsc9CBB4ZoYzmKAk0NahRxa3vJufbrt590956SITCDn3/vksom3z/LmHa8M
 vZRgQ3d8UVEVNo+B+E2NYBPRmiJX4LiMthNPfDQs8KfllIojx09iMLJ798jRIMydvmCY
 U8fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=fS1XqJWqVjRHcta7KHWeyMOfnXXwi8tdMareZxThb2I=;
 b=WGToXfCV4WrEvJ0IQHc3hcFF1GkeIEvCV0fzydsZ8WPdyKCN2ecv4QTzPX6R1y0uBP
 s3hzRM4cUQF0KEM/pFxfOcLK/mqjnOS//ti0g9gPaPN/O/Eg4tQE7803C42r1Uh6v9HA
 jqhVVe4ShK40FTIpdtfi2Zw9wAGTeCFHlMPMNQzwlly2aP4CjRyMpWpdoiXskDmyLH50
 7yhF07/R8FRRnxAsx4ehaCbqCqKhnzU1Evqy6D+sK/5zbXONgGfx5BL1zmxbOi5dx9gZ
 9MlRVg5vf0CzYjV4fVSDTjIf+gN681qwD7VpTd4gBxptOP8ffgOqd853OqAgVgEBzZ4C
 42Ig==
X-Gm-Message-State: APjAAAUtn4t732ZF+7lZP5v7wJuBbW6dJ2KyIeeFil2IHn2WwHy7MUyR
 y2jjM8sqYfuF7qeK5W6iw/gtlIEAVhO8RvgzphM=
X-Google-Smtp-Source: APXvYqyAhU8uQUD0zm8QvqxqZs0SRUUp1heVVDsogqbZfq13jDT93MpGfVhB9jNJBtA6PQU3xc1YLYgevg/o4Oiho5s=
X-Received: by 2002:a5e:c207:: with SMTP id v7mr4795904iop.163.1562339202985; 
 Fri, 05 Jul 2019 08:06:42 -0700 (PDT)
MIME-Version: 1.0
References: <20181122171538.12359-1-eric.auger@redhat.com>
 <VI1PR04MB48456BBF709F364C8E9B08269AD00@VI1PR04MB4845.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB48456BBF709F364C8E9B08269AD00@VI1PR04MB4845.eurprd04.prod.outlook.com>
From: Zhangfei Gao <zhangfei.gao@gmail.com>
Date: Fri, 5 Jul 2019 23:06:31 +0800
Message-ID: <CAMj5BkhwpP0GMkZ2Cp2aQBAQvNzZYZuTz_4wzwGKhW4F_5OQcw@mail.gmail.com>
To: Bharat Bhushan <bharat.bhushan@nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d31
Subject: Re: [Qemu-devel] [RFC v9 00/17] VIRTIO-IOMMU device
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
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "mst@redhat.com" <mst@redhat.com>,
 "jean-philippe.brucker@arm.com" <jean-philippe.brucker@arm.com>,
 "tn@semihalf.com" <tn@semihalf.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "peterx@redhat.com" <peterx@redhat.com>, Eric Auger <eric.auger@redhat.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi, Bharat

On Tue, Nov 27, 2018 at 3:12 PM Bharat Bhushan <bharat.bhushan@nxp.com> wrote:

> > Testing:
> > - tested with guest using virtio-net-pci
> >   (,vhost=off,iommu_platform,disable-modern=off,disable-legacy=on)
> >   and virtio-blk-pci
> > - VFIO/VHOST integration is not part of this series
> > - When using the virtio-blk-pci, some EDK2 FW versions feature
> >   unmapped transactions and in that case the guest fails to boot.
>
> I have tested this series with virtio and VFIO both
> Tested-by: Bharat Bhushan <bharat.bhushan@nxp.com>
>

Would you mind pasting the qemu test command.
A bit confused about testing vfio, virtio-iommu-pci has no "host" property.
Do we need unbind pf and bind the device to vfio-pci first,

Thanks

