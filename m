Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95A3DCA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 10:14:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D58920663
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 10:14:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SSsxOo6T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D58920663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37828 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNa8N-00061A-PT
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 06:14:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47981)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jfreimann@redhat.com>) id 1iNZZO-0007HX-T5
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 05:38:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jfreimann@redhat.com>) id 1iNZZM-00086X-4D
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 05:38:13 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58076
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jfreimann@redhat.com>)
 id 1iNZZL-00086D-SL
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 05:38:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571909890;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qoYg8aW/8GT/o56ZF+k+AWWe95z0Ge4KBU63fAuKvEg=;
 b=SSsxOo6TwPhy1SV07VkYxIVt4AmrcyYlsHnFw3hh13JIdgQ9jA/bqIseQ7f5Cg++VVNbWw
 S5cTKNFY2dflw34D/akRBTSMF9ieQp9dP9rYxZhfwX8MNf/G6vRd9AJfZu8wIMWQ/M9jKd
 iyt0jzqfeIrN4ycXvYxQwILYWNOYgis=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-336-XjaFGWkhPHadqLJYxG9WgA-1; Thu, 24 Oct 2019 05:38:04 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CAADE800D49;
 Thu, 24 Oct 2019 09:38:03 +0000 (UTC)
Received: from localhost (ovpn-116-210.ams2.redhat.com [10.36.116.210])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BBA1860624;
 Thu, 24 Oct 2019 09:37:55 +0000 (UTC)
Date: Thu, 24 Oct 2019 11:37:54 +0200
From: Jens Freimann <jfreimann@redhat.com>
To: Parav Pandit <parav@mellanox.com>
Subject: Re: [PATCH v5 02/11] pci: add option for net failover
Message-ID: <20191024093754.tgdd7cp5riwcsytc@jenstp.localdomain>
References: <20191023082711.16694-1-jfreimann@redhat.com>
 <20191023082711.16694-3-jfreimann@redhat.com>
 <AM0PR05MB486628D14AE740F3843CA236D16A0@AM0PR05MB4866.eurprd05.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <AM0PR05MB486628D14AE740F3843CA236D16A0@AM0PR05MB4866.eurprd05.prod.outlook.com>
User-Agent: NeoMutt/20180716-1376-5d6ed1
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: XjaFGWkhPHadqLJYxG9WgA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: "pkrempa@redhat.com" <pkrempa@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "aadam@redhat.com" <aadam@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "laine@redhat.com" <laine@redhat.com>, "ailan@redhat.com" <ailan@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Oct 24, 2019 at 05:03:46AM +0000, Parav Pandit wrote:
>> @@ -2101,6 +2104,20 @@ static void pci_qdev_realize(DeviceState *qdev,
>> Error **errp)
>>          }
>>      }
>>
>> +    if (pci_dev->net_failover_pair_id) {
>> +        if (!pci_is_express(pci_dev)) {
>
>I am testing and integrating this piece with mlx5 devices.
>I see that pci_is_express() return true only for first PCI function.
>Didn't yet dig the API.
>Commenting out this check and below class check progresses further.

First of all, thanks for testing this!
Could you share your commandline please? I can't reproduce it.
>
>While reviewing, I realized that we shouldn't have this check for below re=
asons.
>
>1. It is user's responsibility to pass networking device.
>But its ok to check the class, if PCI Device is passed.
>So class comparison should be inside the pci_check().

I'm not sure I understand this point, could you please elaborate?
You're suggesting to move the check for the class into the check for
pci_is_express?

>2. It is limiting to only consider PCI devices.
>Automated and regression tests should be able validate this feature withou=
t PCI Device.
>This will enhance the stability of feature in long run.
>
>3. net failover driver doesn't limit it to have it over only PCI device.
>So similarly hypervisor should be limiting.

I agree that we don't have to limit it to PCI(e) forever. But for this
first shot I think we should and then extend it continually. There are
more things we can support in the future like other hotplug types etc.

regards,
Jens =20


