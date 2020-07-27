Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31C2EC433E3
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 19:54:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0032E2072E
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 19:54:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GEqMJS5d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0032E2072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k09CU-0004pQ-8B
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 15:54:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50070)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1k09B0-0002Cc-TW
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 15:52:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38700
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1k09Ay-0004uL-EU
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 15:52:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595879563;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cyTmfbKXhn/eGEdbdQnXskoWDF3+b6qV3q9TxSXZLHQ=;
 b=GEqMJS5dM0S9OmeDeQNK2T7zIZzeu1ywsQiiIvfuAFgeT6lRGrOHqcFk+H0l4zaleQUDEs
 qjqSXWH4ji1erSxCXp6eurjLskSmi1tl40MoOEXr7OoeeIUZFOzghzTYJRBN6ueUoqqfgN
 Iyn0Ygy7XzQ9u+u08KWeFfrXkqucHHU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-286-FsLaiyH1OX2Qq4wpfUoEwA-1; Mon, 27 Jul 2020 15:52:39 -0400
X-MC-Unique: FsLaiyH1OX2Qq4wpfUoEwA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6D5A2E918;
 Mon, 27 Jul 2020 19:52:38 +0000 (UTC)
Received: from localhost (ovpn-120-33.rdu2.redhat.com [10.10.120.33])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F28DA1C4;
 Mon, 27 Jul 2020 19:52:37 +0000 (UTC)
Date: Mon, 27 Jul 2020 15:52:34 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: Alexey Kirillov <lekiravi@yandex-team.ru>
Subject: Re: [PATCH 1/1] analyze-migration.py: fix
 read_migration_debug_json() return type
Message-ID: <20200727195234.GD225270@habkost.net>
References: <20200715152135.20287-1-lekiravi@yandex-team.ru>
MIME-Version: 1.0
In-Reply-To: <20200715152135.20287-1-lekiravi@yandex-team.ru>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 01:44:14
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
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
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org, yc-core@yandex-team.ru
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jul 15, 2020 at 06:21:35PM +0300, Alexey Kirillov wrote:
> Since we use result of read_migration_debug_json() as JSON formatted string,
> we must provide proper type. Before Python 3.6 json.loads() method
> support only str typed input.
> 
> Signed-off-by: Alexey Kirillov <lekiravi@yandex-team.ru>

Queued for 5.2, thanks!

I've added a small comment explaining why the explicit decode()
call is needed.

        # explicit decode() needed for Python 3.5 compatibility
        return data[jsonpos:jsonpos + jsonlen].decode("utf-8")

> ---
>  scripts/analyze-migration.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/analyze-migration.py b/scripts/analyze-migration.py
> index 95838cbff3..c5f06482cf 100755
> --- a/scripts/analyze-migration.py
> +++ b/scripts/analyze-migration.py
> @@ -97,7 +97,7 @@ class MigrationFile(object):
>          # Seek back to where we were at the beginning
>          self.file.seek(entrypos, 0)
>  
> -        return data[jsonpos:jsonpos + jsonlen]
> +        return data[jsonpos:jsonpos + jsonlen].decode("utf-8")
>  
>      def close(self):
>          self.file.close()
> -- 
> 2.25.1
> 
> 

-- 
Eduardo


