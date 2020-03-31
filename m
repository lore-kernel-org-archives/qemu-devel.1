Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75DD5C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 13:45:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A9AB206F5
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 13:45:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fyRwVbfo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A9AB206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38342 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJHD6-0006AK-CK
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 09:45:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44962)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jJHCK-0005TZ-6w
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 09:44:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1jJHCI-0000TR-JV
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 09:44:55 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55667
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1jJHCI-0000T9-Fl
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 09:44:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585662293;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Gw1vmhjUTM/L9ZxInXP/WEtklsRr+SfUxCX++LNxRLY=;
 b=fyRwVbfo00nCekdJLNfwVH4vJcLyYGL2QEROr9lmTaMG6jul5lFX80r+ZQF3XKfq0b6Y1p
 FVyh+kbt+D8oFtZq0KwB7KKckGpnNs6jtmWRV7VvXKZfS1w9USk5Q3zrw8skeQ0G5TmpHT
 ScgaHjy2ignYuPNu+gh8SmqXAcyWjEs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-489-3ta517OzMBCHWqGAIfTvIQ-1; Tue, 31 Mar 2020 09:44:50 -0400
X-MC-Unique: 3ta517OzMBCHWqGAIfTvIQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 42825107ACC7;
 Tue, 31 Mar 2020 13:44:49 +0000 (UTC)
Received: from linux.fritz.box (ovpn-114-236.ams2.redhat.com [10.36.114.236])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7519898A38;
 Tue, 31 Mar 2020 13:44:47 +0000 (UTC)
Date: Tue, 31 Mar 2020 15:44:46 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v10 14/14] iotests: use python logging for iotests.log()
Message-ID: <20200331134446.GF7030@linux.fritz.box>
References: <20200331000014.11581-1-jsnow@redhat.com>
 <20200331000014.11581-15-jsnow@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200331000014.11581-15-jsnow@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: ehabkost@redhat.com, qemu-block@nongnu.org, armbru@redhat.com,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 31.03.2020 um 02:00 hat John Snow geschrieben:
> We can turn logging on/off globally instead of per-function.
>=20
> Remove use_log from run_job, and use python logging to turn on
> diffable output when we run through a script entry point.
>=20
> iotest 245 changes output order due to buffering reasons.
>=20
>=20
> An extended note on python logging:
>=20
> A NullHandler is added to `qemu.iotests` to stop output from being
> generated if this code is used as a library without configuring logging.
> A NullHandler is only needed at the root, so a duplicate handler is not
> needed for `qemu.iotests.diff_io`.
>=20
> When logging is not configured, messages at the 'WARNING' levels or
> above are printed with default settings. The NullHandler stops this from
> occurring, which is considered good hygiene for code used as a library.
>=20
> See https://docs.python.org/3/howto/logging.html#library-config
>=20
> When logging is actually enabled (always at the behest of an explicit
> call by a client script), a root logger is implicitly created at the
> root, which allows messages to propagate upwards and be handled/emitted
> from the root logger with default settings.
>=20
> When we want iotest logging, we attach a handler to the
> qemu.iotests.diff_io logger and disable propagation to avoid possible
> double-printing.
>=20
> For more information on python logging infrastructure, I highly
> recommend downloading the pip package `logging_tree`, which provides
> convenient visualizations of the hierarchical logging configuration
> under different circumstances.
>=20
> See https://pypi.org/project/logging_tree/ for more information.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> Reviewed-by: Max Reitz <mreitz@redhat.com>

Should we enable logger if -d is given?

Previously we had:

$ ./check -d -T -raw 281
[...]
281 not run: not suitable for this image format: raw
281      not run    [15:39:03] [15:39:04]                    not suitable f=
or this image format: raw
Not run: 281

After this series, the first line of output from notrun() is missing.
Not that I think it's important to have the line, but as long as we
bother to call logger.warning(), I thought that maybe we want to be able
to actually see the effect of it somehwere?

Kevin


