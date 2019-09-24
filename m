Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BF0EC432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 20:37:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DD5B2146E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 20:37:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DD5B2146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCrZB-0005xz-2s
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 16:37:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52003)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iCrXI-0004LM-PU
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 16:35:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iCrXG-0006nb-2u
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 16:35:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49076)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iCrXF-0006nE-Cq
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 16:35:45 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A77C7356C5;
 Tue, 24 Sep 2019 20:35:44 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-142.ams2.redhat.com
 [10.36.117.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C980360C5D;
 Tue, 24 Sep 2019 20:35:41 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5B602113864E; Tue, 24 Sep 2019 22:35:40 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH 06/25] qapi: Change frontend error messages to start with
 lower case
References: <20190924132830.15835-1-armbru@redhat.com>
 <20190924132830.15835-7-armbru@redhat.com>
 <ab13d1b0-319c-1f57-de17-1718090f0e25@redhat.com>
Date: Tue, 24 Sep 2019 22:35:40 +0200
In-Reply-To: <ab13d1b0-319c-1f57-de17-1718090f0e25@redhat.com> (Eric Blake's
 message of "Tue, 24 Sep 2019 10:17:16 -0500")
Message-ID: <875zlha0v7.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Tue, 24 Sep 2019 20:35:44 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Cc: marcandre.lureau@redhat.com, qemu-devel@nongnu.org,
 mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eric Blake <eblake@redhat.com> writes:

> On 9/24/19 8:28 AM, Markus Armbruster wrote:
>> Starting error messages with a capital letter complicates things when
>> text can get interpolated both at the beginning and in the middle of
>> an error message.  The next patch will do that.  Switch to lower case
>> to keep it simpler.
>>=20
>> For what it's worth, the GNU Coding Standards advise the message
>> "should not begin with a capital letter when it follows a program name
>> and/or file name, because that isn=E2=80=99t the beginning of a sentence=
. (The
>> sentence conceptually starts at the beginning of the line.)"
>
> We're inconsistent throughout the code base, but this is one place where
> I like the GCS rationale.  Fixing it everywhere may not be worth the
> churn, but fixing it within the subset of the qapi generator is worthwhil=
e.
>
>>=20
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  scripts/qapi/common.py                        | 175 +++++++++---------
>>  tests/qapi-schema/alternate-any.err           |   2 +-
>
>>  tests/qapi-schema/unknown-expr-key.err        |   2 +-
>>  125 files changed, 215 insertions(+), 204 deletions(-)
>>  create mode 100644 tests/qapi-schema/escape-too-big.err
>>  create mode 100644 tests/qapi-schema/string-control.err
>>  create mode 100644 tests/qapi-schema/string-unclosed.err
>>  create mode 100644 tests/qapi-schema/string-unicode.err
>
> Umm, what's going on here?

Accident.

> You'll want to either drop these files (if they were leftovers in your
> working directory from previous points in time), or defer their addition
> to when the corresponding actual tests exist.

I'll drop them,

>>      def get_doc(self, info):
>>          if self.val !=3D '##':
>> -            raise QAPIParseError(self, "Junk after '##' at start of "
>> -                                 "documentation comment")
>> +            raise QAPIParseError(
>> +                self, "junk after '##' at start of documentation commen=
t")
>
> Reformatting like this also makes grepping for a particular message easie=
r.
>
>
>> @@ -868,8 +869,8 @@ def check_union(expr, info):
>>          enum_values =3D members.keys()
>>          allow_metas =3D ['built-in', 'union', 'alternate', 'struct', 'e=
num']
>>          if base is not None:
>> -            raise QAPISemError(info, "Simple union '%s' must not have a=
 base" %
>> -                               name)
>> +            raise QAPISemError(
>> +                info, "simple union '%s' must not have a base" % name)
>>=20=20
>
> A bit odd that you reformat here to get the second argument all on one
> line...
>
>>      # Else, it's a flat union.
>>      else:
>> @@ -878,46 +879,47 @@ def check_union(expr, info):
>>                     base, allow_dict=3Dname,
>>                     allow_metas=3D['struct'])
>>          if not base:
>> -            raise QAPISemError(info, "Flat union '%s' must have a base"
>> +            raise QAPISemError(info, "flat union '%s' must have a base"
>>                                 % name)
>
> ...but not here.  The reformatting is not the primary focus of the
> patch, and doesn't hurt semantically whether or not you do it, but maybe
> it is worth calling out in the commit message the criteria you used for
> deciding when to reformat, and/or make the patch strive for more
> consistency.

I admit I wobble between

    raise QAPISemError(info, "some lengthy error message text with %s"
                       % argument)

and

    raise QAPISemError(info,
                       "some lengthy error message text with %s" % argument)

and

    raise QAPISemError(
        info, "some lengthy error message text with %s" % argument)

The first looks okay, but as a rule, lines should be broken at an
operator with lowest precedence.

The second tends to produce long lines.

I'm still getting used to the third.

>               I'll leave that up to you; fixing the spurious new files,
> and making your choice of where to place the linebreaks, doesn't affect
> my ability to offer:
>
> Reviewed-by: Eric Blake <eblake@redhat.com>

I'll have another look.

Thanks!

