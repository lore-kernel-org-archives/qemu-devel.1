Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 496C7C433E7
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 11:29:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAAAD2073A
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 11:29:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HZ3MULKs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAAAD2073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36260 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kT1Ry-0003Bg-MF
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 07:29:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48442)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kT1QL-0001jc-IQ
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 07:27:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60896)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kT1Pp-0008Ji-RL
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 07:27:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602761243;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sW9Jvkt0tvGRPTMBmdNnmeMznwynyu21/MS0p3TOwNg=;
 b=HZ3MULKsfGXAVCjFkBNXhLCZ6wDCpA7rtZJlzuTz+vwYu0v8tLX7Uus0bIHaLBqMfDossm
 XVYgUonRrcU0oQh1S4OT+yGyjPsJ+TSBiljnhDR6sMM8+Ptt/rs3QNvPWs0Q02wR9RnJ7j
 Eydw4Cqt51TT/UPmwgrvQnR4aajlDhk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-228-Zs6V5JEXN82VsHuGOpnZyg-1; Thu, 15 Oct 2020 07:27:21 -0400
X-MC-Unique: Zs6V5JEXN82VsHuGOpnZyg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BB93364094;
 Thu, 15 Oct 2020 11:27:20 +0000 (UTC)
Received: from merkur.fritz.box (ovpn-114-163.ams2.redhat.com [10.36.114.163])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C42AA5D9D5;
 Thu, 15 Oct 2020 11:27:16 +0000 (UTC)
Date: Thu, 15 Oct 2020 13:27:12 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: [PATCH v2 17/20] iotests: Give access to the qemu-storage-daemon
Message-ID: <20201015112712.GE4610@merkur.fritz.box>
References: <20200922104932.46384-1-mreitz@redhat.com>
 <20200922104932.46384-18-mreitz@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200922104932.46384-18-mreitz@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/15 02:10:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 22.09.2020 um 12:49 hat Max Reitz geschrieben:
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  tests/qemu-iotests/check     | 11 +++++++++++
>  tests/qemu-iotests/common.rc | 17 +++++++++++++++++
>  2 files changed, 28 insertions(+)
> 
> diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
> index e14a1f354d..467a7cf1b7 100755
> --- a/tests/qemu-iotests/check
> +++ b/tests/qemu-iotests/check
> @@ -644,6 +644,17 @@ if [ -z $QEMU_NBD_PROG ]; then
>  fi
>  export QEMU_NBD_PROG="$(type -p "$QEMU_NBD_PROG")"
>  
> +if [ -z "$QEMU_STGD_PROG" ]; then

No series without some bikeshedding:

This is the first time I see "QEMU_STGD" as a short form. Without the
subject line of the patch, I wouldn't be able to guess what it is.

If the full name ($QEMU_STORAGE_DAEMON_PROG) is too long, I think simply
$QSD_PROG would be an alternative, because "qsd" is what people already
use an as abbreviation.

Kevin


