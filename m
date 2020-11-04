Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD933C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 17:21:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D15620795
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 17:21:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FigQWPwN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D15620795
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41110 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaMTE-0006r0-5y
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 12:21:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59900)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kaMS6-0005n5-BB
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 12:20:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47210)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kaMS4-0007Ci-Kb
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 12:20:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604510404;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pBu1OYn62X4A+4kHBo5v4OAkGqLE6PPu7VnFJSn6N64=;
 b=FigQWPwNgwSkZz1f23eIWMy6rJSOC7QJnyytXjjaWuPJT7PLiFDGazfQl4si2Fm2jtooXH
 +QFCI69OaI3c4dP9/ygPMjnzjIzFFHSa4TBro5k9zT7XI8CqBoFE2kShRn33VHq6T53v1E
 kuqLei6ruuiysAHDx6jYs8JG4SXPz3o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-463-yin1xKdEMuS2OgM0faxjuQ-1; Wed, 04 Nov 2020 12:19:58 -0500
X-MC-Unique: yin1xKdEMuS2OgM0faxjuQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C50FC8015B1;
 Wed,  4 Nov 2020 17:19:57 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.194.145])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 800C76F142;
 Wed,  4 Nov 2020 17:19:56 +0000 (UTC)
Subject: Re: [PATCH v2] block: Remove unused BlockDeviceMapEntry
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20201030062434.3629438-1-armbru@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <9827132c-9c33-bae8-d344-fcd88ac8d843@redhat.com>
Date: Wed, 4 Nov 2020 18:19:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201030062434.3629438-1-armbru@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 00:03:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 30.10.20 07:24, Markus Armbruster wrote:
> BlockDeviceMapEntry has never been used.  It was added in commit
> facd6e2 "so that it is published through the introspection mechanism."
> What exactly introspecting types that aren't used for anything could
> accomplish isn't clear.  What "introspection mechanism" to use is also
> nebulous.  To the best of my knowledge, there has never been one that
> covered this type.  Certainly not query-qmp-schema, which includes
> only types that are actually used in QMP.
> 
> Not being able to introspect BlockDeviceMapEntry hasn't bothered
> anyone enough to complain in almost four years.  Get rid of it.
> 
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Eric Blake <eblake@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
> I found an old patch I neglected to merge.
> 
> Max replied to a remark in Eric's review of v1:
> 
>     Max Reitz <mreitz@redhat.com> writes:
> 
>     > On 2017-07-28 20:10, Eric Blake wrote:
>     >> This type is the schema for 'qemu-img map --output=json'.  And I had a
>     >> patch once (that I need to revive) that added a JSON Output visitor; at
>     >> which point I fixed qemu-img to convert from QAPI to JSON instead of
>     >> open-coding its construction of its output string, at which point the
>     >> QAPI generated code for this type is useful.
>     > (Very late reply, I know, I just stumbled over *MapEntry when looking
>     > over block-core.json what we might want to deprecate in 3.0)
>     >
>     > We already use MapEntry there -- why don't we output just that instead?
>     > The only difference seems to be an additional @filename parameter which
>     > would probably be actually nice to include in the output.
>     >
>     > Except that BlockDeviceMapEntry's documentation is better, so we should
>     > merge that into MapEntry before removing the former.
>     >
>     > Max
> 
> https://lists.nongnu.org/archive/html/qemu-devel/2017-12/msg02933.html
> 
> Me doing the doc update Max suggested could take more than one
> iteration, as I know nothing about this stuff.  Max, could you give it
> a try?  Feel free to take over my patch.

Thanks, done :)

https://lists.nongnu.org/archive/html/qemu-block/2020-11/msg00143.html

Max


