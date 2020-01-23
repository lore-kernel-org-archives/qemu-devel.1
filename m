Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 473D0C33CAA
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 21:24:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B99220704
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 21:24:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YCcqXwhF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B99220704
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34244 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iujxr-0003rf-7R
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 16:24:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56192)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lersek@redhat.com>) id 1iujxH-0003St-Ge
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 16:24:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lersek@redhat.com>) id 1iujxF-0006CT-Nk
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 16:23:59 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42878
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lersek@redhat.com>) id 1iujxF-0006BR-K1
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 16:23:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579814637;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jihn4Ua6RA0yDEWVJV96UM8M4El4Lu/tm4W/WzfTzpI=;
 b=YCcqXwhF3PM5TwLTYeBAu6lmh3/FhynXe8VGgzuSEl8yI9WVks99d7zOfYIeSxX7ZQJ+Jy
 Y7ngm7pvUfAYSb8Qs/+4AAQSZx8DIioD1+Lr5GJRghhkIiPpFw9gzla4btSHbGAaW6lb28
 ttyybSPu6R2MUFKQcjSiZFjW5cFJXkQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-112-W9TWAksHNCCRODdbVl8VCQ-1; Thu, 23 Jan 2020 16:23:52 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E36DB18C8C1E;
 Thu, 23 Jan 2020 21:23:51 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-117-226.ams2.redhat.com
 [10.36.117.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A54DD1084381;
 Thu, 23 Jan 2020 21:23:48 +0000 (UTC)
Subject: Re: Maintainers, please add Message-Id: when merging patches
To: Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>
References: <CAJSP0QX22cYJvnpb+zDDXLaYg0yY4CV3Jn5QY+ExxJyFcmQ3Gw@mail.gmail.com>
 <20200122122831.GB13482@linux.fritz.box>
 <20200123171857.GC5021@linux.fritz.box>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <7e7ef938-9b6c-065f-6278-3d06aec5e383@redhat.com>
Date: Thu, 23 Jan 2020 22:23:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200123171857.GC5021@linux.fritz.box>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: W9TWAksHNCCRODdbVl8VCQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 01/23/20 18:18, Kevin Wolf wrote:
> Am 22.01.2020 um 13:28 hat Kevin Wolf geschrieben:
>> Am 22.01.2020 um 13:02 hat Stefan Hajnoczi geschrieben:
>>> Around 66% of qemu.git commits since v4.1.0 include a Message-Id: tag.  Hooray!
>>>
>>> Message-Id: references the patch email that a commit was merged from.
>>> This information is helpful to anyone wishing to refer back to email
>>> discussions and patch series.
>>>
>>> Please use git-am(1) -m/--message-id or set am.messageid in your git-config(1).
>>
>> I've had -m in my scripts for a while (last time someone asked me to
>> make the change, I guess), but it wasn't effective, because my .muttrc
>> has 'set pipe_decode' enabled, which doesn't only decode the output, but
>> also throws away most headers.
>>
>> I seem to remember that this was necessary at some point because
>> otherwise some mails just wouldn't apply. Maybe 'git am' works better
>> these days and can actually parse the mails that used to give me
>> problems. I'll give it a try and disable pipe_decode.
> 
> Here is the first patch for which it failed for me:
> 
> Message-ID: <20200123124357.124019-1-felipe@nutanix.com>
> 
> The problem seems to be related to line endings because the patch that
> git-apply sees eventually has "\r\n" whereas the file to be patched has
> only "\n".
> 
> If I understand correctly (this is a bit of guesswork after reading man
> pages and trying out a few options), git-mailsplit would normally get
> rid of the "\r". However, this specific patch email is base64 encoded,
> so the encoded "\r" characters survive this stage.
> 
> git-mailinfo later decodes the email, but doesn't seem to do anything
> about "\r" again, so it survives this one as well. This means feeding a
> patch with the wrong line endings to git-apply, which just fails.
> 
> Any suggestion how to fix this? (For this patch, I just enabled
> pipe_decode again, so no Message-Id tag for it.)

In my opinion, the patch you mention is malformed.

I saved it to a local file with Thunderbird, saved the base64-encoded
body to a separate file, and decoded it with a naked "base64 --decode"
invocation. The result is a file with CRLF line terminators.

When someone sends a base64-encoded patch email, that's a statement
(again: IMO) that the patch conforms to the "canonical" checkout (=
working tree) line ending convention. For QEMU, I would think that said
convention dictates LF.

Note: I'm aware that with git, the "internal" representation for
newlines, and the "external" one, are different things. Dependent on
whether one is on Windows vs. Linux, git-checkout will produce CRLF vs.
LF in the working tree, as the "external" newline representation. What
I'm saying is that, if someone sends a base64-encoded patch, that's a
statement that their *external* newline representation matches that of
the people that they expect to apply the patch. Normally, external
representations (i.e., the local working trees' newline representations)
don't have to match each other -- but if a patch is sent with base64
Content-Transfer-Encoding, then I claim that they do.

IOW, I'd simply answer the patch in question with:

"""
Please resend the patch with one of the following options:
- use LF in your local working tree, and keep the base64 C-T-E, or
- keep CRLF in your local working tree, and send with 8bit C-T-E.
"""

As a practical result, if someone develops QEMU in a Windows
environment, they should only use 8bit C-T-E when posting patches.

Strictly my personal opinion, of course.

Thanks,
Laszlo


