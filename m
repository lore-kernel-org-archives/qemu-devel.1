Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FEBEC3A5A1
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 23:11:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F29B2173E
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 23:11:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F29B2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48626 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0wEd-0007Gy-21
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 19:11:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53185)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1i0wD4-0005Q4-3z
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 19:09:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1i0wCz-0004ip-DF
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 19:09:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58312)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>)
 id 1i0wCz-0004hO-5V; Thu, 22 Aug 2019 19:09:33 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 60F58C049D7C;
 Thu, 22 Aug 2019 23:09:28 +0000 (UTC)
Received: from x1w.redhat.com (unknown [10.40.205.175])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 46BF519C65;
 Thu, 22 Aug 2019 23:09:27 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 23 Aug 2019 01:09:16 +0200
Message-Id: <20190822230916.576-4-philmd@redhat.com>
In-Reply-To: <20190822230916.576-1-philmd@redhat.com>
References: <20190822230916.576-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Thu, 22 Aug 2019 23:09:28 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 3/3] mailmap: Add many entries to improve 'git
 shortlog' statistics
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
Cc: qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

All of these emails have a least 1 commit with utf8/latin1 encoding
issue, or one with no author name.
When there are multiple commits, keep the author name the most used.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 .mailmap | 105 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 105 insertions(+)

diff --git a/.mailmap b/.mailmap
index e68ddd26e6..d0fc1d793c 100644
--- a/.mailmap
+++ b/.mailmap
@@ -37,5 +37,110 @@ Yongbok Kim <yongbok.kim@mips.com> <yongbok.kim@imgte=
c.com>
=20
 # Also list preferred name forms where people have changed their
 # git author config, or had utf8/latin1 encoding issues.
+Aaron Lindsay <aaron@os.amperecomputing.com>
+Alexey Gerasimenko <x1917x@gmail.com>
+Alex Ivanov <void@aleksoft.net>
+Andreas F=C3=A4rber <afaerber@suse.de>
+Bandan Das <bsd@redhat.com>
+Benjamin MARSILI <mlspirat42@gmail.com>
+Beno=C3=AEt Canet <benoit.canet@gmail.com>
+Beno=C3=AEt Canet <benoit.canet@irqsave.net>
+Beno=C3=AEt Canet <benoit.canet@nodalink.com>
+Boqun Feng <boqun.feng@gmail.com>
+Boqun Feng <boqun.feng@intel.com>
+Brad Smith <brad@comstyle.com>
+Brijesh Singh <brijesh.singh@amd.com>
+Brilly Wu <brillywu@viatech.com.cn>
+C=C3=A9dric Vincent <cedric.vincent@st.com>
+CheneyLin <linzc@zju.edu.cn>
+Chen Gang <chengang@emindsoft.com.cn>
+Chen Gang <gang.chen.5i5j@gmail.com>
+Chen Gang <gang.chen@sunrus.com.cn>
+Chen Wei-Ren <chenwj@iis.sinica.edu.tw>
+Christophe Lyon <christophe.lyon@st.com>
+Collin L. Walling <walling@linux.ibm.com>
 Daniel P. Berrang=C3=A9 <berrange@redhat.com>
