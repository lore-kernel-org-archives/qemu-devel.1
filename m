Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0579BC1975A
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 02:48:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5C2920724
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 02:48:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OO5oIh9L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5C2920724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44518 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEOlI-0004KG-15
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 22:48:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45205)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jasowang@redhat.com>) id 1jEOkP-0003vc-CD
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 22:47:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1jEOkN-0006WT-VD
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 22:47:56 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:53691)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1jEOkN-0006JU-N3
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 22:47:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584499674;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1Q2jyhD6kwVMqb2D1Fz+579YSYinOjPpmTN3CTrHDVk=;
 b=OO5oIh9Lf2WBHBVS7EzAqHF9DUnKOCgvhOVJh5paAhgNp62z/98t138ISqqpRhM0+ylSQL
 Ahw6ig/8yWIfNwaJZM7ue81gVURWpnhtn1Buts1bLfUTGNwvzcCO+qNiwTa/ep9snZggxd
 zRTeS4Sa+WKL6fWv+X+KWICQJXaiRjI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-48-s48uDvz6MSyMGL8TXL-FBw-1; Tue, 17 Mar 2020 22:47:53 -0400
X-MC-Unique: s48uDvz6MSyMGL8TXL-FBw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 222661083E81;
 Wed, 18 Mar 2020 02:47:52 +0000 (UTC)
Received: from [10.72.13.166] (ovpn-13-166.pek2.redhat.com [10.72.13.166])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 40AD75C241;
 Wed, 18 Mar 2020 02:47:49 +0000 (UTC)
Subject: Re: [PATCH 0/2] net/colo-compare.c: Expose more COLO internal
To: "Zhang, Chen" <chen.zhang@intel.com>, qemu-dev <qemu-devel@nongnu.org>
References: <20200223205805.26412-1-chen.zhang@intel.com>
 <16d27cc5e749412ebfff71cdb0de1e34@intel.com>
 <151064153931455a89ed47c03bbb54a9@intel.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <6f05b6a2-cd63-e0a0-f24e-f99a2f1a9f02@redhat.com>
Date: Wed, 18 Mar 2020 10:47:48 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <151064153931455a89ed47c03bbb54a9@intel.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Daniel Cho <danielcho@qnap.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Zhang Chen <zhangckid@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/3/17 =E4=B8=8B=E5=8D=884:25, Zhang, Chen wrote:
> Hi Jason,
>
> No news for a while.
> Please review this series when you have time.
>
> Thanks
> Zhang Chen


Sorry for the delay.

Patch looks good to me.

But it can not be applied cleanly on master.

Please rebase and send V2 (btw, I notice some typos in the commit log,=20
please try to fix them as well).

Thanks


