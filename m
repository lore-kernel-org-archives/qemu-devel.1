Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02C8FC43461
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 08:30:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AD70206F7
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 08:30:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ssltll/4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AD70206F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kISpG-0004tR-6B
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 04:30:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58606)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1kISib-0004ht-Te
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 04:23:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:33059)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1kISiX-0005E4-8m
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 04:23:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600244582;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jV0lCDEWsJXMKTbmJUGcIIgrfrQ13Kv6FUHIAQbMaJo=;
 b=Ssltll/4APfPzrIG7kpHRRszsIPa+Y/AvCaRuAbeUuydTR6aiyysIEuzgkK4UYPqf2S8fG
 kuIwq7EE+VIA4/vUGra6iQuKb4UzCVFmC4HmMxqL9Xba5dzpK5MUXSCDgYnQLTlmsk928k
 5amtA6YT+bVkLxMXHVK4Ago8eDvbWLc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-596-lVd6HfZWMJCRCd75zpnZ5A-1; Wed, 16 Sep 2020 04:22:56 -0400
X-MC-Unique: lVd6HfZWMJCRCd75zpnZ5A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CB4AF10082F9;
 Wed, 16 Sep 2020 08:22:55 +0000 (UTC)
Received: from harajuku.usersys.redhat.com (unknown [10.40.195.7])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8B4C519C71;
 Wed, 16 Sep 2020 08:22:49 +0000 (UTC)
Message-ID: <ae92199e3e4b63bb3a74e988d7f7ee9aabb1363c.camel@redhat.com>
Subject: Re: Python 3.5 EOL; when can require 3.6?
From: Andrea Bolognani <abologna@redhat.com>
To: Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>, Markus
 Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Date: Wed, 16 Sep 2020 10:22:47 +0200
In-Reply-To: <495bd2bd-4f38-8fe2-e758-82acbecd0d04@redhat.com>
References: <875z8eupyp.fsf@dusky.pond.sub.org>
 <495bd2bd-4f38-8fe2-e758-82acbecd0d04@redhat.com>
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=abologna@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=abologna@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 02:35:56
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 2020-09-16 at 09:53 +0200, Philippe Mathieu-Daudé wrote:
> On 9/16/20 9:43 AM, Markus Armbruster wrote:
> > We require Python 3.5.  It will reach its "end of life" at the end of
> > September 2020[*].  Any reason not to require 3.6 for 5.2?  qemu-iotests
> > already does for its Python parts.
> 
> Not answering your question, but it would help to start a table
> of "oldest package released" versions, with our supported distributions
> as columns and package names as row.
> 
> This way when new distributions are released (and oldest dropped from
> our side) we can add/remove a column and see the oldest version we aim
> to support.

In case you're not already aware of it, https://repology.org/ is a
very valuable tool when it comes to figuring out minimum versions for
dependencies.

-- 
Andrea Bolognani / Red Hat / Virtualization


