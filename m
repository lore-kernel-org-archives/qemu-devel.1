Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AE4AC433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 16:43:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6DF8206E6
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 16:43:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dwC18B9f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6DF8206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35780 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIx08-0003l4-PG
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 12:43:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53216)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kIwqm-0002Qz-OC
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 12:33:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:49222)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kIwqk-0001DB-S9
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 12:33:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600360414;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=TZR2S4bV1ZlGo+lv3IDu0oPkqZHj1cI16xO5Qlz3UHo=;
 b=dwC18B9fTXTo2Ob6wVLjHmcMHppF7rCROBrDpMGNFTPcySs3wBZjcgXSwhpoV3wnz6LgIG
 unHesuUJBNp6O1V15//T0AjSjtf1L8sZSu+lmh48YS/MlWSp9X2KDYnUuo+Q8EfId6/3BA
 cFPfNsuJKO7VpOBtxpKwErJ0j3LYPPo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-20-3JdH_s-aOtC6_HP-P8Xk_w-1; Thu, 17 Sep 2020 12:33:25 -0400
X-MC-Unique: 3JdH_s-aOtC6_HP-P8Xk_w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 41EC41074643;
 Thu, 17 Sep 2020 16:33:24 +0000 (UTC)
Received: from redhat.com (ovpn-114-29.ams2.redhat.com [10.36.114.29])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E6A8768D60;
 Thu, 17 Sep 2020 16:33:18 +0000 (UTC)
Date: Thu, 17 Sep 2020 17:33:15 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: Python 3.5 EOL; when can require 3.6?
Message-ID: <20200917163315.GL1597829@redhat.com>
References: <875z8eupyp.fsf@dusky.pond.sub.org>
 <CAFEAcA8q8J1n2UqsNbHgNwEedA8pZ6fNA7obCR1REN-33nvmkg@mail.gmail.com>
 <d07189e2-0683-2eb9-44e0-a275688fa8b4@redhat.com>
 <20200917161919.GO7594@habkost.net>
MIME-Version: 1.0
In-Reply-To: <20200917161919.GO7594@habkost.net>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 20:51:18
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.997,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Sep 17, 2020 at 12:19:19PM -0400, Eduardo Habkost wrote:
> On Wed, Sep 16, 2020 at 04:00:14PM +0200, Thomas Huth wrote:
> > On 16/09/2020 14.30, Peter Maydell wrote:
> > > On Wed, 16 Sep 2020 at 08:43, Markus Armbruster <armbru@redhat.com> wrote:
> > >> We require Python 3.5.  It will reach its "end of life" at the end of
> > >> September 2020[*].  Any reason not to require 3.6 for 5.2?  qemu-iotests
> > >> already does for its Python parts.
> > [...]
> > > The default should be
> > > "leave the version dependency where it is", not "bump the version
> > > dependency as soon as we can".
> > 
> > OTOH, if none of our supported build systems uses python 3.5 by default
> > anymore, it also will not get tested anymore, so bugs might creep in,
> > which will of course end up in a bad experience for the users, too, that
> > still try to build with such an old version. So limiting the version to
> > the level that we also test is IMHO very reasonable.
> > 
> > Let's have a look at the (older) systems that we support and the python
> > versions according to repology.org:
> > 
> > - RHEL7 / CentOS 7 : 3.6.8
> > - Ubuntu 18.04 (Bionic) : >= 3.6.5
> > - openSUSE Leap 15.0 : >= 3.6.5
> > - OpenBSD Ports : >= 3.7.9
> > - FreeBSD Ports : >= 3.5.10 - but there is also 3.6 or newer
> > - Homebrew : >= 3.7.9
> > 
> > ... so I think it should be fine to retire 3.5 nowadays.
> 
> Thank you very much for the summary.  I've added this info to
> https://wiki.qemu.org/Supported_Build_Platforms
> 
> Has anybody been able to find information om SLES Python
> versions?  I can't find this anywhere.

It is slightly tedious, but I was pointed at

  https://scc.suse.com/api/package_search/products

where you find the product ID.

eg SLES 15  is ID 1609

which you can plug into

https://scc.suse.com/api/package_search/packages?product_id=1609&amp;query=python

and that somes some package names like "libpython3_6" so 3.6.5
looks like a match,

This looks like it matches openSUSE Leap 15, which suggest we
probably don't need to look at SLES directly.


SLES 15 was released in July 2018, so with our 2 year overlap for the
previous release, we can consider SLES 12sp2 unsupported from this
release cycle.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


