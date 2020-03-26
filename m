Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 882D0C43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 21:41:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48E3B20658
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 21:41:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="ldni9GAu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48E3B20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60974 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHaGD-00088G-AG
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 17:41:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34704)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwankhede@nvidia.com>) id 1jHaEm-0006GW-Tp
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 17:40:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwankhede@nvidia.com>) id 1jHaEl-0004Yt-Op
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 17:40:28 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:14567)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwankhede@nvidia.com>)
 id 1jHaEl-0004W2-HU
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 17:40:27 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5e7d20ed0000>; Thu, 26 Mar 2020 14:38:53 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate102.nvidia.com (PGP Universal service);
 Thu, 26 Mar 2020 14:40:25 -0700
X-PGP-Universal: processed;
 by hqpgpgate102.nvidia.com on Thu, 26 Mar 2020 14:40:25 -0700
Received: from [10.40.103.35] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 26 Mar
 2020 21:40:06 +0000
Subject: Re: [PATCH v15 Kernel 1/7] vfio: KABI for migration interface for
 device state
To: Christoph Hellwig <hch@infradead.org>
References: <1584649004-8285-1-git-send-email-kwankhede@nvidia.com>
 <1584649004-8285-2-git-send-email-kwankhede@nvidia.com>
 <20200326093310.GA12078@infradead.org>
X-Nvconfidentiality: public
From: Kirti Wankhede <kwankhede@nvidia.com>
Message-ID: <d7918318-ff3a-04dd-9c80-41098a777f7f@nvidia.com>
Date: Fri, 27 Mar 2020 03:09:58 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200326093310.GA12078@infradead.org>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1585258733; bh=V2c3guzclP/omsTo+UqpgNGxiLDtiViGM07WNO9Zcys=;
 h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
 Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
 X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=ldni9GAu9CbAvCrWziJ8CzSJk+U86sz4bwGpQvmyqOHvJQ9MzMzSxOE3II/5GObw/
 igHgkh1yJKEcd6kGWWWtk1lMiW12cPWZmwDW2jRRQIfKxhsxJC91T2yZ8tizT12Pao
 JIpkNisz89X1cQUVGlkYD0FegHNW7ofz+PqfCKmZU5o1wIMEmxDYeUVqiBDb8ENL5y
 phQFm5EjSrlfr0B4VpsRhJswhp+EbSUhCbmGsPINByOHlE0+CTvkln8xzBkMs+7gE/
 L+1IWx9rNwud1axYuxWeOdc5/t26RxR5hOGcN1Pkf0vzdEhe5wDEZX1MQmrEn/JlsN
 bR63XL6Cbjfww==
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 216.228.121.143
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
Cc: cjia@nvidia.com, kvm@vger.kernel.org, aik@ozlabs.ru,
 Zhengxiao.zx@alibaba-inc.com, shuangtai.tst@alibaba-inc.com,
 qemu-devel@nongnu.org, eauger@redhat.com, yi.l.liu@intel.com,
 eskultet@redhat.com, ziye.yang@intel.com, mlevitsk@redhat.com,
 pasic@linux.ibm.com, felipe@nutanix.com, zhi.a.wang@intel.com,
 kevin.tian@intel.com, yan.y.zhao@intel.com, dgilbert@redhat.com,
 alex.williamson@redhat.com, changpeng.liu@intel.com, cohuck@redhat.com,
 Ken.Xue@amd.com, jonathan.davies@nutanix.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 3/26/2020 3:03 PM, Christoph Hellwig wrote:
> s/KABI/UAPI/ in the subject and anywhere else in the series.
> 

Ok.

> Please avoid __packed__ structures and just properly pad them, they
> have a major performance impact on some platforms and will cause
> compiler warnings when taking addresses of members.
> 

Yes, removing it.

Thanks,
Kirti

