Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D077C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 15:36:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 140F5206D8
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 15:36:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F/8SJ9h2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 140F5206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jydHE-0004Ke-6X
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 11:36:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37630)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1jydGb-0003uE-2n
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 11:36:17 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:20471
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1jydGY-00030j-By
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 11:36:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595518570;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tEppsMviv8xbtOqvpkGPzUSN4/gAvnJzYGYLUxhrysg=;
 b=F/8SJ9h2zZLJb2ok2AkMi9FOuJkwArH2fvVp70CEFfrgGsz1HA1hlZ2JH0kQpfu8h9oYJV
 yyx6V/Qe8fjwHDoq6/v5ye0lQ5QXi9920K2sOo4hEC/UdLKCpqarqJfmMfrrkTeqeGW4Tq
 1KD36jsitxmmf7UKaNyW6BnakTioxMI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-488-kHPp-EeNMumgIzV9vykQ9Q-1; Thu, 23 Jul 2020 11:36:08 -0400
X-MC-Unique: kHPp-EeNMumgIzV9vykQ9Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 89BF61937FDE;
 Thu, 23 Jul 2020 15:36:06 +0000 (UTC)
Received: from colo-mx.corp.redhat.com
 (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7FFA119D7B;
 Thu, 23 Jul 2020 15:36:06 +0000 (UTC)
Received: from zmail17.collab.prod.int.phx2.redhat.com
 (zmail17.collab.prod.int.phx2.redhat.com [10.5.83.19])
 by colo-mx.corp.redhat.com (Postfix) with ESMTP id 56FF618095FF;
 Thu, 23 Jul 2020 15:36:06 +0000 (UTC)
Date: Thu, 23 Jul 2020 11:36:05 -0400 (EDT)
From: Cleber Rosa <crosa@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Message-ID: <2001087850.4576521.1595518565995.JavaMail.zimbra@redhat.com>
In-Reply-To: <de0c01b5-80e0-63f7-7a69-fb8f0d4b5b4c@redhat.com>
References: <20200723122800.723-1-thuth@redhat.com>
 <20200723122800.723-4-thuth@redhat.com>
 <a78f13d8-5f81-43ae-f497-90f86f60f0bc@amsat.org>
 <de0c01b5-80e0-63f7-7a69-fb8f0d4b5b4c@redhat.com>
Subject: Re: [PATCH 3/4] tests/acceptance: Disable the rx sash and arm
 cubieboard replay test on Gitlab
MIME-Version: 1.0
X-Originating-IP: [174.251.66.224, 10.4.196.3, 10.5.101.130, 10.4.195.11]
Thread-Topic: tests/acceptance: Disable the rx sash and arm cubieboard replay
 test on Gitlab
Thread-Index: h1rxvbhgRIH8Ag7tNmWsKuatg4/I+w==
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/23 02:33:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Fam Zheng <fam@euphon.net>, Yoshinori Sato <ysato@users.sourceforge.jp>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-devel@nongnu.org,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


----- Thomas Huth <thuth@redhat.com> wrote:
> On 23/07/2020 14.53, Philippe Mathieu-Daud=C3=A9 wrote:
> > On 7/23/20 2:27 PM, Thomas Huth wrote:
> >> These tests always time out on Gitlab, not sure what's happening here.
> >> Let's disable them until somebody has enough spare time to debug the
> >> issues.
> >=20
> > Is the Avocado cache working? Is it failing with an empty cache?
> > If so, maybe we need to run avocado cache fetching in a previous
> > step, before the testing job.
> >=20
> > Can you share a url of failed job so I can have a look?
>=20
> CentOS:
>  https://gitlab.com/huth/qemu/-/jobs/651179303
>=20
I don't see the sash files being downloaded/checked ahead of test execution=
, so that may be an issue indeed. But for the cubieboard, that is being don=
e, so does not look like a cache issue.

Either way, it's better to disable these and re-enable them after a proper =
investigation (I'll follow up with that).

Reviewed-by: Cleber Rosa <crosa@redhat.com>


> Debian:
>  https://gitlab.com/huth/qemu/-/jobs/651179296
>=20
> ... might be a cache issue, indeed.
>=20
>  Thomas


