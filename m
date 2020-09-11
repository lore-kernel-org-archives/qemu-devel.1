Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57E51C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 16:13:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDA80221EB
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 16:13:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K1qSrogy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDA80221EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46974 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGlg6-0007Rf-SE
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 12:13:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55664)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1kGleK-0005uH-Mf
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 12:11:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50733
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1kGleJ-0006A1-3T
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 12:11:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599840702;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jDAbOovrQQaScvUZ/xLzwkhJ8kzz8Dq7nM+ZrmnN+AQ=;
 b=K1qSrogyV4qhxE7ENpKyMSB3fezfD6LS0dGDWrpIkBF7NLXGo8+a8SCaiXOUiu6EHznibl
 o7ZCLwf0VUeZzLMdcQazsq2ZBDiNydgKghiHjIsg72VaM5uaja5QYJDtLeKeYvIALTvhxF
 En9M8jvQ+V/qs5IuZluMf0DzjZllKB4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-394-02mfc5rCNxalaeOZT3_BTQ-1; Fri, 11 Sep 2020 12:11:40 -0400
X-MC-Unique: 02mfc5rCNxalaeOZT3_BTQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4EF221005E66;
 Fri, 11 Sep 2020 16:11:39 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-113-62.ams2.redhat.com
 [10.36.113.62])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9659660C07;
 Fri, 11 Sep 2020 16:11:34 +0000 (UTC)
Subject: Re: PATCH: Increase System Firmware Max Size
To: "McMillan, Erich" <erich.mcmillan@hp.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
References: <CS1PR8401MB0327EF9D532330BA44257AFCF3240@CS1PR8401MB0327.NAMPRD84.PROD.OUTLOOK.COM>
 <20c5210f-8199-a9e7-9297-0bea06c4d9ae@redhat.com>
 <20200911083408.GA3310@work-vm>
 <ae2d820e-78c6-da92-2fa6-73c1a7d10333@redhat.com>
 <20200911150602.GH3310@work-vm>
 <CS1PR8401MB03273F105DE3FA773E2DB2F5F3240@CS1PR8401MB0327.NAMPRD84.PROD.OUTLOOK.COM>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <ad584cb7-3fb6-1f1f-62af-61aa3a071fb0@redhat.com>
Date: Fri, 11 Sep 2020 18:11:33 +0200
MIME-Version: 1.0
In-Reply-To: <CS1PR8401MB03273F105DE3FA773E2DB2F5F3240@CS1PR8401MB0327.NAMPRD84.PROD.OUTLOOK.COM>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=lersek@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=205.139.110.120; envelope-from=lersek@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/11 03:28:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: "mst@redhat.com" <mst@redhat.com>,
 "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09/11/20 17:22, McMillan, Erich wrote:

> I agree that fw has become the vendor OS, but at this point there's no
> going back.
> Utilizing a virtual platform allows us to greatly increase the security
> of our code,
> could we make this change a Qemu experimental flag, so that fw vendors could
> use it at their own risk?

That would make me feel more comfortable, yes.

Daniel proposed "firmware-max-size" (I've now taken the liberty to
replace "_" with "-"; I believe that's the current rule for property names).

If we called it "x-firmware-max-size" and kept the default value
unchanged, I'd feel way safer. (Because then any feature request for
upstream OVMF that were based on changing "x-firmware-max-size" could be
refuted immediately with: "that property name starts with x-, sorry".)

Thanks,
Laszlo


