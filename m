Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77EE8C4727F
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 09:09:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A895520719
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 09:09:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cyFwNOnF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A895520719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51480 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNY72-0004ga-Nq
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 05:09:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58138)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rjones@redhat.com>) id 1kNY6G-0004GG-OB
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 05:08:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:21069)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <rjones@redhat.com>) id 1kNY6E-0001KC-Df
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 05:08:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601456912;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hDdZlYOi9AcMvrXQLtpbOWdire/Mu7Bl3eqTnKQOFPw=;
 b=cyFwNOnFS4S1B9u9VS70I8ox43Z7dbRxKSVnRVZHtWAIIBCJS0zAa81utE/SH+dDOvp3As
 WIvkYXPnjqLnd5Fru3nBWAOzpJzrLehh+vXYMM0oUHX4z5PK670HesVrG7Km2mg6ag4Fif
 +7n60nNGtqa0EIL2ky33yVmPflkFqs4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-4-vIVLPrNPMzOtNXbn0BCjCw-1; Wed, 30 Sep 2020 05:08:29 -0400
X-MC-Unique: vIVLPrNPMzOtNXbn0BCjCw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0971B427C9
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2020 09:08:29 +0000 (UTC)
Received: from localhost (ovpn-112-51.ams2.redhat.com [10.36.112.51])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8C2DD19D61;
 Wed, 30 Sep 2020 09:08:28 +0000 (UTC)
Date: Wed, 30 Sep 2020 10:08:27 +0100
From: "Richard W.M. Jones" <rjones@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: Some comments on using qemu-storage-daemon
Message-ID: <20200930090827.GB29698@redhat.com>
References: <20200930084058.GA29698@redhat.com>
 <20200930084900.GB2264779@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200930084900.GB2264779@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=rjones@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=rjones@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 00:31:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Sep 30, 2020 at 09:49:00AM +0100, Daniel P. Berrangé wrote:
> On Wed, Sep 30, 2020 at 09:40:59AM +0100, Richard W.M. Jones wrote:
> > I understand that QSD is at an early stage of development and I'm sure
> > you have plans to fix these things.  Nevertheless here are my comments
> > after trying to add an interop test with libnbd.
> > 
> > (1) Documentation!  (Or complete lack of it ...)  I had to ask Kevin
> > how to construct the command line because several things were not
> > obvious.  In particular the --blockdev parameters only make sense if
> > you're already used to constructing blockdev parameters (and these
> > are, separately, not well-documented).  And you have to supply the
> > parameters in a particular order on the command line, else it doesn't
> > work.
> > 
> > (2) There seems to be no --pid-file option, so there's no way of
> > knowing when the server is ready to accept connections, except to
> > start QSD and then "sleep for a bit".
> 
> It supports QMP via the normal chardev framework, so you can pre-create
> a UNIX listener socket and pass in the pre-opened FD. The parent just
> sends the QMP handshake, and waits until it gets EOF (exited during
> startup) or gets the QMP response (successfully running).

This is all fine when run from libvirt (and I do understand that QSD
is all about that, not necessarily a standalone general purpose
server), but also that's a massive hassle for anyone else trying to
use QSD.  I'm not confident I could correctly formulate the set of QMP
commands that would be needed to make this work, even with the
documentation and full source code.

Also this moves the problem to "when is the chardev socket ready",
especially when not using chardev over stdio.

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-top is 'top' for virtual machines.  Tiny program with many
powerful monitoring features, net stats, disk stats, logging, etc.
http://people.redhat.com/~rjones/virt-top


