Return-Path: <SRS0=Pynu=7U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BCCAC433DF
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Jun 2020 05:40:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DEDD20656
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Jun 2020 05:40:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VIw1BKI8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DEDD20656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jho2d-0001It-Dt
	for qemu-devel@archiver.kernel.org; Sun, 07 Jun 2020 01:40:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45674)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jho1y-0000ht-Fx
 for qemu-devel@nongnu.org; Sun, 07 Jun 2020 01:39:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42707
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jho1x-0006HJ-CQ
 for qemu-devel@nongnu.org; Sun, 07 Jun 2020 01:39:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591508376;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=0wQGb8e8oOdNGexjPezclwoQislRxKxTV0eavbe72j0=;
 b=VIw1BKI8oOtjeuxCUOAo/4+5FNSP91ZpgRMN5cmYJH0tr/bVk15uvO00+7b1/SFfj9IaPh
 ZdOPMDYEEgCko9DNp04JxEZEKw6i67s0i8v2TT31s3kYWPciQl7pkQPqmX2s2flbx2vFN9
 bXP0ZgUUyTDj/YhxNRYx+W7oyhfuZjU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-417-oF5zFbhvPXK3HfPFiMHXEg-1; Sun, 07 Jun 2020 01:39:34 -0400
X-MC-Unique: oF5zFbhvPXK3HfPFiMHXEg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 716AD1005510;
 Sun,  7 Jun 2020 05:39:33 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-22.ams2.redhat.com [10.36.112.22])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BA6C47F4D7;
 Sun,  7 Jun 2020 05:39:28 +0000 (UTC)
Subject: Re: gitlab-ci: Do not use the standard container images from gitlab
To: Sam Eiderman <sameid@google.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>
References: <20200528101039.24600-7-thuth@redhat.com>
 <20200606100632.26442-1-sameid@google.com> <87mu5gct2j.fsf@linaro.org>
 <CAFr6bUnBLLdBK3Pxohynp6vp7qykbb_tNwq5-V6zu8B-vUUb+w@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <451d6048-8688-d51d-d94d-72e29238d514@redhat.com>
Date: Sun, 7 Jun 2020 07:39:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAFr6bUnBLLdBK3Pxohynp6vp7qykbb_tNwq5-V6zu8B-vUUb+w@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/07 01:39:36
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, wainersm@redhat.com, crosa@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 06/06/2020 14.38, Sam Eiderman wrote:
> Thanks for the link
> 
> I do believe that the correct approach for me is to rename
> BITS_PER_LONG to __BITS_PER_LONG (I just added a sed command in my
> Dockerfile) and move on with my particular usage, however I am just
> wondering whether dropping debian10/ubuntu20 in the official qemu ci/
> pipeline until it's fixed is the correct approach instead of keep
> failing it until the error resolves, in a way we want to always know
> on which OSs the compilation fails for visibility, no?

 Hi,

that bug was only one reason to move the pipelines to another OS. The
other reason is that we are already extensively testing various Ubuntu
(and thus Debian-based) versions in the Travis CI - but did not test any
RPM-based distros in the CI yet. Since Travis is bound to Ubuntu, we can
not test Fedora/CentOS there, thus the Gitlab CI pipelines have now been
moved to RPM-based distros (except for the "build-user" pipeline which
is still using Debian, and the "build-system1" which is now using Ubuntu
19.04 instead, so I think we still have a good mix there).

Note that the problem with Ubuntu 20.04 is also something completely
different: It hangs in an interactive prompt during update and waits for
user input, so that the pipelines finally times out:

 https://gitlab.com/huth/qemu/-/jobs/584573287#L800

If you know a work-around for that, we can move the build-system1
pipeline from 19.04 to 20.04 ... or if Debian gets finally fixed, we can
also move that pipeline back to Debian. I'm fine either way, as long as
the pipelines do not fail due to non-QEMU bugs in the distros.

 Thomas


