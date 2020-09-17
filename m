Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A008EC43461
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 12:56:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 162F921734
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 12:56:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EdLzYCYO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 162F921734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36190 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kItSl-0003vM-5E
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 08:56:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44498)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kItRV-0003NV-MY
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 08:55:17 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:32745
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kItRR-0007qj-8h
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 08:55:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600347311;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4VsVmdNcDsuExW4tXL8MFjfUBAMt4AefqsY0AMDS/yA=;
 b=EdLzYCYOmYjibO0fVAzvVN13hyrcNNKYLr3X1UIfTjOY+cF7YrrE5M5ADvbIALWO2oHrzi
 C85GhcoF1xT4WOU/Oh7mL2tMSPWZazD7xt38uXjcIEddyYkjQi5UZXH1B4m301mR0SPcXu
 EzEhGZqCH3m2IOUN03USpY1V0ya+3j8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-333-UXzNa4cSNGClp_iZnEsmRQ-1; Thu, 17 Sep 2020 08:55:09 -0400
X-MC-Unique: UXzNa4cSNGClp_iZnEsmRQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B029618BFED7
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2020 12:55:06 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-114-66.ams2.redhat.com
 [10.36.114.66])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4082371C54;
 Thu, 17 Sep 2020 12:55:05 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 98783113864A; Thu, 17 Sep 2020 14:55:03 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: Python docstrings and licensing/authorship
References: <361aad7f-c2a3-524e-bd5a-2fc1fa6fe38a@redhat.com>
 <5C5765B1-3E0F-4577-B7B3-8BFFCB2D936F@redhat.com>
 <d6b98fa9-ee29-a9d3-c3e7-30ae84b8e4cd@redhat.com>
 <20200916163714.GT1535709@redhat.com>
Date: Thu, 17 Sep 2020 14:55:03 +0200
In-Reply-To: <20200916163714.GT1535709@redhat.com> ("Daniel P. =?utf-8?Q?B?=
 =?utf-8?Q?errang=C3=A9=22's?=
 message of "Wed, 16 Sep 2020 17:37:14 +0100")
Message-ID: <87mu1o4l7c.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/17 03:47:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.997,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: John Snow <jsnow@redhat.com>, Christophe de Dinechin <cdupontd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Wed, Sep 16, 2020 at 12:22:37PM -0400, John Snow wrote:
[...]
>> The real question I have is if anyone thinks it would be "rude" to separ=
ate
>> out any of the comment preambles (currently not visible at runtime or do=
cs
>> in any way, shape or form!) into two pieces:
>>=20
>> 1. Functional stuff relating to the usage of the module, visible in
>> help(module_name), visible in generated docs, visible in IDE popups, etc=
.
>>=20
>> 2. Authorship/copyright and licensing info, not visible in the above pla=
ces.
>
> I think this makes sense. IME it is not common to include copyright /
> author info the module help text, as that s non-technical information.

Seconded.

[...]


