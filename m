Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAC84C43461
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 15:03:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DED32220D
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 15:03:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q2kuho9l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DED32220D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIvRg-0003LF-8x
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 11:03:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52470)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kIvJT-0003yW-9B
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 10:55:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:52206)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kIvJP-0008D5-Or
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 10:55:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600354501;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d9ntLIU7TziRVeQTZErYPgJDAtJOdY+7ISQ+St0WLJs=;
 b=Q2kuho9lpqzzBz7nAknSV2Pa4CJ2BEpXGx9Xw4NWtU/DiZDp+F/Sy4DyryiRDCGWEN7slW
 oCndcYMQG+oCw3bRNuayyqfvz+5xEwz1TdV2rPHTi/ynIoAUxmMQDM86pRuHGCQ+0Rxzhi
 +UmSzQXn/VdUGU9hXqhjaX181h7meho=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-560-UPc2LrEvPtWO6etWaqHKPQ-1; Thu, 17 Sep 2020 10:54:41 -0400
X-MC-Unique: UPc2LrEvPtWO6etWaqHKPQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CBB8F89BBC3;
 Thu, 17 Sep 2020 14:54:32 +0000 (UTC)
Received: from localhost (ovpn-119-217.rdu2.redhat.com [10.10.119.217])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 375899916D;
 Thu, 17 Sep 2020 14:54:00 +0000 (UTC)
Date: Thu, 17 Sep 2020 10:53:59 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Subject: Re: Python 3.5 EOL; when can require 3.6?
Message-ID: <20200917145359.GN7594@habkost.net>
References: <875z8eupyp.fsf@dusky.pond.sub.org>
 <495bd2bd-4f38-8fe2-e758-82acbecd0d04@redhat.com>
 <436800a3-7645-52f7-5fea-134d883c0a7b@redhat.com>
 <87d02lzv2k.fsf@linaro.org> <20200916135737.GP1535709@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200916135737.GP1535709@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=ehabkost@redhat.com;
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Sep 16, 2020 at 02:57:37PM +0100, Daniel P. Berrangé wrote:
> On Wed, Sep 16, 2020 at 02:53:55PM +0100, Alex Bennée wrote:
> > 
> > Thomas Huth <thuth@redhat.com> writes:
> > 
> > > On 16/09/2020 09.53, Philippe Mathieu-Daudé wrote:
> > >> On 9/16/20 9:43 AM, Markus Armbruster wrote:
> > >>> We require Python 3.5.  It will reach its "end of life" at the end of
> > >>> September 2020[*].  Any reason not to require 3.6 for 5.2?  qemu-iotests
> > >>> already does for its Python parts.
> > >>>
> > >>>
> > >>> [*] https://www.python.org/downloads/release/python-3510/
> > >> 
> > >> Not answering your question, but it would help to start a table
> > >> of "oldest package released" versions, with our supported distributions
> > >> as columns and package names as row.
> > >> 
> > >> This way when new distributions are released (and oldest dropped from
> > >> our side) we can add/remove a column and see the oldest version we aim
> > >> to support.
> > >
> > > That's quite a bit of extra work - I think it's enough to look up the
> > > versions on repology instead, e.g.:
> > >
> > > https://repology.org/project/python/versions
> > 
> > Hmm are there any magic runes to limit the list to only the distros we
> > care about?
> 
> No, thats the hard bit. Basically have to search through the list looking
> for the two most recent versions of RHEL, Ubuntu, Debian, Fedora, etc

I'm using the following command to query Repology from the command line:

 $ curl -s 'https://repology.org/api/v1/project/python' |  \
   jq -r 'group_by(.repo) | .[] | "\(.[0].repo): \(map(.version))"' | \
   egrep -i 'fedora|ubuntu|debian|rhel|centos|bsd|suse|sles'

-- 
Eduardo


