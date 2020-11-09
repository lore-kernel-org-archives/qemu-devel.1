Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF839C56201
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 08:05:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34CE1206B6
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 08:05:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RCnrDLMy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34CE1206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38598 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kc2B9-000148-57
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 03:05:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34886)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kc2AM-0000eE-2Y
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 03:04:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28680)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kc2AK-0007yX-Cj
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 03:04:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604909079;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LW/fnjVRGqHOcyGQzH6La0cxu6bpqxv375Mkj1jQEzY=;
 b=RCnrDLMyzwDMyPK9jqBntr+dBEqfudk3R7XEwJyVGVndwI/M+VkMhXp2Og/GVpnVBcAhfZ
 GusaZdvnWqhm03d0LrCl5xQX06h8MWND7gZ89WfjdJEp6PMoQYrZIb1rhPty5tCSwJEiI1
 YB+5IhpEEsYXlraixLQik5XY5YKwNNo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-471-x3ZTX-gGOqKzAU2QhuqFJg-1; Mon, 09 Nov 2020 03:04:37 -0500
X-MC-Unique: x3ZTX-gGOqKzAU2QhuqFJg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 07F6910866A0;
 Mon,  9 Nov 2020 08:04:36 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-53.ams2.redhat.com [10.36.112.53])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BF36C5D9DC;
 Mon,  9 Nov 2020 08:04:30 +0000 (UTC)
Subject: Re: Migrating to the gitlab issue tracker
To: Peter Maydell <peter.maydell@linaro.org>
References: <3713093e-bf3b-bf23-a8d0-70fe429032ba@redhat.com>
 <c7308133-cf29-8668-f781-6d025eb16722@redhat.com>
 <3d9b264a-5e1f-b936-8455-bafc6b89ebe5@redhat.com>
 <20201030092324.GC99222@redhat.com>
 <CAFEAcA_8PKkfeninOXCzPdtY7WVHnC7Pkon758zXe7h9MzS+aw@mail.gmail.com>
 <20201030101013.GG99222@redhat.com>
 <CAFEAcA9crYaa8-guWkYFDYgEi8=gH3xaXraD7iWZMHM6vryAtw@mail.gmail.com>
 <c75f91b7-6972-9e48-efa9-49792fc011d2@redhat.com>
 <37a00b98-428b-d1ca-79c2-7846ccfda651@redhat.com>
 <de1d3c49-967b-bc96-220f-3deabc441dfa@redhat.com>
 <20201105155006.GP630142@redhat.com>
 <72985bcf-668d-7472-192f-502963d2b6ad@redhat.com>
 <CAFEAcA_dT_RQ8Pmk_S=zCSu1tUbptuP0+rtrsS55tEg+XD=S2Q@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <bef46169-9fec-eaff-5606-18d355cde0d6@redhat.com>
Date: Mon, 9 Nov 2020 09:04:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_dT_RQ8Pmk_S=zCSu1tUbptuP0+rtrsS55tEg+XD=S2Q@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/09 00:04:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Cc: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 John Snow <jsnow@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Alistair Francis <alistair23@gmail.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 08/11/2020 12.58, Peter Maydell wrote:
> On Sun, 8 Nov 2020 at 09:01, Thomas Huth <thuth@redhat.com> wrote:
>> I agree with Daniel. Please let's not clog the new bug tracker right from
>> the start with hundreds of bugs - that only makes it harder to focus on the
>> tickets that are really important. Let's use the migration instead to start
>> as clean as possible again.
> 
> I really don't like doing this kind of thing. It basically
> tells bug reporters "we don't care about your reports".

But all those bugs that got stale and did not receive an answer within years
certainly give the same impression to the reporters.

> We ought to at least triage them. Certainly for arm a
> lot of the reports in LP are real bug reports which we
> shouldn't just drop on the floor.

Ok, then let's do it this way:

- Let's do *not* automatically close bugs directly

- Let's try to do at least some basic triage. If bugs are
  obviously still present, there is no need to mark them
  as incomplete. For all other bugs, let's ask whether they
  are still important and mark them ask incomplete so that
  they can expire if nobody cares anymore.

- Should I assign opened arm bugs that I find along the way
  to you, Peter, so you can triage them?

- Let's not auto-migrate any bugs within the next weeks and
  wait 'till the LP bug triage has been done.

- I think we could already update the links on the website
  to the new bug tracker at gitlab to get some more experience
  with the new bug tracker. That of course means that we would
  be using two bug tracker during the next weeks or months,
  but I think that's ok if we set a final date for the complete
  switch (e.g. at the end of the LP bug expiration period, so
  something like January 2021)

Sounds like a plan?

 Thomas


