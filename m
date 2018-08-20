Received: from eggs.gnu.org ([2001:4830:134:3::10]:59049)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1frfaj-0001Qm-9v
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 04:31:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1frfae-0006NV-IG
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 04:31:13 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57454 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1frfae-0006NN-Ej
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 04:31:08 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <153458654892.28280.9192299594353632366@502c9da6d61e>
Date: Mon, 20 Aug 2018 10:31:02 +0200
In-Reply-To: <153458654892.28280.9192299594353632366@502c9da6d61e> (no-reply's
	message of "Sat, 18 Aug 2018 03:02:30 -0700 (PDT)")
Message-ID: <87y3d1sam1.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 00/60] json: Fixes,
 error reporting improvements, cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, famz@redhat.com, mdroth@linux.vnet.ibm.comFam Zheng <famz@redhat.com>

no-reply@patchew.org writes:

> Hi,
>
> This series seems to have some coding style problems. See output below for
> more information:
[...]
> Checking PATCH 4/60: qmp-cmd-test: Split off qmp-test...
> WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
> #48: 
> new file mode 100644

False positive: the patch does update MAINTAINERS.  Surprising, since
commit 1a6fad0c3bd "checkpatch: reduce MAINTAINERS update message
frequency" suppresses this.  Fam, is patchew running an outdated version
of checkpatch?

>
> total: 0 errors, 1 warnings, 460 lines checked
[...]
> Checking PATCH 15/60: check-qjson: Cover interpolation more thoroughly...
> ERROR: space required after that close brace '}'
> #179: FILE: tests/check-qjson.c:1122:
> +            {}}));

I consider this a false positive.  We do require space after } in things
like } else.  We don't in complex initializes, as far as I know.

> total: 1 errors, 0 warnings, 207 lines checked
[...]
> Checking PATCH 55/60: json: Clean up headers...
> WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
> #72: 
> deleted file mode 100644

False positive: MAINTAINERS matches the deleted files' directory, and
more files remain there.

> total: 0 errors, 1 warnings, 155 lines checked
>
> Your patch has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> Checking PATCH 56/60: docs/interop/qmp-spec: How to force known good parser state...
> Checking PATCH 57/60: tests/drive_del-test: Fix harmless JSON interpolation bug...
> Checking PATCH 58/60: json: Keep interpolation state in JSONParserContext...
> Checking PATCH 59/60: json: Improve safety of qobject_from_jsonf_nofail() & friends...
> Checking PATCH 60/60: json: Support %% in JSON strings when interpolating...
> === OUTPUT END ===
>
> Test command exited with code: 1
>
>
> ---
> Email generated automatically by Patchew [http://patchew.org/].
> Please send your feedback to patchew-devel@redhat.com
