Return-Path: <SRS0=bgql=3H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F4EFC33CB1
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2020 14:33:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C7432469A
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2020 14:33:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D1JUd6IP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C7432469A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40874 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isp9r-0005gE-0U
	for qemu-devel@archiver.kernel.org; Sat, 18 Jan 2020 09:33:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47993)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1isp96-0005ED-DR
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 09:32:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1isp92-0007dO-N5
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 09:32:15 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21249
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1isp92-0007cR-JW
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 09:32:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579357931;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=leH5PFjtgnyrCU8Sr/mNN2FRMr3J4q0bmvC03UZKDuc=;
 b=D1JUd6IPg5BumsFC4sS3lg8xcvO3gkiGng/dfRtPfj04uXu6skSoXls55F3vOiHDJ9DJHk
 oFWyCwOGrKLCoV6N9zDgDPvf8Vcxh7woDDFQngvj54ZjoWr3pJ6YZ3jal5w8CY6o3akjyf
 BBijag6qvY4iDtsI4HJaZAfhaqA49MI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-254-FuUjBDJRPg21h6O5ygdnnQ-1; Sat, 18 Jan 2020 09:32:10 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 07062800D41;
 Sat, 18 Jan 2020 14:32:09 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-59.brq.redhat.com [10.40.204.59])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7EBBA5C1D4;
 Sat, 18 Jan 2020 14:32:04 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2] mailmap: Add more entries to sanitize 'git log' output
Date: Sat, 18 Jan 2020 15:32:02 +0100
Message-Id: <20200118143202.29187-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: FuUjBDJRPg21h6O5ygdnnQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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
Cc: qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Marek Dolata <mkdolata@us.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Most of these developers have the Signed-off-by tag properly
written, but not the author/committer name. Fix this.
Also we incorrectly wrote Arei Gonglei name, update and reorder.

The committer name/email is displayed when using:

  $ git log --format=3Dfuller

(which can be set in git-config setting format.pretty=3Dfuller).

Example of commits with miswritten committer email:
  3b08098b40 76349f5ba8 eb83c2030a 572992eefa 0d4abda8f7

Note: git-log does not use this file by default until you specify
the --use-mailmap flag:

  $ git log --use-mailmap

Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
v2:
- Added Marek Dolata (commit 5a07192a0)
- Describe git-log --format=3Dfuller
- Added Markus R-b
---
 .mailmap | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index 3816e4effe..cf981a3ec0 100644
--- a/.mailmap
+++ b/.mailmap
@@ -56,6 +56,10 @@ Aaron Lindsay <aaron@os.amperecomputing.com>
 Alexey Gerasimenko <x1917x@gmail.com>
 Alex Ivanov <void@aleksoft.net>
 Andreas F=C3=A4rber <afaerber@suse.de>
+Andreas F=C3=A4rber <andreas.faerber@web.de>
+Andreas F=C3=A4rber <andreas.faerber@web.de> <andreas.faerber>
+Arei Gonglei <arei.gonglei@huawei.com>
+Arei Gonglei <arei.gonglei@huawei.com> <root@ceth6.(none)>
 Bandan Das <bsd@redhat.com>
 Benjamin MARSILI <mlspirat42@gmail.com>
 Beno=C3=AEt Canet <benoit.canet@gmail.com>
@@ -67,27 +71,36 @@ Brad Smith <brad@comstyle.com>
 Brijesh Singh <brijesh.singh@amd.com>
 Brilly Wu <brillywu@viatech.com.cn>
 C=C3=A9dric Vincent <cedric.vincent@st.com>
+Chai Wen <chaiw.fnst@cn.fujitsu.com>
+Chaojian Hu <chaojianhu@hotmail.com>
 CheneyLin <linzc@zju.edu.cn>
+Chen Fan <chen.fan.fnst@cn.fujitsu.com>
 Chen Gang <chengang@emindsoft.com.cn>
 Chen Gang <gang.chen.5i5j@gmail.com>
 Chen Gang <gang.chen@sunrus.com.cn>
 Chen Wei-Ren <chenwj@iis.sinica.edu.tw>
 Christophe Lyon <christophe.lyon@st.com>
+Christoph Hellwig <hch@lst.de>
 Collin L. Walling <walling@linux.ibm.com>
 Daniel P. Berrang=C3=A9 <berrange@redhat.com>
+Disheng Su <edison@cloud.com>
+Dunrong Huang <riegamaths@gmail.com>
 Eduardo Otubo <otubo@redhat.com>
 Fabrice Desclaux <fabrice.desclaux@cea.fr>
 Fernando Luis V=C3=A1zquez Cao <fernando_b1@lab.ntt.co.jp>
 Fernando Luis V=C3=A1zquez Cao <fernando@oss.ntt.co.jp>
 Gautham R. Shenoy <ego@in.ibm.com>
 Gautham R. Shenoy <ego@linux.vnet.ibm.com>
-Gonglei (Arei) <arei.gonglei@huawei.com>
 Guang Wang <wang.guang55@zte.com.cn>
 Hailiang Zhang <zhang.zhanghailiang@huawei.com>
 Herv=C3=A9 Poussineau <hpoussin@reactos.org>
