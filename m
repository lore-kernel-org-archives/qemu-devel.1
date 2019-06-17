Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40FC6C31E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 18:00:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1568120861
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 18:00:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jxC2Kazh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1568120861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50712 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcvvp-0000j5-BP
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 14:00:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51983)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <liran.alon@oracle.com>) id 1hcvsm-0005OB-JF
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 13:57:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liran.alon@oracle.com>) id 1hcvsl-0003N6-AX
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 13:57:28 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:40238)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liran.alon@oracle.com>)
 id 1hcvsl-0003KR-0r
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 13:57:27 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5HHrnNA147784;
 Mon, 17 Jun 2019 17:57:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2018-07-02; bh=4/nzRexmthmDAqzX7wECeVu9vRIcTdjkWAE4EBtpxA4=;
 b=jxC2KazhgBl+cheBUDX3z2nKxDy2qRcQwfcvbpDk23X0BwkHNZbs9BCDRbeQ2tdf4NvW
 7aoZDCi4bOOf2ZC+3FyQwgBJbb81BRLIm8ll7x+x7HWSp91V0KDdCdnTr5QPj6cOIH2D
 jf2nR6y4zh2pGDMvY9fma5NK5J689Smx0KE3oQ6LesDjwNwXZR38RPBcqEs7wuHhNugJ
 5lUsnf4GjdYHzABpyvHLOLeM0d6hJXMuX7pp/ZcNf5An84Ag63IFYYDRwv73s7pkF9vY
 BOzc+4K5jE1MZwqjAqybUWcKJPiBam+MgLLZd56+dlZF2yM+gntXFkYD2yJeygv99AtM Xg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2120.oracle.com with ESMTP id 2t4saq7w39-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Jun 2019 17:57:22 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5HHv5eS189245;
 Mon, 17 Jun 2019 17:57:22 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by userp3020.oracle.com with ESMTP id 2t5h5t93f7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Jun 2019 17:57:22 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5HHvK1S003385;
 Mon, 17 Jun 2019 17:57:21 GMT
Received: from spark.ravello.local (/213.57.127.2)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 17 Jun 2019 10:57:20 -0700
From: Liran Alon <liran.alon@oracle.com>
To: qemu-devel@nongnu.org
Date: Mon, 17 Jun 2019 20:56:49 +0300
Message-Id: <20190617175658.135869-1-liran.alon@oracle.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9291
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=450
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906170160
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9291
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=489 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906170160
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 156.151.31.85
Subject: [Qemu-devel] [QEMU PATCH v3 0/9]: KVM: i386: Add support for save
 and restore of nested state
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
Cc: ehabkost@redhat.com, kvm@vger.kernel.org, maran.wilson@oracle.com,
 mtosatti@redhat.com, dgilbert@redhat.com, pbonzini@redhat.com, rth@twiddle.net,
 jmattson@google.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

This series aims to add support for QEMU to be able to migrate VMs that
are running nested hypervisors. In order to do so, it utilizes the new
IOCTLs introduced in KVM commit 8fcc4b5923af ("kvm: nVMX: Introduce
KVM_CAP_NESTED_STATE") which was created for this purpose.

1st patch introduce kvm_arch_destroy_vcpu() to perform per-vCPU
destruction logic that is arch-dependent.

2st patch is just refactoring to use symbolic constants instead of hard-coded
numbers.

3st patch fixes QEMU to update DR6 when QEMU re-inject #DB to guest after
it was intercepted by KVM when guest is debugged.

4th patch adds migration blocker for vCPU exposed with either Intel VMX
or AMD SVM. Until now it was blocked only for Intel VMX.

5rd patch updates linux-headers to have updated struct kvm_nested_state.
The updated struct now have explicit fields for the data portion.

6rd patch add vmstate support for saving/restoring kernel integer types (e.g. __u16).

7th patch adds support for saving and restoring nested state in order to migrate
guests which run a nested hypervisor.

8th patch add support for KVM_CAP_EXCEPTION_PAYLOAD. This new KVM capability
allows userspace to properly distingiush between pending and injecting exceptions.

9th patch reverts a past commit which have added a migration blocker when guest
is exposed with VMX. Remaining with only a migration blocker for vCPU
exposed with AMD SVM.

Regards,
-Liran

v1->v2 changes:
* Add patch to fix bug when re-inject #DB to guest.
* Add support for KVM_CAP_EXCEPTION_PAYLOAD.
* Use explicit fields for struct kvm_nested_state data portion.
* Use vmstate subsections to save/restore nested state in order to properly
* support forward & backwards migration compatability.
* Remove VMX migration blocker.

v2->v3 changes:
* Add kvm_arch_destroy_vcpu().
* Use DR6_BS where appropriate.
* Add cpu_pre_save() logic to convert pending exception to injected
  exception if guest is running L2.
* Converted max_nested_state_len to int instead of uint32_t.
* Use kvm_arch_destroy_vcpu() to free nested_state.
* Add migration blocker for vCPU exposed with AMD SVM.
* Don't rely on CR4 or MSR_EFER to know if it is required to
migrate new VMState subsections.
* Signal if vCPU is in guest-mode in hflags as original intention by Paolo.

Reference for discussion on v2:
https://patchwork.kernel.org/patch/10601689/


