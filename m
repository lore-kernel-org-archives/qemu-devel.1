Return-Path: <SRS0=dCqM=2Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14570C2D0C2
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 12:05:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D413A20848
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 12:05:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SPs+5s1p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D413A20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51446 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1inLhc-0007v5-1y
	for qemu-devel@archiver.kernel.org; Fri, 03 Jan 2020 07:05:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41447)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1inLgt-0007Ki-Hx
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 07:04:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1inLgr-0000D3-0V
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 07:04:31 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:58584
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1inLgq-00009H-PZ
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 07:04:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578053068;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SIhqbFjZJ01b4yzuronp1xBl1VANvp5tWkW4eu66PFs=;
 b=SPs+5s1pHwbhRSJkGPkLrm9O1+HgL6X6zbUiDSHot8BL+7/eCtUH9/g0ZaxHbyzZxrzGvv
 LN8w04Dy9zhwOKASZpqb3hP+SFoHBgkl8v/smPgBKPYJRejfyrpI0ZKiJjNTcp8rlKaziS
 GZ3xksilmq311yXVEF6pzn1Rf7twoHw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-341-sageCbhxMYui709XdWDmaQ-1; Fri, 03 Jan 2020 07:04:26 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0F0F3477
 for <qemu-devel@nongnu.org>; Fri,  3 Jan 2020 12:04:25 +0000 (UTC)
Received: from redhat.com (ovpn-112-41.ams2.redhat.com [10.36.112.41])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0E25E84666;
 Fri,  3 Jan 2020 12:04:20 +0000 (UTC)
Date: Fri, 3 Jan 2020 12:04:17 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Subject: Re: [PATCH 007/104] virtiofsd: Format imported files to qemu style
Message-ID: <20200103120417.GM2753983@redhat.com>
References: <20191212163904.159893-1-dgilbert@redhat.com>
 <20191212163904.159893-8-dgilbert@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191212163904.159893-8-dgilbert@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: sageCbhxMYui709XdWDmaQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Dec 12, 2019 at 04:37:27PM +0000, Dr. David Alan Gilbert (git) wrot=
e:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>=20
> Mostly using a set like:
>=20
> indent -nut -i 4 -nlp -br -cs -ce --no-space-after-function-call-names fi=
le
> clang-format -style=3Dfile -i -- file
> clang-tidy -fix-errors -checks=3Dreadability-braces-around-statements fil=
e
> clang-format -style=3Dfile -i -- file
>=20
> With manual cleanups.
>=20
> The .clang-format used is below.
>=20
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>=20
> Language:        Cpp
> AlignAfterOpenBracket: Align
> AlignConsecutiveAssignments: false # although we like it, it creates chur=
n
> AlignConsecutiveDeclarations: false
> AlignEscapedNewlinesLeft: true
> AlignOperands:   true
> AlignTrailingComments: false # churn
> AllowAllParametersOfDeclarationOnNextLine: true
> AllowShortBlocksOnASingleLine: false
> AllowShortCaseLabelsOnASingleLine: false
> AllowShortFunctionsOnASingleLine: None
> AllowShortIfStatementsOnASingleLine: false
> AllowShortLoopsOnASingleLine: false
> AlwaysBreakAfterReturnType: None # AlwaysBreakAfterDefinitionReturnType i=
s taken into account
> AlwaysBreakBeforeMultilineStrings: false
> BinPackArguments: true
> BinPackParameters: true
> BraceWrapping:
>   AfterControlStatement: false
>   AfterEnum:       false
>   AfterFunction:   true
>   AfterStruct:     false
>   AfterUnion:      false
>   BeforeElse:      false
>   IndentBraces:    false
> BreakBeforeBinaryOperators: None
> BreakBeforeBraces: Custom
> BreakBeforeTernaryOperators: false
> BreakStringLiterals: true
> ColumnLimit:     80
> ContinuationIndentWidth: 4
> Cpp11BracedListStyle: false
> DerivePointerAlignment: false
> DisableFormat:   false
> ForEachMacros:   [
>   'CPU_FOREACH',
>   'CPU_FOREACH_REVERSE',
>   'CPU_FOREACH_SAFE',
>   'IOMMU_NOTIFIER_FOREACH',
>   'QLIST_FOREACH',
>   'QLIST_FOREACH_ENTRY',
>   'QLIST_FOREACH_RCU',
>   'QLIST_FOREACH_SAFE',
>   'QLIST_FOREACH_SAFE_RCU',
>   'QSIMPLEQ_FOREACH',
>   'QSIMPLEQ_FOREACH_SAFE',
>   'QSLIST_FOREACH',
>   'QSLIST_FOREACH_SAFE',
>   'QTAILQ_FOREACH',
>   'QTAILQ_FOREACH_REVERSE',
>   'QTAILQ_FOREACH_SAFE',
>   'QTAILQ_RAW_FOREACH',
>   'RAMBLOCK_FOREACH'
> ]
> IncludeCategories:
>   - Regex:           '^"qemu/osdep.h'
>     Priority:        -3
>   - Regex:           '^"(block|chardev|crypto|disas|exec|fpu|hw|io|libdec=
number|migration|monitor|net|qapi|qemu|qom|standard-headers|sysemu|ui)/'
>     Priority:        -2
>   - Regex:           '^"(elf.h|qemu-common.h|glib-compat.h|qemu-io.h|trac=
e-tcg.h)'
>     Priority:        -1
>   - Regex:           '.*'
>     Priority:        1
> IncludeIsMainRegex: '$'
> IndentCaseLabels: false
> IndentWidth:     4
> IndentWrappedFunctionNames: false
> KeepEmptyLinesAtTheStartOfBlocks: false
> MacroBlockBegin: '.*_BEGIN$' # only PREC_BEGIN ?
> MacroBlockEnd:   '.*_END$'
> MaxEmptyLinesToKeep: 2
> PointerAlignment: Right
> ReflowComments:  true
> SortIncludes:    true
> SpaceAfterCStyleCast: false
> SpaceBeforeAssignmentOperators: true
> SpaceBeforeParens: ControlStatements
> SpaceInEmptyParentheses: false
> SpacesBeforeTrailingComments: 1
> SpacesInContainerLiterals: true
> SpacesInParentheses: false
> SpacesInSquareBrackets: false
> Standard:        Auto
> UseTab:          Never
> ...
> ---
>  tools/virtiofsd/buffer.c              |  550 ++--
>  tools/virtiofsd/fuse.h                | 1572 +++++------
>  tools/virtiofsd/fuse_common.h         |  764 ++---
>  tools/virtiofsd/fuse_i.h              |  127 +-
>  tools/virtiofsd/fuse_log.c            |   38 +-
>  tools/virtiofsd/fuse_log.h            |   32 +-
>  tools/virtiofsd/fuse_loop_mt.c        |   66 +-
>  tools/virtiofsd/fuse_lowlevel.c       | 3678 +++++++++++++------------
>  tools/virtiofsd/fuse_lowlevel.h       | 2401 ++++++++--------
>  tools/virtiofsd/fuse_misc.h           |   30 +-
>  tools/virtiofsd/fuse_opt.c            |  659 ++---
>  tools/virtiofsd/fuse_opt.h            |   79 +-
>  tools/virtiofsd/fuse_signals.c        |  118 +-
>  tools/virtiofsd/helper.c              |  517 ++--
>  tools/virtiofsd/passthrough_helpers.h |   33 +-
>  tools/virtiofsd/passthrough_ll.c      | 2063 +++++++-------
>  16 files changed, 6530 insertions(+), 6197 deletions(-)


Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


