Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C93D3C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 08:26:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92F5A208DB
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 08:26:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KB7pUllL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92F5A208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53882 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlps0-0000XD-Se
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 04:26:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59374)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jlprB-0008Kd-AN
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 04:25:09 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49019
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jlpr8-0000Fw-OS
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 04:25:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592468705;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=SsspWaJo47It/V4SuPUK/X+kT3Z19SqyPrEYAlWc8hc=;
 b=KB7pUllLhSNiAwwbbJyQO0UtYHJFxQFwJs78lVCQs7mMas0fbsvW7OuT9ZIjcItMei1LEg
 65220sb81yhgK9ihrQeYQ2VLe3gOiYM7k7+U7JnHrAGjZ58A+gEqNcu0v2ICmFzycXbT9u
 HrUa986KzVREpJ4J5djn4loQWCq26gM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-412-TT3tE1kCMuKzhDZaNh3kjw-1; Thu, 18 Jun 2020 04:25:01 -0400
X-MC-Unique: TT3tE1kCMuKzhDZaNh3kjw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6360C835B43;
 Thu, 18 Jun 2020 08:25:00 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-114-95.ams2.redhat.com [10.36.114.95])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 211F819C79;
 Thu, 18 Jun 2020 08:24:58 +0000 (UTC)
Subject: Re: [PATCH] softmmu/vl: Remove the check for colons in -accel
 parameters
References: <159246738056.23362.454044772825360901@d1fd068a5071>
To: Peter Maydell <peter.maydell@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <dc4c7cca-f3bd-a3fb-132e-e13f65a32c67@redhat.com>
Date: Thu, 18 Jun 2020 10:24:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <159246738056.23362.454044772825360901@d1fd068a5071>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/18 01:21:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: no-reply@patchew.org, qemu-trivial@nongnu.org, qemu-devel@nongnu.org,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


 Hi Peter,

could you maybe apply the Clang patches on the list directly to the
repository as a build fix? ... these warning mails from Patchew are
currently rather annoying... :-(

 Thomas


On 18/06/2020 10.03, no-reply@patchew.org wrote:
[...]
> /tmp/qemu-test/src/fpu/softfloat.c:3365:13: error: bitwise negation of a boolean expression; did you mean logical negation? [-Werror,-Wbool-operation]
>     absZ &= ~ ( ( ( roundBits ^ 0x40 ) == 0 ) & roundNearestEven );
>             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>             !
> /tmp/qemu-test/src/fpu/softfloat.c:3423:18: error: bitwise negation of a boolean expression; did you mean logical negation? [-Werror,-Wbool-operation]
>         absZ0 &= ~ ( ( (uint64_t) ( absZ1<<1 ) == 0 ) & roundNearestEven );
>                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>                  !
> /tmp/qemu-test/src/fpu/softfloat.c:3483:18: error: bitwise negation of a boolean expression; did you mean logical negation? [-Werror,-Wbool-operation]
>         absZ0 &= ~(((uint64_t)(absZ1<<1) == 0) & roundNearestEven);
>                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>                  !
> /tmp/qemu-test/src/fpu/softfloat.c:3606:13: error: bitwise negation of a boolean expression; did you mean logical negation? [-Werror,-Wbool-operation]
>     zSig &= ~ ( ( ( roundBits ^ 0x40 ) == 0 ) & roundNearestEven );
>             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>             !
> /tmp/qemu-test/src/fpu/softfloat.c:3760:13: error: bitwise negation of a boolean expression; did you mean logical negation? [-Werror,-Wbool-operation]
>     zSig &= ~ ( ( ( roundBits ^ 0x200 ) == 0 ) & roundNearestEven );
>             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>             !
> /tmp/qemu-test/src/fpu/softfloat.c:3987:21: error: bitwise negation of a boolean expression; did you mean logical negation? [-Werror,-Wbool-operation]
>                     ~ ( ( (uint64_t) ( zSig1<<1 ) == 0 ) & roundNearestEven );
>                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>                     !
> /tmp/qemu-test/src/fpu/softfloat.c:4003:22: error: bitwise negation of a boolean expression; did you mean logical negation? [-Werror,-Wbool-operation]
>             zSig0 &= ~ ( ( (uint64_t) ( zSig1<<1 ) == 0 ) & roundNearestEven );
>                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>                      !
> /tmp/qemu-test/src/fpu/softfloat.c:4273:18: error: bitwise negation of a boolean expression; did you mean logical negation? [-Werror,-Wbool-operation]
>         zSig1 &= ~ ( ( zSig2 + zSig2 == 0 ) & roundNearestEven );
>                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>                  !
> 8 errors generated.
> make[1]: *** [/tmp/qemu-test/src/rules.mak:69: fpu/softfloat.o] Error 1
> make[1]: *** Waiting for unfinished jobs....
> /tmp/qemu-test/src/migration/ram.c:919:45: error: implicit conversion from 'unsigned long' to 'double' changes value from 18446744073709551615 to 18446744073709551616 [-Werror,-Wimplicit-int-float-conversion]
>             xbzrle_counters.encoding_rate = UINT64_MAX;
>                                           ~ ^~~~~~~~~~
> /usr/include/stdint.h:130:23: note: expanded from macro 'UINT64_MAX'


