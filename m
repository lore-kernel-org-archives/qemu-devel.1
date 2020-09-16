Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E756C43461
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 16:45:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D3592064E
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 16:45:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dahf0ta7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D3592064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIaYx-0000yj-Vz
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 12:45:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59040)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1kIaXx-00004x-4R
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 12:44:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44075)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1kIaXu-0003qj-Kv
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 12:44:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600274677;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ie0UnYrJlUPb3R1dSeMfljbCLaWHBLCMssNHy8XhzYQ=;
 b=dahf0ta7ujnsIH22WuVZJ8dd1awHn/O47NwLW15/Rw2YquD57CGK5DlVf0FVWp3QHTH3a4
 4CYu1wrlr1H8yHReWYu57HjDi9AlxN0zQ3zqOx/rQSHO+WcEPS/ldXKjXAaeO6zGmfdCrG
 44RoUpFc/bpcuYsq5aJSSpXtTWoPriw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-547-17xtPf4VNmGUTwZ6nY2yEA-1; Wed, 16 Sep 2020 12:44:34 -0400
X-MC-Unique: 17xtPf4VNmGUTwZ6nY2yEA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B881A64081
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2020 16:44:33 +0000 (UTC)
Received: from harajuku.usersys.redhat.com (unknown [10.40.195.7])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8595B19D61;
 Wed, 16 Sep 2020 16:44:28 +0000 (UTC)
Message-ID: <a6b5e34843b3f08994d4ffefadc5867001e0bc36.camel@redhat.com>
Subject: [RFC DOCUMENT 00/12] kubevirt-and-kvm: Add documents
From: Andrea Bolognani <abologna@redhat.com>
To: libvir-list@redhat.com, qemu-devel@nongnu.org
Date: Wed, 16 Sep 2020 18:44:25 +0200
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=abologna@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=abologna@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 02:16:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: vromanso@redhat.com, rmohr@redhat.com, abologna@redhat.com,
 crobinso@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello there!

Several weeks ago, a group of Red Hatters working on the
virtualization stack (primarily QEMU and libvirt) started a
conversation with developers from the KubeVirt project with the goal
of better understanding and documenting the interactions between the
two.

Specifically, we were interested in integration pain points, with the
underlying ideas being that only once those issues are understood it
becomes possible to look for solutions, and that better communication
would naturally lead to improvements on both sides.

This series of documents was born out of that conversation. We're
sharing them with the QEMU and libvirt communities in the hope that
they can be a valuable resource for understanding how the projects
they're working on are consumed by higher-level tools, and what
challenges are encountered in the process.

Note that, while the documents describe a number of potential
directions for things like development of new components, that's all
just brainstorming that naturally occurred as we were learning new
things: the actual design process should, and will, happen on the
upstream lists.

Right now the documents live in their own little git repository[1],
but the expectation is that eventually they will find a suitable
long-term home. The most likely candidate right now is the main
KubeVirt repository, but if you have other locations in mind please
do speak up!

I'm also aware of the fact that this delivery mechanism is fairly
unconventional, but I thought it would be the best way to spark a
discussion around these topics with the QEMU and libvirt developers.

Last but not least, please keep in mind that the documents are a work
in progress, and polish has been applied to them unevenly: while the
information presented is, to the best of our knowledge, all accurate,
some parts are in a rougher state than others. Improvements will
hopefully come over time - and if you feel like helping out in making
that happen, it would certainly be appreciated!

Looking forward to your feedback :)


[1] https://gitlab.com/abologna/kubevirt-and-kvm
-- 
Andrea Bolognani / Red Hat / Virtualization


