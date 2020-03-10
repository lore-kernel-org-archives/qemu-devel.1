Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5598CC10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 18:46:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B3CA20873
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 18:46:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bqyDzs2u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B3CA20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38694 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBjtw-0000Rj-Ai
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 14:46:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34887)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1jBjt6-0008LM-WA
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 14:45:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1jBjt5-0008JK-Kc
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 14:45:56 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:38129
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1jBjt5-0008FK-HB
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 14:45:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583865954;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D2hJBCtIDQGvUJW1Ts+lj8FVypWoRxjM+T34ZDx0pE4=;
 b=bqyDzs2u170NesqMVYsHDA7dnEwnvJSwVYTdtsTRZylOCrXoKdXXYHTz+Hs1UD4IX7BaSR
 sY+HxLK+FSleJVCImCJsPxcTy7QgRfna1KvcHZh1qUxnBUhy0S2qXKeiTINURWpUhF78t5
 aE5VPUlObT+N9/78zUw8VJ9l6dKEAx0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-467-F8tXKvADNrWtlRJ3nBxHaw-1; Tue, 10 Mar 2020 14:45:52 -0400
X-MC-Unique: F8tXKvADNrWtlRJ3nBxHaw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AB405107ACC7;
 Tue, 10 Mar 2020 18:45:51 +0000 (UTC)
Received: from redhat.com (ovpn-116-72.ams2.redhat.com [10.36.116.72])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 478895C28D;
 Tue, 10 Mar 2020 18:45:51 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: Guenter Roeck <linux@roeck-us.net>
Subject: Re: "Unknown option --exist" message when building qemu
In-Reply-To: <66841404-892f-edef-eb1a-37ed2e2e08ee@roeck-us.net> (Guenter
 Roeck's message of "Tue, 10 Mar 2020 11:27:18 -0700")
References: <66841404-892f-edef-eb1a-37ed2e2e08ee@roeck-us.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date: Tue, 10 Mar 2020 19:45:46 +0100
Message-ID: <875zfcyrol.fsf@secure.laptop>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
Reply-To: quintela@redhat.com
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Guenter Roeck <linux@roeck-us.net> wrote:
> Hi,
>
> when building qemu, I keep seeing the following message.
>
> Unknown option --exist
>
> This was introduced with commit 3a67848134d0 ("configure: Enable test
> and libs for zstd").
> If I replace "--exist" with "--exists", on a system with libzstd-dev
> installed, I get
> a number of error messages.

Patch is on the line already.  You need to change the test to:

 if test "$zstd" !=3D "no" ; then
-    if $pkg_config --exist libzstd ; then
+    libzstd_minver=3D"1.4.0"
+    if $pkg_config --atleast-version=3D$libzstd_minver libzstd ; then
         zstd_cflags=3D"$($pkg_config --cflags libzstd)"

It is not enough with having zstd installed, you need to have version
1.4.0 for it to work.

Sorry, Juan.

>
> migration/multifd-zstd.c:125:9: error: unknown type name
> =E2=80=98ZSTD_EndDirective=E2=80=99; did you mean =E2=80=98ZSTD_DDict=E2=
=80=99?
> migration/multifd-zstd.c:125:35: error: =E2=80=98ZSTD_e_continue=E2=80=99=
 undeclared
> migration/multifd-zstd.c:128:21: error: =E2=80=98ZSTD_e_flush=E2=80=99 un=
declared
> migration/multifd-zstd.c:143:19: error: implicit declaration of
> function =E2=80=98ZSTD_compressStream2=E2=80=99
> migration/multifd-zstd.c:143:19: error: nested extern declaration of
> =E2=80=98ZSTD_compressStream2=E2=80=99
>
> Any idea, anyone, what might be wrong ?
>
> Thanks,
> Guenter


