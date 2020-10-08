Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 441FCC433E7
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 07:24:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D88C20739
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 07:24:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GaXSc67M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D88C20739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQQHq-0004Ie-7g
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 03:24:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57702)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kQQGn-0003E6-QH
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 03:23:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46492)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kQQGl-0005aL-Eq
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 03:23:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602141798;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TeNbMi8GejadQX58SIV/GBfevrBJLPKCODwyAn6+48U=;
 b=GaXSc67M1Xm++/+G2U4u1pFSCU/KwvtCJ1fNhyaWl1BwkgKvv9L/GlA0suB+vTrsIUGC/K
 Sjf4S0q/db9PFYwuTXltC9//VqxmxkBkDB8U0QJzx9pynCeGkuI8vOtevaDzeNAxQrr+aa
 dHZaquv4jRvZ0M5yx7iEdbsKEW8YV5E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-445-8bpNHaTUMVGmWHOoIz9Apw-1; Thu, 08 Oct 2020 03:23:16 -0400
X-MC-Unique: 8bpNHaTUMVGmWHOoIz9Apw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CE663425D7
 for <qemu-devel@nongnu.org>; Thu,  8 Oct 2020 07:23:15 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-182.ams2.redhat.com
 [10.36.112.182])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9D82D6EF5B;
 Thu,  8 Oct 2020 07:23:15 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2EC4111329C1; Thu,  8 Oct 2020 09:23:14 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: [PATCH v5 11/36] qapi/common.py: Add indent manager
References: <20201005195158.2348217-1-jsnow@redhat.com>
 <20201005195158.2348217-12-jsnow@redhat.com>
 <87d01uifmn.fsf@dusky.pond.sub.org>
 <0a507019-1e59-2967-9c7a-fa3712a74ae0@redhat.com>
 <20201007181830.GZ7303@habkost.net>
Date: Thu, 08 Oct 2020 09:23:14 +0200
In-Reply-To: <20201007181830.GZ7303@habkost.net> (Eduardo Habkost's message of
 "Wed, 7 Oct 2020 14:18:30 -0400")
Message-ID: <87zh4x2nbx.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=216.205.24.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/08 02:56:27
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.742,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eduardo Habkost <ehabkost@redhat.com> writes:

> On Wed, Oct 07, 2020 at 02:08:33PM -0400, John Snow wrote:
>> On 10/7/20 4:50 AM, Markus Armbruster wrote:
>> > John Snow <jsnow@redhat.com> writes:
>> > 
>> > > Code style tools really dislike the use of global keywords, because it
>> > > generally involves re-binding the name at runtime which can have strange
>> > > effects depending on when and how that global name is referenced in
>> > > other modules.
>> > > 
>> > > Make a little indent level manager instead.
>> > > 
>> > > Signed-off-by: John Snow <jsnow@redhat.com>
>> > > Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
>> > > Reviewed-by: Cleber Rosa <crosa@redhat.com>
>> > 
>> > Intentation is a job for QAPIGen (and its subtypes).  But if this patch
>> > is easier to achieve this series' goal, I don't mind.
>> > 
>> 
>> I agree, but refactoring it properly is beyond my capacity right now.
>> 
>> This was the dumbest thing I could do to get pylint/mypy passing, which
>> required the elimination (or suppression) of the global keyword.
>> 
>> Creating a stateful object was the fastest way from A to B.
>
> An even dumber solution could be:
>
>   indent_prefixes = []
>   def push_indent(amount=4):
>       """Add `amount` spaces to indentation prefix"""
>       indent_prefixes.push(' '*amount)
>   def pop_indent():
>       """Revert the most recent push_indent() call"""
>       indent_prefixes.pop()
>   def genindent():
>       """Return the current indentation prefix"""
>       return ''.join(indent_prefixes)
>
> No global keyword involved, and the only stateful object is a
> dumb list.

Ha, this is Dumb with a capital D!  I respect that :)

John, I'm not asking you to switch.  Use your judgement.


