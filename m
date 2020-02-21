Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ADADC35666
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 20:11:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3749320578
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 20:11:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GA4beGpw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3749320578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35824 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j5EeE-0005GQ-9i
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 15:11:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48892)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1j5Ed2-0003YT-3i
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 15:10:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1j5Ed0-0007yx-VV
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 15:10:28 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:47362
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1j5Ed0-0007yO-Qu
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 15:10:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582315826;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WasyKTLNX156llRoyrshOAOea3ULgaG5bG4wy7/RODk=;
 b=GA4beGpwBRsEnK7hcFLwXTDDxXwh8ZkP6i5BDfjvUgEsFJxVdnqaX5BVvn/MOdyZk3xp52
 ZfRVNOlp+z7c4WrmdA8a0c5JcD59u8rk1C5ed6EdhJLVdH0Y+nh3AZ36rCcRj32NoGWdFA
 ovMdogCV6mH5Tig7+REaCX2GiE7smM8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-319-7_2tcSxqOXeMiokG8e6nuQ-1; Fri, 21 Feb 2020 15:10:24 -0500
X-MC-Unique: 7_2tcSxqOXeMiokG8e6nuQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D9B3C100DFC7;
 Fri, 21 Feb 2020 20:10:22 +0000 (UTC)
Received: from [10.3.116.90] (ovpn-116-90.phx2.redhat.com [10.3.116.90])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 91B5860499;
 Fri, 21 Feb 2020 20:10:22 +0000 (UTC)
Subject: Re: [PATCH] maint: Include top-level *.rst files early in git diff
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200220162214.3474280-1-eblake@redhat.com>
 <CAFEAcA8p7D_XFZ9e66wWHNSD6fh2yUvFyAM3QVrwBP7oonoCjQ@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <7ffc8c30-020e-ebcc-94d9-70ced216352f@redhat.com>
Date: Fri, 21 Feb 2020 08:33:43 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8p7D_XFZ9e66wWHNSD6fh2yUvFyAM3QVrwBP7oonoCjQ@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/21/20 4:17 AM, Peter Maydell wrote:
> On Thu, 20 Feb 2020 at 16:22, Eric Blake <eblake@redhat.com> wrote:
>>
>> We are converting more doc files to *.rst rather than *.texi.  Most
>> doc files are already listed early in diffs due to our catchall
>> docs/*, but a few top-level files get missed by that glob.
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>> ---
>>
>> Both *.texi and *.rst entries make sense while we are still converting
>> things, but we'll need a followup to drop *.texi when the conversion
>> is complete...
> 
> I was wondering what rst files we had outside docs, and
> the answer is "README.rst, CODING_STYLE.rst and
> tests/acceptance/README.rst".
> 
> (There's a reasonable argument for moving CODING_STYLE.rst to
> docs/devel now; depends how highly you rate having it more
> "discoverable" to new contributors.)

Or even:
git mv CODING_STYLE.rst docs/devel/CODING_STYLE.rst
ln -s docs/devel/CODING_STYLE.rst .
git add CODING_STYLE.rst

to turn it into a git link in the top level for easy discoverabilty on a 
fresh checkout, while still making it part of our overall built 
documentation.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