+Hiroyuki Obinata <hiroyuki.obinata@gmail.com>
 Jakub Jerm=C3=A1=C5=99 <jakub@jermar.eu>
 Jakub Jerm=C3=A1=C5=99 <jakub.jermar@kernkonzept.com>
+Jay Zhou <jianjay.zhou@huawei.com>
 Jean-Christophe Dubois <jcd@tribudubois.net>
+Jean-Christophe Dubois <jcd@tribudubois.net> <jcd@jcd-laptop.(none)>
+Jia Lina <jialina01@baidu.com>
 Jind=C5=99ich Makovi=C4=8Dka <makovick@gmail.com>
 John Arbuckle <programmingkidx@gmail.com>
 Juha Riihim=C3=A4ki <juha.riihimaki@nokia.com>
@@ -96,9 +109,11 @@ Jun Li <junmuzi@gmail.com>
 Laurent Vivier <Laurent@lvivier.info>
 Leandro Lupori <leandro.lupori@gmail.com>
 Li Guang <lig.fnst@cn.fujitsu.com>
+Lili Huang <huanglili.huang@huawei.com>
 Liming Wang <walimisdev@gmail.com>
 linzhecheng <linzc@zju.edu.cn>
 Liran Schour <lirans@il.ibm.com>
+Li Tianqing <tianqing@unitedstack.com>
 Liu Yu <yu.liu@freescale.com>
 Liu Yu <Yu.Liu@freescale.com>
 Li Zhang <zhlcindy@gmail.com>
@@ -110,13 +125,17 @@ Luc Michel <luc.michel@git.antfield.fr>
 Luc Michel <luc.michel@greensocs.com>
 Marc Mar=C3=AD <marc.mari.barcelo@gmail.com>
 Marc Mar=C3=AD <markmb@redhat.com>
+Marek Dolata <mkdolata@us.ibm.com>
 Michael Avdienko <whitearchey@gmail.com>
 Michael S. Tsirkin <mst@redhat.com>
+Michael S. Tsirkin <mst@redhat.com> <mst@robin.(none)>
+Michael Tokarev <mjt@tls.msk.ru> <mjt@gandalf>
 Munkyu Im <munkyu.im@samsung.com>
 Nicholas Bellinger <nab@linux-iscsi.org>
 Nicholas Thomas <nick@bytemark.co.uk>
 Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
 Orit Wasserman <owasserm@redhat.com>
+Pan Nengyuan <pannengyuan@huawei.com>
 Paolo Bonzini <pbonzini@redhat.com>
 Pavel Dovgaluk <dovgaluk@ispras.ru>
 Pavel Dovgaluk <pavel.dovgaluk@gmail.com>
@@ -124,15 +143,23 @@ Pavel Dovgaluk <Pavel.Dovgaluk@ispras.ru>
 Peter Crosthwaite <crosthwaite.peter@gmail.com>
 Peter Crosthwaite <peter.crosthwaite@petalogix.com>
 Peter Crosthwaite <peter.crosthwaite@xilinx.com>
+Peter Maydell <peter.maydell@linaro.org> <petmay01@cam-vm-266.(none)>
 Prasad J Pandit <pjp@fedoraproject.org>
 Prasad J Pandit <ppandit@redhat.com>
 Qiao Nuohan <qiaonuohan@cn.fujitsu.com>
 Reimar D=C3=B6ffinger <Reimar.Doeffinger@gmx.de>
 Remy Noel <remy.noel@blade-group.com>
+Richard Henderson <rth@twiddle.net> <rth@anchor.twiddle.home>
 Roger Pau Monn=C3=A9 <roger.pau@citrix.com>
 Shin'ichiro Kawasaki <kawasaki@juno.dti.ne.jp>
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
+Siwei Zhuang <Siwei.Zhuang@data61.csiro.au>
+Sochin Jiang <sochin@aliyun.com>
 Sochin Jiang <sochin.jiang@huawei.com>
+Stefan Berger <stefanb@linux.ibm.com> <Stefan Berger stefanb@linux.vnet.ib=
m.com>
+Stefan Weil <sw@weilnetz.de> <stefan@kiwi.(none)>
+Stefan Weil <sw@weilnetz.de> <stefan@weilnetz.de>
+Stefan Weil <sw@weilnetz.de> <weil@mail.berlios.de>
 Takashi Yoshii <takasi-y@ops.dti.ne.jp>
 Thomas Huth <thuth@redhat.com>
 Thomas Knych <thomaswk@google.com>
@@ -150,6 +177,7 @@ Wenshuang Ma <kevinnma@tencent.com>
 Xiaoqiang Zhao <zxq_yx_007@163.com>
 Xinhua Cao <caoxinhua@huawei.com>
 Xiong Zhang <xiong.y.zhang@intel.com>
+Ying Fang <fangying1@huawei.com>
 Yin Yin <yin.yin@cs2c.com.cn>
 yuchenlin <npes87184@gmail.com>
 YunQiang Su <syq@debian.org>
--=20
2.21.1


