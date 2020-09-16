Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76822C433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 09:58:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C826221E5
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 09:58:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fDUbtAE+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C826221E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIUDJ-0007d5-1t
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 05:58:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54144)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kIU8n-0000ed-4G
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 05:54:17 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:57200
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kIU8l-0000nG-06
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 05:54:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600250054;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CgzW+ofsCKVWBaStkUDLhIDaMLB1w42HIUuF0SLQxHg=;
 b=fDUbtAE+WwTQbhgSVBHzd5UPs+pmRo1XQi6rG+qBSVGkB8Th/vXjnoLutUryAHblslaQ1S
 ZTC42rUUz4dghmHICJWlRJC+IJAqWEAKuUzMbCaKObSeRDZ6DuP5Ereh6B2CGY0CJJCAy3
 1mohNlu3T4cI68PDdS1pxmQDxxDOSQw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-473-oUQS7D3AM2OuQb7lXshbGg-1; Wed, 16 Sep 2020 05:54:12 -0400
X-MC-Unique: oUQS7D3AM2OuQb7lXshbGg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 77AF381C463;
 Wed, 16 Sep 2020 09:54:11 +0000 (UTC)
Received: from redhat.com (ovpn-113-248.ams2.redhat.com [10.36.113.248])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9A77C60BFA;
 Wed, 16 Sep 2020 09:54:05 +0000 (UTC)
Date: Wed, 16 Sep 2020 10:54:02 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: Python 3.5 EOL; when can require 3.6?
Message-ID: <20200916095402.GI1535709@redhat.com>
References: <875z8eupyp.fsf@dusky.pond.sub.org>
 <1ad049f0-09f9-d56f-bc63-d120a0dbcf24@redhat.com>
 <20200916083327.GE1535709@redhat.com>
 <91372bbf-bb36-2ade-c8a4-7e1f8b0776ea@redhat.com>
MIME-Version: 1.0
In-Reply-To: <91372bbf-bb36-2ade-c8a4-7e1f8b0776ea@redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 02:41:36
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
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
 Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Sep 16, 2020 at 11:50:06AM +0200, Thomas Huth wrote:
> On 16/09/2020 10.33, Daniel P. Berrangé wrote:
> > On Wed, Sep 16, 2020 at 09:54:32AM +0200, Thomas Huth wrote:
> >> On 16/09/2020 09.43, Markus Armbruster wrote:
> >>> We require Python 3.5.  It will reach its "end of life" at the end of
> >>> September 2020[*].  Any reason not to require 3.6 for 5.2?  qemu-iotests
> >>> already does for its Python parts.
> >>
> >> I think the only reason for requiring Python 3.5 is that we still use
> >> Ubuntu Xenial in Travis. We don't support Xenial according to our
> >> support policy anymore, but we did not update to Bionic there since it
> >> has that broken version of libssh.
> >>
> >> Fortunately, since a couple of weeks, Travis now supports Focal, too, so
> >> once we switched our .travis.yml to use Focal, I think we could start
> >> requiring Python 3.6.
> > 
> > Note we really should not be constrained by what Travis provides as
> > images. Travis images provide docker, so we can spawn our Travis
> > jobs inside containers to get arbitrary linux distros. We did this
> > for libvirt for a while until we switched to GitLab CI. So we
> > definitely don't need to care about Xenial from a Travis POV no
> > matter what.
> 
> I hope we could finally exploit the possibility to use KVM on Travis ...
> that won't be possible anymore once we use containers there.

Do they forbid passing the /dev/kvm device node into the docker
container ? I would have though that would be allowed, since using
KVM inside docker is no worse than using it outside docker in the
Travis env.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


