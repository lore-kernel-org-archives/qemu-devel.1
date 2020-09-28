Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BE8BC2D0A8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 14:37:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3C142075A
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 14:37:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eoXlyutM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3C142075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33306 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMuHh-0008Ht-Ou
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 10:37:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55890)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kMuEt-0005qM-7v
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 10:34:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33087)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kMuEr-00053q-MV
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 10:34:50 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601303686;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XGIKjTyscA10UKsqxfBriDI7dSHJkqrTRqyf/5NHv0U=;
 b=eoXlyutMdD3qQOAv1UnqrDk7fuoCFp5og4wEYTuX5lQpe+QN0F17/bvcblfItuHvaqoV9A
 WL8d+7925zQW7O5sr8+VVU4VetzLwLTC4Cja4hqYxZgToGpOdasO4yLv8Q78n++v/JWSrv
 AkTuX/XpRFplBEmn9YjPOw/cnN9gTdQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-393-JEOPC9uUOlml-WKB_BjhKQ-1; Mon, 28 Sep 2020 10:34:44 -0400
X-MC-Unique: JEOPC9uUOlml-WKB_BjhKQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5584A1084D77
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2020 14:34:43 +0000 (UTC)
Received: from [10.10.119.140] (ovpn-119-140.rdu2.redhat.com [10.10.119.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C8FA25C1BB;
 Mon, 28 Sep 2020 14:34:42 +0000 (UTC)
Subject: Re: [PATCH v3 12/47] qapi: enforce import order/styling with isort
To: Markus Armbruster <armbru@redhat.com>
References: <20200925002900.465855-1-jsnow@redhat.com>
 <20200925002900.465855-13-jsnow@redhat.com>
 <87imc2w6uf.fsf@dusky.pond.sub.org>
 <8baab976-1dfd-a7b4-1a1e-47480cf0c4b6@redhat.com>
 <87tuvigkuf.fsf@dusky.pond.sub.org>
From: John Snow <jsnow@redhat.com>
Message-ID: <a2bd875a-b158-3c64-e6b6-7238e1e7c7d9@redhat.com>
Date: Mon, 28 Sep 2020 10:34:42 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <87tuvigkuf.fsf@dusky.pond.sub.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 03:29:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/28/20 8:13 AM, Markus Armbruster wrote:
> PEP 8: "Surround top-level function and class definitions with two blank
> lines."
> 
> [...]
> 
> 

Yep, but flake8 does not complain about the first definitions that occur 
below imports. Why not? I don't know.

Regardless, I can change it and fold the changes in; they won't affect 
much here.

--js


