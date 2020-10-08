Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F17CC433E7
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 09:17:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC8C1215A4
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 09:17:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CSaofgiJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC8C1215A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47522 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQS3g-00068f-Qn
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 05:17:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51020)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kQS2X-0005f3-Oo
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 05:16:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47743)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kQS2V-0003xW-0I
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 05:16:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602148601;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=n9UX6aHnMVwf8XsrGSFDk9UIal1aH3Mr6xLjmgyJ12E=;
 b=CSaofgiJEGQtWhjzM3+e1pkNU/b6jFmIAXxJ4/oDS+C3D+se+0VU+cC2Egi44yhVaVwraz
 1evw77EqMqTynU2THbDdG8niOYXa0nobs2+vvx5OjQ+lx6ntOXUIK4TrQAr1x1qmjEHxUD
 L19ZDg6lCcvenGk/gEXfhw0XV+3Jofk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-164-wd5iOztqNCShkKchIeqntg-1; Thu, 08 Oct 2020 05:16:39 -0400
X-MC-Unique: wd5iOztqNCShkKchIeqntg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 31392AE823
 for <qemu-devel@nongnu.org>; Thu,  8 Oct 2020 09:16:38 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-182.ams2.redhat.com
 [10.36.112.182])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E0B4219744;
 Thu,  8 Oct 2020 09:16:37 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2701711329C1; Thu,  8 Oct 2020 11:16:36 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v5 19/36] qapi/events.py: add type hint annotations
References: <20201005195158.2348217-1-jsnow@redhat.com>
 <20201005195158.2348217-20-jsnow@redhat.com>
 <87zh4ye0fh.fsf@dusky.pond.sub.org>
 <87pn5ucl3n.fsf@dusky.pond.sub.org>
 <69622744-fb05-2db7-47cf-533a3a3d89ac@redhat.com>
Date: Thu, 08 Oct 2020 11:16:36 +0200
In-Reply-To: <69622744-fb05-2db7-47cf-533a3a3d89ac@redhat.com> (John Snow's
 message of "Wed, 7 Oct 2020 11:46:46 -0400")
Message-ID: <87v9fl13ij.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=63.128.21.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/08 01:56:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.742,
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
Cc: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

John Snow <jsnow@redhat.com> writes:

> On 10/7/20 7:49 AM, Markus Armbruster wrote:
>> Looks like commit message of PATCH 24 has an answer.
>> Copy to all the commits that omit -> None similarly?
>
> Probably not needed.
>
> It's covered by the class basics section in the mypy manual;
> https://mypy.readthedocs.io/en/stable/class_basics.html#annotating-init-methods
>
> and if you should happen to omit annotations for __init__ entirely as
> a novice, you will be treated to messages such as these:
>
> qapi/source.py:18: error: Function is missing a return type annotation
> qapi/source.py:18: note: Use "-> None" if function does not return a value
> Found 1 error in 1 file (checked 14 source files)
>
> Pretty good error!
>
> There's no error if you DO explicitly add a -> None from __init__, but
> at worst it's just extraneous (but correct) information.

Let me apply the zero-one-infinity rule:

* Zero: explain it in none of the commit messages, i.e. dumb down PATCH
  24.

* One: explain it in one.  Do it in the first one, please (here, I
  think).

* Infinity: explain it in every one.

Up to you!

> I could add a note to the style guide that I prefer omitting the
> return from __init__. I like omitting as much as I possibly can.
>
> (You'll notice I don't always type every local, either -- when local
> inference is accurate, I leave it alone.)

Type inference can save us from repeating the obvious over and over, and
that's lovely.


