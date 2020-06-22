Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97305C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 08:13:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 615B9206D4
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 08:13:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iw2ynLgB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 615B9206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50856 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnHZv-0004A5-NC
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 04:13:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59018)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jnHYs-0003S3-5H
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 04:12:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46026
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jnHYq-0006MS-AY
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 04:12:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592813531;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ln6sPXc1yu1Wx8IzGGYx4x46BuVGfWg9Mnw7BZnmYV4=;
 b=iw2ynLgBD3I1dlKsnXBrkMq6EU7bYfEDSw+i4RRBiV+YXcIZoobUTGxG8GFDAhpDvrPMQf
 uNS+LvbdMfgJWSXviZnr2ZqUjLsQhSnsc4Hk8J0faxwykMHK+YEYnkPYbhTgoEz606TVvu
 Ag3cDxak3IbLTXpdXd0d6ntRFlOQuF0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-86-qRiW5apiNcez3ztuSBJoZQ-1; Mon, 22 Jun 2020 04:12:07 -0400
X-MC-Unique: qRiW5apiNcez3ztuSBJoZQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DA462107ACF3;
 Mon, 22 Jun 2020 08:12:06 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-121.ams2.redhat.com
 [10.36.112.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BBD2A5C220;
 Mon, 22 Jun 2020 08:12:03 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 30F96113846D; Mon, 22 Jun 2020 10:12:02 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Michal Privoznik <mprivozn@redhat.com>
Subject: Re: [PATCH v2 2/2] qemu-options.hx: Document hmat-lb and hmat-cache
 order
References: <cover.1591794890.git.mprivozn@redhat.com>
 <5bd3f4a03227658cbdb1d184518c7805c1c0122f.1591794890.git.mprivozn@redhat.com>
 <877dw8bvu5.fsf@dusky.pond.sub.org>
 <8de1babf-0925-eda0-9d30-a765aff0c4df@redhat.com>
Date: Mon, 22 Jun 2020 10:12:02 +0200
In-Reply-To: <8de1babf-0925-eda0-9d30-a765aff0c4df@redhat.com> (Michal
 Privoznik's message of "Tue, 16 Jun 2020 08:46:11 +0200")
Message-ID: <878sgfr031.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=205.139.110.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/22 01:27:42
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
Cc: Igor Mammedov <imammedo@redhat.com>, Tao Xu <tao3.xu@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Liu Jingqi <jingqi.liu@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Michal Privoznik <mprivozn@redhat.com> writes:

> On 6/15/20 10:02 AM, Markus Armbruster wrote:
>> Michal Privoznik <mprivozn@redhat.com> writes:
>>
>>> To simplify internal implementation the hmat-cache parsing code
>>> expects hmat-lb to be already parsed. This means, that hmat-lb
>>> arguments must come before hmat-cache. Document this restriction
>>> so that management applications can follow it.
>>>
>>> Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
>>> ---
>>>   qemu-options.hx | 3 +++
>>>   1 file changed, 3 insertions(+)
>>>
>>> diff --git a/qemu-options.hx b/qemu-options.hx
>>> index b1a399079a..3fe9e6d6a0 100644
>>> --- a/qemu-options.hx
>>> +++ b/qemu-options.hx
>>> @@ -319,6 +319,9 @@ SRST
>>>       'none/direct(direct-mapped)/complex(complex cache indexing)'. policy
>>>       is the write policy. line is the cache Line size in bytes.
>>>   +    Please note, that due to internal implementation, '\
>>> ``hmat-cache``\ '
>>> +    must be configured only after '\ ``hmat-lb``\ ' option.
>>> +
>>>       For example, the following options describe 2 NUMA nodes. Node 0 has
>>>       2 cpus and a ram, node 1 has only a ram. The processors in node 0
>>>       access memory in node 0 with access-latency 5 nanoseconds,
>>
>> What happens when we do it wrong?
>>
>
> We error out.
>
> https://lists.nongnu.org/archive/html/qemu-devel/2020-05/msg08409.html

Good.

>> Can we catch doing it wrong somehow?  I figure that would be much better
>> than merely documenting it.
>>
>
> Sure, but that would require some more code (according to Igor's
> e-mail and discussion linked from the linked document). And frankly,
> to libvirt it doesn't matter. For everybody else, let's document it at
> least and if somebody ever writes the missing piece we can remove the
> restriction from the docs.

Misunderstanding.  By "catch doing it wrong", I mean "error out when
hmat-cache is configured before hmat-lb".  I understand we do that.

Avoiding the restriction entirely would be even better, but the
maintainer obviously decided it was not worth the trouble.  I gladly
defer to the maintainer here.

Given the general undocumentedness of similar restrictions elsewhere, I
can't bring myself to care for documenting this one.  Up to the
maintainer.


