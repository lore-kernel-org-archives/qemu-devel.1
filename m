Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9F99CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 19:57:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3C302070B
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 19:57:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GTeCqVXW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3C302070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51566 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNjF4-0004d1-QR
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 15:57:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32839)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jfreimann@redhat.com>) id 1iNjDt-0003Ij-3i
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 15:56:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jfreimann@redhat.com>) id 1iNjDq-0001J2-MH
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 15:56:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40350
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jfreimann@redhat.com>)
 id 1iNjDq-0001Ip-Ig
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 15:56:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571946997;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7UVhYNG+O0yFRXSOyLgcjBL9xBdM69MVqMjzHn8yNsw=;
 b=GTeCqVXWYl7SWU4n3YIUJAq1GLY5VTLKcu2XPcHV3fij7tcGKAx38VwTwHYLUr2BgKKOne
 Vdkux2ditMPNT7QmB/dUixkQim6OEoP/p3PXDMx8cTQsUf402F38tpr+Y/Xt9EYOVBEsFb
 Dt9a9nzHWqV3g80E/MMNgvy3fDh95PU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-329-4Eh6e_upOeqrwqfbZ3dZWQ-1; Thu, 24 Oct 2019 15:56:31 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 97186801E5C;
 Thu, 24 Oct 2019 19:56:30 +0000 (UTC)
Received: from localhost (ovpn-116-48.ams2.redhat.com [10.36.116.48])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0A7A85D9D5;
 Thu, 24 Oct 2019 19:56:21 +0000 (UTC)
Date: Thu, 24 Oct 2019 21:56:20 +0200
From: Jens Freimann <jfreimann@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH v5 02/11] pci: add option for net failover
Message-ID: <20191024195620.nerz6qcxak2k2tp6@jenstp.localdomain>
References: <20191023082711.16694-1-jfreimann@redhat.com>
 <20191023082711.16694-3-jfreimann@redhat.com>
 <20191024172227.GO2877@work-vm>
MIME-Version: 1.0
In-Reply-To: <20191024172227.GO2877@work-vm>
User-Agent: NeoMutt/20180716-1376-5d6ed1
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: 4Eh6e_upOeqrwqfbZ3dZWQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: pkrempa@redhat.com, berrange@redhat.com, ehabkost@redhat.com,
 mst@redhat.com, aadam@redhat.com, qemu-devel@nongnu.org,
 alex.williamson@redhat.com, laine@redhat.com, ailan@redhat.com,
 parav@mellanox.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Oct 24, 2019 at 06:22:27PM +0100, Dr. David Alan Gilbert wrote:
>* Jens Freimann (jfreimann@redhat.com) wrote:
>> This patch adds a net_failover_pair_id property to PCIDev which is
>> used to link the primary device in a failover pair (the PCI dev) to
>> a standby (a virtio-net-pci) device.
>>
>> It only supports ethernet devices. Also currently it only supports
>> PCIe devices. QEMU will exit with an error message otherwise.
>>
>> Signed-off-by: Jens Freimann <jfreimann@redhat.com>
>> ---
>>  hw/pci/pci.c         | 17 +++++++++++++++++
>>  include/hw/pci/pci.h |  3 +++
>>  2 files changed, 20 insertions(+)
>>
>> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
>> index aa05c2b9b2..fa9b5219f8 100644
>> --- a/hw/pci/pci.c
>> +++ b/hw/pci/pci.c
>> @@ -75,6 +75,8 @@ static Property pci_props[] =3D {
>>                      QEMU_PCIE_LNKSTA_DLLLA_BITNR, true),
>>      DEFINE_PROP_BIT("x-pcie-extcap-init", PCIDevice, cap_present,
>>                      QEMU_PCIE_EXTCAP_INIT_BITNR, true),
>> +    DEFINE_PROP_STRING("net_failover_pair_id", PCIDevice,
>> +            net_failover_pair_id),
>
>Should we just make this 'failover_pair_id' - then when someone in the
>future figures out how to make it work for something else (e.g.
>multipath block devices) then it's all good?

Yes, I see no reason why not to rename it.=20

Thanks!

regards,
Jens


