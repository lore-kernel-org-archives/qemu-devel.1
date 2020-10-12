Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55ED2C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 14:36:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B661120735
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 14:36:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C7xg6RdW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B661120735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRywX-0002Yk-Sx
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 10:36:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37786)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kRyut-0001VD-Ft
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 10:35:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55156)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kRyuq-000795-3F
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 10:35:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602513306;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6KRLTS9c2LrmKT4TP3CTRJkq3ZyB6kmHXGgCMRDzOGk=;
 b=C7xg6RdWIOrPxgYRgcJ/CFjWuQkZyMjzNWI5p5gCi2QznLYerFJGZBiQ4WDhjM1bf7vZ9O
 iSoFMPjzOS9HR+sZzGJPXi9h0gMQ0dFdKnmNXFCU7Jnz4YbrS77eam5xsGgA/gWJDIiks0
 gVXoq8pfXgoV/rbB3I359HG3JXwyAdQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-445-Xz1bRan7NwirFAs4iPpuZA-1; Mon, 12 Oct 2020 10:35:04 -0400
X-MC-Unique: Xz1bRan7NwirFAs4iPpuZA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D4A83802B51;
 Mon, 12 Oct 2020 14:35:03 +0000 (UTC)
Received: from merkur.fritz.box (ovpn-114-24.ams2.redhat.com [10.36.114.24])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DFA786EF59;
 Mon, 12 Oct 2020 14:35:02 +0000 (UTC)
Date: Mon, 12 Oct 2020 16:35:01 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v4 4/7] keyval: Parse help options
Message-ID: <20201012143501.GE7777@merkur.fritz.box>
References: <20201011073505.1185335-1-armbru@redhat.com>
 <20201011073505.1185335-5-armbru@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201011073505.1185335-5-armbru@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/11 23:52:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 11.10.2020 um 09:35 hat Markus Armbruster geschrieben:
> From: Kevin Wolf <kwolf@redhat.com>
> 
> This adds a special meaning for 'help' and '?' as options to the keyval
> parser. Instead of being an error (because of a missing value) or a
> value for an implied key, they now request help, which is a new boolean
> output of the parser in addition to the QDict.
> 
> A new parameter 'p_help' is added to keyval_parse() that contains on
> return whether help was requested. If NULL is passed, requesting help
> results in an error and all other cases work like before.
> 
> Turning previous error cases into help is a compatible extension. The
> behaviour potentially changes for implied keys: They could previously
> get 'help' as their value, which is now interpreted as requesting help.
> 
> This is not a problem in practice because 'help' and '?' are not a valid
> values for the implied key of any option parsed with keyval_parse():
> 
> * audiodev: union Audiodev, implied key "driver" is enum AudiodevDriver,
>   "help" and "?" are not among its values
> 
> * display: union DisplayOptions, implied key "type" is enum
>   DisplayType, "help" and "?" are not among its values
> 
> * blockdev: union BlockdevOptions, implied key "driver is enum
>   BlockdevDriver, "help" and "?" are not among its values
> 
> * export: union BlockExport, implied key "type" is enum BlockExportType,
>   "help" and "?" are not among its values
> 
> * monitor: struct MonitorOptions, implied key "mode" is enum MonitorMode,
>   "help" and "?" are not among its values
> 
> * nbd-server: struct NbdServerOptions, no implied key.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

> diff --git a/tests/test-keyval.c b/tests/test-keyval.c
> index 04c62cf045..7b459900af 100644
> --- a/tests/test-keyval.c
> +++ b/tests/test-keyval.c
> @@ -1,3 +1,4 @@
> +
>  /*
>   * Unit tests for parsing of KEY=VALUE,... strings
>   *

This hunk looks unintentional.

Kevin


