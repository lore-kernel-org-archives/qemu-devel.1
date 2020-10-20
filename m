Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AE14C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 08:54:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94B7520936
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 08:54:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HhY5Sjp+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94B7520936
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUnPl-0004pa-J2
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 04:54:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49702)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1kUnNq-00030K-Sp
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 04:52:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56692)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1kUnNi-0007UZ-QP
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 04:52:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603183953;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+NKkh7eeuRsoCCr6jzvGHQhfZ2CcIVV7vjeLkyuE7l8=;
 b=HhY5Sjp+CGSAKpxgScLCK9ncVbheQZaE15Je4Mt9T2s1zYzu6lj1j7RZTcdFEIFjEVxXwj
 FX+jJK896/bNpkZJvm0WNfIQdT0eMZUdO2oE0vldrtTq1AFQ5hkh4AZYnR3DCl+saQB9Ks
 RCoWkwz6qZQRtr8QsPKW3LcDo2UJMMY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-96-B5KE3ZdzPx6vogFciDbCyw-1; Tue, 20 Oct 2020 04:52:31 -0400
X-MC-Unique: B5KE3ZdzPx6vogFciDbCyw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 75A778049DA;
 Tue, 20 Oct 2020 08:52:29 +0000 (UTC)
Received: from harajuku.usersys.redhat.com (unknown [10.40.195.95])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8CA7D1002397;
 Tue, 20 Oct 2020 08:52:17 +0000 (UTC)
Message-ID: <bec8bd228f9d3627cb848241f2df413d917bd500.camel@redhat.com>
Subject: Re: [PATCH v2 03/15] python: add VERSION file
From: Andrea Bolognani <abologna@redhat.com>
To: "Daniel P." =?ISO-8859-1?Q?Berrang=E9?= <berrange@redhat.com>
Date: Tue, 20 Oct 2020 10:52:14 +0200
In-Reply-To: <20201019100207.GD236912@redhat.com>
References: <20201014142957.763624-1-jsnow@redhat.com>
 <20201014142957.763624-4-jsnow@redhat.com>
 <5d5148df6e51a70b8980945b5259c248c2994969.camel@redhat.com>
 <20201019100207.GD236912@redhat.com>
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=abologna@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=abologna@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 01:15:43
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Ben Widawsky <ben@bwidawsk.net>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Alex =?ISO-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Rohit Shinde <rohit.shinde12194@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Fam Zheng <fam@euphon.net>, Max Reitz <mreitz@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 2020-10-19 at 11:02 +0100, Daniel P. Berrangé wrote:
> On Mon, Oct 19, 2020 at 11:45:09AM +0200, Andrea Bolognani wrote:
> > I think this need to be considered very carefully.
> > 
> > I'm not overly familiar with the Python ecosystem but it would appear
> > that, despite PEP 440 not mandating this, many (most?) of the
> > packages uploaded to PyPi are using semantic versioning.
> 
>   https://packaging.python.org/guides/distributing-packages-using-setuptools/#choosing-a-versioning-scheme
> 
> Semver is the recommended approach, but they explicitly list date
> based versioning as a valid alternative
> 
>   "Semantic versioning is not a suitable choice for all projects, 
>    such as those with a regular time based release cadence and a 
>    deprecation process that provides warnings for a number of 
>    releases prior to removal of a feature."
> 
> That paragraph describes QEMU's scenario.

The section on date based versioning continues with

  A key advantage of date based versioning is that it is
  straightforward to tell how old the base feature set of a
  particular release is given just the version number.

  Version numbers for date based projects typically take the form of
  YEAR.MONTH (for example, 12.04, 15.10).

The problem with QEMU's version numbers is that, while they are date
based, they still *look* like semver, so it wouldn't be at all
unreasonable for the user to expect that they also *behave* like
semver.

This is not much of a problem when it comes to the main binary, but
it is certainly much more confusing when you start using the same
version number for a Python library.

> > With that in mind, I think it would be unwise for qemu.* not to do
> > the same; in particular, using a version number that's not <1.0.0 for
> > a package that is very much in flux will almost certainly break
> > people's expectations, and is also not something that you can easily
> > take back at a later time.
> 
> I don't think it is that big a deal, and there is clear benefit to
> having the python code version match the QEMU version that it is
> the companioon to.
> 
> Ultimately the versioning scheme just impacts on the version string
> conditionals people list for their dependancies. Apps consuming QEMU
> can handle any of the version schemes without much difference.

The problem comes from the expectations: a Python programmer, who is
used to semver due to its prominence on PyPi, when deciding whether
to move from qemu.core 4.2.0 to 5.0.0 might expect to need code
changes to cope with API-breaking changes - where in fact there are
none, and at the same time might expect upgrading to 5.2.0 from 5.0.0
to be completely straightforward when in reality a feature their
application depends on might have been removed after the usual
deprecation period.

-- 
Andrea Bolognani / Red Hat / Virtualization


