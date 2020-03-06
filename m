Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D1B7C10F00
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 10:15:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69040207FD
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 10:15:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LbKq73Up"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69040207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAA0t-0006Wy-Gs
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 05:15:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50789)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jAA04-0005vi-CN
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 05:14:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1jAA02-00009l-Md
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 05:14:36 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:42803
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1jAA02-00008V-Iv
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 05:14:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583489674;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NDcrFrDtdIXGzpr2y5MvwvqngvNd3mupNEOy6NUfHdQ=;
 b=LbKq73Up8Qb1IjYvX2rNwFBH5IqdcKRwIFfhC+gnHcol0tFbewBMyNmppKgMGnM0wFY9pT
 3qcn+aMA6Dvz6LU1a9AriWUY0tEBjaBdcTYZ3GgIZdck43mmbe9VKM5mrfQTvYqUusl0K8
 J91opjRapuR32ep54wduwAo8MzjsaRo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-42-pYTzzVQ7OR60QvWKZvrckw-1; Fri, 06 Mar 2020 05:14:30 -0500
X-MC-Unique: pYTzzVQ7OR60QvWKZvrckw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A9516100FA04;
 Fri,  6 Mar 2020 10:14:29 +0000 (UTC)
Received: from linux.fritz.box (unknown [10.36.118.33])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7876D277AD;
 Fri,  6 Mar 2020 10:14:26 +0000 (UTC)
Date: Fri, 6 Mar 2020 11:14:25 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v7 06/10] iotests: limit line length to 79 chars
Message-ID: <20200306101425.GC7240@linux.fritz.box>
References: <20200304213818.15341-1-jsnow@redhat.com>
 <20200304213818.15341-7-jsnow@redhat.com>
 <a23da70f-a46f-acc8-18b4-c1b2e5cea60c@redhat.com>
 <c57333a3-baf3-cc00-7f99-6fce2de91a7f@redhat.com>
 <20200305115548.GA5363@linux.fritz.box>
 <d9500e3c-48d4-8ab2-51c7-9a914dd8ec49@redhat.com>
MIME-Version: 1.0
In-Reply-To: <d9500e3c-48d4-8ab2-51c7-9a914dd8ec49@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: qemu-block@nongnu.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 05.03.2020 um 19:25 hat John Snow geschrieben:
> On 3/5/20 6:55 AM, Kevin Wolf wrote:
> > Am 05.03.2020 um 00:14 hat John Snow geschrieben:
> >>
> >>
> >> On 3/4/20 4:58 PM, Philippe Mathieu-Daud=E9 wrote:
> >=20
> > Adding back the context:
> >=20
> >> -        sys.stderr.write('qemu-img received signal %i: %s\n' % (-exit=
code, ' '.join(qemu_img_args + list(args))))
> >> +        sys.stderr.write('qemu-img received signal %i: %s\n' % (
> >> +            -exitcode, ' '.join(qemu_img_args + list(args))))
> >=20
> >>> Do we want to indent Python like C and align argument below opening
> >>> parenthesis? Except when using sys.stderr.write() you seem to do it.
> >>
> >> This isn't an argument to write, it's an argument to the format string=
,
> >> so I will say "no."
> >=20
> > The argument to write() is an expression. This expression contains the =
%
> > operator with both of its operands. It's still fully within the
> > parentheses of write(), so I think Philippe's question is valid.
> >=20
> >> For *where* I've placed the line break, this is the correct indentatio=
n.
> >> emacs's python mode will settle on this indent, too.
> >>
> >> https://python.org/dev/peps/pep-0008/#indentation
> >=20
> > The PEP-8 examples are not nested, so it's not completely clear. I
> > wonder if hanging indents wouldn't actually mean the following because
> > if you line wrap an argument list (which contains the whole %
> > expression), you're supposed to have nothing else on the line of the
> > opening parenthesis:
> >=20
> >     sys.stderr.write(
> >         'qemu-img received signal %i: %s\n'
> >         % (-exitcode, ' '.join(qemu_img_args + list(args))))
> >=20
>=20
> This is fine too.
>=20
> > But anyway, I think the question is more whether we want to use hanging
> > indents at all (or at least if we want to use it even in cases where th=
e
> > opening parenthesis isn't already at like 70 characters) when we're
> > avoiding it in our C coding style.
> >=20
> > There's no technical answer to this, it's a question of our preferences=
.
> >=20
>=20
> Maybe it is ambiguous. Long lines are just ugly everywhere.
>=20
> >> (If anyone quotes Guido's belittling comment in this email, I will
> >> become cross.)
> >>
> >>
> >> But there are other places to put the line break. This is also
> >> technically valid:
> >>
> >> sys.stderr.write('qemu-img received signal %i: %s\n'
> >>                  % (-exitcode, ' '.join(qemu_img_args + list(args))))
> >>
> >> And so is this:
> >>
> >>     sys.stderr.write('qemu-img received signal %i: %s\n' %
> >>                      (-exitcode, ' '.join(qemu_img_args + list(args)))=
)
> >=20
> > PEP-8 suggests the former, but allows both styles:
> >=20
> > https://www.python.org/dev/peps/pep-0008/#should-a-line-break-before-or=
-after-a-binary-operator
> >=20
>=20
> So in summary:
>=20
> - Avoid nested hanging indents from format operators
> - Use a line break before the % format operator.
> - OPTIONALLY(?), use a hanging indent for the entire format string to
> reduce nesting depth.

Yes, though I don't think of it as a special case for format strings. So
I would phrase it like this:

- Don't use hanging indent for any nested parentheses unless the outer
  parentheses use hanging indents, too.
- Use a line break before binary operators.
- OPTIONALLY, use a hanging indent for the top level(s) to reduce
  nesting depth.

The first one is the only rule that involves some interpretation of
PEP-8, the rest seems to be its unambiguous recommendation.

Anyway, so I would apply the exact same rules to the following (imagine
even longer expressions, especially the last example doesn't make sense
with the short numbers):

* bad:
    really_long_function_name(-1234567890 + 987654321 * (
        1337 / 42))

* ok:
    really_long_function_name(-1234567890 + 987654321
                              * (1337 / 42))

* ok:
    really_long_function_name(
        -1234567890 + 987654321
        * (1337 / 42))

* ok:
    really_long_function_name(
        -1234567890 + 987654321 * (
            1337 / 42))

> e.g., either this form:
> (using a line break before the binary operator and nesting to the
> argument level)
>=20
> write('hello %s'
>       % (world,))
>=20
>=20
> or optionally this form if it buys you a little more room:
> (using a hanging indent of 4 spaces and nesting arguments at that level)
>=20
> write(
>     'hello %s'
>     % ('world',))
>=20
>=20
> but not ever this form:
> (Using a hanging indent of 4 spaces from the opening paren of the format
> operand)
>=20
> write('hello %s' % (
>     'world',))
>=20
>=20
>=20
> yea/nea?
>=20
> (Kevin, Philippe, Markus, Max)

Looks good to me.

Kevin


