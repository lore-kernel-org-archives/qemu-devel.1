Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B39DC4363C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 11:37:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEDC420782
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 11:37:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PJQO5TEu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEDC420782
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQ7lA-0005jb-Gz
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 07:37:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58456)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kQ7jA-0004Fm-Rh
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 07:35:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:36620)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kQ7j4-0007IE-V2
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 07:35:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602070517;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1Wjh0CbeRl8EItSrCwHjTOU1Gqo7n/lZaykhY6yFhtk=;
 b=PJQO5TEultTgagQ2LM/NB4I6nByCg+GonaupRUdSIfmUXuxze1r8yTyLMciq8tgqAA+yzn
 GA1gbY4MhordA2Y16bHtpcnLAMLFud+RsQ//UTGnhp5riNloElSVleBJjUcT7EH+zVmWKv
 2f9LuQGRK/IOd7nOIpKF62AhVFadrbE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-596-ktRTcITkM8qWQsI5g9BFdA-1; Wed, 07 Oct 2020 07:35:16 -0400
X-MC-Unique: ktRTcITkM8qWQsI5g9BFdA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1060A81F01A;
 Wed,  7 Oct 2020 11:35:15 +0000 (UTC)
Received: from linux.fritz.box (ovpn-113-169.ams2.redhat.com [10.36.113.169])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AD31B5576D;
 Wed,  7 Oct 2020 11:35:13 +0000 (UTC)
Date: Wed, 7 Oct 2020 13:35:12 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH 20/20] python: add mypy config
Message-ID: <20201007113512.GM7212@linux.fritz.box>
References: <20201006235817.3280413-1-jsnow@redhat.com>
 <20201006235817.3280413-21-jsnow@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201006235817.3280413-21-jsnow@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.742,
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
> Formalize the options used for checking the python library. You can run
> mypy from the directory that mypy.ini is in by typing `mypy qemu/`.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  python/mypy.ini | 4 ++++
>  1 file changed, 4 insertions(+)
>  create mode 100644 python/mypy.ini
> 
> diff --git a/python/mypy.ini b/python/mypy.ini
> new file mode 100644
> index 00000000000..7a70eca47c6
> --- /dev/null
> +++ b/python/mypy.ini
> @@ -0,0 +1,4 @@
> +[mypy]
> +strict = True

$ mypy --strict qemu
mypy.ini: [mypy]: Strict mode is not supported in configuration files: specify individual flags instead (see 'mypy -h' for the list of flags enabled in strict mode)
Success: no issues found in 6 source files
$ mypy --version
mypy 0.740

Did this change in newer mypy versions? I guess it's time that I get the
new laptop which will involve installing a newer Fedora release. :-)

> +python_version = 3.6
> +warn_unused_configs = True
> \ No newline at end of file

Kevin


