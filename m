Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B48AFC2D0A8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 11:51:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3190F2073A
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 11:51:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BidKXtrF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3190F2073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39762 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMrge-0005or-1c
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 07:51:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37906)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kMres-0004EK-Hl
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 07:49:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:29995)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kMreq-0007ua-L1
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 07:49:30 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601293767;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Y+rFvyjMwrBzTa/faML7Bgew933gkrGfKh42VmG/jyg=;
 b=BidKXtrFiBYl5ZgP+6VpzYvOukTZ2aviz9/TNq0+zB4BoNcE1jfcPD4ZM2WqmV3IHdv5a7
 0a8TTY12TBFIT/6GGqkdoLptB02R5EH68BXWkchE1fXk07fWOVAFgCIx7CAs3z38gUE/E5
 R1TciMxp+CTJuadL0JjzcloiFXKxofM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-256-evvwZaacNcaISlIlEBwY1A-1; Mon, 28 Sep 2020 07:49:25 -0400
X-MC-Unique: evvwZaacNcaISlIlEBwY1A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BBF571021200;
 Mon, 28 Sep 2020 11:49:24 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-70.ams2.redhat.com
 [10.36.112.70])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8BA8D60C11;
 Mon, 28 Sep 2020 11:49:24 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 234AA113865F; Mon, 28 Sep 2020 13:49:23 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v2 18/38] qapi/events.py: Move comments into docstrings
References: <20200922210101.4081073-1-jsnow@redhat.com>
 <20200922210101.4081073-19-jsnow@redhat.com>
 <20200923144819.GE3312949@habkost.net>
 <87k0wit5ef.fsf@dusky.pond.sub.org>
 <e9838231-f0b2-f953-448d-3c86e5b4f813@redhat.com>
Date: Mon, 28 Sep 2020 13:49:23 +0200
In-Reply-To: <e9838231-f0b2-f953-448d-3c86e5b4f813@redhat.com> (John Snow's
 message of "Fri, 25 Sep 2020 11:55:31 -0400")
Message-ID: <877dsei0jg.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=63.128.21.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 03:47:08
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
 Michael Roth <mdroth@linux.vnet.ibm.com>, Cleber Rosa <crosa@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

John Snow <jsnow@redhat.com> writes:

> On 9/25/20 8:19 AM, Markus Armbruster wrote:
>> What about:
>>      Generate a QAPI struct variable holding the event parameters,
>>      initialized with the function's arguments.
>
> Line length and style-guide limitations; docstrings need a one-liner
> summary.

They do!

> (Consistency is the hobgoblin, blah blah blah.)
>
> I am writing:
>
>     """
>     Generate a QAPI struct variable with an initializer.
>
>     The QAPI struct describes the event parameters, and the initializer
>     references the function arguments defined in `gen_event_send`.
>     """

Better.

My second try:

      Generate a struct variable holding the event parameters.

      Initialize it with the function arguments defined in in
      `gen_event_send`.


