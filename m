Return-Path: <SRS0=mi2X=WI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AC95C31E40
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 22:40:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A9C920665
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 22:40:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A9C920665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxIz3-0008W8-A6
	for qemu-devel@archiver.kernel.org; Mon, 12 Aug 2019 18:40:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54613)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bsd@redhat.com>) id 1hxIyf-00082j-Ip
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 18:39:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bsd@redhat.com>) id 1hxIye-0004lJ-Nv
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 18:39:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36098)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <bsd@redhat.com>) id 1hxIye-0004kz-J8
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 18:39:44 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E246085542;
 Mon, 12 Aug 2019 22:39:42 +0000 (UTC)
Received: from gigantic.usersys.redhat.com (helium.bos.redhat.com
 [10.18.17.132])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 258FC608C2;
 Mon, 12 Aug 2019 22:39:39 +0000 (UTC)
From: Bandan Das <bsd@redhat.com>
To: "Oleinik\, Alexander" <alxndr@bu.edu>
References: <20190805071038.32146-1-alxndr@bu.edu>
 <20190805071038.32146-3-alxndr@bu.edu>
Date: Mon, 12 Aug 2019 18:39:38 -0400
In-Reply-To: <20190805071038.32146-3-alxndr@bu.edu> (Alexander Oleinik's
 message of "Mon, 5 Aug 2019 07:11:03 +0000")
Message-ID: <jpgzhkeovo5.fsf@linux.bootlegged.copy>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Mon, 12 Aug 2019 22:39:42 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [RFC PATCH v2 02/17] fuzz: Add fuzzer configure
 options
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
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "stefanha@redhat.com" <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

"Oleinik, Alexander" <alxndr@bu.edu> writes:
...
>  if test "$supported_cpu" = "no"; then
>      echo
> @@ -7306,6 +7310,17 @@ fi
>  if test "$sheepdog" = "yes" ; then
>    echo "CONFIG_SHEEPDOG=y" >> $config_host_mak
>  fi
> +if test "$fuzzing" = "yes" ; then
> +  QEMU_CFLAGS="$QEMU_CFLAGS -fsanitize=fuzzer,address  -fprofile-instr-generate"
> +  QEMU_CFLAGS="$QEMU_CFLAGS -fprofile-instr-generate -fcoverage-mapping"

What is the purpose of -fprofile-instr-generate ? Coverage info ? (Listed twice above)

Bandan

> +  QEMU_LDFLAGS="$LDFLAGS -fsanitize=fuzzer,address"
> +
> +  # Add tests/ to include path, since this is done in tests/Makefile.include,
> +  # and required for QOS objects to build. This can be removed if/when the
> +  # fuzzer is compiled using rules in tests/Makefile.include
> +  QEMU_INCLUDES="-iquote \$(SRC_PATH)/tests $QEMU_INCLUDES"
> +  echo "CONFIG_FUZZ=y" >> $config_host_mak
> +fi
>  
>  if test "$tcg_interpreter" = "yes"; then
>    QEMU_INCLUDES="-iquote \$(SRC_PATH)/tcg/tci $QEMU_INCLUDES"

