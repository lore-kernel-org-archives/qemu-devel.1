Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D2C4C2D0A8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 18:07:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE8452074A
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 18:07:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ASKsH6oF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE8452074A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43520 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMxYu-00030C-JU
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 14:07:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59946)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kMxW3-00015C-9y
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 14:04:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56349)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kMxW0-00055q-Pk
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 14:04:46 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601316283;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6H0ENIgMfi90Rr94igHyK+xumzn7DVwNMTryKTrr0Pc=;
 b=ASKsH6oFkuQD8WWutpHLQlliLh1lPkDcjzBkrfEfFw1OedlrBLlnhmeXpJmk+ERPPKlpeJ
 VWYlsjJkaDq6OiunFaLoWvi/N9zxy/uzf83xwHh9RPMSky6KxXEaKzDHZLWPuGO0K5UUIR
 wmn+6lVOrXMNibLJYIh2iL4Blk57vPo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-155-jorrPX4GOiKzQCau0qc_6w-1; Mon, 28 Sep 2020 14:04:41 -0400
X-MC-Unique: jorrPX4GOiKzQCau0qc_6w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8BB17425D5;
 Mon, 28 Sep 2020 18:04:40 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-70.ams2.redhat.com
 [10.36.112.70])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5CD547880B;
 Mon, 28 Sep 2020 18:04:40 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id DB541113865F; Mon, 28 Sep 2020 20:04:38 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v6 02/21] qapi/block.json: Add newline after "Example:"
 for block-latency-histogram-set
References: <20200925162316.21205-1-peter.maydell@linaro.org>
 <20200925162316.21205-3-peter.maydell@linaro.org>
 <87sgb2f4xz.fsf@dusky.pond.sub.org>
 <CAFEAcA85d59WbSGko-1W6ck7K3C5RB4avP6_Wte9YAUrgsqs-Q@mail.gmail.com>
Date: Mon, 28 Sep 2020 20:04:38 +0200
In-Reply-To: <CAFEAcA85d59WbSGko-1W6ck7K3C5RB4avP6_Wte9YAUrgsqs-Q@mail.gmail.com>
 (Peter Maydell's message of "Mon, 28 Sep 2020 13:49:22 +0100")
Message-ID: <878sctbww9.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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
Cc: John Snow <jsnow@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> writes:

> On Mon, 28 Sep 2020 at 13:42, Markus Armbruster <armbru@redhat.com> wrote:
>>
>> Peter Maydell <peter.maydell@linaro.org> writes:
>>
>> > The block-latency-histogram-set command is the only one which uses
>> > the Example/Examples section with the first line of the documentation
>> > immediately following the ':'. Bring it into line with the rest.
>> >
>> > This allows us to avoid special-casing the indentation handling for
>> > "Examples" sections; instead for Examples as for any other section
>> > header these two indentations will be equivalent:
>>
>> I figure you're talking about PATCH 5 here.  Correct?
>>
>> If yes, I'd like to tweak this to "This will allow us".  Okay?
>
> Sure. (In my idiolect both those phrasings have pretty much
> identical meaning in this context.)
>
> thanks
> -- PMM

Neglected to say
Reviewed-by: Markus Armbruster <armbru@redhat.com>


