Return-Path: <SRS0=I56D=SL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF1BFC10F0E
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 06:10:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D91820883
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 06:10:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D91820883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36008 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDjyC-0000gc-Mg
	for qemu-devel@archiver.kernel.org; Tue, 09 Apr 2019 02:10:56 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42578)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hDjx7-0008Un-HS
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 02:09:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hDjx6-0003Jl-IG
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 02:09:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:15516)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>)
	id 1hDjx4-0003Gh-39; Tue, 09 Apr 2019 02:09:46 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0A936811A9;
	Tue,  9 Apr 2019 06:09:45 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-116.ams2.redhat.com
	[10.36.116.116])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id CB9595C29A;
	Tue,  9 Apr 2019 06:09:44 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 3A5571138648; Tue,  9 Apr 2019 08:09:43 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Eric Blake <eblake@redhat.com>
References: <20190408083627.7479-1-armbru@redhat.com>
	<20190408083627.7479-3-armbru@redhat.com>
	<3d4cd6c6-49f0-daad-bb1b-25a2456f740f@redhat.com>
Date: Tue, 09 Apr 2019 08:09:43 +0200
In-Reply-To: <3d4cd6c6-49f0-daad-bb1b-25a2456f740f@redhat.com> (Eric Blake's
	message of "Mon, 8 Apr 2019 14:13:08 -0500")
Message-ID: <8736mriuag.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.27]);
	Tue, 09 Apr 2019 06:09:45 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 02/15] block/ssh: Do not report
 read/write/flush errors to the user
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>,
	qemu-devel@nongnu.org, qemu-block@nongnu.org,
	"Richard W.M. Jones" <rjones@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190409060943.L8qIVC8KOToBttd7g-bYePJIpK4qNj6HKnkSSgMpo0k@z>

Eric Blake <eblake@redhat.com> writes:

> On 4/8/19 3:36 AM, Markus Armbruster wrote:
>> Callbacks ssh_co_readv(), ssh_co_writev(), ssh_co_flush() report
>> errors to the user with error_printf().  They shouldn't, it's their
>> caller's job.  Replace by a suitable trace point.
>> 
>> Perhaps we should convert this part of the block driver interface to
>> Error, so block drivers can pass more detail to their callers.  Not
>> today.
>> 
>> Cc: "Richard W.M. Jones" <rjones@redhat.com>
>> Cc: Kevin Wolf <kwolf@redhat.com>
>> Cc: Max Reitz <mreitz@redhat.com>
>> Cc: qemu-block@nongnu.org
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  block/ssh.c        | 36 ++++++++++++------------------------
>>  block/trace-events |  3 +++
>>  2 files changed, 15 insertions(+), 24 deletions(-)
>> 
>
>> -static void GCC_FMT_ATTR(2, 3)
>> -sftp_error_report(BDRVSSHState *s, const char *fs, ...)
>> +static void sftp_error_trace(BDRVSSHState *s, const char *op)
>>  {
>> -    va_list args;
>> +    char *ssh_err;
>> +    int ssh_err_code;
>> +    unsigned long sftp_err_code;
>>  
>> -    va_start(args, fs);
>> -    error_vprintf(fs, args);
>> -
>> -    if ((s)->sftp) {
>
> The old code was conditional,
>
>> -        char *ssh_err;
>> -        int ssh_err_code;
>> -        unsigned long sftp_err_code;
>> -
>> -        /* This is not an errno.  See <libssh2.h>. */
>> -        ssh_err_code = libssh2_session_last_error(s->session,
>> +    /* This is not an errno.  See <libssh2.h>. */
>> +    ssh_err_code = libssh2_session_last_error(s->session,
>>                                                    &ssh_err, NULL, 0);
>
> Indentation looks off now.

Will fix.

>> -        /* See <libssh2_sftp.h>. */
>> -        sftp_err_code = libssh2_sftp_last_error((s)->sftp);
>> +    /* See <libssh2_sftp.h>. */
>> +    sftp_err_code = libssh2_sftp_last_error((s)->sftp);
>
> but it appears the new code can call libssh2_sftp_last_error(NULL). Am I
> missing something, or could that be a problem?
>
> /me rescans the full file...
>
> Okay, connect_to_ssh() won't succeed unless s->sftp is set, and it
> appears that all callers to the trace function can only be reached if
> connect succeeded.

I can add to the commit message

    While there, drop the unreachable !s->sftp case.

> Indentation fixup can be done by maintainer,
> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!

