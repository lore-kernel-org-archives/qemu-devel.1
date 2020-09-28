Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEF20C2D0A8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 13:19:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9336F2076D
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 13:19:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N4QxoJ8L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9336F2076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50396 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMt4A-0008Ry-Cx
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 09:19:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56558)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kMspn-0007IN-4T
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 09:04:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49171)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kMsph-0000pV-No
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 09:04:50 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601298285;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=j9eXQH222IF4z/5+ryWHdc3O+aVHS/WKifvlWGjCSSU=;
 b=N4QxoJ8LL7stjGrroGOfQr9Fu4B3FZUUc1t2Z+488NfBRXqWxYNlGlfN2AWpnoX0yRdNxM
 gck5cqKadH/ZFZRgw991Z8oRDZpQ6NfxHZyU5xkP28/o3HHADuwZRKLxJuoZjRDoeBy3AQ
 kuW7LU648uVfd125OREOQhUDwu+i5ho=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-245-oGLH_cG3Nf2dXwAWA1JEkQ-1; Mon, 28 Sep 2020 09:04:42 -0400
X-MC-Unique: oGLH_cG3Nf2dXwAWA1JEkQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C8B73873112;
 Mon, 28 Sep 2020 13:04:41 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-70.ams2.redhat.com
 [10.36.112.70])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 84A9C183AB;
 Mon, 28 Sep 2020 13:04:41 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0E00C113865F; Mon, 28 Sep 2020 15:04:40 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v6 00/21] Convert QAPI doc comments to generate rST
 instead of texinfo
References: <20200925162316.21205-1-peter.maydell@linaro.org>
 <160106193961.10465.12078546060105198824@66eaa9a8a123>
 <CAFEAcA8uWY+MCDToz9an+zsrMVrctkBmgpMV82iUR2ZZOgA3Vg@mail.gmail.com>
Date: Mon, 28 Sep 2020 15:04:40 +0200
In-Reply-To: <CAFEAcA8uWY+MCDToz9an+zsrMVrctkBmgpMV82iUR2ZZOgA3Vg@mail.gmail.com>
 (Peter Maydell's message of "Fri, 25 Sep 2020 22:37:56 +0100")
Message-ID: <87h7rif3x3.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=216.205.24.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 03:29:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
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
Cc: John Snow <jsnow@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> writes:

> On Fri, 25 Sep 2020 at 20:25, <no-reply@patchew.org> wrote:
>
>> In file included from ../src/qapi/qapi-schema.json:78:
>> ../src/qapi/migration.json:1747:1: unexpected de-indent (expected at least 13 spaces)
>
> This is yet another mis-indented line in a change to the QAPI
> doc-comments (commit 4c437254b807). It hit master in the
> latest migration pull after I'd sent out this patchseries
> but before patchew got round to testing..

Obvious fixup for your PATCH 01:

diff --git a/qapi/migration.json b/qapi/migration.json
index 7d9342c064..7f5e6fd681 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -1744,9 +1744,9 @@
 # Information about current dirty page rate of vm.
 #
 # @dirty-rate: @dirtyrate describing the dirty page rate of vm
-#          in units of MB/s.
-#          If this field returns '-1', it means querying has not
-#          yet started or completed.
+#              in units of MB/s.
+#              If this field returns '-1', it means querying has not
+#              yet started or completed.
 #
 # @status: status containing dirtyrate query status includes
 #          'unstarted' or 'measuring' or 'measured'

Happy to fix it up in my tree.


