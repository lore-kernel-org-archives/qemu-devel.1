Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA7BAC433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 11:43:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A97B2087D
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 11:43:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aJtl6S+W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A97B2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFc2B-00011b-HK
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 07:43:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50408)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchamart@redhat.com>)
 id 1kFc1O-00009c-4v
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 07:42:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32843
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kchamart@redhat.com>)
 id 1kFc1M-0001qL-9I
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 07:42:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599565363;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HkIJcBOm/9Ugq5aJ27pQ4eYGJyo9zxNR89mLSe3o5io=;
 b=aJtl6S+WasVQ22ssrSNpXpfImA3Io2cf6nrZZBzvVrHXdT//w1kXLKopr7BPfF9K1agSuc
 n9wamLHndZ79gcyRscwtQURAi937n+KwfcR2GgBufM/GKb2elZL/D0rM+9yU+cDsgpqWhc
 HQoR2wNblg3tbjrtLFsnOcdYtEDnqbc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-437-pDRMrqW3PoaugcWSmaiLtw-1; Tue, 08 Sep 2020 07:42:41 -0400
X-MC-Unique: pDRMrqW3PoaugcWSmaiLtw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 98A0E805723;
 Tue,  8 Sep 2020 11:42:40 +0000 (UTC)
Received: from paraplu.localdomain (ovpn-113-84.ams2.redhat.com [10.36.113.84])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CAE43194BF;
 Tue,  8 Sep 2020 11:42:36 +0000 (UTC)
Received: by paraplu.localdomain (Postfix, from userid 1001)
 id A9F513E0489; Tue,  8 Sep 2020 13:42:33 +0200 (CEST)
Date: Tue, 8 Sep 2020 13:42:33 +0200
From: Kashyap Chamarthy <kchamart@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH 3/4] docs: add qemu-storage-daemon(1) man page
Message-ID: <20200908114233.GC19304@paraplu>
References: <20200908093113.47564-1-stefanha@redhat.com>
 <20200908093113.47564-4-stefanha@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200908093113.47564-4-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kchamart@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kchamart@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/08 00:33:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>, qemu-block@nongnu.org, afrosi@redhat.com,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 08, 2020 at 10:31:12AM +0100, Stefan Hajnoczi wrote:
> Document the qemu-storage-daemon tool. Most of the command-line options
> are identical to their QEMU counterparts. Perhaps Sphinx hxtool
> integration could be extended to extract documentation for individual
> command-line options so they can be shared. For now the
> qemu-storage-daemon simply refers to the qemu(1) man page where the
> command-line options are identical.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  docs/tools/conf.py                 |   2 +
>  docs/tools/index.rst               |   1 +
>  docs/tools/qemu-storage-daemon.rst | 105 +++++++++++++++++++++++++++++
>  3 files changed, 108 insertions(+)
>  create mode 100644 docs/tools/qemu-storage-daemon.rst
> 
> diff --git a/docs/tools/conf.py b/docs/tools/conf.py
> index 9052d17d6d..c16290e716 100644
> --- a/docs/tools/conf.py
> +++ b/docs/tools/conf.py
> @@ -20,6 +20,8 @@ html_theme_options['description'] = \
>  man_pages = [
>      ('qemu-img', 'qemu-img', u'QEMU disk image utility',
>       ['Fabrice Bellard'], 1),
> +    ('qemu-storage-daemon', 'qemu-storage-daemon', u'QEMU storage daemon',
> +     [], 1),
>      ('qemu-nbd', 'qemu-nbd', u'QEMU Disk Network Block Device Server',
>       ['Anthony Liguori <anthony@codemonkey.ws>'], 8),
>      ('qemu-trace-stap', 'qemu-trace-stap', u'QEMU SystemTap trace tool',
> diff --git a/docs/tools/index.rst b/docs/tools/index.rst
> index 232ce9f3e4..9b076adb62 100644
> --- a/docs/tools/index.rst
> +++ b/docs/tools/index.rst
> @@ -11,6 +11,7 @@ Contents:
>     :maxdepth: 2
>  
>     qemu-img
> +   qemu-storage-daemon
>     qemu-nbd
>     qemu-trace-stap
>     virtfs-proxy-helper
> diff --git a/docs/tools/qemu-storage-daemon.rst b/docs/tools/qemu-storage-daemon.rst
> new file mode 100644
> index 0000000000..729a5e7248
> --- /dev/null
> +++ b/docs/tools/qemu-storage-daemon.rst
> @@ -0,0 +1,105 @@
> +QEMU Storage Daemon
> +===================
> +
> +Synopsis
> +--------
> +
> +**qemu-storage-daemon** [options]
> +
> +Description
> +-----------
> +
> +qemu-storage-daemon provides disk image functionality from QEMU, qemu-img, and
> +qemu-nbd in a long-running process controlled via QMP commands without running
> +a virtual machine. It can export disk images over NBD, run block job
> +operations, and perform other disk-related operations. The daemon is controlled
> +via a QMP monitor socket and initial configuration from the command-line.
> +
> +The daemon offers the following subset of QEMU features:
> +
> +* Blockdev nodes
> +* Block jobs
> +* NBD server
> +* Character devices
> +* Crypto and secrets
> +* QMP
> +
> +Commands can be sent over a QEMU Monitor Protocol (QMP) connection. See the
> +:manpage:`qemu-storage-daemon-qmp-ref(7)` manual page for a description of the
> +commands.
> +
> +The daemon runs until it is stopped using the ``quit`` QMP command or
> +SIGINT/SIGHUP/SIGTERM.
> +
> +**Warning:** Never modify images in use by a running virtual machine or any
> +other process; this may destroy the image. Also, be aware that querying an
> +image that is being modified by another process may encounter inconsistent
> +state.

I wonder if it's appropriate to mention libguestfs for safe, read-only
access to disk images (via `guestfish -ro -i -a disk.qcow2`).  I say
this because, the above warning tells what _not_ to do; a pointer on
what to do could be useful.  I let you decide on this.

The rest looks good to me; I couldn't even spot a typo.


Reviewed-by: Kashyap Chamarthy <kchamart@redhat.com>

[...]

-- 
/kashyap


