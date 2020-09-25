Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 824C3C4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 05:52:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B056020838
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 05:52:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VzLQxL/r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B056020838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLgf8-0001VC-Ks
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 01:52:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44078)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kLge1-000131-TT
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 01:51:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:38483)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kLgdz-0001GF-Lf
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 01:51:45 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601013102;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bxHix8vbCCKj6liSLuZ8Breesi6xYlgfMyxQ0wtvNgM=;
 b=VzLQxL/ryzM9X2sPzSHMehIjIFDURxDBKoOk9hqPJOEO5/urszUm4Y0UPtSIiExv8fsm/B
 t5fyQqjja3dTgGe7FbkVAxqBdZ9JUBYMhzqfpk8bnuiDizbtxb08nql9f+li3Op7rTIOjf
 mWkF4iro4cpxxy2vU0BO+TEPDyjBYCk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-194--XO8CUfDNMe45GDghyON1w-1; Fri, 25 Sep 2020 01:51:36 -0400
X-MC-Unique: -XO8CUfDNMe45GDghyON1w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9B453425DD;
 Fri, 25 Sep 2020 05:51:35 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-70.ams2.redhat.com
 [10.36.112.70])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 57BDE5C1D7;
 Fri, 25 Sep 2020 05:51:35 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D851C113865F; Fri, 25 Sep 2020 07:51:33 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v5 09/20] docs/sphinx: Add new qapi-doc Sphinx extension
References: <20200810195019.25427-1-peter.maydell@linaro.org>
 <20200810195019.25427-10-peter.maydell@linaro.org>
 <875z8t913t.fsf@dusky.pond.sub.org>
 <CAFEAcA_X6gA7XTAXwcCLa-08UWpwg_AhBVKyTfsDrq53R4rH0A@mail.gmail.com>
 <CAFEAcA-7BW-FabdC4YmnKbG0D9yUfbBcxOeFeKHac05qkUn9cQ@mail.gmail.com>
Date: Fri, 25 Sep 2020 07:51:33 +0200
In-Reply-To: <CAFEAcA-7BW-FabdC4YmnKbG0D9yUfbBcxOeFeKHac05qkUn9cQ@mail.gmail.com>
 (Peter Maydell's message of "Thu, 24 Sep 2020 17:30:37 +0100")
Message-ID: <87eemq5rq2.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> writes:

> On Mon, 21 Sep 2020 at 19:06, Peter Maydell <peter.maydell@linaro.org> wrote:
>> (I've just noticed that with Sphinx 1.6, which we still have
>> to support, the file/line info isn't passed through, so you get:
>>
>> Warning, treated as error:
>> /home/petmay01/linaro/qemu-from-laptop/qemu/docs/interop/qemu-qmp-ref.rst:7:Bullet
>> list ends without a blank line; unexpected unindent.
>>
>> The plugin has code borrowed from kerneldoc.py which is
>> *supposed* to handle the older API Sphinx 1.6 used, but it
>> looks like it's broken. I'll have a look and see if it
>> is fixable, but possibly we may have to live with people
>> developing on old distros getting suboptimal errors.)
>
> Tracked down the cause of this -- it turns out that if you
> feed nested_parse_with_titles() bogus rST then in some
> cases it will detect the error with a line number that's
> one off the end of the input text, eg on the 2 lines:
> 0: * a bulleted list
> 1: a misindented line
>
> there's a syntax error here where line 1 is misindented,
> but at least Sphinx 1.6 wants to attribute the error to a
> nonexistent line 2, which then doesn't match in the
> input-lines-to-source-info mapping for the fragment
> and so gets reported for the next level out (the .rst file).
> It just happened that the syntax error I used to test the
> file/line reporting this time around was one of this kind.

Lucky!

> I assume Sphinx 3 either gets the line attribution more
> accurate or is not using the same mechanism for finding
> the input line in the source mapping.
>
> The fix is just to always add a blank line at the end of
> every .rst fragment we hand to the Sphinx parser, which
> doesn't affect the generated output and does sidestep this
> issue.

Sounds good, as long as it has a comment explaining why we need this.


