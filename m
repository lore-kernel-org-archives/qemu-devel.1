Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C625C31E49
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 06:43:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCA0F2084A
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 06:43:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCA0F2084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35424 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdUK1-0007ZY-HC
	for qemu-devel@archiver.kernel.org; Wed, 19 Jun 2019 02:43:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51841)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hdUJH-00073G-Uk
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 02:43:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hdUJG-0002ET-SW
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 02:43:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45786)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hdUJG-0001xD-Js
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 02:43:06 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id F07DD30820EA
 for <qemu-devel@nongnu.org>; Wed, 19 Jun 2019 06:42:47 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-85.ams2.redhat.com
 [10.36.116.85])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BE4E55D9D6;
 Wed, 19 Jun 2019 06:42:47 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 329B611386A6; Wed, 19 Jun 2019 08:42:46 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
References: <20190617184903.19436-1-armbru@redhat.com>
 <20190617184903.19436-17-armbru@redhat.com>
 <20190618090153.GE28525@redhat.com>
 <20190618103449.GE4296@localhost.localdomain>
Date: Wed, 19 Jun 2019 08:42:46 +0200
In-Reply-To: <20190618103449.GE4296@localhost.localdomain> (Kevin Wolf's
 message of "Tue, 18 Jun 2019 12:34:49 +0200")
Message-ID: <87lfxy5b4p.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Wed, 19 Jun 2019 06:42:48 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PULL 16/16] vl: Deprecate -mon pretty=... for HMP
 monitors
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
Cc: "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Kevin Wolf <kwolf@redhat.com> writes:

> Am 18.06.2019 um 11:01 hat Daniel P. Berrang=C3=A9 geschrieben:
>> On Mon, Jun 17, 2019 at 08:49:03PM +0200, Markus Armbruster wrote:
>> > From: Kevin Wolf <kwolf@redhat.com>
>> >=20
>> > The -mon pretty=3Don|off switch of the -mon option applies only to QMP
>> > monitors. It's silently ignored for HMP. Deprecate this combination so
>> > that we can make it an error in future versions.
>>=20
>> No objection to merging this PR as is, but how about we extend the
>> deprecation to QMP too ?
>>=20
>> I was responsible for adding this option back in 2010 and I don't
>> think I've used it since 2012 when I added pretty printing support
>> to scripts/qmp/qmp-shell. I struggle to imagine good reasons for
>> using QMP directly with pretty printing, as opposed to doing it
>> via qmp-shell or another wrapper tool.
>
> qemu-iotests uses it. It doesn't only make the output (and espeically
> diffs on failure) much more readable, but in fact also avoids very long
> lines in the refernce output that used to break patch emails when we
> didn't use pretty printing yet.
>
> So let's keep it for QMP, please.

Perhaps we can get rid of it if we find a suitable filter.

Hmm, Python comes with one: "python -m json.tool".  It expects just one
expression, and fails if anything follows:

    $ printf '{"execute": "qmp_capabilities"}\n{"execute": "query-version"}=
\n' | socat UNIX:/work/armbru/images/test-qmp STDIO | python3 -m json.tool
    Extra data: line 2 column 1 (char 134)

To pretty print a sequence of expressions, you have to wrap a loop
around it:

    $ printf '{"execute": "qmp_capabilities"}\n{"execute": "query-version"}=
\n' | socat UNIX:/work/armbru/images/test-qmp STDIO | { while read line; do=
 echo "$line" | python3 -m json.tool; done; }
    {
        "QMP": {
            "version": {
                "qemu": {
                    "micro": 50,
                    "minor": 0,
                    "major": 4
                },
                "package": "v4.0.0-1467-g6385dd6613"
            },
            "capabilities": [
                "oob"
            ]
        }
    }
    {
        "return": {}
    }
    {
        "return": {
            "qemu": {
                "micro": 50,
                "minor": 0,
                "major": 4
            },
            "package": "v4.0.0-1467-g6385dd6613"
        }
    }

I figure we'd want to loop in Python instead of shell.

My point is: pretty-printing is trivial in Python.  The case for
maintaining C code to do it seems weak.

