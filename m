Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 145A1C4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 20:39:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FF2221D7F
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 20:39:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ntgi9pUn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FF2221D7F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLY1J-0008TD-R4
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 16:39:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37094)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kLY0L-00081G-C3
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 16:38:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:20787)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kLY0J-0006yQ-B7
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 16:38:12 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600979890;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/41G/CRs3da4bp62ceMEK7KFJEIw39QGC5vjYuHIlUg=;
 b=Ntgi9pUnaDvCa0gkk77z1Ja0T9f5HWfIleWddvo1COhNm9mvjhG8MzTbL4psFD3NQqZxdr
 tZo0aQkTOLG+Tmro8lTDPX+lq4uA9Z4357RYPg1MGuXgUevsQdKA5hNui2PHmUiCh0ZTdH
 gfBZxsl1OlIcGR5HTjCEiH7kln4ivac=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-268-I2DIshKkP8WUXyEgsnwMzA-1; Thu, 24 Sep 2020 16:38:01 -0400
X-MC-Unique: I2DIshKkP8WUXyEgsnwMzA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1BFFC1017DE8;
 Thu, 24 Sep 2020 20:38:00 +0000 (UTC)
Received: from [10.10.119.140] (ovpn-119-140.rdu2.redhat.com [10.10.119.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 065225E25F;
 Thu, 24 Sep 2020 20:37:58 +0000 (UTC)
Subject: Re: [PATCH v2 00/38] qapi: static typing conversion, pt1
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200922210101.4081073-1-jsnow@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <12d40064-5735-5acc-18dd-5f6fdd94beed@redhat.com>
Date: Thu, 24 Sep 2020 16:37:58 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200922210101.4081073-1-jsnow@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/24 01:10:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.214, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/22/20 5:00 PM, John Snow wrote:
> Hi, this series adds static type hints to the QAPI module.
> This is part one!
> 

Hi, I will be sending out a v3 shortly.

The status of this series is presently as follows:

+ [01] do-not-merge-qapi-add          #
+ [02] qapi-gen-separate-arg-parsing  # [SOB] JS [RB] EH
+ [03] qapi-move-generator-entrypoint # [SOB] JS [RB] CR,EH [TB] CR
+ [04] qapi-prefer-explicit-relative  # [SOB] JS [RB] CR,EH
+ [05] qapi-remove-wildcard-includes  # [SOB] JS [RB] CR,EH
+ [06] qapi-enforce-import-order      # [SOB] JS
+ [07] qapi-delint-using-flake8       # [SOB] JS [RB] CR,EH
+ [08] qapi-add-pylintrc              # [SOB] JS [TB] CR,EH [RB] CR
+ [09] qapi-common-py-remove-python   # [SOB] JS [RB] CR,EH
+ [10] qapi-common-add-indent-manager # [SOB] JS [RB] CR,EH
+ [11] qapi-common-py-delint-with     # [SOB] JS [RB] CR,EH
+ [12] replace-c-by-char              # [SOB] JS [RB] CR,EH
+ [13] qapi-common-py-check-with      # [SOB] JS [RB] CR [TB] CR,EH
+ [14] qapi-common-py-add-notational  # [SOB] JS [RB] CR,EH
+ [15] qapi-common-move-comments-into # [SOB] JS [RB] CR,EH
+ [16] qapi-split-build_params-into   # [SOB] JS [RB] CR,EH
+ [17] qapi-establish-mypy-type       # [SOB] JS [TB] EH
+ [18] qapi-events-py-add-notational  # [SOB] JS [RB] CR,EH
+ [19] qapi-events-move-comments-into # [SOB] JS [RB] CR,EH
+ [20] qapi-commands-py-don-t-re-bind # [SOB] JS [RB] CR,EH
+ [21] qapi-commands-py-add           # [SOB] JS [RB] CR,EH
+ [22] qapi-commands-py-enable        # [SOB] JS [RB] CR,EH
+ [23] qapi-source-py-add-notational  # [SOB] JS [RB] EH
+ [24] qapi-source-py-delint-with     # [SOB] JS [RB] CR,EH [TB] CR
+ [25] qapi-gen-py-fix-edge-case-of   #
+ [26] qapi-gen-py-add-notational     # [SOB] JS [RB] CR,EH
+ [27] qapi-gen-py-enable-checking    # [SOB] JS [RB] CR,EH [TB] CR
+ [28] qapi-gen-py-remove-unused      # [SOB] JS [RB] CR,EH
+ [29] qapi-gen-py-update-write-to-be # [SOB] JS [RB] CR,EH
+ [30] qapi-gen-py-delint-with-pylint # [SOB] JS [RB] CR,EH
+ [31] qapi-introspect-py-assert-obj  #
+ [32] qapi-introspect-py-create-a    # [SOB] EH,JS
+ [33] qapi-introspect-py-add         #
+ [34] qapi-introspect-py-unify       #
+ [35] qapi-introspect-py-replace     #
+ [36] qapi-introspect-py-create-a-0  #
+ [37] qapi-types-py-add-type-hint    # [SOB] JS [RB] CR,EH
+ [38] qapi-types-py-remove-one       # [SOB] JS [RB] CR,EH
+ [39] qapi-visit-py-assert           # [SOB] JS [RB] CR,EH
+ [40] qapi-visit-py-remove-unused    # [SOB] JS [RB] CR,EH [TB] CR
 > [41] qapi-visit-py-add-notational   # [SOB] JS [RB] CR,EH [TB] CR


Thank you for your help so far, everyone!

--js


