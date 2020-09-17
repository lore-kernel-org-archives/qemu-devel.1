Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB6CBC433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 15:43:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FF8C2222D
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 15:43:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KmjZedvW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FF8C2222D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIw4a-0000hP-4U
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 11:43:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37856)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kIw0o-00058l-1b
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 11:39:54 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:28413
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kIw0l-0008W8-6R
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 11:39:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600357188;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oU7708IGukd3gdW1yiedM5Uvq80nWoB6E6U87lSxMQc=;
 b=KmjZedvWfVI9+/Zki40ao9AgujyNSYmHWeixDr90tV4J15//O6BzMHkn+KpIymxq6JAxO2
 Un5Lk0lkpBKXDM+8w2JFl6ZRTk0c++80Hr2nButYlDpPftT/XE2KUk8hCXDRt0EfpFh+tM
 FPsZWICNhFv5fBmBWWtF7Q3eGRZgMyQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-198-WxHOEkjVOMyDHm-ySqV4Tg-1; Thu, 17 Sep 2020 11:39:29 -0400
X-MC-Unique: WxHOEkjVOMyDHm-ySqV4Tg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 00C6656B57;
 Thu, 17 Sep 2020 15:39:28 +0000 (UTC)
Received: from redhat.com (ovpn-114-29.ams2.redhat.com [10.36.114.29])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 90BB410023A5;
 Thu, 17 Sep 2020 15:39:18 +0000 (UTC)
Date: Thu, 17 Sep 2020 16:39:15 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: Python 3.5 EOL; when can require 3.6?
Message-ID: <20200917153915.GJ1597829@redhat.com>
References: <875z8eupyp.fsf@dusky.pond.sub.org>
 <CAFEAcA8q8J1n2UqsNbHgNwEedA8pZ6fNA7obCR1REN-33nvmkg@mail.gmail.com>
 <d07189e2-0683-2eb9-44e0-a275688fa8b4@redhat.com>
 <9d4363e8-7bb8-8255-9914-6d9bc36cec79@redhat.com>
 <20200917145512.GF1597829@redhat.com>
 <37d8203d-e4f8-f9dd-828c-2d754a3695eb@redhat.com>
MIME-Version: 1.0
In-Reply-To: <37d8203d-e4f8-f9dd-828c-2d754a3695eb@redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/17 08:56:18
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.997,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>, Markus Armbruster <armbru@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, John Snow <jsnow@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Sep 17, 2020 at 05:24:15PM +0200, Thomas Huth wrote:
> On 17/09/2020 16.55, Daniel P. Berrangé wrote:
> > On Thu, Sep 17, 2020 at 04:10:55PM +0200, Thomas Huth wrote:
> >> On 16/09/2020 16.00, Thomas Huth wrote:
> >>> On 16/09/2020 14.30, Peter Maydell wrote:
> >>>> On Wed, 16 Sep 2020 at 08:43, Markus Armbruster <armbru@redhat.com> wrote:
> >>>>> We require Python 3.5.  It will reach its "end of life" at the end of
> >>>>> September 2020[*].  Any reason not to require 3.6 for 5.2?  qemu-iotests
> >>>>> already does for its Python parts.
> >>> [...]
> >>>> The default should be
> >>>> "leave the version dependency where it is", not "bump the version
> >>>> dependency as soon as we can".
> >>>
> >>> OTOH, if none of our supported build systems uses python 3.5 by default
> >>> anymore, it also will not get tested anymore, so bugs might creep in,
> >>> which will of course end up in a bad experience for the users, too, that
> >>> still try to build with such an old version. So limiting the version to
> >>> the level that we also test is IMHO very reasonable.
> >>>
> >>> Let's have a look at the (older) systems that we support and the python
> >>> versions according to repology.org:
> >>>
> >>> - RHEL7 / CentOS 7 : 3.6.8
> >>> - Ubuntu 18.04 (Bionic) : >= 3.6.5
> >>> - openSUSE Leap 15.0 : >= 3.6.5
> >>> - OpenBSD Ports : >= 3.7.9
> >>> - FreeBSD Ports : >= 3.5.10 - but there is also 3.6 or newer
> >>> - Homebrew : >= 3.7.9
> >>>
> >>> ... so I think it should be fine to retire 3.5 nowadays.
> >>
> >> Sorry, I forgot to check Debian. If I got that right, Debian 9 still
> >> uses Python 3.5 by default. So I guess that means we can not deprecate
> >> Python 3.5 yet?
> > 
> > FWIW, Debian 9 EOL was July this year, if you only count the regular
> > lifetime, not the LTS.
> 
> Do we support Debian LTS? ... If not, we should maybe add a proper
> remark about that to our support policy...?

I didn't define Debian situation very well in the support policy
because I didn't realize it had separate normal and LTS EOL
dates. I had originally thought it was LTS only.

In libvirt we have since clarified the language I originally
wrote (and then copied to QEMU), to remove the LTS distinction.
Instead libvirt now says:

 "The project aims to support the most recent major version at all
  times. Support for the previous major version will be dropped 2
  years after the new major version is released or when the vendor
  itself drops support, whichever comes first. In this context,
  third-party efforts to extend the lifetime of a distro are not
  considered, even when they are endorsed by the vendor (eg. Debian
  LTS)."

I'd suggest we copy this updated terminolgy into QEMU as it simplifies
the current language used.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