+Eduardo Otubo <otubo@redhat.com>
+Fabrice Desclaux <fabrice.desclaux@cea.fr>
+Fernando Luis V=C3=A1zquez Cao <fernando_b1@lab.ntt.co.jp>
+Fernando Luis V=C3=A1zquez Cao <fernando@oss.ntt.co.jp>
+Gautham R. Shenoy <ego@in.ibm.com>
+Gautham R. Shenoy <ego@linux.vnet.ibm.com>
+Gonglei (Arei) <arei.gonglei@huawei.com>
+Guang Wang <wang.guang55@zte.com.cn>
+Hailiang Zhang <zhang.zhanghailiang@huawei.com>
+Herv=C3=A9 Poussineau <hpoussin@reactos.org>
+Jakub Jerm=C3=A1=C5=99 <jakub@jermar.eu>
+Jakub Jerm=C3=A1=C5=99 <jakub.jermar@kernkonzept.com>
+Jean-Christophe Dubois <jcd@tribudubois.net>
+Jind=C5=99ich Makovi=C4=8Dka <makovick@gmail.com>
+John Arbuckle <programmingkidx@gmail.com>
+Juha Riihim=C3=A4ki <juha.riihimaki@nokia.com>
+Juha Riihim=C3=A4ki <Juha.Riihimaki@nokia.com>
+Jun Li <junmuzi@gmail.com>
+Laurent Vivier <Laurent@lvivier.info>
+Leandro Lupori <leandro.lupori@gmail.com>
+Li Guang <lig.fnst@cn.fujitsu.com>
+Liming Wang <walimisdev@gmail.com>
+linzhecheng <linzc@zju.edu.cn>
+Liran Schour <lirans@il.ibm.com>
+Liu Yu <yu.liu@freescale.com>
+Liu Yu <Yu.Liu@freescale.com>
+Li Zhang <zhlcindy@gmail.com>
+Li Zhang <zhlcindy@linux.vnet.ibm.com>
+Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
+Llu=C3=ADs Vilanova <xscript@gmx.net>
+Longpeng (Mike) <longpeng2@huawei.com>
+Luc Michel <luc.michel@git.antfield.fr>
+Luc Michel <luc.michel@greensocs.com>
+Marc Mar=C3=AD <marc.mari.barcelo@gmail.com>
+Marc Mar=C3=AD <markmb@redhat.com>
+Michael Avdienko <whitearchey@gmail.com>
+Michael S. Tsirkin <mst@redhat.com>
+Munkyu Im <munkyu.im@samsung.com>
+Nicholas Bellinger <nab@linux-iscsi.org>
+Nicholas Thomas <nick@bytemark.co.uk>
+Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
+Orit Wasserman <owasserm@redhat.com>
+Paolo Bonzini <pbonzini@redhat.com>
+Pavel Dovgaluk <dovgaluk@ispras.ru>
+Pavel Dovgaluk <pavel.dovgaluk@gmail.com>
+Pavel Dovgaluk <Pavel.Dovgaluk@ispras.ru>
+Peter Crosthwaite <crosthwaite.peter@gmail.com>
+Peter Crosthwaite <peter.crosthwaite@petalogix.com>
+Peter Crosthwaite <peter.crosthwaite@xilinx.com>
+Prasad J Pandit <pjp@fedoraproject.org>
+Prasad J Pandit <ppandit@redhat.com>
+Qiao Nuohan <qiaonuohan@cn.fujitsu.com>
 Reimar D=C3=B6ffinger <Reimar.Doeffinger@gmx.de>
+Remy Noel <remy.noel@blade-group.com>
+Roger Pau Monn=C3=A9 <roger.pau@citrix.com>
+Shin'ichiro Kawasaki <kawasaki@juno.dti.ne.jp>
+Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
+Sochin Jiang <sochin.jiang@huawei.com>
+Takashi Yoshii <takasi-y@ops.dti.ne.jp>
+Thomas Huth <thuth@redhat.com>
+Thomas Knych <thomaswk@google.com>
+Timothy Baldwin <T.E.Baldwin99@members.leeds.ac.uk>
+Tony Nguyen <tony.nguyen@bt.com>
+Venkateswararao Jujjuri <jvrao@linux.vnet.ibm.com>
+Vibi Sreenivasan <vibi_sreenivasan@cms.com>
+Vijaya Kumar K <vijayak@cavium.com>
+Vijaya Kumar K <Vijaya.Kumar@cavium.com>
+Vijay Kumar <vijaykumar@bravegnu.org>
+Vijay Kumar <vijaykumar@zilogic.com>
+Wang Guang <wang.guang55@zte.com.cn>
+Wenchao Xia <xiawenc@linux.vnet.ibm.com>
+Wenshuang Ma <kevinnma@tencent.com>
+Xiaoqiang Zhao <zxq_yx_007@163.com>
+Xinhua Cao <caoxinhua@huawei.com>
+Xiong Zhang <xiong.y.zhang@intel.com>
+Yin Yin <yin.yin@cs2c.com.cn>
+yuchenlin <npes87184@gmail.com>
+YunQiang Su <syq@debian.org>
+YunQiang Su <ysu@wavecomp.com>
+Yuri Pudgorodskiy <yur@virtuozzo.com>
+Zhengui Li <lizhengui@huawei.com>
+Zhenwei Pi <pizhenwei@bytedance.com>
+Zhenwei Pi <zhenwei.pi@youruncloud.com>
+Zhuang Yanying <ann.zhuangyanying@huawei.com>
--=20
2.20.1


