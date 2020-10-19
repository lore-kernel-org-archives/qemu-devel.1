Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2900C433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 09:48:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2750022240
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 09:48:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cE+PnQAa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2750022240
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kURmd-0007tu-11
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 05:48:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50560)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1kURjQ-0004xp-Cf
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 05:45:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28414)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1kURjN-0001uO-JN
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 05:45:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603100726;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Fovv0TKyrS+e6AARsrv1eiu8YDGBm5Rq0pqBtnZNEPs=;
 b=cE+PnQAa/ga4PSBWka9T9q0VF2+Ix2X1zULS8FzOU42bGemjYfHrtRQ/wd+uOw7zTReLbX
 mr5yQGTxwu6p6SgQXi/RUbnxhFWAh0mNcS3t1Ai+PDhCVgLihRarbMILMiN9iZt2cvjZ8P
 x02r9zvZo8orW5PbXW7snC0jj/c9Nm4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-190-DlSdRtS2Nam8PCHDE-x_4Q-1; Mon, 19 Oct 2020 05:45:24 -0400
X-MC-Unique: DlSdRtS2Nam8PCHDE-x_4Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D450164141;
 Mon, 19 Oct 2020 09:45:22 +0000 (UTC)
Received: from harajuku.usersys.redhat.com (unknown [10.40.195.195])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 39C911002388;
 Mon, 19 Oct 2020 09:45:11 +0000 (UTC)
Message-ID: <5d5148df6e51a70b8980945b5259c248c2994969.camel@redhat.com>
Subject: Re: [PATCH v2 03/15] python: add VERSION file
From: Andrea Bolognani <abologna@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Date: Mon, 19 Oct 2020 11:45:09 +0200
In-Reply-To: <20201014142957.763624-4-jsnow@redhat.com>
References: <20201014142957.763624-1-jsnow@redhat.com>
 <20201014142957.763624-4-jsnow@redhat.com>
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=abologna@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=abologna@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/19 02:32:01
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 Alex =?ISO-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Rohit Shinde <rohit.shinde12194@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Fam Zheng <fam@euphon.net>,
 Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 2020-10-14 at 10:29 -0400, John Snow wrote:
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
> Further, Python versions have a standard (PEP 440) that may or may not
> follow QEMU's versioning. In general, it does; but naturally QEMU does
> not follow PEP 440. To avoid any automatically-generated conflict, a
> manual version file is preferred.
> 
> 
> I am proposing:
> 
> - Python core tooling synchronizes with the QEMU version directly
>   (5.2.0, 5.1.1, 5.3.0, etc.)
> 
> - In the event that a Python package needs to be updated independently
>   of the QEMU version, a pre-release alpha version should be preferred,
>   but *only* after inclusion to the qemu development or stable branches.
> 
>   e.g. 5.2.0a1, 5.2.0a2, and so on should be preferred prior to 5.2.0's
>   release.
> 
> - The Python core tooling makes absolutely no version compatibility
>   checks or constraints. It *may* work with releases of QEMU from the
>   past or future, but it is not required to.
> 
>   i.e., "qemu.core" will always remain in lock-step with QEMU.
> 
> - We reserve the right to split out e.g. qemu.core.qmp to qemu.qmp
>   and begin indepedently versioning such a package separately from the
>   QEMU version it accompanies.

I think this need to be considered very carefully.

I'm not overly familiar with the Python ecosystem but it would appear
that, despite PEP 440 not mandating this, many (most?) of the
packages uploaded to PyPi are using semantic versioning.

With that in mind, I think it would be unwise for qemu.* not to do
the same; in particular, using a version number that's not <1.0.0 for
a package that is very much in flux will almost certainly break
people's expectations, and is also not something that you can easily
take back at a later time.

-- 
Andrea Bolognani / Red Hat / Virtualization


