Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F11DC43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 09:34:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECFFF2073E
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 09:34:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="F6JlYzTi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECFFF2073E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHOuI-0002pH-0n
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 05:34:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46445)
 by lists.gnu.org with esmtp (Exim 4.90_1) (envelope-from
 <BATV+f73da832ea8226d6223e+6059+infradead.org+hch@bombadil.srs.infradead.org>)
 id 1jHOtT-0002PU-Ad
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 05:33:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from
 <BATV+f73da832ea8226d6223e+6059+infradead.org+hch@bombadil.srs.infradead.org>)
 id 1jHOtS-0005cm-Br
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 05:33:43 -0400
Received: from bombadil.infradead.org ([2607:7c80:54:e::133]:48662)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from
 <BATV+f73da832ea8226d6223e+6059+infradead.org+hch@bombadil.srs.infradead.org>)
 id 1jHOtR-0005W7-S2
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 05:33:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=D7iUfyyuqm+dw4598KbpWIu+GERU4Vqzux8/iRw3Pco=; b=F6JlYzTiE+9B++gXkAJKN3WCxV
 xWwamyGhjsFIpTTEiZN042yCZfOx7/WEBR+9I4WHpGyGUs0oazlAvy9UJ4SmSW35mN3rfl2IA3lfR
 Niw5LZyeb2oojAHa0fYTjZEAWUqqOayoJPg8jTMXN3Px173WZEwiNsjQdhyl6CRIWTw/NoSVBLv84
 DHTNLHasfYNNfophQ+se8/udStYa7K/hpOWKIBIA7h8D6BgoUVWf79Pft/YBAUMBtE89HdJBXH2N/
 ajqcfx5Gc0BmlcoU2M4eD0w2EXPaBKcA3kGZuqwb8iZCnK4sZZqDIho14z/yBpzbzcBpx94aF0xpy
 iyedccrA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1jHOsw-0003Fy-SL; Thu, 26 Mar 2020 09:33:10 +0000
Date: Thu, 26 Mar 2020 02:33:10 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Kirti Wankhede <kwankhede@nvidia.com>
Subject: Re: [PATCH v15 Kernel 1/7] vfio: KABI for migration interface for
 device state
Message-ID: <20200326093310.GA12078@infradead.org>
References: <1584649004-8285-1-git-send-email-kwankhede@nvidia.com>
 <1584649004-8285-2-git-send-email-kwankhede@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1584649004-8285-2-git-send-email-kwankhede@nvidia.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:7c80:54:e::133
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

s/KABI/UAPI/ in the subject and anywhere else in the series.

Please avoid __packed__ structures and just properly pad them, they
have a major performance impact on some platforms and will cause
compiler warnings when taking addresses of members.

