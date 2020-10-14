Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFDE8C433E7
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 16:22:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D0F7214D8
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 16:22:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BJaSqeOC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D0F7214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSjXO-0007iV-35
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 12:22:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59498)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kSjFX-0008Qx-6x
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 12:03:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58008)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kSjFU-0001WX-5b
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 12:03:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602691411;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nsw9/0NTPY2w3noSBLX5X/ID9gGigUhIMBfhyZTcJJc=;
 b=BJaSqeOC4AIggulO30fEeLl6chp8fftY7j2Oj+uxnwPk3B6gLV2MNHRy7EntVj0sozrnzG
 61xefWcPEHph8uN20Kqqlwwa1S8gx/8jKGmGv0MDp08EOalxbp+h2WrDAY2/LfW8S9xbMM
 h7EorvLYo2BjwviT9QBsyD5LBsiWgSE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-519-VoY0B05_NVqlKEmph1rq8Q-1; Wed, 14 Oct 2020 12:03:26 -0400
X-MC-Unique: VoY0B05_NVqlKEmph1rq8Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2E4861018F9D;
 Wed, 14 Oct 2020 16:03:25 +0000 (UTC)
Received: from [10.10.117.231] (ovpn-117-231.rdu2.redhat.com [10.10.117.231])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1D259610F3;
 Wed, 14 Oct 2020 16:03:14 +0000 (UTC)
Subject: Re: [PATCH v2 03/15] python: add VERSION file
To: qemu-devel@nongnu.org
References: <20201014142957.763624-1-jsnow@redhat.com>
 <20201014142957.763624-4-jsnow@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <f1279b1b-0463-e46b-5309-73064890398a@redhat.com>
Date: Wed, 14 Oct 2020 12:03:13 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201014142957.763624-4-jsnow@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/14 01:12:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 Ben Widawsky <ben@bwidawsk.net>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Rohit Shinde <rohit.shinde12194@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Fam Zheng <fam@euphon.net>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/14/20 10:29 AM, John Snow wrote:
> Python infrastructure as it exists today is not capable reliably of
> single-sourcing a package version from a parent directory. The authors
> of pip are working to correct this, but as of today this is not possible
> to my knowledge.
> 
> The problem is that when using pip to build and install a python
> package, it copies files over to a temporary directory and performs its
> build there. This loses access to any information in the parent
> directory, including git itself.
> 

See also:

https://github.com/pypa/pip/issues/7549
https://github.com/pypa/pip/issues/7555

> Further, Python versions have a standard (PEP 440) that may or may not
> follow QEMU's versioning. In general, it does; but naturally QEMU does
> not follow PEP 440. To avoid any automatically-generated conflict, a
> manual version file is preferred.
> 
> 
> I am proposing:
> 
> - Python core tooling synchronizes with the QEMU version directly
>    (5.2.0, 5.1.1, 5.3.0, etc.)
> 
> - In the event that a Python package needs to be updated independently
>    of the QEMU version, a pre-release alpha version should be preferred,
>    but *only* after inclusion to the qemu development or stable branches.
> 
>    e.g. 5.2.0a1, 5.2.0a2, and so on should be preferred prior to 5.2.0's
>    release.
> 
> - The Python core tooling makes absolutely no version compatibility
>    checks or constraints. It *may* work with releases of QEMU from the
>    past or future, but it is not required to.
> 
>    i.e., "qemu.core" will always remain in lock-step with QEMU.
> 
> - We reserve the right to split out e.g. qemu.core.qmp to qemu.qmp
>    and begin indepedently versioning such a package separately from the
>    QEMU version it accompanies.
> 
> 
> Implement this versioning scheme by adding a VERSION file and setting it
> to 5.2.0a1.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>   python/VERSION   | 1 +
>   python/setup.cfg | 1 +
>   2 files changed, 2 insertions(+)
>   create mode 100644 python/VERSION
> 
> diff --git a/python/VERSION b/python/VERSION
> new file mode 100644
> index 0000000000..2e81039c82
> --- /dev/null
> +++ b/python/VERSION
> @@ -0,0 +1 @@
> +5.2.0a1
> diff --git a/python/setup.cfg b/python/setup.cfg
> index 12b99a796e..260f7f4e94 100755
> --- a/python/setup.cfg
> +++ b/python/setup.cfg
> @@ -1,5 +1,6 @@
>   [metadata]
>   name = qemu
> +version = file:VERSION
>   maintainer = QEMU Developer Team
>   maintainer_email = qemu-devel@nongnu.org
>   url = https://www.qemu.org/
> 


