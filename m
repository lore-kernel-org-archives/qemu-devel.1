Received: from eggs.gnu.org ([2001:4830:134:3::10]:56726)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fnjQh-0005n1-Du
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 07:48:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fnjQe-0007lv-QZ
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 07:48:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:11331)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fnjQe-0007lX-IY
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 07:48:32 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3B58E3082A48
	for <qemu-devel@nongnu.org>; Thu,  9 Aug 2018 11:48:31 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180719184111.5129-1-marcandre.lureau@redhat.com>
Date: Thu, 09 Aug 2018 13:48:25 +0200
In-Reply-To: <20180719184111.5129-1-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Thu, 19 Jul 2018 20:40:53 +0200")
Message-ID: <878t5fkbg6.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 00/18] monitor: various code
 simplification and fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Hi,
>
> This series is a rebased subset of "[PATCH v3 00/38] RFC: monitor: add
> asynchronous command type" with code cleanups and improvements that
> are worth to consider for 3.0.
>
> The series applies on master, and will conflict with the pending
> series "[PATCH 0/9] monitor: enable OOB by default" from Peter.
>
> In particular, reverting "qmp: isolate responses into io thread" is
> quite intrusive, but is a nice simplification that is worth to
> consider before modifying/maintaining it further. Also, "monitor: no
> need to save need_resume" could be dropped if Peter "[PATCH 5/9]
> monitor: suspend monitor instead of send CMD_DROP" is adopted (see
> discussion about need_resume there).
>
> The last patch, "RFC: qmp: rework 'id' handling" simplifies a bit
> monitor "id" handling, and makes qemu-ga conform to the QMP
> specification by copying "id" from the request in the reply.  This is
> the opposite to Markus change "qmp qemu-ga: Revert change that
> accidentally made qemu-ga accept 'id'".
>
> (the first patch is already in Markus qapi-next branch, it is there
> for patchew testing)
[...]

I took the liberty to rebase this onto my "[PATCH 00/56] json: Fixes,
error reporting improvements, cleanups", which is by the way also
available at
http://repo.or.cz/qemu/armbru.git/shortlog/refs/heads/json-fixes

> Marc-Andr=C3=A9 Lureau (18):
>   tests: change /0.15/* tests to /qmp/*

Kept (not really part of this series, as noted above)

>   monitor: consitify qmp_send_response() QDict argument
>   qmp: constify qmp_is_oob()
>   Revert "qmp: isolate responses into io thread"
>   monitor: no need to save need_resume

Kept, has my R-by.

I figure the last two need to be considered in context of OOB work that
hasn't landed, yet.  Discussed in review of v1.

>   qga: process_event() simplification and leak fix

Already in master as commit ae7da1e5f6.

>   qmp: drop json_parser_parse() wrapper

Replaced by my series.

>   json-parser: simplify and avoid JSONParserContext allocation

Picked into my series.

>   json-parser: further simplify freeing JSONParserContext
>   qjson: report an error if there are multiple results
>   qjson: report error on unterminated string
>   qjson: return parsing error if unterminated input
>   json-parser: set an error if parsing returned NULL

Replaced by my series.

>   json-lexer: make it safe to call multiple times
>   tests: add a few qemu-qmp tests
>   tests: add a qmp success-response test
>   qga: process_event() simplification
>   RFC: qmp: common 'id' handling & make QGA conform to QMP spec

Kept, only the success-response test has my R-by.

Result:
http://repo.or.cz/qemu/armbru.git/shortlog/refs/heads/elmarco-monitor

[...]
