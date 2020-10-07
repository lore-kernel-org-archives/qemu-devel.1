Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E730AC4363C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 09:45:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AC2620760
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 09:45:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q09x7O/9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AC2620760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50750 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQ60M-0004z2-Mh
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 05:45:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34176)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kQ5zI-0004TN-To
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 05:43:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:50581)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kQ5zG-0001NG-6c
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 05:43:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602063831;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ehX8ZlPYMmtXBraQ4B5CjCltyDqm9Ll7bgqxbDa8GSQ=;
 b=Q09x7O/9wXWEEgVme811o9G6lVvEOO/iO2RJe4CqBORFUJXxiwwBEyxhk29BjrgiD8553v
 1fuNUS0fLbBuuL2ZNWX+W2xKOARgyDjQGYB5Wxeehc883akVSTiWkVbVUaKVY3vF8CTEeg
 M8YZkVI5dWOrTrYUFH3qjODer85iAkg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-358-zcehBUm8NhaFjPGiWZv16Q-1; Wed, 07 Oct 2020 05:43:50 -0400
X-MC-Unique: zcehBUm8NhaFjPGiWZv16Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 005091084CA8;
 Wed,  7 Oct 2020 09:43:49 +0000 (UTC)
Received: from linux.fritz.box (ovpn-113-169.ams2.redhat.com [10.36.113.169])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9AD22672C6;
 Wed,  7 Oct 2020 09:43:38 +0000 (UTC)
Date: Wed, 7 Oct 2020 11:43:37 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH 03/20] python/machine.py: reorder __init__
Message-ID: <20201007094337.GA7212@linux.fritz.box>
References: <20201006235817.3280413-1-jsnow@redhat.com>
 <20201006235817.3280413-4-jsnow@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201006235817.3280413-4-jsnow@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/07 00:44:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 07.10.2020 um 01:58 hat John Snow geschrieben:
> Put the init arg handling all at the top, and mostly in order (deviating
> when one is dependent on another), and put what is effectively runtime
> state declaration at the bottom.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  python/qemu/machine.py | 44 ++++++++++++++++++++++++------------------
>  1 file changed, 25 insertions(+), 19 deletions(-)
> 
> diff --git a/python/qemu/machine.py b/python/qemu/machine.py
> index 3017ec072df..71fe58be050 100644
> --- a/python/qemu/machine.py
> +++ b/python/qemu/machine.py
> @@ -84,42 +84,54 @@ def __init__(self, binary, args=None, wrapper=None, name=None,
>          @param monitor_address: address for QMP monitor
>          @param socket_scm_helper: helper program, required for send_fd_scm()
>          @param sock_dir: where to create socket (overrides test_dir for sock)
> -        @param console_log: (optional) path to console log file
>          @param drain_console: (optional) True to drain console socket to buffer
> +        @param console_log: (optional) path to console log file
>          @note: Qemu process is not started until launch() is used.
>          '''
> +        # Direct user configuration
> +
> +        self._binary = binary
> +
>          if args is None:
>              args = []
> +        # Copy mutable input: we will be modifying our copy
> +        self._args = list(args)
> +
>          if wrapper is None:
>              wrapper = []
> -        if name is None:
> -            name = "qemu-%d" % os.getpid()
> -        if sock_dir is None:
> -            sock_dir = test_dir
> -        self._name = name
> +        self._wrapper = wrapper
> +
> +        self._name = name or "qemu-%d" % os.getpid()
> +        self._test_dir = test_dir
> +        self._sock_dir = sock_dir or self._test_dir
> +        self._socket_scm_helper = socket_scm_helper

Interesting that you use a shortcut with 'or' for name and sock_dir,
but you don't have 'wraper or []' and 'args or []' above.

It's not wrong, of course, but if you have to respin for another reason,
maybe an inconsistency to address.

Reviewed-by: Kevin Wolf <kwolf@redhat.com>


