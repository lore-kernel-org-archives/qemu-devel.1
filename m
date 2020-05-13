Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.6 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94239CA90AF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 11:29:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62CAA206E5
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 11:29:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MnMjd79L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62CAA206E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42184 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYpZQ-0005k0-Ke
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 07:29:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55182)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1jYpF7-0004e2-Ss
 for qemu-devel@nongnu.org; Wed, 13 May 2020 07:08:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60067
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1jYpF6-0004N0-8f
 for qemu-devel@nongnu.org; Wed, 13 May 2020 07:08:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589368083;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=x8tMH3H2VCDEO45Gjf6uumuhzxLLIke71lW2ELQRRp4=;
 b=MnMjd79LN4UKQ8LGlKUukF12DyqrtbsstF4w9O3QPyYKa09JJhVkEoAppUrBX8NQWMrCXe
 rZc/hT6ypb4GERm6qBbT60/imk/DvIVhCJat9ZrJJCrxli0wnVbGobKvqAQzaoLpQdq/oj
 wqQ/NRUG1uO9z0zdz/DWeqLAoKtaYn8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-338-kd14H5JpNPu5-nnvDFZBvQ-1; Wed, 13 May 2020 07:07:59 -0400
X-MC-Unique: kd14H5JpNPu5-nnvDFZBvQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 510BB100A627;
 Wed, 13 May 2020 11:07:58 +0000 (UTC)
Received: from kaapi (unknown [10.74.9.109])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C4C8F60C05;
 Wed, 13 May 2020 11:07:48 +0000 (UTC)
Date: Wed, 13 May 2020 16:37:43 +0530 (IST)
From: P J P <ppandit@redhat.com>
X-X-Sender: pjp@kaapi
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <f4bug@amsat.org>
Subject: =?GB2312?Q?Re=3A_=BB=D8=B8=B4=3A_=5BPATCH_0=2F2=5D_use_unsigned?=
 =?GB2312?Q?_type_for_MegasasState_fields?=
In-Reply-To: <4a9f8ae4-ef42-5a82-6d36-fb30f2878c6a@amsat.org>
Message-ID: <nycvar.YSQ.7.76.2005131624100.1451610@xnncv>
References: <20200507105718.1319187-1-ppandit@redhat.com>
 <26201c24-c483-85a7-2f4b-b3cc56d4b8b7@redhat.com>
 <nycvar.YSQ.7.76.2005122357030.1451610@xnncv>
 <BN6PR07MB341283EBBF78F86AAA995382CABE0@BN6PR07MB3412.namprd07.prod.outlook.com>
 <4a9f8ae4-ef42-5a82-6d36-fb30f2878c6a@amsat.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/mixed;
 boundary="-1463810047-1405803420-1589368077=:1451610"
Received-SPF: pass client-ip=205.139.110.120; envelope-from=ppandit@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 01:56:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, CHARSET_FARAWAY_HEADER=3.2,
 DKIMWL_WL_HIGH=0.001, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Fam Zheng <fam@euphon.net>, QEMU Developers <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Ding, Ren" <rding@gatech.edu>,
 =?ISO-8859-15?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>, "Zhao,
 Hanqing" <hanqing@gatech.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

---1463810047-1405803420-1589368077=:1451610
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

+-- On Tue, 12 May 2020, Philippe Mathieu-Daudé wrote --+
| The cover describes the bug as OOB, so I suppose this is a security issue. 
| Now a 6 months embargo surprises me. I was expecting some period in a 
| 30-90days range to be the default. However reading the 'Publication embargo' 
| chapter on https://www.qemu.org/contribute/security-process/, it is only 
| stated "Embargo periods will be negotiated by mutual agreement between 
| members of the security team and other relevant parties to the problem." 
| Shouldn't be a maximum upper limit on the embargo period? Are there QEMU 
| security bugs embargoed for more than a year? That would be a shame.

Yes, some of these issue are old. We are working on the time-line details. We 
have quite regular influx of CVE issues, which leads to long triage times for 
some of them.

Thank you.
--
Prasad J Pandit / Red Hat Product Security Team
8685 545E B54C 486B C6EB 271E E285 8B5A F050 DE8D
---1463810047-1405803420-1589368077=:1451610--


