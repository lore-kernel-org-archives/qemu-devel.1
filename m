Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 501AAC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 09:19:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1ED592084C
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 09:19:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1ED592084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdsDF-0000pN-AT
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 05:19:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40540)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <piaojun@huawei.com>)
 id 1jdsCd-0000Ov-Nw
 for qemu-devel@nongnu.org; Wed, 27 May 2020 05:18:23 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:51570 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <piaojun@huawei.com>)
 id 1jdsCb-0000Ox-SS
 for qemu-devel@nongnu.org; Wed, 27 May 2020 05:18:23 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 2E40B632DF8A871E3C58;
 Wed, 27 May 2020 17:18:07 +0800 (CST)
Received: from [10.174.149.79] (10.174.149.79) by smtp.huawei.com
 (10.3.19.212) with Microsoft SMTP Server (TLS) id 14.3.487.0; Wed, 27 May
 2020 17:18:04 +0800
To: <marcandre.lureau@redhat.com>
From: Jun Piao <piaojun@huawei.com>
Subject: [QUESTION]: vhost-user-gpu: Unable to find a satisfying vhost-user-gpu
Message-ID: <f176ccff-4988-8ba0-e3db-d859cde0db20@huawei.com>
Date: Wed, 27 May 2020 17:18:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.149.79]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.32; envelope-from=piaojun@huawei.com;
 helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/27 05:18:07
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Marc-Andr¨¦,

I encounter a problem when trying to use vhost-user-gpu as below. And
I'm not familiar to the libvirt code. Could you please help find out
the reason?

# virsh create snap1.xml
error: Failed to create domain from snap1.xml
error: operation failed: Unable to find a satisfying vhost-user-gpu

qemu-4.1.1:
  # ./vhost-user-gpu -v -s /home/vgpu.sock -r /dev/dri/renderD128

libvirt-5.8.0:
    <graphics type='spice' port='5901' tlsPort='5903' autoport='yes'>
      <listen type='socket' socket='/tmp/spice.socket1'/>
      <gl enable='yes' rendernode='/dev/dri/renderD128'/>
    </graphics>
    <video model='virtio'>
      <driver name='vhostuser'/>
      <acceleration accel3d='yes' rendernode='/dev/dri/renderD128'/>
    </video>

thanks,
Jun

