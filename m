Return-Path: <SRS0=xvb4=SS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,TRACKER_ID,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14E13C282DA
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 19:29:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9BF620821
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 19:29:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9BF620821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41665 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGTls-0001gV-V1
	for qemu-devel@archiver.kernel.org; Tue, 16 Apr 2019 15:29:33 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36819)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hGTkV-0000fZ-JS
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 15:28:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hGTkU-0007zh-Lv
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 15:28:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38940)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hGTkU-0007yo-Dn
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 15:28:06 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A667A3082133;
	Tue, 16 Apr 2019 19:28:04 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-116.ams2.redhat.com
	[10.36.116.116])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 6812B1001E8C;
	Tue, 16 Apr 2019 19:28:02 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id EDA5E1138648; Tue, 16 Apr 2019 21:28:00 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Eric Blake <eblake@redhat.com>
References: <20190416153850.5186-1-armbru@redhat.com>
	<5ee06a0b-90bc-602d-5ee3-3bb3f80f2f6c@redhat.com>
Date: Tue, 16 Apr 2019 21:28:00 +0200
In-Reply-To: <5ee06a0b-90bc-602d-5ee3-3bb3f80f2f6c@redhat.com> (Eric Blake's
	message of "Tue, 16 Apr 2019 10:50:41 -0500")
Message-ID: <87h8ax3g3j.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.42]);
	Tue, 16 Apr 2019 19:28:04 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] error: Fix error_report_err(),
 warn_report_err() hint printing
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
Cc: vsementsov@virtuozzo.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190416192800.D_gJThYa8NDljlodoDhnfE_xM2NEUcu6pcQ-jbvi3bE@z>

Eric Blake <eblake@redhat.com> writes:

> On 4/16/19 10:38 AM, Markus Armbruster wrote:
>> Before the from qerror_report() to error_setg(), hints looked like
>
> s/the from/the change from/
>
>> this:
>> 
>>     qerror_report(QERR_MACRO, ... arguments ...);
>>     error_printf_unless_qmp(... hint ...);
>> 
>> error_printf_unless_qmp() made perfect sense: it printed exactly when
>> qerror_report() did.
>> 
>> After the conversion to error_setg():
>
> Commit id?

Many.  From the cover letter of the series that finally killed
qerror_report: "After a bit over a year and many patches, QError is
finally ripe."

Here are two known to have messed up hints (commit 50b7b000c91 says so):

7216ae3d1a11e07192623ad04d450e98bf1f3d10
d282842999b914c38c8be4659012aa619c22af8b

>> 
>>     error_setg(errp, QERR_MACRO, ... arguments ...);
>>     error_printf_unless_qmp(... hint ...);
>> 
>> The "unless QMP part" still made some sense; in QMP context, the
>> caller generally uses the error as QMP response instead of printing
>> it.
>> 
>> However, everything else is wrong.  If the caller handles the error,
>> the hint gets printed anyway (unless QMP).  If the caller reports the
>> error, the hint gets printed *before* the report (unless QMP) or not
>> at all (if QMP).
>> 
>> Commit 50b7b000c91 fixed this by making hints a member of Error.  It
>
> Belongs to 2.5.0.
>
>> kept printing hints with error_printf_unless_qmp():
>> 
>>      void error_report_err(Error *err)
>>      {
>> 	 error_report("%s", error_get_pretty(err));
>>     +    if (err->hint) {
>>     +        error_printf_unless_qmp("%s\n", err->hint->str);
>>     +    }
>> 	 error_free(err);
>>      }
>> 
>> This is wrong.  We should (and now can) print the hint exactly when we
>> print the error.
>> 
>> The mistake has since been copied to warn_report_err().
>
> Commit id?

e43ead1d0b9c467af4a2af8f5177316a0ccb5602

>> 
>> Fix both to use error_printf().
>> 
>> Reported-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> Cc: Eric Blake <eblake@redhat.com>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  util/error.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>> 
>
> Probably too late for 4.0-rc4. Then again, it regressed in 2.5, so
> having yet one more release with the lame output doesn't hurt.
>
> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!

