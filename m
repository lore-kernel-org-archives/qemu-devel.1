Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FF4CC4CECE
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 12:31:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 341CE21744
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 12:31:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 341CE21744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49066 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJzVz-0002aZ-Av
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 08:31:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56679)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iJzOO-00069I-I5
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 08:24:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iJzOM-0000xw-Cv
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 08:24:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59210)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iJzOM-0000wx-7H
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 08:24:02 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2C38510CC1F6
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 12:24:01 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.36.118.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C4AB61001B07;
 Mon, 14 Oct 2019 12:23:59 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 452FD1138619; Mon, 14 Oct 2019 14:23:57 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH v4 2/4] qapi: Add feature flags to commands in qapi
References: <20191011085027.28606-1-armbru@redhat.com>
 <20191011085027.28606-3-armbru@redhat.com>
Date: Mon, 14 Oct 2019 14:23:57 +0200
In-Reply-To: <20191011085027.28606-3-armbru@redhat.com> (Markus Armbruster's
 message of "Fri, 11 Oct 2019 10:50:25 +0200")
Message-ID: <87imor4isi.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.65]); Mon, 14 Oct 2019 12:24:01 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: kwolf@redhat.com, pkrempa@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Markus Armbruster <armbru@redhat.com> writes:

> From: Peter Krempa <pkrempa@redhat.com>
>
> Similarly to features for struct types introduce the feature flags also
> for commands. This will allow notifying management layers of fixes and
> compatible changes in the behaviour of a command which may not be
> detectable any other way.
>
> The changes were heavily inspired by commit 6a8c0b51025.
>
> Signed-off-by: Peter Krempa <pkrempa@redhat.com>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  docs/devel/qapi-code-gen.txt   |  7 ++++---
>  qapi/introspect.json           |  6 +++++-
>  scripts/qapi/commands.py       |  3 ++-
>  scripts/qapi/doc.py            |  3 ++-
>  scripts/qapi/expr.py           | 35 +++++++++++++++++++---------------
>  scripts/qapi/introspect.py     |  7 ++++++-
>  scripts/qapi/schema.py         | 22 +++++++++++++++++----
>  tests/qapi-schema/test-qapi.py |  3 ++-
>  8 files changed, 59 insertions(+), 27 deletions(-)
>
> diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.txt
> index 64d9e4c6a9..637fa49977 100644
> --- a/docs/devel/qapi-code-gen.txt
> +++ b/docs/devel/qapi-code-gen.txt
> @@ -640,9 +640,10 @@ change in the QMP syntax (usually by allowing values or operations
>  that previously resulted in an error).  QMP clients may still need to
>  know whether the extension is available.
>  
> -For this purpose, a list of features can be specified for a struct type.
> -This is exposed to the client as a list of string, where each string
> -signals that this build of QEMU shows a certain behaviour.
> +For this purpose, a list of features can be specified for a command or
> +struct type.  This is exposed to the client as a list of strings,
> +where each string signals that this build of QEMU shows a certain
> +behaviour.
>  
>  Each member of the 'features' array defines a feature.  It can either
>  be { 'name': STRING, '*if': COND }, or STRING, which is shorthand for

Squashing in missing syntax update:

diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.txt
index 637fa49977..45c93a43cc 100644
--- a/docs/devel/qapi-code-gen.txt
+++ b/docs/devel/qapi-code-gen.txt
@@ -457,7 +457,8 @@ Syntax:
                 '*gen': false,
                 '*allow-oob': true,
                 '*allow-preconfig': true,
-                '*if': COND }
+                '*if': COND,
+                '*features': FEATURES }
 
 Member 'command' names the command.

[...]

