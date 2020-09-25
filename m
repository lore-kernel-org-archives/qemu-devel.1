Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAD00C4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 07:50:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 348A9206C3
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 07:50:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DKHosU9W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 348A9206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLiUg-0007gs-Qm
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 03:50:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37546)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kLiU8-0007GQ-LE
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 03:49:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:32684)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kLiU6-00064t-C7
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 03:49:40 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601020177;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XFWhY6ADkiA2L7gQ47jjDU3nGrb7QML0Rmkmd9wvsVs=;
 b=DKHosU9WUWWEZ9OT4HbnJANC7ovrhxoe0DysM5soU1xDejfMspolX7fGAk8ucRhIbJpTyL
 5AtcINWKFxS2379Ow4dHKdXKQPp60gI5ocsCi+XrPT5OhHWdClMzKOI3YsExOLKcetQnjZ
 sBJf9Mv/dUv0/JO93ZzU/G4lAb6IBqs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-578-8Mhki_AsMRy4TxobYOwR-A-1; Fri, 25 Sep 2020 03:49:33 -0400
X-MC-Unique: 8Mhki_AsMRy4TxobYOwR-A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 684B5800E23;
 Fri, 25 Sep 2020 07:49:32 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-70.ams2.redhat.com
 [10.36.112.70])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3794760C07;
 Fri, 25 Sep 2020 07:49:32 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C053A113865F; Fri, 25 Sep 2020 09:49:30 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH 14/37] qapi/common.py: Move comments into docstrings
References: <20200915224027.2529813-1-jsnow@redhat.com>
 <20200915224027.2529813-15-jsnow@redhat.com>
 <87d02kpizr.fsf@dusky.pond.sub.org>
 <49e28f59-012c-9b7b-02b7-1854f85884b2@redhat.com>
 <20200917191455.GX7594@habkost.net>
 <3b1ce70b-377d-144f-9331-4f6da4c93f6f@redhat.com>
 <87a6xf8b9a.fsf@dusky.pond.sub.org>
 <7a58ccb0-8b54-38e9-316d-c8b7690b6ea1@redhat.com>
Date: Fri, 25 Sep 2020 09:49:30 +0200
In-Reply-To: <7a58ccb0-8b54-38e9-316d-c8b7690b6ea1@redhat.com> (John Snow's
 message of "Thu, 24 Sep 2020 12:31:56 -0400")
Message-ID: <87eemq1ek5.fsf@dusky.pond.sub.org>
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
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 01:07:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Cleber Rosa <crosa@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

John Snow <jsnow@redhat.com> writes:

> On 9/24/20 11:06 AM, Markus Armbruster wrote:
>> John Snow <jsnow@redhat.com> writes:
>> 
>>> On 9/17/20 3:14 PM, Eduardo Habkost wrote:
>>>> On Thu, Sep 17, 2020 at 02:44:53PM -0400, John Snow wrote:
>>>> [...]
>>>>> Having said this, I have not found any tool to date that actually *checks*
>>>>> these comments for consistency. The pycharm IDE interactively highlights
>>>>> them when it senses that you have made a mistake, but that cannot be worked
>>>>> into our CI process that I know of - it's a proprietary checker.
>>>>>
>>>>> So right now, they're just plaintext that I am writing to approximate the
>>>>> Sphinx style until such time as I enable autodoc for the module and
>>>>> fine-tune the actual formatting and so on.
>> You are deliberately trying to "approximate" Sphinx style, and ...
>> 
>>>> After applying this series, I only had to make two small tweaks
>>>> to make Sphinx + autodoc happy with the docstrings you wrote.
>>>> With the following patch, "make sphinxdocs" will generate the
>>>> QAPI Python module documentation at docs/devel/qapi.html.
>>>> I had to explicitly skip qapi/doc.py because autodoc thinks the
>>>> string constants are documentation strings.
>>>>
>>>
>>> Awesome!
>> ... actually almost nail it.
>> Please mention your choice of style in the commit message.
>> 
>
> OK, I'll try to summarize it. I guess I'll do it in this commit
> message, but it's not likely to be too visible in the future that way,
> depending on how you run git blame and what you're looking at.

Thanks!

> I want to resurface my other python style patches soon; perhaps a
> python coding style document should go in alongside those patches.
>
>>> I think I am going to delay explicitly pursuing writing a manual for
>>> the QAPI parser for now, but it's good to know I am not too far
>>> off. I'm going to target the mypy conversions first, because they can
>>> be invasive and full of churn.
>>>
>>> When I get there, though ... I am thinking I should add this as
>>> Devel/QAPI Parser.
>> Doing "actually Sphinx style" instead of "an approximation of Sphinx
>> style" would reduce churn later on.  So, if it's not too distracting...
>> 
>
> Yes, I just mean in terms of rebasing, docstrings and signatures fight
> with each other for context and make re-spinning 125 patches a major 
> chore. I wasn't prepared to have the debate on if we wanted to add
> Python code into the Sphinx generator and have that entire discussion
> yet.
>
> So, I figured it would be a separate series afterwards. I mentioned
> somewhere else that I anticipated doing it when I removed the 
> "missing-docstring" warning.
>
> I will investigate doing it (using Eduardo's patches) as a starting
> point while reviews continue to filter in. If I figure it out in time,
> I might squash the formatting changes in, but leave the sphinx
> enablement patches themselves out.

Use your judgement.


