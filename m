Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE411C2D0CE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 09:59:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8925420882
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 09:59:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="McQelIz0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8925420882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50848 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itqJy-0008SK-Ie
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 04:59:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33103)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1itqJ1-0007VT-MM
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 04:58:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1itqIy-0000QR-WB
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 04:58:43 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26277
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1itqIy-0000Q8-Rv
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 04:58:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579600720;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=AFjkN8bouUrfUaNGMdKSZ041gyEtd0iTfg4rOY3K8Bo=;
 b=McQelIz0IRvTUOXqSTqTSW/tpbamMzu39AqQXGJcK6M4HUWVP+IeNLgzY/oX4tk+S8Ckkz
 eKEm4yO6UNLWse4D+aQnib4M3Y7t9hvstffNZdLy+RK9riJoADky7arW85x+8SO2GHPAcf
 6cPCyGjWET102po8ST8Xvy6L14ykg60=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-349-fuvSs_5oPQmunrKRyhPVvQ-1; Tue, 21 Jan 2020 04:58:37 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 01DE5800D50;
 Tue, 21 Jan 2020 09:58:36 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-121.ams2.redhat.com [10.36.116.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8338860E1C;
 Tue, 21 Jan 2020 09:58:34 +0000 (UTC)
Subject: Re: [PATCH 1/2] test-logging: Fix -Werror=maybe-uninitialized warning
To: mrezanin@redhat.com, qemu-devel@nongnu.org
References: <cover.1579598240.git.mrezanin@redhat.com>
 <63b0fcedf7dfe799c8210b113e5dccf32414a89d.1579598240.git.mrezanin@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <14ba746f-97c3-1ae3-c836-ad2e3e213756@redhat.com>
Date: Tue, 21 Jan 2020 10:58:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <63b0fcedf7dfe799c8210b113e5dccf32414a89d.1579598240.git.mrezanin@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: fuvSs_5oPQmunrKRyhPVvQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: qemu-trivial@nongnu.org, peter.maydell@linaro.org,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Robert Foley <robert.foley@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 21/01/2020 10.28, mrezanin@redhat.com wrote:
> From: Miroslav Rezanina <mrezanin@redhat.com>
> 
> Checking for uninitialized variables raises warning for file path
> variables in test_logfile_write and test_logfile_lock functions.
> 
> To suppress this warning, initialize varibles to NULL. This is safe
> change as result of g_build_filename is stored to them before any usage.
> 
> Signed-off-by: Miroslav Rezanina <mrezanin@redhat.com>
> ---
>  tests/test-logging.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tests/test-logging.c b/tests/test-logging.c
> index 1e646f0..6387e49 100644
> --- a/tests/test-logging.c
> +++ b/tests/test-logging.c
> @@ -114,8 +114,8 @@ static void test_logfile_write(gconstpointer data)
>      QemuLogFile *logfile2;
>      gchar const *dir = data;
>      Error *err = NULL;
> -    g_autofree gchar *file_path;
> -    g_autofree gchar *file_path1;
> +    g_autofree gchar *file_path = NULL;
> +    g_autofree gchar *file_path1 = NULL;
>      FILE *orig_fd;
>  
>      /*
> @@ -157,7 +157,7 @@ static void test_logfile_lock(gconstpointer data)
>      FILE *logfile;
>      gchar const *dir = data;
>      Error *err = NULL;
> -    g_autofree gchar *file_path;
> +    g_autofree gchar *file_path = NULL;
>  
>      file_path = g_build_filename(dir, "qemu_test_logfile_lock0.log", NULL);

Right. The glib documentation clearly states that "the variable must be
initialized", see:

https://developer.gnome.org/glib/stable/glib-Miscellaneous-Macros.html#g-autofree

So this is the right thing to do here!

Reviewed-by: Thomas Huth <thuth@redhat.com>


